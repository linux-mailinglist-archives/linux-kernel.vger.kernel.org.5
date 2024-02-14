Return-Path: <linux-kernel+bounces-65912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AA8553A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207C51C25096
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4413DBA1;
	Wed, 14 Feb 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECUbcmGz"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A65C90E;
	Wed, 14 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941074; cv=none; b=bWpA1X7If7XatwmbAAXOyGdR2SVDh+86DZ4VIPpuquTxo4hfVQggEtLAehtJykuY7M8Cc7inKna2Y/cBY/BPH6u7tcguc7n1apMVxBaqG9VCvLGXZxEdooJh/Zg7RqXxQSjg37RTy+bfw9LtLXhZJddUQrtCYbaK/RA7faoZZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941074; c=relaxed/simple;
	bh=Nyn4zdMUYJcetucv3ZLRDWdEDWYVJZ7irXf29bg1UYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdwQsLOs9Rj37WTZ1wWbYFz89D5B5GBrVVrYtfestbifEL1Y6q94ujROOfZs/uLc4Os3ZGZcYS9xCUKoJ0/7eiw7kcbxAN0NRhqZyfa603BO8sNo9MVCP4H3CSxrHEf77VC5lBGor0Nx4QUPt7U/pjwNEgBXXniOJT6IISleKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECUbcmGz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so1028411fa.2;
        Wed, 14 Feb 2024 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941071; x=1708545871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0+QBUAm/aVRpiPaqhCze/LDszKrnlyY/NggllvOcA0=;
        b=ECUbcmGzTskJcHkgrvyawdZGtqmBIkf/vSjf2iEOtt3HKWp4n+oY05HEVf7lg01bSS
         xT6pfIMET1doO95Ydgp4VnU64XG26ip82R5vUAHkN8xBmKi9psx9gsHyyi9hobMQL1pf
         hpCaFxnM8VjmlPZTwM8cPZvdBMAuRpBLuNbRPWdq4PYS0VF2/Acmt/XWdCCFMC7U0fkU
         M1DncO8HDDKDLK4XI4INLwUUgEbn0adqDWUPondFBzrVOlcfKW5Tj/2fEL7cEBfLhosp
         U2Bb82U/yXKQJGlOzyloTfHLbxFnQto5XG1+qtQuPtVhQgM5/E7fOAvT1vku3G76eo5b
         q98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941071; x=1708545871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0+QBUAm/aVRpiPaqhCze/LDszKrnlyY/NggllvOcA0=;
        b=ADxT0gMd8lWP5WAsQC8x44uAtIAhUDxKYTGywpoz9vVzn0204U3iD1VumunOx23G4x
         LjsY4VxHozQHgqoIl8vaCZam0Qy8SK7fZv2L8TkEosa4D1xQon4DmmPmZQJbG2tULPzJ
         kItH3IC+mv0eIs0DyA2n52l+pEJA8KyFjEVrsfIYgBXL1UIXwaD5Fvymp5wB03fkrOyO
         +e8z617kaodREP1JKXitjBUOYjUdbFnOLY1qXW0iI1keuzC+6cc4ejGN+eb1sYiVZ8ZA
         PFvSJZK6r+1/Xkq2Vvpb2wKFVphfOlh74iIaL377yJyz3YPq2QgRq+OvtL4J6wN7TXfm
         /FEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2vcuCPio85LUsas8hdpX2IjP8asB7EViTY5EyjVH27oAQ6xCrE7IgzlLktQwJ2Sl8PbF8J9yHKkN4enfCGA72B8Vs6oqm9pNGNjQrOgT16KAP3iTPpEE7OVyiuUGV6YaI1Og2RGs+TlsRLG9asMtcaXGltTdX82kja9FI20XLWG1pWg==
X-Gm-Message-State: AOJu0YysspTUsQkDkKMGg5Jne16ooRb2jNL/yiyUdMkNmNY5GHjN5XSR
	H65pBEoIr7GwSNuZUIxAkJ1tZpOJewBhZExDzcJriJ6cFFjsppFA
X-Google-Smtp-Source: AGHT+IHCCk3h4RYYrdY/RIfjuz0KCiI8lT7wSiom63AMX0z71+lISRylWaJNs5DSlXnpEHv75qUPPQ==
X-Received: by 2002:a2e:2206:0:b0:2d0:e587:8f44 with SMTP id i6-20020a2e2206000000b002d0e5878f44mr2866879lji.10.1707941070425;
        Wed, 14 Feb 2024 12:04:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnLQH8oTYViKRCiyoOTnDGWCL46suRUTUlmiNTgxkByAk2D7QSsuJLlbRBVRdsCu2tgNENk9IXt7n+vsfKJXZ85C9z3kg7wfjKoXybug2PYT6eUDEw0fu0TlnFyng0/Q834uWq9bss+GPzVM7QYHYfMW6FY/MPc6I5JawLs8fuyQThW7UcOnFKpV9t2iFg79b2r0qYf+OcVxxhESjsGk438Z/EiXF9zn/0P1aO/xwmIb/BxpoD+tfvifNXxPQoIM518sQZy9OqvH0tWwnTw5CUCteJNewY7PYH3VN0hUMtPhI/BCHdMy3RoqV1AQT930V4kX/xaPUfLk8h75UD9cRbEfgxrsQFmMuR1NwjxzKqyjr46A3mXtPtCKbE2+NJRPedF50wTa6HRroF
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8456000000b002d08f4f0adasm969187ljh.16.2024.02.14.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:04:29 -0800 (PST)
Date: Wed, 14 Feb 2024 23:04:29 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <Zc0czfbphqRABxYR@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240212175410.3101973-1-megi@xff.cz>
 <20240212175410.3101973-4-megi@xff.cz>
 <ZcvdW3SvgIuhJtKX@skv.local>
 <20240214163815.00005a02@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214163815.00005a02@Huawei.com>

On 24-02-14 16:38, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 00:21:31 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> > Hi Ondřej,
> > 
> > thank you for submitting the driver.
> > 
> > On 24-02-12 18:53, Ondřej Jirman wrote:
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > > 
> > > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> > > 
> > > Add a simple IIO driver for it.
> > > 
> > > Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > ---
> > >  drivers/iio/magnetometer/Kconfig   |  12 +
> > >  drivers/iio/magnetometer/Makefile  |   1 +
> > >  drivers/iio/magnetometer/af8133j.c | 528 +++++++++++++++++++++++++++++
> > >  3 files changed, 541 insertions(+)
> > >  create mode 100644 drivers/iio/magnetometer/af8133j.c
> > > 
> > > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > > index 38532d840f2a..cd2917d71904 100644
> > > --- a/drivers/iio/magnetometer/Kconfig
> > > +++ b/drivers/iio/magnetometer/Kconfig
> > > @@ -6,6 +6,18 @@
> > >    
> > 
> > Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > 
> > I've successfully tested driver from v2 on 6.8-rc3.
> > 
> How about a Tested-by tag so we can keep that for ever?
I have nothing against that.

Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

-- 
Best regards,
Andrey Skvortsov

