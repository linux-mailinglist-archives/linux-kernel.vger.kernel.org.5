Return-Path: <linux-kernel+bounces-143800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C08A3D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0CE2821C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607984CB2E;
	Sat, 13 Apr 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzcw2efK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D033D68;
	Sat, 13 Apr 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713024458; cv=none; b=AXByBnSg2HpxaTI5+wIJ39KxFhJiO7lADXwPJGTTfZ7/aMPqqsoGAWLzMfMorSO1rBf7EzO8mbj4+VXyifD6ke7WNLhcJJPl0FWlWJwZ3FCgtGNvt8b55m3m7ZuhkjJmmM+00v8fFplypzevjSPvPG016ZKEritB0xabGBZNs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713024458; c=relaxed/simple;
	bh=Q0/0rpvxAebSkQxJM0MspGBlJ94tc5YKn/wuQsvYPOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAfO/8y647w9djzNm7BT8RutVw43eCLlUv5p8ClP1NYFpuyIYffBvniJt7bTO1ADloaOcf9h1uEohXQzaCJpkzQ/tWLyFq3uzygY6eksPY6x0o0n2imjwYkwqt/z7rE3U79q1AtCK+s0ccbAN9WgtG3IzbXiqPKTFGmiC8ZV7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzcw2efK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A4AC3277B;
	Sat, 13 Apr 2024 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713024458;
	bh=Q0/0rpvxAebSkQxJM0MspGBlJ94tc5YKn/wuQsvYPOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mzcw2efKX/5hB0dsAbm+IM0eJaUYCk4JEHJA7esEchc+oBSNlquHjj0h5tbkccMzU
	 Fh5Sz+GoRvwE47ZZ3u1HZAKQGZefSKQ6AAvS2jVp+JaVn6VpDOASaQjGKG7Wu6KtT1
	 oxpPfxJEXOmtSbGi7pf6xWZumtpaI9yLaqKVnxKjwBS3SifgRHeJVC2OtZE27EUvlB
	 zKW41vpVUYmTxujwO45+WoRteq3Us3wdY4alOI8pAMtbZAKV2kApnPXZFL9RXPKcot
	 LCP9hdlPb8B/oHzpcXovOlWImemlK9FuqscwUlm7AuEOxWrebmkZ/K9bzsHh3rW4f+
	 Dm8tey5JNoI7A==
Date: Sat, 13 Apr 2024 17:07:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for AD4000 series
Message-ID: <20240413170722.44399921@jic23-huawei>
In-Reply-To: <CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >
> > - Span compression and offset.
> > For non-differential ADCs, enabling the span compression requires an input offset.
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD4000-4004-4008.pdf
> > page 18
> > and
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > page 19
> > I updated the _offset attribute for those ADCs according to span compression
> > being enabled or not. Is it okay to have an attribute update cause an update to
> > another one?

Yes.  Happens all the time and it's not possible in general to define an ABI where
this doesn't happen on some combinations.   scale in particular can be affected in lots
of fun non linear ways by other attributes.

How you handle it is a bit up to the driver writer and interpretation of what is
most natural for a given combination.
Sometimes:
a) Stash previously set value of the other attributes and try to find a new value
   as near as possible give constraint of whatever else was just written
b) Just use whatever the register value now corresponds to given the other attribute
   changed

Either way userspace needs to take another look at other attributes to see if they
changed after changing anything that might have an influence.  It can then update
them however it likes.

> > Maybe also make the span compression a dt property and have it fixed after probe?  
> 
> This doesn't sound like something that belongs in DT since it doesn't
> depend on the physical properties of what is wired to the input.


> 
> But the fact that offset should not be read until after scale is set
> sounds like a quirk that would be worth documenting in some
> chip-specific docs.

Agreed - it is useful to hint at this but in general software has to check
everything as there are lots of these sorts of interactions :(

Jonathan

