Return-Path: <linux-kernel+bounces-51654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC4848DF5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32733284658
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DC224F0;
	Sun,  4 Feb 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQJMaGRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07D24B23;
	Sun,  4 Feb 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051873; cv=none; b=ZJDIHh6j4HLZIk/OKOwcUEzxEq9L+0ts59u0xudMHBTxXBixSNLJ0t/zuKRC01cocyXiG7AL2/+qtkBn6jNODtn8pkbV2Xx0QEvhBdFJm3nNw3Cj73femOMY/LBLz0UNICGT5fJxeXuTV9RsNudrjDyJ1tieJqs2Uv1fj6V97Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051873; c=relaxed/simple;
	bh=rEOfohGClmor7V7cbTke00vd5PxmsX4kEU8atdcgq7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpoXtYBYwbc1i+Qz3Uzixdk1HZIsnopR5X5dSvZ2kfT9uKxNj6QgXvvlx/dE2jkO9glOq4xDe2Lw4ANC3ho1V9ijX7jJy6aC+5BUGBzHeIX0zjcsBwtAzt8KnmymFFEbf1ShchE3n88PrsatPjaEAcLqpxbQEvLkVjH5zujcKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQJMaGRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC48C433F1;
	Sun,  4 Feb 2024 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707051872;
	bh=rEOfohGClmor7V7cbTke00vd5PxmsX4kEU8atdcgq7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQJMaGRRQ7HAJ0g5HBB+orrjZKpP0RYm1LYi19aeE7Hs7JQwujmVSGPJZyrjJ2ado
	 uE49A2aG1/1AXn6E1EEW/bFDQ+IBAsvn65z9GK1MM1oD7fDoQ8Sv1YbPNxnCp3GRhc
	 O8FpLUIbi0ePcF32oEFEqvbSWljyhAguTZGy5dk3hEAxFlbogrAmzxPFawwG40q19n
	 S4k7Tq9ot6xcyvXgWgh9jkonjOFg0vybv9dDv2H/cNs7mwSsqlUWyFprC5z1UBnq5p
	 fS6J4ze5rVyhoc4GSHwt5GKkkq1j5bkcZV1aQkrGz4VD3Cgk+ELel+4lXYdlceKNnX
	 ov8az4jzGyDBg==
Date: Sun, 4 Feb 2024 13:04:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Peter Zijlstra <peterz@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240204130415.56ca3c42@jic23-huawei>
In-Reply-To: <8c7839a9-b1f1-4e58-b35e-afdc8503c90f@gmail.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
	<20231114200533.137995-5-alisa.roman@analog.com>
	<20231126163426.66e51114@jic23-huawei>
	<8c7839a9-b1f1-4e58-b35e-afdc8503c90f@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 16:32:14 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> On 26.11.2023 18:34, Jonathan Cameron wrote:
> > On Tue, 14 Nov 2023 22:05:33 +0200
> > Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> >   
> >> Unlike the other AD719Xs, AD7194 has configurable differential
> >> channels. The default configuration for these channels can be changed
> >> from the devicetree.
> >>
> >> The default configuration is hardcoded in order to have a stable number
> >> of channels.
> >>
> >> Also modify config AD7192 description for better scaling.
> >>
> >> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>  
> > 
> > Not directly related to this patch (which looks fine to me)
> > but any idea why 3db_frequency_available is not using read_avail?
> > 
> > Seems sensible to convert it over given all the other cases are using that
> > and it will allow dropping at least some of the attributes infrastructure
> > for some devices.  
> 
> Thank you very much for the feedback!
> 
> I actually tried then to use read_avail for the 3db frequencies, but it 
> required a greater rework. If I remember correctly, the four possible 
> frequency choices need to be stored in the ad7192_state for it to work. 
> Should I add a patch with these changes?
> 
If will end up a tiny bit more complex than currently because of the need
to stash them in an array rather than simply print the strings directly.
But not a lot and should allow you to get rid of a small amount of other code.

Not urgent, but I think this would be a nice change in the longer term

Thanks,

Jonathan


