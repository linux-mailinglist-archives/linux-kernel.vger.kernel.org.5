Return-Path: <linux-kernel+bounces-82695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E070868850
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73071F2470D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DC56467;
	Tue, 27 Feb 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Jj3zID0S"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41355E55
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008938; cv=none; b=QFCQro3zKXT+KCUm12O4J2sanMERfWUq50ZDq5sgv8Yq2OuxLXDk/HDKyUFW67HSwjw5u3B7IWST+l3YfnrMKGEk9isvkUdfvjth/NclM0pYdESSGrJh/Q8DsFTpDyWrZt0kOkspER7r+KGjAa/N0NCH+LaZPcw4MnUqF+Ahv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008938; c=relaxed/simple;
	bh=tqcc9gB26d1zgnSGh753STas+DgJU/zFIqtBXvVY2h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8DD9HDl2mOMMse4ZMwpyRbqw48fw6RCcFu2SkvPAPR0SdpIaxfqtfQolAHwLwh/8McXrSHwHQoRq74mrshp0CUtZ3ifdY0sHa0Q2THdP+jAD2w4TRbk446Dy+PCLce8KJ1OzTieZTw8nB1awm72ddSUepmxQkA/FHEcxxYgBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Jj3zID0S; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c17ac08a38so1714272b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008936; x=1709613736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGjxrWfSkdcoBSYz9zgMBbu18xLKxQVnlKOGiNS55KQ=;
        b=Jj3zID0St0cWFi6z3Tkf9khO1jEnSqIXFX4MARAZbv/7qFD/jQibgZgB6D3+S776Ws
         STLaFf6Xbpvuf1fZJtA2BUWUD/wrqy7fffw9WjSJtK5868ZW08ncXfB2ZmI6GK5BI6LA
         TimH73b8+Kw+kOoJXF+lyTDcBvZt7+BkOzryTXuxrQMWt5oSAaTh6hatLgWgmvOqc7c3
         GHcobLSlwiih0qQ5juCXgrJv0HhQKduROsATpgopUSFFrXIfyFwwW4DGrsCmFSdFAL+c
         fIm/CUtKSmHKz2WZcOslZ/Uto1TOyCEk+nX3m1tWR9A/MnX6HHTGJz7jMiI/zd/4g10K
         NagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008936; x=1709613736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGjxrWfSkdcoBSYz9zgMBbu18xLKxQVnlKOGiNS55KQ=;
        b=ryWRtSiLSi9Hwh1qOK/vKMeAQqjA0rf8N3YdB4Dmn6tbJoFVhi7eBigql65Us4kWDv
         +1p2ytfyBHNkje6UN85yK5ZNjDAUrwiVq5zq+vs/PW3zatUk7fEitX82RoctFdjSajjA
         ogP5skwlkEjOplsWcZo60+UEQd9Nwgfq76USWUrqCx2dUkdp4VqvGnhI0x0gVcKQ6sRn
         0FESIJnQGoN8wHLvaGxZiCibOvHvUvpT1H13vpmlJsV6bzGyOT9bpf1fL3j8F/HjPDXA
         y/UtEZwaghCTyCuB4USIr3HEcMmjHl9iwK0wa9vaRj12buSZ3otVg94lH0jhSDR+vSDa
         W7pA==
X-Forwarded-Encrypted: i=1; AJvYcCW+8JCqTh6jkoHT6kTqVBSJy7VMTvF5PlyPCQ3jrMEUrX2W3q/47WChT3qBUfq9XW1QfNWsuGERlNIQ7CpstEHlxcSAlwQWJjSODRnx
X-Gm-Message-State: AOJu0YwCETNMHnPla/RKuFWVDU8oFeJRTv6rDR1HQBK6UbijGBzAlior
	i0mU20y1SwhTpLz+q0qTwqGmAY6uqbiDkvaHvC69XhfTtfwBizz2BeHxeZcl+PQ=
X-Google-Smtp-Source: AGHT+IHZaax2qw5NUDsSsoTWWNL5lFHUm0IGcmncb2DRReoxqE9EU2USBp4ULMg16kaET15VNnJ51g==
X-Received: by 2002:a05:6808:18a8:b0:3c1:b01e:4db3 with SMTP id bi40-20020a05680818a800b003c1b01e4db3mr113179oib.37.1709008936498;
        Mon, 26 Feb 2024 20:42:16 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:15 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 13/20] Staging: rtl8192e: Rename variable AironetIeOui
Date: Mon, 26 Feb 2024 20:41:50 -0800
Message-Id: <20240227044157.407379-14-tdavies@darkphysics.net>
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

Rename variable AironetIeOui to aironet_ie_oui to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 880ce2bfd0eb..da8be4383d69 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -818,15 +818,15 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->ckip_supported) {
-		static const u8 AironetIeOui[] = {0x00, 0x01, 0x66};
+		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
 		struct octet_string osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
 		osCcxAironetIE.octet = CcxAironetBuf;
 		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.octet, AironetIeOui,
-		       sizeof(AironetIeOui));
+		memcpy(osCcxAironetIE.octet, aironet_ie_oui,
+		       sizeof(aironet_ie_oui));
 
 		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
-- 
2.39.2


