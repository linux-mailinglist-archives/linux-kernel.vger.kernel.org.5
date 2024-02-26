Return-Path: <linux-kernel+bounces-80497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890E8668F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6231F23B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477E1F95F;
	Mon, 26 Feb 2024 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="H5Bfh491"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF531D55D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919803; cv=none; b=YREyebO1jmJOXZH//cbCDzC04KzTq3sMsv921j4KUoPo1dodZ81lcSa0eUDqxu5X0/FzVpkNjkiKaPvHFlFrfMtrnoZNt2HKORBdUwRalzaCj7vE+9S6DmmrWD1jSRKLHMAsBOVz9nSG+ohSaVYPxmepvn0Bzr2YeFLtctAKVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919803; c=relaxed/simple;
	bh=KC8f5tKLcakXLFJnCQDVtL5djU4Oic9YsJ5qZcyvzp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G20KfRSV0N6pvtSotkR7J85eMS6YSlOQCgyKEZdyGq+x9vIupiQlFTmjd5dRx4dpF5aQnVnqCcY7VQXCfaZ3v/HWfoFhgCg32HtgQA/Z5Vz4HHtSAnkDlvRJWMKxxDvMefK+uwWo4mL5iONToNYOEKrnSRMZ4PNSbr73kPNfDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=H5Bfh491; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2607503a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919801; x=1709524601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2UOCiOq3z4TaNYTS3NvfUhT3Z3UJvF129xHaAOmoRY=;
        b=H5Bfh491BpIQl7msgdV6XdcfZt0hsJXMZrHms8FoEf4yJat9GsdJ65YBzWNM53p+r9
         xpfCrCp+fv7kTlP5T1gUiQjc06iwwTXVO3N9l+RC9dKWRb+zn0IInGMKxVMu4pvu8yC2
         EWz5Z613Bj9Dnk7XTGdGPsBodtRJ+nI8EJF4cZ8COb9LS/YC9dRE1usg4mPz05b7AjAQ
         Q0NVdzR6U8mhYerBRc37ecnWKEPg6BdRJoGiq/SDnSFc4Vw4ciuZ10m2TuBZ3tTcmrvQ
         vj/PV6TV4NwI8lLWHXBtL+MCOjNrtV82EeetTDKrYG0S+7NXmyVZqt9OmWiNuq+ClH49
         3n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919801; x=1709524601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2UOCiOq3z4TaNYTS3NvfUhT3Z3UJvF129xHaAOmoRY=;
        b=MJQ3Iif4Yd7U3xQfoWOWxQ4gmDvY1a6GylFSokoO8NFV7vtHTW3geQ4FvcIsBZW02T
         R4kZJrLSs5SVCDXKbNl/QBvU/PdRqueP8+u/JiZbbIj4Em8rLJrZNZscUR14jOKKQJvC
         HrrPcU1dhJADjVW4lSP1+CjWBo2YmJTZ+8Vz4N/vz5jDEapzIqRvDNIWED3dPcmKRfzf
         2rEi7XY+wnYuMTR6cThkiWNXyc9Fije0vrk9VZMCug0/M0RtH+iCKpSpH2LxnnSjTBwX
         hSjl5v5G+0HuhqBOyEnfapc4ofR1xnEyzbNMt6v3m4DAA5J5EMOOgvKgKX2f9BcmBkR7
         sGtg==
X-Forwarded-Encrypted: i=1; AJvYcCWLRlPu48SeeBvRHQC6q/UHpZDl3InALsosnhDDx1wkV/hJ8BGb261eO2dO9SugS6fWb44jSTH0/OHwMK01p6QQfy9InoEzTs5AQuii
X-Gm-Message-State: AOJu0Yys/mR6rH5U0Lw/yL2BTExwO18iiDFOH3C55royntXrN9uIyg2y
	KAeoFKx4cSULl/WNtss9XBAPaDBjZeMVTuUGGo9qcYGV071x5gQABmuIt+KfX+Y=
X-Google-Smtp-Source: AGHT+IF2sk9/Qcvi/q6Sk2DytQViKRdE/SjCWRk5v+V3gfwmLtldkF73DmJHH+T/4ms+JGSBCrSTcg==
X-Received: by 2002:a17:903:2312:b0:1dc:89fe:570f with SMTP id d18-20020a170903231200b001dc89fe570fmr6193728plh.68.1708919801095;
        Sun, 25 Feb 2024 19:56:41 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:40 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/20] Staging: rtl8192e: Rename variable CcxAironetBuf
Date: Sun, 25 Feb 2024 19:56:19 -0800
Message-Id: <20240226035624.370443-16-tdavies@darkphysics.net>
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

Rename variable CcxAironetBuf to ccx_aironet_buf to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 68194763b20c..c088fb28c62c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -819,12 +819,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (beacon->ckip_supported) {
 		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
-		u8	CcxAironetBuf[30];
+		u8	ccx_aironet_buf[30];
 		struct octet_string os_ccx_aironet_ie;
 
-		memset(CcxAironetBuf, 0, 30);
-		os_ccx_aironet_ie.octet = CcxAironetBuf;
-		os_ccx_aironet_ie.Length = sizeof(CcxAironetBuf);
+		memset(ccx_aironet_buf, 0, 30);
+		os_ccx_aironet_ie.octet = ccx_aironet_buf;
+		os_ccx_aironet_ie.Length = sizeof(ccx_aironet_buf);
 		memcpy(os_ccx_aironet_ie.octet, aironet_ie_oui,
 		       sizeof(aironet_ie_oui));
 
-- 
2.39.2


