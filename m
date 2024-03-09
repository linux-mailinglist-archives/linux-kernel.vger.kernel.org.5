Return-Path: <linux-kernel+bounces-97969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F5877285
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B999D282155
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5825779;
	Sat,  9 Mar 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrMGJaHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6F2375B;
	Sat,  9 Mar 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006669; cv=none; b=XRYT2rfavA1ddONIbwerntCF1ycKpocW2PpomdDcigXwLt2qS4UK59JMlwXmxZ0op1Lui6sJ3nTWc7dx3mK+nAIO2tc3E0LrVCINlZNhW0wnwWMoBYsMUqA9WS4CgNwGfmmsPBxyHVltY475HDX8oGBkJhGkuXzydUY5SfKcaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006669; c=relaxed/simple;
	bh=48FuxJYRobyq9zL7gLnlB6u3+I5puPcnQ7hwrjEettQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9qD0ese7uCQQDjTkOqHNSz4fYftjogJkTDvgXl8MnZ88AIWZsIWms19h5gZVlCXI4lhD9imFO7eqv8ECJFpa8USeySkkqaOm8zJLkxqz7HWxYj0lAIfMfbDR8BJIYHW5cYsixKqiFWSWFcHpgb+1R2AJK1ha4DgPOMhqTGPR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrMGJaHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B252C433C7;
	Sat,  9 Mar 2024 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710006669;
	bh=48FuxJYRobyq9zL7gLnlB6u3+I5puPcnQ7hwrjEettQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrMGJaHir/TdQZnTw3lW6X9p4veg8SIrGCUoWFR6l2GzgARyzY7EOgLuvcZQs5D4r
	 rD2rljRiFkrmWi9qA51iS+CabXLW/aUr3DkjzDGZy4NTY6we5WA6A7XtmDnSGZVrsn
	 8c7CMkthDDPlHitSTh6wXcd8/Sf8G58Fy/Fa36BPtrq/3wtOBN5Ax3dDoEYpY24va5
	 g0TLf3G9ZVox5rXHvbCr3Shak8YKScDbUBRMqTZflZKzfrDr8Fn8WGM05yv1JoBHAg
	 bUdYCpYT+T80fCXkIKgs4JKVQMvHry8fQv2ANdWyqBO0ey5RiYvG+52jI/f1mZDCIL
	 7lHV5UhRbDh1A==
Date: Sat, 9 Mar 2024 17:50:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 linux-iio@vger.kernel.org, Shreeya Patel <shreeya.patel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Paul
 Gazzillo <paul@pgazz.com>, Rob Herring <robh+dt@kernel.org>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 0/5] Support ROHM BU27034 ALS sensor
Message-ID: <20240309175056.3862630f@jic23-huawei>
In-Reply-To: <ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
	<ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 14:38:38 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi deee Ho peeps!
> 
> On 3/31/23 15:40, Matti Vaittinen wrote:
> > Support ROHM BU27034 ALS sensor
> > 
> > This series adds support for ROHM BU27034 Ambient Light Sensor.  
> 
> I have one word for all of you who worked to get the ROHM BU27034NUC 
> driver working in upstream.
> 
> Meh.
> 
> I just found out that the BU27034 sensor which was developed when I 
> wrote this driver had some "manufacturing issues"... The full model 
> number was BU27034NUC. The has been cancelled, and, as far as I know, no 
> significant number of those were manufactured.

ouch. We all have some cancelled products in our history!
When that happens I usually go eat cake and moan at anyone standing
near by. At least this seems like there will be some direct use of
the work done (sometimes you just have to list the things learnt along
the way).

> 
> The issues of BU27034NUC were solved, and new model BU27034ANUC was 
> developed and is available in the ROHM catalog.
> 
> I did also learn that this new model BU27034ANUC is _not_ functionally 
> equivalent to the BU27034NUC. I am currently clarifying all the 
> differences, and I have requested the HQ to send me a sample for driver 
> development and verification work.
> 
> This far I've come to know at least following differences:
> 
> - The DATA2 (IR) channel is removed. So is the gain setting for it. This
>    should very much simplify the gain logic.
> - Some of the gains were removed.
> - The 5ms integration time was removed. (The support of 5ms was severely
>    limited on original BU27034NUC too so driver did not support that
>    anyways).
> - The light sensitivity curves had changed so the lux calculation will
>    be changed.
> 
> One thing that has _not_ changed though is the part-id :rolleyes:

*sigh* Not even a version number?  Even unreleased / prototype parts should have
different IDs if anything in the interface changed.

> 
> My preferred approach would be to convert the in-tree bu27034 driver to 
> support this new variant. I think it makes sense because:
> - (I expect) the amount of code to review will be much smaller this way
>    than it would be if current driver was completely removed, and new one
>    submitted.
> - This change will not break existing users as there should not be such
>    (judging the statement that the original BU27034NUC was cancelled
>    before it was sold "en masse").
> 
> It sure is possible to drop the existing driver and submit a new one 
> too, but I think it will be quite a bit more work with no strong benefits.

Agreed, modify the existing driver. Just needs a clear statement in
patch descriptions that the original part is not expected to be in the wild.

> 
> I expect the rest of the information to be shared to me during the next 
> couple of days, and I hope I can start testing the driver immediately 
> when I get the HW.
> 
> My question is, do you prefer the changes to be sent as one "support 
> BU27034ANUC patch, of would you rather see changes splitted to pieces 
> like: "adapt lux calculation to support BU27034ANUC", "remove obsolete 
> DATA2 channel", "remove unsupported gains"...? Furthermore, the DT 
> compatible was just rohm,bu27034 and did not include the ending "nuc". 

Separate patches preferred for each feature / type of change. Mostly
they'll hopefully be trivial to review.

> Should that compatible be removed and a new one with "anuc"-suffix be 
> added to denote the new sensor?

Yes. The binding patch in particular will need a really clear statement
that we believe there are none in products in the wild.

> 
> I am truly sorry for all the unnecessary reviewing and maintenance work 
> you guys did. I can assure you I didn't go through it for fun either - 
> even if the coding was fun :) I guess even the "upstream early" process 
> has it's weaknesses...

True enough. It's always 'interesting' to not know if / when a product
you've upstreamed code for will launch.

Jonathan

> 
> Yours,
> 	-- Matti
> 


