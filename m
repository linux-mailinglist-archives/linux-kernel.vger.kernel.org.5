Return-Path: <linux-kernel+bounces-134825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579A89B782
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A099F1C20F81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC1D8821;
	Mon,  8 Apr 2024 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPBg45sJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4741C0DE9;
	Mon,  8 Apr 2024 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556966; cv=none; b=i0RR2wOzO2uzRjrrWk6+MXmf6q2iRGRNdqC4xSh6vIDuqMDKMmAMAk+gAG2t0/U8FQL6A9IF6B2wYHgfbbmV92fpfKWKg/2yknXSWAsJsbLLHmwOppjw8r8K66FujqBaqKTdy2RtFsXWZXdeYL+9AjB03xCik9pI+KK4/+MScko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556966; c=relaxed/simple;
	bh=T5csKTySHpyFpDTdORdTc4Go0ycPeWxQy54P5+fKCA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aljGjlnD9WiY+iSXC2m9xxHqReNLTR9rgz3oSvxhqkhmjb4EC+tU8msjx/kDvAD0jAd39Lq6zEbakCslMJ0QDRVN15c9rLrRfZ3vJDjUwMWI7SS8Hed41aspcsYFXKRnHKGP9Mo154oN+Cn6JcKCbuDtBix7E4+W4qRLstaXDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPBg45sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E10C433F1;
	Mon,  8 Apr 2024 06:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712556965;
	bh=T5csKTySHpyFpDTdORdTc4Go0ycPeWxQy54P5+fKCA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPBg45sJylhhUtPhCIHaD6ruAxDbIPovzOTwvdrW8aQzQi7gEv2wAg2gaoCw1yaZz
	 D+kHys73Y9WtBlNGcyCLnoi55mzQ2/UYWrjGcE0FTZl92xDPJoChJ3Tgauuvuj9gsN
	 Ah5UX8bJV8r0+r/zVVg7BL/PvdNqSYWBFtIyoYqUKlWAyVLn3Inc5NH/PtuBqfK7re
	 KCM03YKJT25L7y79cRQh5+4pxSRy7f/lOO5EPUQV5QSYUkqTRL5gXbeFce7NOybVIK
	 REr/c3dZ0NaoE1mLa08i3LhxsAThAraWWiIdQ4MZ7WYA98pn8zqhSPxzAqVgTuACW+
	 j3oC8tFZGto2w==
Date: Mon, 8 Apr 2024 14:16:02 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] platform: add HAS_IOPORT dependencies
Message-ID: <ZhOLohgMr_oJNJAM@google.com>
References: <20240405134151.5560-1-schnelle@linux.ibm.com>
 <20240405134151.5560-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405134151.5560-2-schnelle@linux.ibm.com>

On Fri, Apr 05, 2024 at 03:41:51PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Applied with a slight title change.

