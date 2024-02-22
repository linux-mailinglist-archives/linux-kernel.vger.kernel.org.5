Return-Path: <linux-kernel+bounces-76033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1085F232
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7D31F223C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC817BA5;
	Thu, 22 Feb 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtz8QT+8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69B1799F;
	Thu, 22 Feb 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588492; cv=none; b=s9ilemcRf4cQHUmcH89xerDN5IKRl76y14t7BbTjSZc11LIj7Tz0Zo0OkAbY8aPhDSCYLbptoFm2i0xMyOsZkp5I1oHbNdqU9Wfa1reIXIM7QpA4ORI7VOm9cVhCCey38hA8hvvxSChVGGsyGDFLPzc5+5bVW7isGhdHxZeT7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588492; c=relaxed/simple;
	bh=g2mW3Nwl6sYkaS6umsNOSjQa/5XpfCZEuHk3fpe0TAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Inu65krL03SqfcmDq1gpGgrIWkUksUNGSNseC2sGnvwc3IIiMbfaNa7FlEQgw9P3LzkpNNsFF2nMIB2dntjSFsDbSnOc3BkTZ8/1GryJVcru3m/Zmc+D41mOrYwEX0PuncQo0zyabaISbaZBCM7BabqqC6AYbHyjad1Xbxc6Res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtz8QT+8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41278acf971so8798015e9.2;
        Wed, 21 Feb 2024 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708588489; x=1709193289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2mW3Nwl6sYkaS6umsNOSjQa/5XpfCZEuHk3fpe0TAM=;
        b=Qtz8QT+862T0u5q9Jtryaov8jOwkMdnUUwqpNbqQr9Ar75PAkfzWv7Ue3Se5yQml0b
         NV3pRiYBpulCqiim1hZyUVrP716+xITqQ6e/wMPUBaaZfnno1MOX5qTU76e/g41DAQ+K
         WVpK6B8W8WO7JOwfKx79ffVIqATj994DYmkfMcWZk+wFFlc8FLm2P/WyxVq2552kjpzM
         E3NhShv9vQqwCk4MXJlm5m+Rqnk4RgS+Tp+LzixLPGdhG5uzc/EUvzAmbX9cMjTKAue5
         3XXwpgJcyOsyfxiIk7RGHT9Gk0ohVbiZhCt7bkOQg2NKbHg3MzX6dIcQb6q+8AvW+Qsn
         YdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708588489; x=1709193289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2mW3Nwl6sYkaS6umsNOSjQa/5XpfCZEuHk3fpe0TAM=;
        b=dFHWiBs0ad6i+6ZJXapfw88rRbZ9T0Kk0OYrlrt10CDG7MOjwy3kU9gk5m8w0YbZQS
         1emXOrIsR52p5t78D8ANNASuJGH0US+OTaa3w5duZz6IKk/ZuV8jA7zSH2J/LZgpjvQY
         C3B7i1sZHb0BUw+7SvihYG+nIVMcK3vnOkYmVFpz1m0joHb8uP5pKk2LllQ1bS1quckp
         jJDOXWBwCD+QXjIUerUDxlfN4hI9/7lGSyre3AhTcPdzUELlea+GiWtYgoW41+8ghsux
         CKwLdJt7tslFa6DWoiYz8M6c8aCYoixJyD+3liZ58cRD543780l1l3Tvikm4lu4/H3vP
         /N4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBa3jPpq+Gww2l/hsH5Ap/QuypqMeHIpGGhWBfsWDUO51C0uNuJZZ5Z+vMtoftndZh0jPPDPjjgVbX2bZF2VMyJdnqNuPNPbMypSwr1ethzW+1yFf0iwpdZv8L3t3AnecrvzPtV1a3
X-Gm-Message-State: AOJu0Yxslpem96IU2ygLuLucUXIRTvsZyuhVo2R4UqS3Ky+3NJ0n9lhQ
	dubfPfcizAY/QlFxfyKmaoAU1a5kF79rI2euTJZ/uSWWIqKXFhL6
X-Google-Smtp-Source: AGHT+IEqCEXVcoHV15hHlLd/NAUAkFenMMYe6MQN2ffOwJQBgzkrZ+ydr7sPeoyDk9pvGEl97YcZPg==
X-Received: by 2002:a05:600c:4f14:b0:411:eb4f:7fb6 with SMTP id l20-20020a05600c4f1400b00411eb4f7fb6mr16973212wmq.8.1708588488824;
        Wed, 21 Feb 2024 23:54:48 -0800 (PST)
Received: from [192.168.90.166] (146.red-83-35-56.dynamicip.rima-tde.net. [83.35.56.146])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b00410add3af79sm5371262wms.23.2024.02.21.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 23:54:48 -0800 (PST)
Message-ID: <2ed76eb5acce0e2b66b651a34319459358d77e9a.camel@gmail.com>
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 08:54:47 +0100
In-Reply-To: <20240220224329.53729-1-vassilisamir@gmail.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 23:43 +0100, Vasileios Amoiridis wrote:
> Alphabetical sorting and separation of headers for the BMPxxx
> SPI driver.
>=20
LGTM, so:

Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Kind regards,
Angel

