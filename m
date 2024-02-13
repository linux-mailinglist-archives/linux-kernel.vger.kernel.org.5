Return-Path: <linux-kernel+bounces-63430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334D852F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F99B1F21A58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30C52F95;
	Tue, 13 Feb 2024 11:21:46 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FE52F7B;
	Tue, 13 Feb 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823306; cv=none; b=fc4c4wDg+PAPOviiSbJaVcR8uSa6rXaljV1E4mp1bLDNhhhvuAIkpj1SgYxb2758boIjc7YwtLU1vR7dhwFsVQ85dWPjpxvpUTPjnhTv1oOI0FfCypP+IHm8rKETL1Syua76zo+iatb6DT24LmrmWzNHdn9nnQniScmCNLk8RiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823306; c=relaxed/simple;
	bh=irRQ/m90YekOG71Qw6BtrTc5Gvq0DSqk8L96juNCHcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iK449E2myDH77vB89RGiIKw0vadSfxLCbllolgkoS3ifu4A2rE/mKObgGrmUNnEevTZUck+l+MtyJRJkdiX5FBHswUwh6B+2ijdNMJDwz0I/USrYH9BNayskqp6gf9rmetxMLvhr5nFapaT7+h7cV/xMX+jAEKc+LoLovOFKjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561f5086a1fso578574a12.2;
        Tue, 13 Feb 2024 03:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823302; x=1708428102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2fi7YzH+StJmNwBMeEGpiocT0DtpILeZR/6wF23oBc=;
        b=D7ZkthLS/7lv/mjFSAWc5Rbnb8V4OjclIuudSdD7ivJrOLI71IuopbVr1KJBkQMn7a
         fOE2uSHln3/wDYrVa0hrVnoI0GXX+aSuV2RrK2eDNRD93KAaaJFTOSpuhtQ9PFX2z1uA
         jDWmpmcfRfds1XlG55Q8Cx7VCxSXwcby/nu6ZG1WpH4NtX0yRxAZgcWNt6mLQoj44ieL
         ojZ++g/rFkh3jWLf63ZpDA92Vl8kPO+GZ+FT4kR0El6OokL874rnbA44WbiKMJaglo58
         c1OtJqz6SXm9DmCU2mDaX533F2uuv7NWLM5thK5Ie4efBKPlhsuCEzIcbaJ8ilkKmUUV
         b0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX7wZf5NNfDB8uvjGXKdMWs3jcKIVaww+eJj1W9cLEshgeyt0f4/lSxJp98YBlJH0RuqC1Me3DqXOaf0wL+ILP0HMMjoTEG45M5LfAJ
X-Gm-Message-State: AOJu0Yw2wt/MDpKIDi3kp/B8rTEBvMUwazyqb41vNJKG4DKQoTtuLvd1
	PS/d54QgLimkfX78syikQdsPzsPSUann+93Rt1OR3WRgXWM8r4Hj
X-Google-Smtp-Source: AGHT+IGxUUa7MQFFH+2c/wiDqNdRpUBNLKGDgveSmr2Ugbu384K5k3ptbafrZmd8nlXxk2atbunPsw==
X-Received: by 2002:a05:6402:2c2:b0:561:d3d4:242d with SMTP id b2-20020a05640202c200b00561d3d4242dmr2712574edx.38.1707823302545;
        Tue, 13 Feb 2024 03:21:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyyStnPDFkeZg2AxZJ1GYeC9JyK6hZC2lmWiHUJqznqpjUW2RMFbsXpaYuQ/jy88o21OM0zMWW67OrswieDyzg8mAQToQ1UcYSx8TMmlgXCRH4Kp2XDWlp7HwSEd+HPGUSAuubThi7y3HBqpq977E/8hG6mzskWLbRIyT+AWEzj959Al2fzJCDnSMlWd0NpeN8qSgSw7Guf2SJBg==
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id cf26-20020a0564020b9a00b00561e912ed5asm740032edb.45.2024.02.13.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 4/7] net: fill in MODULE_DESCRIPTION()s for fddik/skfp
Date: Tue, 13 Feb 2024 03:21:19 -0800
Message-Id: <20240213112122.404045-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the SysKonnect FDDI PCI module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/fddi/skfp/skfddi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index 2b6a607ac0b7..a273362c9e70 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -153,6 +153,7 @@ static const struct pci_device_id skfddi_pci_tbl[] = {
 	{ }			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, skfddi_pci_tbl);
+MODULE_DESCRIPTION("SysKonnect FDDI PCI driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mirko Lindner <mlindner@syskonnect.de>");
 
-- 
2.39.3


