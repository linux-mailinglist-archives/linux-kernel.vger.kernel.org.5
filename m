Return-Path: <linux-kernel+bounces-69007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A1858353
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D6FB22ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E213173F;
	Fri, 16 Feb 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN1sTWTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA21E53F;
	Fri, 16 Feb 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102922; cv=none; b=g2igedJiBRojOAp6OO6a/mKUEGHefwuw7oGvWOAup6x9f1TXLAXpeDRuDlhhWhEDSLYJmVtQblyWUCPKaQaUUeh6fg7WODbv3/qWzO/6jkXdhtr+A6OCC4XFcgl4WOBT4z/JwEz1abyH8Md3ezCMrQg85wFzTI53enLSiG2pVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102922; c=relaxed/simple;
	bh=YuIu18s9Bh9d8QimtdhANWmZFdUv3i48Yw7a1CA3luo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqLK5JbI+xgkoSGamXM+eoAjQ37xpbawnNeHn1iI5LLhu3KcYSzTWFOfUzLZW17xPU0aGPI5/XN/GS88omPXf0Lx3b+g8HbHvzEz3z9o3FIa8/ObdO2NsMx94T5vnIecBStj3pKv1BVQtC8eBHMiQn0G+HJnB+8giIeJWdmn9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN1sTWTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16213C433C7;
	Fri, 16 Feb 2024 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102922;
	bh=YuIu18s9Bh9d8QimtdhANWmZFdUv3i48Yw7a1CA3luo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uN1sTWTUYDtixilsnghvCYoeZTgPFihWUTL3j37em/cvP9na6AvbyUoQIHxYpu6NT
	 fahvQ84xFvbIxsszGFC2tjUeGM1ImLo1radmC9gRTUSdWq4Q0FPx26N3ytDVfDpzAI
	 C/Ij6IYhmMuHVJGDOwNfXnMnqHzBMh1Yx2VAz2szfn/EiM6qSXKcUBTx4rXNStUBGx
	 n7KLEo6NQShOsVa1Z9SGiTzaBLAhnHOZ1yA/qVNoO8wgJZsrJN4W3HRBWTFMdYjoeF
	 wwXxSO3NXCJOQ1fWB9t8Lw+N/RKI3pjek3sDQUH7crppqwbB+t2e8dZA3pxTEYIOwV
	 XX5I1hN49Zx3g==
Date: Fri, 16 Feb 2024 17:01:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, Mark Brown
 <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Okan Sahin
 <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240216170149.040ff86b@jic23-huawei>
In-Reply-To: <20240216153020.485201-2-mike.looijmans@topic.nl>
References: <20240216153020.485201-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.52058f93-4994-4138-8075-7b04acaef74b@emailsignatures365.codetwo.com>
	<20240216153020.485201-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 16:30:20 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v5:
> Derive the name from the chip ID register
> Fail probe if the ID is unknown

This is a fun corner when it comes to DT bindings where we may
have fallback compatibles for parts introduced in the future.
For those we are supposed to ignore ID registers and just
assume they are correct (in IIO I tends to suggest we print
a message to say we are carrying on despite not recognising the
ID)  We could go half way here and assume the channel count
can always be gotten from the register, but relax the family bit
to allow families that aren't yet 'born'.

If we don't assume channel count, we would need to add explicit
entries to the ID tables for each of the device supported.

Anyhow, I have no problem leaving that as a problem for another day.

> Interpret the number of channels (only tested the "8")

The way you've done this will not work if you want to add a timestamp
(which is tricky in this device anyway) but for now it is fine.

I tweaked the order in kconfig and Makefile whilst applying.
The relevant sections aren't in alphanumeric order as currently
the TI parts with longer names come later. Having said that this
fits better after ADS1100 than where you have it so I've moved
it up to there.

However...

  CHECK   drivers/iio/adc/ti-ads1298.c                                                                                                             
drivers/iio/adc/ti-ads1298.c:424:13: warning: context imbalance in 'ads1298_rdata_unmark_busy' - wrong count at exit
drivers/iio/adc/ti-ads1298.c:465:9: warning: context imbalance in 'ads1298_rdata_release_busy_or_restart' - wrong count at exit
drivers/iio/adc/ti-ads1298.c:531:9: warning: context imbalance in 'ads1298_interrupt' - wrong count at exit
  MODPOST Module.symvers                                                 
sparse isn't happy (and I upgraded it to make sure I had anything new for guard() etc)

I think it is the missing context tracking referred to here:
https://lore.kernel.org/linux-sparse/Zag2fYsyJDtDR7a6@google.com/

Anyhow, looks like false positives so applied to the togreg branch of iio.git
but first pushed out as testing to let 0-day take a look.

Thanks,

Jonathan

