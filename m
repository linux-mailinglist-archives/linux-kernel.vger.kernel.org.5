Return-Path: <linux-kernel+bounces-80496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960E8668EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1BE1F23928
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513A1EF1C;
	Mon, 26 Feb 2024 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dOy7HIm8"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067351D52D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919802; cv=none; b=WYoaiEZlYbK3ads+aydKj5PdL6atOn5kz3MuFkv9rQ2OwUkOeDHTw5PhkpXQDSn9dnQ9cIgbIQOeaYE5wLV1scIpw55vojj1dOYkzYUpHjVR6KtFcOcCEieGag2j9MjhLHc0VfOpSxPOcWh3SUEll0OiDYeflwCcdT/bawK9Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919802; c=relaxed/simple;
	bh=PU+r0O6S245XpV+Rs9xKJAijgXkkWYRIGOWMDo/7qWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3KIEGeZnguU1PEeNTITfPQPStn4Djb4iUTZOvE51xBP2/0aoLvKDob4LfyxxNMdgt675AmNe6MtCgdmXHi/6MmwB45bHnW0hq39plaewFnknkKWzal5XD2Jh1uSfLfFlzFXysTkUv4nUM1F59uoKXEC5EqYS7aN5iWNsWMZmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dOy7HIm8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1563720a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919800; x=1709524600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dltjxfxWlIXrn+4WrlfjIjhm1kDm0y+Q0IFjKykPQVs=;
        b=dOy7HIm8PfxiCqUXoP+trCwbg/GXPg8+8t43FQRtJXksqBVBNH66rBeB2fKtP25IIW
         rhdh5OEC06sqU2TvHJ9s3jPttJ3tXDHym7+3g87P/gvNJX1yQp5R46aPNVvlatUBpqD4
         tRuIbyI+TUzSsRpwVCnMlZaaVZfq1a2h39JguuRwOl3brLK3g3hJ+IH6JQgKxx+4ae6O
         2HkQbhBfKisALrbXeAY44240r901c2epw+gmqxCOF08J/g9t5Mz4HGrpR3GP4rbFn+6A
         y0ciCLfcG/k6Ap81brFShSHn44kxzCiMbnMuQWiUKJJnq+SdRqm2t6I4IeHHW8OADaf3
         pS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919800; x=1709524600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dltjxfxWlIXrn+4WrlfjIjhm1kDm0y+Q0IFjKykPQVs=;
        b=dREwHJUz1K3xF1VRKo1CZzr/tS9nifhQFaVAqwlab/mhSV1z+8rpwW0x5lcY/OQrKA
         Tzmc0D3Rgvt92fG6nPUykr+K61+MyunqLK3Ux60jWpkGstjh+nWnpvPbANrlJ9k7eVjP
         EQJv95p2kQa0WMPtWXTVcWHb1u/RNJJ2A7Cb9Lzja4/Qh7k20PaLB18eUvP9wyKjCLUR
         kvGtBFrn9a+4GMP5xTJOEwZHyy99c92jNR0j96g7viShjGsvtqoE0yrjPiGFUnbthcrF
         K0xoUBoeOyXcOoGwQqQghFZahlw1OvBBalpp1y2ve/10yYbCEsKRRsjn/K/nqXsJVn0E
         rJqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/77Vt67VeLiTEoKmA3mQp13UYEathTU2XxRYQhUBzu88b8daksl1vBS/NPO2pmbG4UlOnm0GQcizEkJVO+vNlN3tiH8cVVgE5KqE2
X-Gm-Message-State: AOJu0YwPo7zrtShDKlgxq3aaV/xy29cUUW/hPhrPE+YE1qKz8+LO3d1G
	o5xkwwumnzjl9Prd6exVXUoxir4mkKFGbvuo+dmAnaqZ4MSNc4pqvOpBUgXad1w=
X-Google-Smtp-Source: AGHT+IGmv4Cfgz7MuTtjpdIUZmtBc5HhsU+JcufWs7k7Xr2dmGU1dvYc0V6YCla/qqgOAXUVPBbUsA==
X-Received: by 2002:a05:6a20:5a21:b0:1a0:d2ca:d3b6 with SMTP id jz33-20020a056a205a2100b001a0d2cad3b6mr3090933pzb.34.1708919800343;
        Sun, 25 Feb 2024 19:56:40 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:40 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/20] Staging: rtl8192e: Rename variable osCcxAironetIE
Date: Sun, 25 Feb 2024 19:56:18 -0800
Message-Id: <20240226035624.370443-15-tdavies@darkphysics.net>
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

Rename variable osCcxAironetIE to os_ccx_aironet_ie to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ff912cdac9bd..68194763b20c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -820,21 +820,21 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->ckip_supported) {
 		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
-		struct octet_string osCcxAironetIE;
+		struct octet_string os_ccx_aironet_ie;
 
 		memset(CcxAironetBuf, 0, 30);
-		osCcxAironetIE.octet = CcxAironetBuf;
-		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.octet, aironet_ie_oui,
+		os_ccx_aironet_ie.octet = CcxAironetBuf;
+		os_ccx_aironet_ie.Length = sizeof(CcxAironetBuf);
+		memcpy(os_ccx_aironet_ie.octet, aironet_ie_oui,
 		       sizeof(aironet_ie_oui));
 
-		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
+		os_ccx_aironet_ie.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
-		*tag++ = osCcxAironetIE.Length;
-		memcpy(tag, osCcxAironetIE.octet, osCcxAironetIE.Length);
-		tag += osCcxAironetIE.Length;
+		*tag++ = os_ccx_aironet_ie.Length;
+		memcpy(tag, os_ccx_aironet_ie.octet, os_ccx_aironet_ie.Length);
+		tag += os_ccx_aironet_ie.Length;
 	}
 
 	if (beacon->ccx_rm_enable) {
-- 
2.39.2


