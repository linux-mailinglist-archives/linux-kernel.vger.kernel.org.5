Return-Path: <linux-kernel+bounces-85668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8986B8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB03B24A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D274433;
	Wed, 28 Feb 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFbxjVCT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFB2CA8;
	Wed, 28 Feb 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151578; cv=none; b=Be3Fuvd3+82In8V4VdA15T7Lm36+qO+zZlpWY2Ml/fiMZxEtVeZVp4locVMfLkPQcoFlyeRWJcatgo6UMeUyjwXJ0WZNz3IXAU1+tuciIK/gAEU/IDG580FDjGh+Jcaqrd6uZf1k8ktHwI/00RH0RHW8rJMsvxPjh+rNAhAHfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151578; c=relaxed/simple;
	bh=XdH1gVAmPrYrirTX0Zyh+LhBwvzthAkxOMyXwhAk/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0NNRosGmKY0O/7mV0XyEawJ8ci5LUc8xWOfyBsccveyQYq7k2h+4OVgd3lTrTqIOO6V/sNXvT8yHsPIktVrzG/LMk6e/g2kdWPpSBXMhNV6fgwo5pYH5URRwpReTP4c4CNmsp71tDPfrYN/myxAIB28ROl2Cxer9+97dV9iZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFbxjVCT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d288bac3caso1367851fa.2;
        Wed, 28 Feb 2024 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709151575; x=1709756375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AaYkftKp1y11sdAWaYMn4v1B8t9t+mmU/Hhe9qMT1cc=;
        b=iFbxjVCTC8qWr95n1EzEApjXV0OhXODOKVDCWwpKw+MtI2tXNgLrp+me5D3JTLVszI
         xo8XxHmEe6JrBRtZXu/eaUcydS3l5oap7UZSeh/aY42w66VOPaTHFWQLeZomrgL02SfQ
         33KfPMhmnL7NKYmQhLt5QlHYdMAMjVRT8whOP2lj9cfLORdmV+rOmlgOioKe0aYI1nkD
         Ww2Z39/YC7BmY9Ze7BUsCG2GzDmca5ZDvCBM2In9t2Y4wdClpE2PiKCs5OI9gOisn3Ki
         TCmzN22kpfNaB1TmiWViHHPGTs7NDIAa7hyzpakETzuWqGMhVTvMe2qQKZ2ilp0u98mk
         jaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151575; x=1709756375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaYkftKp1y11sdAWaYMn4v1B8t9t+mmU/Hhe9qMT1cc=;
        b=sK0eognUGJevje7VB6rpjcl33ja0nEaCw5d7hNT6IoQ/MFYsPyQlFwFeZK7ODO5H+f
         pHTiFiCPN2itLrLD2JjboUukwzsgVDWw4qYanZGTWDqPT4ty4B5qtJlT9rvMZhWWLvwg
         DLbSJ5HUheXKpWfmCutUgWc6Z2Vky18wBec2/jtaMbfxv+eg0pKIGfSLtUpLgrqejDXJ
         5AUS7lQFYWIvywTjx6JXsLqlUb8tgXk4DuAztqikw5pGF2DaWxXu3ZtcfqpAaLEkn5rO
         t5Q2RuPE/h3GWUEDdK86uaV0SbQb2O3jzU014S3qlcCi5uxu8WwsWNvH+I8BAL5ThG8G
         /ZHg==
X-Forwarded-Encrypted: i=1; AJvYcCX6NpZMC7djRN1aRXZjX2wKg9ulaDNR/WKhCzq4qbNx/xNdSDBbWiJ+0HCSlnXAv118F0H3NY9H/wu+mqfHTG2AYsKDZ0Hn2eXpRfYEX3/JsjjvaZlrV16gqciH4UEmgKqqzb3F54vWQd0V+8EHQUqel8SVdHFtXel4PXkl0IZh0aA5fj3WIw==
X-Gm-Message-State: AOJu0YwAqYkPBkehCjUSLmF9L4FN0EWL3pXSrvNkteanK0F+qW57pChy
	qSJMkwn5CnrTbMni8t/pPgmu/umdGN8jgaKW8cMHh8W+YCJS+r4A
X-Google-Smtp-Source: AGHT+IEmzFheUvrhk7elS7+uTO42EaEZigwC+piudVPdSqGPkd8eJkZq1RdUGfSUAb28YaMidt4oZQ==
X-Received: by 2002:a2e:978b:0:b0:2d2:a4e2:bb84 with SMTP id y11-20020a2e978b000000b002d2a4e2bb84mr3894714lji.47.1709151574660;
        Wed, 28 Feb 2024 12:19:34 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id bk25-20020a0560001d9900b0033dd98c518bsm10293993wrb.50.2024.02.28.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:19:34 -0800 (PST)
Date: Wed, 28 Feb 2024 21:19:32 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Message-ID: <Zd-VVGXHoH2ikbmV@Red>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <ZcsYaPIUrBSg8iXu@Red>
 <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>
 <ZdL713ae1swwTU_B@Red>
 <20240228133656.24bic6djmjvkill7@cab-wsm-0029881>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228133656.24bic6djmjvkill7@cab-wsm-0029881>

Le Wed, Feb 28, 2024 at 01:37:02PM +0000, Alexey Romanov a écrit :
> Hello,
> 
> On Mon, Feb 19, 2024 at 07:57:27AM +0100, Corentin Labbe wrote:
> > Le Thu, Feb 15, 2024 at 10:47:24AM +0000, Alexey Romanov a 'ecrit :
> > > On Tue, Feb 13, 2024 at 08:21:12AM +0100, Corentin Labbe wrote:
> > > > Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a 'ecrit :
> > > > > Hello!
> > > > > 
> > > > > This patchset expand the funcionality of the Amlogic
> > > > > crypto driver by adding support for more SoC families:
> > > > > AXG, G12A, G12B, SM1, A1, S4.
> > > > > 
> > > > > Also specify and enable crypto node in device tree
> > > > > for reference Amlogic devices.
> > > > > 
> > > > > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > > > > custom tests [1] and tcrypt module.
> > > > > 
> > > > > ---
> > > > > 
> > > > 
> > > > added patchs up to  "drivers: crypto: meson: process more than MAXDESCS descriptors"
> > > 
> > > Including this patch or not?
> > 
> > The crash start with "drivers: crypto: meson: move algs definition and cipher API to cipher.c"
> 
> Unfortunately I was unable to reproduce this. I use Khadas Vim1 board
> and my custom tests (https://gist.github.com/mRrvz/3fb8943a7487ab7b943ec140706995e7).
> Tried both build as module and built-in.
> 
> Can you, please, give more information? Maybe your test cases?

My test case is simple, simply load the driver.

The problem is that you moved the algs[i].mc = mc after the register of algs (in drivers: crypto: meson: move algs definition and cipher API to cipher.c)
Test could happen as soon the register is done and so mc is deferenced.

Since you didnt hit the case, I suspect you didnt test the driver as module.

Regards

