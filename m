Return-Path: <linux-kernel+bounces-75564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8558B85EB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16273283B28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B02126F2A;
	Wed, 21 Feb 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ5+SQx+"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D3811E7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551907; cv=none; b=fnWrMCkA+9XdAJycwa0B1OmB1bC7VMb7TmdFYscXquMmG9CnCVisFbr87ER9bnps70k8Ba7aNebeXweq92wokBP4p1AmaJlxqsrwY9wTDR0SmBmWzawrJ+tQ4xZEzwN/PZQSuK+N9UbafpI3CYPco0x9m6jhZpQD0A+HFM6Xtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551907; c=relaxed/simple;
	bh=ZPuEGR02MJoL4k4cqYutB0mEV/A2o13a+K+wdiOYt6M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJcnDQSWXe3iSE9xJmsUVWVH1XW5Ko3TXJtGW62zvkesBG2UC6SK78ZbbubOReXu9UVH7uTrBXPqqArVTiZidSj7/XIolYhPgwaJpNnu7RY6UWRPJQ3WaA+HY5gSrM6ayBMEZxPPAD16bIVvPOAHzQk5hkRvlB+hc21Q1nRLDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ5+SQx+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d1f3144c4so771684f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551904; x=1709156704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYLsu8b5gS7pL7FVTOIGXi/uA3Al1fdlKI5v25Vpme8=;
        b=ZQ5+SQx+nsKyO8xV7QIl/s9IiFDRImCZBVGRjNiXJY48sVBTh7LmcVROrGQ15j1zMS
         YM1hd4eseNmyRPoeCdXwSHcMfF68SFr3zChI67nudDRK2Px+2MD09qbRqn8uRorDlyLa
         +4aDi32ge0t0QXJZVAVnGPoDCzibDOSZjyDg7DqEXUHiPaZ3CkjqZ2x+Vgh7vp/siuaJ
         fHg/gJuGeFA4bmWV4irlmqEMoZN5KizChoRGyl57YuJ/t5OZewVXmIb09XKYB60BXBH4
         t+rbtvcsEn9na9exg7FktGjmmKLNQDxiwhnxCJUz8hjir2J20fmcbmZuytel7/1N74eI
         CpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551904; x=1709156704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYLsu8b5gS7pL7FVTOIGXi/uA3Al1fdlKI5v25Vpme8=;
        b=xO2tnCHtDvBUmIN2axaes3F5veY5UBIn+HffVoV3TuVmZrP8EzPweEa6IIeYGjOEBO
         +Sc+0t+b9ZgXddV4PTnZ7h9cizYFka2o69tWgaUOwpm5RATdJs3LjJQal0O2GQ+SFj4u
         0Z37Oz6bBdnSVGoVcsxZVktX2HxAhAnmfKmj4DtZMhDADk6scKBw40cHuAxD16+S3EId
         FiWhRhXkEJFYGQ9pcFkf8Et0eo8lglwhCVLADwWG0LhvnDns/NAhPuyuAftg4BW5BLxg
         SmH0sk/XnofrYc6zpC+B+NO2GF+dVoGBrNW7w+hbGrZXxoyBUaPHkrptwANNMYVVKMYi
         Xfag==
X-Forwarded-Encrypted: i=1; AJvYcCUHr/z03GUyDEs005os9GTzpjE87JMu184aOAyowhVp0UBu7vmmJZpP5KTnJn2BDu5q6yw+c0/b0O+QDeoiKBz6kXcOhOVL6aS2p6F6
X-Gm-Message-State: AOJu0YxOlA+xLB7adJIheTsK0qaXdf0cJ4Mr0ZlW9GGB3NqgrSKfvXqy
	vGlJNAtbTRFv0sbHW1NnOIFPuAVkFrLkTdNELMvg+fFMamT/bRSH
X-Google-Smtp-Source: AGHT+IGAEP17ozOz4gedlovqxGmsaBEUXdqi9aioc7LXfG1ot6BAZj53rKmERrq3S2/GFedPMwjFJg==
X-Received: by 2002:a05:600c:1c24:b0:412:5670:ef62 with SMTP id j36-20020a05600c1c2400b004125670ef62mr416716wms.1.1708551904136;
        Wed, 21 Feb 2024 13:45:04 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b00411c3c2fc55sm18936261wmi.45.2024.02.21.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:00 -0800 (PST)
Date: Wed, 21 Feb 2024 22:44:57 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Remove variables Wakeup, Reserved0
 and AGC
Message-ID: <ed88686c1e9213dac1cc8f698f7dea8cb5fa01f9.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables Wakeup, Reserved0 and AGC.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 945874c1495d..bc4479f7d089 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -485,9 +485,6 @@ struct rtllib_rx_stats {
 	u16 bICV:1;
 	u16 bShortPreamble:1;
 	u16 Decrypted:1;
-	u16 Wakeup:1;
-	u16 Reserved0:1;
-	u8  AGC;
 	u32 TimeStampLow;
 	u32 TimeStampHigh;
 	bool bShift;
-- 
2.43.2


