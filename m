Return-Path: <linux-kernel+bounces-109915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56458857BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B112283A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD457864;
	Thu, 21 Mar 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX3tBLGT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC5954FB7;
	Thu, 21 Mar 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019007; cv=none; b=VJd7lO5zrdepwD+BimCyquN4NsGfZwM7Kp/KffiGAPbDHYvaO2UVUFYqWKLQcdnDh8QwvIC6Rkk+lAFL/3tyi49a8NCT4JbXoJ/lU1+qF0vCSE79kbx8eHnsoUSC8E1CiWFwJepTg7oxtRmyV8DRSCKZZQatP74ttUn1eq7fO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019007; c=relaxed/simple;
	bh=9wK2K43cRuiqRx7FuDm4G45EzjSKz7jVZM0dDOD9C9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs9mmmxBeJTm1HRbjvRcK+MDlT/FZTpmhiRHKbKUcZ9IpkcWeX/y2S5FNjef0h7MXpJFUzbknyQWY9EdBrEDY4W7JkR7XQsquj4VTz8N0nHAcYH0mrvKBi3yogAteto/Nfl/rTU5ZRRPS6+YXRW+rX+sHLVGqR7yKJoIpCGPkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX3tBLGT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso13599391fa.2;
        Thu, 21 Mar 2024 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711019004; x=1711623804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT0UhNpGDPoNyLRvJypE7r2h5AAoACQ2X91BMbmvyVM=;
        b=PX3tBLGTTRpfQcxWnnLWbOw10v9aHKFjVGRcjeds9JEkFZG7/o2gHwczoQueYdxI5m
         3h9EXhwJNZFW3D4TfvuXYqkLoYxf0DWGiOqZZn3lpO+ebikBdL1VsV3Ka2rSiq1ksozQ
         M5lPOMWp4Cq1ozgixLMR1xnIrFU1zl0q5QfPjJX0TD5tcQlaK1tFMqtdSWxWj8+ObZuJ
         jyIf9iC4viITucFbpSzo4wASuW2+eM2xUbN0an74XrSjwC9cLLNnJkGiuLW1UBOtoE1N
         wY3i6bGLj3XmNCmvdsndY/nan10KEXF3/bJbchxkkuPcJO51tICQqAPPu/NHo3MLNDCE
         x+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019004; x=1711623804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT0UhNpGDPoNyLRvJypE7r2h5AAoACQ2X91BMbmvyVM=;
        b=AMA7G+k4tvBNeT24ls2ftR6T0+ykJlbhUTVaP664bDAZmb6BspOOMIkKPNWQ0sTFFu
         SX0LpO/hwdH4xJxLhZkK1lI2UxdUkxE66mjXgWkiil6hkbcDsAdzE+RBlhyL9YqPUq82
         ZRe3SqmZDzQm3QvMC6tg/0kZsGmq1QExNZGh3ZSk66hKV9rcfs9K4JJpU7JUpdy5pWzp
         4BaWphh8oMZ/xgFPZGdScST4c+6Va1sSCSlLFNDY6P/lQgVHU5XOM8a030ZPP4PfIWvX
         UvQIt9Nq3HSzqYffBCCAx0trM/PLWdVgHTkykc4ndZpTfGv2aLijgROzTqFjKvy7lh2h
         672A==
X-Forwarded-Encrypted: i=1; AJvYcCU1XjWBT8kZpulnXl804e6YDMT0WExWojuIYjaZmaeb5HiXIRW7ixJJeof19+Cigsc0n6Z0L4flgtUWv+Pd6OZikKqpZZgys1sLx8D2haK7Gh8mKqpnLApE2kuH4oeHtbIOOb5qL99qzCFqx/lsDeBa5j73foj5e/8cd+Lw8/UWVct8FBuH
X-Gm-Message-State: AOJu0YwTNAPrOB/7B/0n6t0R2KXyGfDa+WrN7LAnuqQHUaK6K5TiZLwn
	x+HK1FH9GTAu4Y2QuXo8XtwyAA/0IIcsZy2x6ku7RlIkWSEomNLC
X-Google-Smtp-Source: AGHT+IFBAAv1s69tHA7UUCCGycmG2dMXcvO3vaRNPikbG0TYdCU7n7qeQNQs6HEN36YcV+g/bPFlCw==
X-Received: by 2002:a2e:a274:0:b0:2d3:1bd0:6bcf with SMTP id k20-20020a2ea274000000b002d31bd06bcfmr2790438ljm.8.1711019003547;
        Thu, 21 Mar 2024 04:03:23 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e8e87000000b002d434d11402sm2390630ljk.15.2024.03.21.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:03:23 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:03:21 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: Brandon Brnich <b-brnich@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: Re: RE: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Message-ID: <i6m7svnr6zutg57leeamepj67ajgddwe2phs6rluyozeg3m37p@jfkrlqss26rz>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
 <20240319210106.awn33cm7ex33g65b@udba0500997>
 <SL2P216MB12468C7256CE2468EE088E7CFB322@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <tg32tsfnj3pmboaaeslvrmf7wtvznagio3vtqot42iflz5lvh7@25s5ykv3dfuz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tg32tsfnj3pmboaaeslvrmf7wtvznagio3vtqot42iflz5lvh7@25s5ykv3dfuz>

On Thu, Mar 21, 2024 at 01:52:03PM +0300, Ivan Bornyakov wrote:
> Hi!
> 
> To sum up, there is 2 favourable approaches:
> 
> 1) to have dedicated SRAM partition for Wave5 VPU as suggested in this
> patchset. In this approach SoC vendor can setup address range of said
> partition to their needs, but other devices won't be able to use SRAM
> memory reserved for Wave5 VPU, unless other device's SRAM memory needs
> don't exceed the size of reserved partition.
> 
> Therefore it is sensible to substitute alloc/free on open/close with
> alloc/free on open/close.
> 
> Advantages: driver code is simpler, no need for platform-specific defines
> or DT properties. Wave5 is guaranteed to get SRAM memory.
> 
> Disadvantage: waste of SRAM memory while VPU is not in use
> 
> 2) allocate all available SRAM memory on open (free on close) from the
> common SRAM pool, but limit maximum amount with SoC-specific define.
> 
> Advantage: less memory waste
> 
> Disadvantages: still need SoC-specific define or DT property, not much
> differ from current state. Wave5 is not guaranteed to get SRAM memory.
> 
> Which of these approaches would be preferable?
> 

Personaly I would say, let's stick with simpler code while there are not
too much mainline users. When someone runs into SRAM insufficiency
because of Wave5 VPU driver, their patches will be welcomed :)

