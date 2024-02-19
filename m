Return-Path: <linux-kernel+bounces-71565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A785A720
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AAF282271
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6F38FA6;
	Mon, 19 Feb 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDAZdOuO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0838DF1;
	Mon, 19 Feb 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355617; cv=none; b=rJB/Hw6B73LhWY3DqKWdm9yfFBxCxfTaAjcvvJ1LmoIU3/rC/ZUgn/YxMJ30QRPXmScglQoL4uGN2VM3AUOywZh0ULMvq2qT6tQvsQz0ZKdPeQjflSBpGpXYJqHxxO6EyNMNnaXJs4Suj0OV11aUEZv7i1BYrBV99nKJyQsXALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355617; c=relaxed/simple;
	bh=219zpRrF+2txenauOR7oz9BE36nHaUCy6d2FitoCx2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un33/SIfdJgxYca46ex/BQk/l8xVkL3dEaQ4Cm25+7l0pf8X3yYBNjeD02xdc3jSmSDxv/TH2q0qbjdnhm75sw1NplPR5b86ujeHQFsloIbJhQSLnoZ3SCbQdnrKrBNsd9ZxvaD7acngQBdS45lYygE+OsbRKG85yrPyJcou4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDAZdOuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E5C433F1;
	Mon, 19 Feb 2024 15:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355616;
	bh=219zpRrF+2txenauOR7oz9BE36nHaUCy6d2FitoCx2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDAZdOuOzQIXrMYvVzMiSwZnj/SSGXgZlyHXJanaGcX21G/YeZcUyGlI7YMlPRBtl
	 NQjnemVKek/RrRiTZJKpp//I5w31ZtqYpzk56LJ55uYxZWUrQz/1SzVkPvhC6ve9Eo
	 9dyH6cP1uqO1g3P7NsLI2302ABSS7ZEnK3rNMtAz5KPaiKMCXc/Lnd/pyLPse+6mFq
	 JGcMNTDVNvuAoGRYlUrSQz1AMnzRn1X7axI/8cyxsJBQ7I0NBuL7wYrDkHvR4a5wil
	 sOOrvhQHIJwdjXA5iuCRqt5gnP5GZtbXI3EYP/y3/rgpM6qKjRRTF+1Hbl8IDSTPgc
	 Nh1nlMtQee6fg==
Date: Mon, 19 Feb 2024 15:13:32 +0000
From: Lee Jones <lee@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Pavel Machek <pavel@ucw.cz>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <20240219151332.GC10170@google.com>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>

On Sun, 11 Feb 2024, Chris Packham wrote:

> Hi Blinkenlight enthusiasts,
> 
> I'm looking for something that I figured must exists but maybe it's so 
> niche that no-one has bothered to upstream a driver for it.
> 
> I have a requirement to support a 7-segment LED display[1] (one that can 
> display a single digit from 0-9). Hardware wise it's just a bunch of 
> individual GPIOs connected to each segment (plus an extra one for a 
> dot). I can't see anything obvious in drivers/leds but maybe I'm looking 
> in the wrong place. Or maybe it's the kind of thing on PC hardware that 
> is just driven by the BIOS without the operating system knowing about it.
> 
> Is there an existing in-kernel driver for such a thing?

Why would LEDs connected to a bunch of GPIOs in a specific fashion
require a hardware driver?  Doesn't drivers/leds/leds-gpio.c already
provide all the support you need?

-- 
Lee Jones [李琼斯]

