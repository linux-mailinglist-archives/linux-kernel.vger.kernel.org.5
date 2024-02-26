Return-Path: <linux-kernel+bounces-80488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21D8668E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907D61F21B51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932091C2A0;
	Mon, 26 Feb 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lK1d6vAn"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AA1BC37
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919794; cv=none; b=pr8mbI3F+ZLAaeH+CHde3cs7iFc+cov/WLfLHvrCYX7Z7qdzJ52zus8uhNt2xXUQ8dWSL4bip305smEzOFl25DBPXwLeydz6PbT0CiIc5rdHY4zWq+3xvRSbcsnd9/NGRhnvg+2d2Pje/AB/XM6HvOq2SjFHutxDQX5arU99pLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919794; c=relaxed/simple;
	bh=Zhnubnov9j3g8AyIMp9VZ9sMhMszfUL6EZW6yyAZ+50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkCIXHpHgfo+N08j7Aa3cTQwpSTJ0M07wLw4ZxZhYMQr+qdBap/slK9jJFQe/+VxFPGnnrYeXBSHAbmV9PAX+1/C7RWw5GT+bskhz5oqXCqmwdvmg5OwbBlUnWMOyC/9s/v4sFYsPe0yEt7v6nmtpxdt+NMtnN43eFZyVb7ifL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lK1d6vAn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1987701a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919793; x=1709524593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY8iqPJEK5oTs16X2+XchY8uGKTkL/eHXG4E9OI6Gb0=;
        b=lK1d6vAn4KoKMVQ637hZL2VE1xVWdNCjsg+1+75yXg5gQAePp1KlFDI69ZnMJBQ9W/
         yfCdHZYku8nf16dhxGmRmZUNE1jtm3oZHi44zJnqy79B2U49D4/SdinVbNZCs2AOdlBJ
         m4UklZTA0HIiSq4guRVfquaOh9TA9VwiPrlp6jHctsC9LN1+lTYnM7iuhman7Yg2mAOg
         YZ/1wznVIZVz8QLIuQm/+U+NCUXi+pEuyD13mgipYSiv9PnU6Z32v5FjxLMVgtE8iaiT
         bnU81iP0y16ulxoDfRdTkBrUBV+3T8jLxhvUMkPPPLG65rDImOaWokab8hDHQRiR2Rhq
         0mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919793; x=1709524593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY8iqPJEK5oTs16X2+XchY8uGKTkL/eHXG4E9OI6Gb0=;
        b=iChmOIkgK+OrKIUH03PtUJrNYmMAcyoeNPnA+IgoS/wyv5juB5pIQ15n5Jil2IHYhW
         4+TP77zBywlgJtmqL6CqXzDM+FuHbqHOFvUdBCIitprew6M0HIIHcgZv7MqEvXUjX4il
         ZSyoNzBo3PBmXH2upgWOyGWAcabAXVPeqGeaUlDI9zDtfoppXFtTE6WxxFq5jlGj1YpR
         hSS9vXgX7YYKfE/oNGsS2qM4g7n3B+ePESsTSCHhgDy0cDMdA5yYnHY2FbucSMkXJ2CH
         ++Iulz06NJycp2SCPeyWOcFnykryQGFSrHCNwm8Nu+WGrNOKqAUFbul1rLi614rw3i0A
         dHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu3A4k4US3uQCWHrr1uTnu7ax0+sVYVRht1whglYDU8W0m8AsVD965W7ooT7pDnCONYSkdzVGxOzZSK2kNeRBaeKCulbs+Rz4l/v1W
X-Gm-Message-State: AOJu0Ywj9E+tyQpni0vVrRrjDOEQwP19janOz3knd8pklY1JuNLa79kh
	8rM4msxzgx4yD7N3NQOW7z35KjrIrPk2RrVeFg97tvF1ytVjqS3a7nlEuXUSniv1fUGZ2gV5Lvv
	i
X-Google-Smtp-Source: AGHT+IEIsn5Gewpg8fz2lFyYRp2mnbqWiLpuKPdbHy/ZoVTu+qMSgu72cb8S8exg4jEBltJKJYGFzw==
X-Received: by 2002:a05:6a20:9c89:b0:1a0:dfc8:9204 with SMTP id mj9-20020a056a209c8900b001a0dfc89204mr5098142pzb.2.1708919792922;
        Sun, 25 Feb 2024 19:56:32 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:32 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/20] Staging: rtl8192e: Rename variable osCcxRmCap
Date: Sun, 25 Feb 2024 19:56:10 -0800
Message-Id: <20240226035624.370443-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable osCcxRmCap to os_ccx_rm_cap to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9255eed85141..fd4bf3486804 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -840,15 +840,15 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->bCcxRmEnable) {
 		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
-		struct octet_string osCcxRmCap;
+		struct octet_string os_ccx_rm_cap;
 
-		osCcxRmCap.octet = (u8 *)CcxRmCapBuf;
-		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
+		os_ccx_rm_cap.octet = (u8 *)CcxRmCapBuf;
+		os_ccx_rm_cap.Length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
-		*tag++ = osCcxRmCap.Length;
-		memcpy(tag, osCcxRmCap.octet, osCcxRmCap.Length);
-		tag += osCcxRmCap.Length;
+		*tag++ = os_ccx_rm_cap.Length;
+		memcpy(tag, os_ccx_rm_cap.octet, os_ccx_rm_cap.Length);
+		tag += os_ccx_rm_cap.Length;
 	}
 
 	if (beacon->BssCcxVerNumber >= 2) {
-- 
2.39.2


