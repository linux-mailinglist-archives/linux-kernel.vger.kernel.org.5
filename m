Return-Path: <linux-kernel+bounces-18-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91324813ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A5AB21124
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA16A020;
	Thu, 14 Dec 2023 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+RTrvfc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C86A336;
	Thu, 14 Dec 2023 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3364c9ba749so272169f8f.1;
        Thu, 14 Dec 2023 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702582331; x=1703187131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZwA4coKcId6uh+NhWHu2prHRdEVSOKW+sQpZ6upqMM=;
        b=c+RTrvfcTr5gmGWsv9b5DPhDRgRW2P4H/BeMen6V0qT49niZhSMM/m5Z2zMafnCoLi
         7hnL73FdpOJsk8k+xNuSGlinBCrp0OHDojabP9Q6nUnMyBDSGtbhrpn4Zyen0/REAHY/
         l+4720cdpd8/UAOSA6jm/Lk4i8qjcBbgo3VyL9IOnFPZzuHzFB7cXRZ4lzAu6hlFnjK7
         ys5xs5MGT9LMpLDCI9/2FcwMDjJA4oJjX1Yfwn5DjF9NjvzzOITm5pgebQPgaO2x7eqS
         G+fnYq5ST4ZuY5VrvVSdCSqhvXKscI0DsaXzca94pM/rksVI2ZxllZcgeP86MK61HIvA
         iN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582331; x=1703187131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZwA4coKcId6uh+NhWHu2prHRdEVSOKW+sQpZ6upqMM=;
        b=wAcK25WSran0P2dmdxe6q/zjUFxwtiHY4KZAP1a69OnPQcmsqQbgA/ABUZil5HYy6i
         XJ+MtMZba+hU9z2LyUciQzIrUErWz+r0bcfTkueL07ycNtOo/BnBDpDYheEi+i3Jx7ci
         uPVxb9CBDbv/WpHNRr0pWWtOUxAMLN2y8IgVL3DAjT43qhbaxBh5I/0u+dfx7Lajn4nK
         bYQif7FUEJ1GewoQNceScCRHbL1d0jRg3l/FXPV9kWx8T0Bj1x3Pbbp5jr9XHx0nfYpD
         fjyZAewXkbHltVtN+c5D7Two+mc8kaZ4/l/sDLfQOnlURGENFXNPZrQWxSOP//qRxO6O
         Bbhw==
X-Gm-Message-State: AOJu0Yx/tqOcki470jYNWWKFuZKalkl3ueVGwXISfs3zHoxYhixXcZA6
	TxSEznYz4Kr4LegcHgZATcQ=
X-Google-Smtp-Source: AGHT+IHtsRk3mvow3KSNtH11+JtzAaTRNz5GbH4j5brmp/1GnWTdRGOSdNUSt5RAhcs8f2RmNTqI2g==
X-Received: by 2002:a5d:69ce:0:b0:336:3ee3:d07 with SMTP id s14-20020a5d69ce000000b003363ee30d07mr762877wrw.119.1702582330895;
        Thu, 14 Dec 2023 11:32:10 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b00332ff137c29sm16934629wru.79.2023.12.14.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:32:10 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Lee Jones <lee@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Chen-Yu Tsai <wens@csie.org>
Subject:
 Re: [PATCH v1 1/1] leds: sun50i-a100: Convert to be agnostic to property
 provider
Date: Thu, 14 Dec 2023 20:32:09 +0100
Message-ID: <12339724.O9o76ZdvQC@archlinux>
In-Reply-To: <20231214192131.1309912-1-andriy.shevchenko@linux.intel.com>
References: <20231214192131.1309912-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 14, 2023 8:21:31 PM CET Andy Shevchenko wrote:
> Convert the driver to be agnostic to the property provider.
> LEDS subsytem is not dependent on OF, so no need to make drivers
> be a such.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



