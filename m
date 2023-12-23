Return-Path: <linux-kernel+bounces-10195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B681D121
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83127287B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5C1095C;
	Sat, 23 Dec 2023 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VlXfyB1z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA369DDA2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3dee5f534so24579195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296796; x=1703901596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bqp++MAnkQTUv5/XZaUL2Oh6X/aSgAe86kIBRlzDrY=;
        b=VlXfyB1zHOFMBE1Xa1H0kRH5DLafX09eeuFIla+ytgrduu+CVHVTyQrQb4Ioo0EKA8
         d1SHDWyd97Rxw1Zy73PNinSnMzlPUZ4Ru/rTFsg2iW21xN7Kr88g3eAFtFouG/EDThna
         /c2ubjJV4IpRIglneRYPUfzxaFhcx7O8pAzZg8LmqCn3mVjinM6equNUm0LOnLuxAC0u
         +cweEarYdC/vmKT2UBo+1IzoIyv8IOXjgknWSl9iBfwJS/6P9Fa8uZWuKAReeNlwJbRg
         TBkYZqimhuewoFkWijAhEkpdLiOlNL+jZC6k9qUqdQNdkzc/VPnMtLLKM5/pV0pcqkCE
         ucRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296796; x=1703901596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bqp++MAnkQTUv5/XZaUL2Oh6X/aSgAe86kIBRlzDrY=;
        b=gbj+lKqiS3vVGYKDby6TFTOoZ2rzIatOm9VplbsVVmUQqTVJ4e/MXVPiiwuuZwTMkL
         yoSZOFcFeM19eNbsRJfuIjul5fAJuWlkss68bmWfwQhvGwrtheu6GrLgUjItFPRUvzvU
         KYPcfE1QchmuXIOzlZvDs4EXwcS/N4Ek/71gzPt8I6pOKSJBdB6qtAtwlZ+s9iMNPPj7
         AOeRKy1MVb5dt9ztLl/9YwMYhtMSW3AM6iM9PcyJq3OTzTYCYA33+QFgYQQSu5f0NMer
         CexCkPaIdFytY0aZpeVfsi5rpgYdxSbBEnTdw0ew3vw9nJ01aSvxYp0saDUK22J6gnDf
         Gepg==
X-Gm-Message-State: AOJu0Yw7O6vrfFwIs6tr62of1VPvHLdgUMwQTGlF6Q/8owAr3Ip1623q
	2A7fVve8Qjw4jt8KG7phn1HOf3fhdrFIuw==
X-Google-Smtp-Source: AGHT+IEmDBgl9HWu3T9deeNsee521BwknLE/M+n8V5jLouQnyzsnfKEaQRl/Cwv9Z0qqaaxJvx837A==
X-Received: by 2002:a17:902:ea94:b0:1d3:eaaa:a2fd with SMTP id x20-20020a170902ea9400b001d3eaaaa2fdmr4267576plb.48.1703296796090;
        Fri, 22 Dec 2023 17:59:56 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:55 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/20] Staging: rtl8192e: Rename function rtllib_MFIE_Brate()
Date: Fri, 22 Dec 2023 17:59:34 -0800
Message-Id: <20231223015942.418263-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_MFIE_Brate to rtllib_mfie_brate to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c268ed6451af..6a3a8e0bb036 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -44,7 +44,7 @@ static unsigned int rtllib_MFIE_rate_len(struct rtllib_device *ieee)
  * Then it updates the pointer so that
  * it points after the new MFIE tag added.
  */
-static void rtllib_MFIE_Brate(struct rtllib_device *ieee, u8 **tag_p)
+static void rtllib_mfie_brate(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
@@ -341,7 +341,7 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 	memcpy(tag, ieee->current_network.ssid, len);
 	tag += len;
 
-	rtllib_MFIE_Brate(ieee, &tag);
+	rtllib_mfie_brate(ieee, &tag);
 	rtllib_MFIE_Grate(ieee, &tag);
 
 	return skb;
-- 
2.39.2


