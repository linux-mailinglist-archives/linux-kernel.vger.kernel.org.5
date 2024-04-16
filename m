Return-Path: <linux-kernel+bounces-147142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCB8A700B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18840285B33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC9131722;
	Tue, 16 Apr 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKoPsWCr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A9127B7E;
	Tue, 16 Apr 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282202; cv=none; b=afs8uBF/62egjQencN0joeiUjjVEYGzPfBRjnu/xlS7q2XkTvgcqNwxVxMRKTaodDwjA5Qm8zUfwG45AR88pYlgDywsQVSvL/Ra+vnD1C3norDUAEPd2p8zkbj2cMg2yja1LdEAXX2zs5/GETbERh82eIh9gZ4xoSYdpN/u9XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282202; c=relaxed/simple;
	bh=+ljhu//9lkmemnsfYqPaaR+oUUleH5aVvLvp0L9bs6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdBUm4np1N5rhTeeX3kZvkhg3Dw/bv09iPhXSYr19YSe3dXGkc64fXqIYDQr+R/qoRW4/FqU9+8L5aI8freKghnTTUdWJO+YIneSrKeYrE4zFycgfmVc1WNB5gGPHbRozjG8ING7Wv80SYkXKDooUhQM5sTSuaukcdFlM0Es+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKoPsWCr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so26151175e9.0;
        Tue, 16 Apr 2024 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282199; x=1713886999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rlm0dfXLfkEH5xBpat5170b8UC+JxKpO7m7UhhNk8/E=;
        b=CKoPsWCrrjqlEaLpQRaFrlrxXMogKf2QyCJ4lttBzRZGG1CFFxkaEaW4fTjhYsDRIE
         LHdZsRvH9nQmYC2AVTrTDFcCyxobsm4WUfODwzbh9OKmxq120D92XNmCOggLf6lyU7Rq
         oNTo7TciT1i2R1JYY9Z+RnCXVcxnmXiPdqunbgFIBBx/ddnc63CMSHKdxXZbfb6uHK/g
         K6tVK2dCqfH+dDmMRKJ4fdEFxuEbJWdYaki79DXUMiwnottpGyZqr7wl633zwyOsGL0I
         jTtOJBNFhTMFVLTqPT4iGp6gJIKgIAO8fmy572hYBapEKsCX+onO7HVJW30I977o4lMl
         DXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282199; x=1713886999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlm0dfXLfkEH5xBpat5170b8UC+JxKpO7m7UhhNk8/E=;
        b=AswtgWRUhiBXdB5pPDhc6er0AoNwySPXnWGBKKkEneWebamKI/eXseyw2jXApxoFew
         iNghY6w/TZxPoULOhG3dalBygGzMHmRbM5w8aYs52D/lmtS2t+FxEiQjj1tL9oW8quxr
         A0XqQTHX0U8F+zTJyDq1UM52nv65Ow+XFoWHVUx9YnmQm2W6d3/HMcW9AP738NUQ1KMT
         KBGw2qdzYTKE+AeWZ3y/klZumfzR+9MpEUvSpeKAOV1RzniCi20sU2ug0ve/eRGAGdL8
         VtXjvc1A8LOWBy0QIRZUQ7mSqMbqqvBzsMGmzcryraeqFu4D5rPE4WVfkB9jzZNv7TkA
         GqjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjroQXrEreq1z46Mws5sFdG31njqhMSZuyD06ylHX7MwrKXiXg9sCoZS93543VehhtCyB+H435lqd2pWcAEQdmsU6XpPd9JifpXK/zfguoMkCVmvzx1BtbxfAmj3iTmBqUlrzf27D1DvPvOzo7kUxdjouv0zQZLiggZr3avMSaRg==
X-Gm-Message-State: AOJu0YwWREOv9Q4wcQRLCEg1Dy98hFNuOs38yY5oQiVc+g16DX6HE0Mu
	F4HEW47qh2ZA/1162M5681TjZ/WrZEZVUH3QtAMwJoim7f/ailnV
X-Google-Smtp-Source: AGHT+IE65oRYbQjWzqoR0xYZpBUekWGdgxn6KmQ0t1p+/kqrnfx0kml9nE0ftIlR6iskBEI8fvGCvg==
X-Received: by 2002:a05:600c:1f17:b0:418:7e71:bff5 with SMTP id bd23-20020a05600c1f1700b004187e71bff5mr2306202wmb.12.1713282199081;
        Tue, 16 Apr 2024 08:43:19 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:ac34:e164:f0a1:f75a])
        by smtp.gmail.com with ESMTPSA id c10-20020adfc04a000000b003467a420243sm15338365wrf.12.2024.04.16.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:43:18 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:43:16 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zh6clAtI3NO+nMEi@eichest-laptop>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>

Hi Andrew,

Thanks a lot for the feedback.

On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > Add a new device tree property to disable SGMII autonegotiation and
> > instead use the option to match the SGMII speed to what was negotiated
> > on the twisted pair interface (tpi).
> 
> Could you explain this is more detail.
> 
> SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> the symbols 100 times when running at 10Mbs, and 10 times when running
> at 100Mbps.

Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
Octeon TX2 SoC, this means that we have to enable "in-band-status" on
the controller. This will work for all three speed settings. However, if
we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
disable SGMII autonegotiation in gpy_update_interface. This is not
supported by this Ethernet controller because in-band-status is still
enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
the SGMII link will not go into a working state.

What this patch does is, if the maxlinear,sgmii-match-tpi-speed property
is set, it will always use the link speed negotiated on the twisted pair
interface and adjust the SGMII data rate accordingly. For the Octeon
controller, this means that we don't set the in-band-status mode because
we don't use the SGMII autnegotiation and all 4 speeds (10, 100, 1000,
2500 Mbps) are working.

Here the description from the datasheet (this patch forces the SGMII
speed to the TPI speed):
If bit 12 is set to a logic one, ANMODE field determines the Auto-
Negotiation protocol. If bit 12 is cleared to a logic zero, speed is set
to maximum in full duplex mode. Once the TPI link is up, the SGMII speed
is automatically forced to match the TPI speed. This bit has no effect
when SGMII_FIXED2G5 is ‘1’.

Best regards,
Stefan

