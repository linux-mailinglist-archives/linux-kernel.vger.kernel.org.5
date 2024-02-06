Return-Path: <linux-kernel+bounces-54277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F484AD32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9264A285643
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1770745DC;
	Tue,  6 Feb 2024 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW28sq18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C4ED9;
	Tue,  6 Feb 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192102; cv=none; b=fnPuN4SNpJpYD02clDne7X9wZWqaDXTDgBUe2VWimWTpSQPwIGZ6r4io3KVjAmDpRisvDdwbhSmOM9HN5FTImtaiQVQt2CnGkNSFp9ySCr+KfTygo46apjwwLGHJWRhawE0vuq2lfV6aSgtjB937in1auoBEhHSVMtCtyfcyILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192102; c=relaxed/simple;
	bh=2TtZ4x6822ckw6ajPpkdmPjqIatlXiLp3/tmvf/aLX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axW/Y6uZd3TPT91bsp8kh78hyAvRv1k191tXVh61LBpcljPxp4xPBVbTqnji4brdM40sQ1+54WZkoW8uZYMN+QOgsLkam3f+zLTO4S6NBmyEPPJlplvMD7V6ZwZSLqcD6bqrgzEkjjbpyz7l0CKrG16yHOcwZC5GsXHeDMRXvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW28sq18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CFDC433C7;
	Tue,  6 Feb 2024 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707192101;
	bh=2TtZ4x6822ckw6ajPpkdmPjqIatlXiLp3/tmvf/aLX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VW28sq18TZpW6/uGrorL6ZEotAyrTzOC7FhrL1nMLLE154zfOwa7ZZwsd5pdGHvS0
	 73ASJ7rvIoIYDIOa9L9b8XYWNJSpwGM19jVOfCdecPLiwLcAK0902P5vVJXrSBeADj
	 kmpvmHnu3SzrOhhNTTqgYuOQjv8eoBR+CiQR2lmTPyKLq9xtJrST9sgK/gO0TvWQjs
	 d+7a2qXaYQNCyTOefIAFd/2w6om4KFtfyivzBP4NN506nOjlTyRoMjcfx4z6f6s0iE
	 ML11sEhU8H0Fq7XGQhoVnpKkL7t1XUapvrR1CNmquZ0+4W1XDNWiQUoNdPXBfnyrUn
	 mgrYT8ysFDmaA==
Date: Tue, 6 Feb 2024 12:01:38 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] firmware: coreboot: make coreboot_bus_type const
Message-ID: <ZcGvIts9LBLRzIiF@google.com>
References: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>

On Sun, Feb 04, 2024 at 01:10:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coreboot_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

Applied, thanks!

[1/1] firmware: coreboot: make coreboot_bus_type const
      commit: e3c5df138169b5494a16b20e74db1ee14b1901ce

