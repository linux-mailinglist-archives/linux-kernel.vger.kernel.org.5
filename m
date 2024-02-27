Return-Path: <linux-kernel+bounces-82698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE5868858
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BCBB25FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072A5676C;
	Tue, 27 Feb 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="guYHwSBa"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB05674B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008942; cv=none; b=Z7ZpAbr416E7QpLqaOXVKx/vnOFgjB4djv116yUQ6VDf38WZ/Po2opBF6XX/+SkwcFV9JUmo+BfD5q1+mgcohYbk0cxu7zKooUpwo89Hn+CGzlAA2nWF1PXfcEzIeA2zn2JSZeE3RD7bKYup+MQV+jBa8QexOdU/KmyjD8gO2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008942; c=relaxed/simple;
	bh=xQjE9qceFGssnOktGdgFoh4IaBLi/CUVDPUQlm65DAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzNmO/m3ZhsXQOsQO3jT/o38HsVpFA7ubKSsmrM/KTHpEwYbKwn5350OFiHo8MBTiM69ppz63nWxTa/IaM/2IUeynY/CjYPgXA6hSiFsslXAGoswnMPFsJmBZZQHbDOtjuQHr8o901bLOXARDSdvg50iN6yXD1PRbDCHkhziKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=guYHwSBa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de3141f041so2411251b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008940; x=1709613740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QC7tGFV1wXK2wCdfOZhadD970J6aNSSO5r9X5gYosE=;
        b=guYHwSBaZfmbiHjZacR21x3lAOSp7LZG0tV+7W24A48Kbl11dU05ea4aBkRtcfN8fU
         5YGsXV0XzFUBIUYjucJCanIK9pMxEGyfBhsHnS/0xxD0wk1tIPfycBJp3/uVJ5Z7PoGE
         XBLj9KGOEOLnJmnTSxhzH4fmLl8tkLde4JgLHnCZavk0JXsBUKQwCbsgLp2pNh9IzEeZ
         A1JzaX3064bBNrpNvVws2665I/S0V5Ox7Sk7WcazCkvy1ugTjZ0u1SDUYu8sF246Z5J/
         ipVuqjNP9zdhUbtMQiGx52d0Cp2Z/JJKYyHvB5OMh3wjunNsU3TnEq6/eah9gmjdkVUg
         5sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008940; x=1709613740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QC7tGFV1wXK2wCdfOZhadD970J6aNSSO5r9X5gYosE=;
        b=NatdSX4NYnoMGb3EV9w6bt6+MtRHC9VZxEOMFobJADaO03+TKMmPKR+0jSD2OM2QhB
         lxTNatlLOZmMulOX97QCze62b9VuzQuCpdQpEA6NOyzCRhnb1vTkYSVq9o6SVKVf8Tfm
         sYAHqFK9g36tIbLautCit1EWRmQNyjvY+NWw4NGj1ipOfac0hajh8ilpQgqqmKGOk5Ls
         VyOmO5FW/UdLxuKqYTS/EjzS2rtHlrlJiUQrXsmWjYWCus/SExBhSn+9yAmhj8TY0ANw
         F9xALXCZZBL5wWBH2DuN1bEigQyxOl/abC60YFBGu+/TMihzy2hqtL1n1BywL7K2IHTI
         kn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2k/oZhN/HAaUE83gmLiPKDF/w11Ew0Nk+xBAAJU0EsfmaKrsKCe/OitWx1ppIg40fM25Ab3XjuozV9RcptXu9o3OzO9ZFkaLzf+vO
X-Gm-Message-State: AOJu0YyI1XTIBlhIKN9h7JD8pbsUA92dpvbySZxWPq5hz5ND8KMmENb3
	HfxaIcx7j4F+xXzUX11A74Fyf6bFyRG7WVz4VQO/fQGAfR4auh/Vq9NxCzVtzHo=
X-Google-Smtp-Source: AGHT+IH0rml7CM8Hprpc9X69j3fgmPBZN0XInwcaLj7X6tEMC6DKR5HECWSvFjz6ERMNupKjn7CsoA==
X-Received: by 2002:a62:c186:0:b0:6e4:d0ed:d2b8 with SMTP id i128-20020a62c186000000b006e4d0edd2b8mr7627506pfg.16.1709008940004;
        Mon, 26 Feb 2024 20:42:20 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:19 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 16/20] Staging: rtl8192e: Rename varoable osCcxVerNum
Date: Mon, 26 Feb 2024 20:41:53 -0800
Message-Id: <20240227044157.407379-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
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
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 51fa9db7d73c..567891123960 100644
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


