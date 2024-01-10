Return-Path: <linux-kernel+bounces-22160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3014829A48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DEDB209C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B314481DD;
	Wed, 10 Jan 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7gHOtgs"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512C481A5;
	Wed, 10 Jan 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3367601a301so3758024f8f.2;
        Wed, 10 Jan 2024 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704889053; x=1705493853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:to:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdITS2A3HXIwVFLWA5DKjHp2pw9bnbR6N/Avumcyr0w=;
        b=i7gHOtgsxqojueKMPwamM1WlnJceIQvF4YbpNR67NNZz21YaAM0BR7SIWIlY5gUL0r
         Bg93zNCKxBsGN9Qp1Mhs1egL2qcqlKecjI7xkPVYQMTWHKl5iwtYWO6TVvMJL8CtA3Gp
         1Hgk8m5np362X/qwi8Nkq7MSsNXs5eBbpuu4xcnyQTd0xJZtuvfxJ9iD2gYrpsG6hPng
         8EgQrpfd2DKIQ40Wo4Q9TNfF3XL3fx9sAyW4qcDAAUVaTMy5FbmVojiqa0yqLgyKHQL4
         y0tdTsGwVSKUNcQZWXqBaOHglWXTu0NpXQZfIMwbv9DDprCdzxl7HZhxsM4o+KbW482f
         dWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704889053; x=1705493853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdITS2A3HXIwVFLWA5DKjHp2pw9bnbR6N/Avumcyr0w=;
        b=iEpQYgMvUNsMAKwdSJxSy7c4bNIZrTf1Cy6KzVNDg8+kENPYZ46V2ifopCCgaqKg25
         sZ5U9n9RcEJjeqY8PM74cAipAwdxpXqpJiSNB90mZAtd6KQ4otDCj6r2wdJkPn33Gi08
         A5UPNvKx2E71CqIecL7k5FXcOw5+oa3PN0yQeXiBjcYXOjNidydykyOdVy3sfVtMpEOk
         4enMd1immzTYvrcA30laOTJmfOu7/XID2t4aaDS08TwBQQni+A9v7pl5l66KZ0F0Sxw4
         7oIoWS2kjDXfIQ/guu0gQxkBmrfZtq70RpRKd0pm8/kMWfYArr/y7hyk4xaPZ9XZL7KQ
         zHqQ==
X-Gm-Message-State: AOJu0YwofkA8Ig9gsqsdCP7D8YSqvI/kD+l0UPFr//r0qBqA9j3eu9zb
	/+GT4HvGYbAL14DJsbTvTXk=
X-Google-Smtp-Source: AGHT+IFjuBro6pt2nIQvGPGs+YNEUND9FumnFa2uhSwD1rF6spuB3B8buMz5zeXxdPjYLCmVyKTuAQ==
X-Received: by 2002:a5d:6288:0:b0:333:2fd2:3bcf with SMTP id k8-20020a5d6288000000b003332fd23bcfmr389741wru.136.1704889052985;
        Wed, 10 Jan 2024 04:17:32 -0800 (PST)
Received: from Ansuel-xps. ([78.209.40.150])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b0033686e8f02dsm4748067wrt.45.2024.01.10.04.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:17:32 -0800 (PST)
Message-ID: <659e8adc.5d0a0220.a73cd.069f@mx.google.com>
X-Google-Original-Message-ID: <ZZ6IW3qXtE8B99ga@Ansuel-xps.>
Date: Wed, 10 Jan 2024 13:06:51 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] leds: trigger: netdev: display only supported
 link speed attribute
References: <20231221171125.1732-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221171125.1732-1-ansuelsmth@gmail.com>

On Thu, Dec 21, 2023 at 06:11:24PM +0100, Christian Marangi wrote:
> With the addition of more link speed mode to the netdev trigger, it was
> pointed out that there may be a problem with bloating the attribute list
> with modes that won't ever be supported by the trigger as the attached
> device name doesn't support them.
> 
> To clear and address this problem, change the logic where these
> additional trigger modes are listed.
> 
> Since the netdev trigger REQUIRE a device name to be set, attach to the
> device name change function additional logic to parse the supported link
> speed modes using ethtool APIs and show only the supported link speed
> modes attribute.
> 
> Link speed attribute are refreshed on device_name set and on
> NETDEV_CHANGE events.
> 
> This only apply to the link speed modes and every other mode is still
> provided by default.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Marek Behún <kabel@kernel.org>

Any news for this?

-- 
	Ansuel

