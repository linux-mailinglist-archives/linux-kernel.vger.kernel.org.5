Return-Path: <linux-kernel+bounces-35965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AA839946
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC5AB2DEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4312C53F;
	Tue, 23 Jan 2024 19:04:28 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626FC12C536;
	Tue, 23 Jan 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036668; cv=none; b=bZ+bO4DmZU4c0ScDqz4fm6kXRg5cXl6+ZpDawbC/05k4izd7/00ftTeLHtkC6x2JY4As0Pr4g+o/9sgkZj9Wan4K70TYpysrorrk3Lm8o2QIzq+QSINRNhOD+1jUEcA8kcTBy5Rw2+tz4Ute1ly/moaKr0pFa8wKKT3n9l0E5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036668; c=relaxed/simple;
	bh=5ioWY6cZMA7SINIP4rC5nvm/iCXXDx+mOGXSFMiYuNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kr+dr/PZfMaID3Heemc7uyKQzhDwtxmXRo+MkLOolekTlatxmnU+9/06H4iI8/uOp9JG/wgOyN6GGXV88qqVWcgl6If9S6i6spmrk1VcJ8TC8cvpOipZGPnzuVOOu9fn7UEc2FdqGT5GU7sBC1Dpl8yf3c3ndBwiKT+g6Sjj5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28fb463a28so457440766b.3;
        Tue, 23 Jan 2024 11:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036664; x=1706641464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUjkdIPV4RyRqGQf6e4w7ul6m32fEFyDKsrtQ13Dd7k=;
        b=mF5QvJXC6nOaEvPf2qcKBfcab/9zZwP52ghmhtI35ufuG4325vpbj4fig01cY9wiNG
         aceWM8lNCUjib9xp9MXBMnFr+q37zmW+0aXetrXFRql/NNmH8FN3Eoaz8ymFEhSzx+HA
         GflsTbgnocGsfRSS9mJPRGt1U7Hzx8ynJXLPIM0jOmvFkVFyZ+uTigKDXwbD+0RtanOM
         aqO5ucdCBl0WjN3i7Rv6Kq/9vQM3fBeXPyIQlfb0tch1qWUIGpJtNoGS5EqgjQ8ckps8
         RLYlu4DRB9ZPRrtsi8utPX9zRXCf2EBKjsTEaHprcRzHOo5ppHCzdw7SzS9XYxOKV9j/
         0auQ==
X-Gm-Message-State: AOJu0Yw59xETWdwQIX2l19wyoEPTtFZhcDgtAWcElXPy2sa0xLyefrbB
	xpZVLtzLhKDvymIOh7+REzpdPPZTctT/Pmam1eV55KhWxKiOgZb/BU/5+y094wKtLQ==
X-Google-Smtp-Source: AGHT+IH4LnkZH4pYfUZRJbum6dHs8mQx5WWsMJza3vaW4PAkBGE2tT8lYqQYRad/oprlzfaCEcoOvQ==
X-Received: by 2002:a17:906:1cca:b0:a2f:bf0f:df53 with SMTP id i10-20020a1709061cca00b00a2fbf0fdf53mr196842ejh.92.1706036664492;
        Tue, 23 Jan 2024 11:04:24 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906c20600b00a28c8ab1342sm14692851ejz.96.2024.01.23.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 10/10] net: fill in MODULE_DESCRIPTION()s for rvu_mbox
Date: Tue, 23 Jan 2024 11:03:31 -0800
Message-Id: <20240123190332.677489-11-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Marvel RVU mbox driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 9690ac01f02c..b92264d0a77e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -413,4 +413,5 @@ const char *otx2_mbox_id2name(u16 id)
 EXPORT_SYMBOL(otx2_mbox_id2name);
 
 MODULE_AUTHOR("Marvell.");
+MODULE_DESCRIPTION("Marvell RVU NIC Mbox helpers");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


