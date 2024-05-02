Return-Path: <linux-kernel+bounces-166167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E38B970E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733081C21046
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152951C45;
	Thu,  2 May 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF/UyDhm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710620B3E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640510; cv=none; b=UKCRUJiolb0RG94t6ZAkPKeLm4e2YjhFNemzMDKxcbGWL5yj3ol1cfaAuVEuLGW31nvYDuep6lumeGwGp4DG8DO8Q+ivTf5EA4wOx8/0Oe5kMrFp1e91iY3MWMflUe5ROs0mWAFbbKe6QagxiERFtWjUwHRBvQG6P9S+cMF5nIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640510; c=relaxed/simple;
	bh=Mozt38krUiRWlXgHYyvV5Q+qX9qpDr+B5QrBnQ8Mc6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0laJjRbWj3BinVnB20KfaOW7DNrSohf+AaXeeKNYZew8gpr8lmzhmF70mquLfraQaSU4D8WmYDFU3oq8zM3MTKw5Tk5/r7rmGEeqJqchIz+ani8oPsTF8Yk+xw/FWIwaU5L3rhryftb2QoqPxTZasDzXbLZ/zAD9uu9MwcmChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF/UyDhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F4DC113CC;
	Thu,  2 May 2024 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714640509;
	bh=Mozt38krUiRWlXgHYyvV5Q+qX9qpDr+B5QrBnQ8Mc6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HF/UyDhmhAsJ8Z0eadaq5FU7ewKvU/DVOV40+S70LH/tEEMTsTDoPYh6gTHMKbZfV
	 VrYLeD+4TInUaBKI8bk0r9RagdzzPSTOUAbBiJbK/UTzIjBzCdvit+558heMJzL3Mr
	 6AER5vzdtsRrW7GedjWEaE4hpg6b55WCrpB3AsGM0mbfdz7++CtHd9vQfwEXu/xoZJ
	 reariBHfNuDq3CykPGqNpG5Rz51nbcKMDPIiHZfC9f2K+qXadLl+cFBEn9c27NtwJb
	 IcLCKKzhJvMNopQhNed13oTsRysjClRxUaJUdvlGvVuYMltIpGnKW5qk5ss9y5//1x
	 Mvvkr8zlIh7vw==
Date: Thu, 2 May 2024 10:01:45 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v2 0/2] mfd: rsmu: support I2C SMBus and FemtoClock3
Message-ID: <20240502090145.GE5338@google.com>
References: <LV3P220MB12027E97C73F84A01548D3F0A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12027E97C73F84A01548D3F0A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 01 May 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> support I2C SMBus access for Clockmatrix devices
> support new FemtoClock3 devices
> 
> Min Li (2):
>   mfd: rsmu: support I2C SMBus access
>   mfd: rsmu: add FemtoClock3 support
> 
>  drivers/mfd/rsmu_core.c  |  10 ++--
>  drivers/mfd/rsmu_i2c.c   | 123 ++++++++++++++++++++++++++++++++-------
>  drivers/mfd/rsmu_spi.c   |   8 +--
>  include/linux/mfd/rsmu.h |   4 +-
>  4 files changed, 112 insertions(+), 33 deletions(-)

I cannot see which commands you are using to create/send these sets, but
something is still off.  Please see:

  https://i.imgur.com/WqfKBq6.png

The patches are attached this time, which is better, but the
cover-letter is still detached to the submission.

-- 
Lee Jones [李琼斯]

