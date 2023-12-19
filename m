Return-Path: <linux-kernel+bounces-4998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB5818504
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB331C22F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B314288;
	Tue, 19 Dec 2023 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKPn8gAO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D01426D;
	Tue, 19 Dec 2023 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e23c620e8so4087878e87.1;
        Tue, 19 Dec 2023 02:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980507; x=1703585307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd1Rq7ccdPFRAkfdb1UEiGgaVGie37sz3xNdgkK3AcM=;
        b=SKPn8gAOHEpacCHFH1t0afP/pkwi6i9D/f+jYivfuaDPQXLLhYMRF4OAd+Y6XpfqDS
         eK+poF/iDfDPkgrw8tINGv1Srvshs8YHAYrnvxbelfg+DMu/A5VwCmKIvzXCdfHq3G09
         UR+mHy+Bs+JpU+F+/4DRCQQClAiCg/qXf7tL+Optdm6NbuUc+6nSQzQhB0V8p3RE478V
         kc0BKMXzEjTtrzBlMRa5EtKZ/jE/HSUTDUXAXSrj3owP9QX56/6vCPGD417NmoDff5Ar
         Bd94UR5b/WTKSo9yy+eUNYaXqzJP60Ur0Fq/knwzoUP11UE94s/NzkAbn1pfjEYMCKCW
         zIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980507; x=1703585307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd1Rq7ccdPFRAkfdb1UEiGgaVGie37sz3xNdgkK3AcM=;
        b=YcU1oULJyhrsTasDjKG9CV5JkTmxQdNdEhyHcj0ZONrBpFTLSzmTCtQMn1sw3Arg/t
         3RPVfxFB4QamoQZi96yEFNseW0VbvT+3kIWT2CEkAdjUR8nmNWi+Q1k7/gHGBOjfAMIv
         FAqI2jvGfmkGlr4q8fijliTaIwn/xDQ0v/fMRwvtC3z1B8YRAotIWYSW6nZGtxAUJJgR
         uKE3h4FBFY9BCikHlem9IISJg4PH6V/Ud1FS4dJS9OUpdOPtdOnf5sZjtTcheLcqAJnS
         d4/Ni7xAlmD97wJ0t0xSz3DSFLhoP/hlt0ZpkDKKvLmHuqIHUp/0bY8Ni1iRroSlPl5R
         xHAg==
X-Gm-Message-State: AOJu0YyiP4hUQeiDnFp5f1HIXeFC7aRThER98b0+ShpmgqhUujFkKL5C
	OSxUOwE68nD9FVuhf1ENsAQ=
X-Google-Smtp-Source: AGHT+IFZZas7gqkOHfTxGX51zxiriE8cdbLR7vmgQiW+zT+WC3gGPp4w5G9TREROW7yXdCemSm+V/Q==
X-Received: by 2002:a05:6512:1093:b0:50e:175d:7407 with SMTP id j19-20020a056512109300b0050e175d7407mr5000397lfg.64.1702980507067;
        Tue, 19 Dec 2023 02:08:27 -0800 (PST)
Received: from alsp.netis.cc ([2a02:2168:8a0b:bd00:ec0a:381e:719d:789d])
        by smtp.googlemail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm3170563lfu.48.2023.12.19.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:08:26 -0800 (PST)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Sapozhnikov <alsp705@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] net: fddi: skfp: Uninitialized data 
Date: Tue, 19 Dec 2023 13:08:19 +0300
Message-Id: <20231219100819.17426-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 drivers/net/fddi/skfp/pmf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/pmf.c b/drivers/net/fddi/skfp/pmf.c
index 563fb7f0b327..3f24fbd82a73 100644
--- a/drivers/net/fddi/skfp/pmf.c
+++ b/drivers/net/fddi/skfp/pmf.c
@@ -1084,7 +1084,7 @@ static int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index,
 	int		path ;
 	int		port ;
 	SK_LOC_DECL(u_char,byte_val) ;
-	SK_LOC_DECL(u_short,word_val) ;
+	SK_LOC_DECL(u_short, word_val) = 0 ;
 	SK_LOC_DECL(u_long,long_val) ;
 
 	mac = index - INDEX_MAC ;
-- 
2.40.1


