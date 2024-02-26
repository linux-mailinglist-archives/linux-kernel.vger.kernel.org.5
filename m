Return-Path: <linux-kernel+bounces-80498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCD8668F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FAF2830E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292E21A14;
	Mon, 26 Feb 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JlvuX4+5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116271EEE9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919804; cv=none; b=KJRrHFl5cD0nKa4F0JPICjK2Q8Xif6dmRe55xcwu/Yw2t/1aCu36RbrO+z7drTTWFEjnUMpk756HW7LpE0ibRxpCC8R/Vd92L/af/+dP08MdPkFeZ3NCFsvT3BZuhbqXjz3cAokr/XMYlrH+v9ZKYiD12Odfv5udH/T1n9P9ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919804; c=relaxed/simple;
	bh=xkAJUyHT9IJVaPQlnOZWTRhXRab/KfstgsbTL98+Dw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4HgerrIqItRelPcTz3KYtnVo1trkVHoyf66OpkwS3Kpb1Z7Mg6MvQxlv4tcQjN9I+0sIS7/SNEuGtGnP/K3mRBNN/7omRZ4KGsrdNo2ZeLEZVevIWB51BuzRBiIfa/Jfu9DG/CLMt978xx1VXMD9yb785ffHmJDTNEJ9kLVdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JlvuX4+5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcad814986so17965ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919802; x=1709524602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgQudfHXYX2Ros6YWs5QZmighXOkmI4wP/T3q7E/9FE=;
        b=JlvuX4+51AlImVJevwTO7+CQBNwKe7rK5bvCRsMBOeFU8mtzeejHK3riZ6YeyTgq1W
         dK3X4S/BjHkYh9zhJoZcTTTB8BJWdm0uk4oGm9aSYCoTcgNjEdgqueovC+XaIqq3tHkQ
         Y2PnMlVCoefrLG1Yasr+rq0cgiJMYzZCBYax7D/KM6Blc7XjH/VypyifkvqEJy+89+Xk
         7qavy+UuIltMrhkXccfqG/Q3c+MrpB5Q3/WvKelPhQ5CPzNBP2ufiVXp3YtgxRaYkhPD
         PrQ6gRQKBTsP3V0PEtK06na903AQmXR73cjSOWMNQdkSAa0n/C9zxmuZvlMXsMVy0iot
         k17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919802; x=1709524602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgQudfHXYX2Ros6YWs5QZmighXOkmI4wP/T3q7E/9FE=;
        b=JV4JuaPkSPBGZK1hv88SE735E6KWS34PFtd/oKfIuLLCphoSCM8t8WhHOMvdi1itNX
         USMHE/bk8f6LKRtkCKG58PZJ4CgkJhihbNpIqUBIw1j+i7SXHpUUF6L8AxXpj5g4fERV
         PnlgkABUtr2SHXxnEQU9oRJWrGh4dft2Nrli7YpIE0iXEH9HL7W0H92Qv2tAIV5gNZAe
         PGk0NAVhDshjaW51+wYnmrQH6Xymqiw0WeGjGPjTGCWmNAhxdN11eif8+QT5nRt0SmHe
         cPIKtwXnQH+3oByOMJtB64etbP8xkuOdauBtGLQ+pmmwGEPHUPOPi1Za/E7ItrMlh9fT
         XZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGJW8jogQU1e4rjzSDpPNucM7FqtDkkBQmqtk9SizqZ3JwUs4vJFLTpw/SzbKtDQvyz0x8hzLnaK0jH9H8tl03Qhx/b7VbeFxDu6h
X-Gm-Message-State: AOJu0YwsM+P6HN6REmWfYbkKx+6WeKQFg541Yq5oy2jBpueSwu3bVJfV
	7CBi48Ej6cRfrKRm0YIF5bJoCtSm97HL7Awz7vv2S5mlVTwjGwYFXX/Lj344eEkjHtRjrXJAU7e
	/
X-Google-Smtp-Source: AGHT+IGq5VHIZ1QfePCr9oytm5Hdu8/xcpcyImSchOSf8PrVuTZWnteSRt0h097oHPDqveaWYDWFlA==
X-Received: by 2002:a17:902:e752:b0:1dc:3e49:677d with SMTP id p18-20020a170902e75200b001dc3e49677dmr8242640plf.26.1708919802531;
        Sun, 25 Feb 2024 19:56:42 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:41 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/20] Staging: rtl8192e: Rename varoable osCcxVerNum
Date: Sun, 25 Feb 2024 19:56:20 -0800
Message-Id: <20240226035624.370443-17-tdavies@darkphysics.net>
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

Rename variable osCcxVerNum to os_vcx_ver_num to fix checkpatch warning
Avoid CamelCase,

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c088fb28c62c..bc08018185ca 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -853,16 +853,16 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (beacon->bss_ccx_ver_number >= 2) {
 		u8 ccx_ver_num_buf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
-		struct octet_string osCcxVerNum;
+		struct octet_string os_ccx_ver_num;
 
 		ccx_ver_num_buf[4] = beacon->bss_ccx_ver_number;
-		osCcxVerNum.octet = ccx_ver_num_buf;
-		osCcxVerNum.Length = sizeof(ccx_ver_num_buf);
+		os_ccx_ver_num.octet = ccx_ver_num_buf;
+		os_ccx_ver_num.Length = sizeof(ccx_ver_num_buf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
-		*tag++ = osCcxVerNum.Length;
-		memcpy(tag, osCcxVerNum.octet, osCcxVerNum.Length);
-		tag += osCcxVerNum.Length;
+		*tag++ = os_ccx_ver_num.Length;
+		memcpy(tag, os_ccx_ver_num.octet, os_ccx_ver_num.Length);
+		tag += os_ccx_ver_num.Length;
 	}
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		if (ieee->ht_info->peer_ht_spec_ver != HT_SPEC_VER_EWC) {
-- 
2.39.2


