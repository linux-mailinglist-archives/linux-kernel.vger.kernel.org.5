Return-Path: <linux-kernel+bounces-90411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7E86FECA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86C81F238B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15583B797;
	Mon,  4 Mar 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2U7f8S4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C33B19E;
	Mon,  4 Mar 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547366; cv=none; b=jE7A7eisFUlsDk0iqDaKRnymsNT2YcUGN5D3PfEcK/cx0/kAkyuinaYnRHIttAxyrSCAF5p1K8EvJVIMBYBzsK0BTgvZFnbgZJvn5GfLjXJXVna7rWigbHyZNQlXapXviVmPuSfVfTCEcdZeGh8NcsiyNBMBQ6b+rfd/foJD5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547366; c=relaxed/simple;
	bh=dqE1sGx2sTd5SmitjperBZu1xsLydudjgfF8a3ciIT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYNM4VjljBhvc603zYco14BU1xP8fE/0g3zaIfzwLS0hR+NtDs8ykqkEX12IvXV0bmn0nfEm+68XEO8YZZxVXgUgx6ZQWoPRCsmIOnZNTYPXVhuNDMWav6FPMe087EiWFSu27pBumi71DvMdJvzv+wm7kiKtI0VJx1luPQsXGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2U7f8S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3904C433F1;
	Mon,  4 Mar 2024 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547365;
	bh=dqE1sGx2sTd5SmitjperBZu1xsLydudjgfF8a3ciIT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2U7f8S4AVG/EzXbOAh4ulCAGNB/BE0AyYiqVjkH7e6+e1WXr+e3VfePvjSfM3JSP
	 namBQkjTiiaG7ZwCvR0R5OS6z8PU2D/9W9vLyaRPQbKQjiWvLxjO5IEIFUuIMJexUd
	 dsBy6E3dCLO0l9cQLJ6v/k3aP2l8HjHb/DDFbvB2nVsOSWcgLlcnYTvnv7qzd9xCia
	 Cu1U6LpFqcgwoiaRfOjplt2ju2c/eSrsV6Mmqz1KWfwGop4vohUFtZJVix+9nDWX5X
	 3t7CSO0KKP6eOFM7HQD0iImfFM1jEIWmBiEFtFxLoIpMRLvR5pBlUhAOy9hqgzsLw2
	 duO9eNg3sWqyQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh5Mk-0000000079W-0OpA;
	Mon, 04 Mar 2024 11:16:14 +0100
Date: Mon, 4 Mar 2024 11:16:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Christian =?utf-8?B?SMOkZ2dzdHLDtm0=?= <christian.haggstrom@orexplore.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: add ID for MGP Instruments PDS100
Message-ID: <ZeWfbpXW5yynhorz@hovoldconsulting.com>
References: <18444448-6e04-4d28-b93d-5852958e35c1@orexplore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18444448-6e04-4d28-b93d-5852958e35c1@orexplore.com>

On Wed, Feb 14, 2024 at 11:47:29AM +0100, Christian Häggström wrote:
> The radiation meter has the text MGP Instruments PDS-100G or PDS-100GN
> produced by Mirion Technologies. Tested by forcing the driver
> association with
> 
>    echo 10c4 863c > /sys/bus/usb-serial/drivers/cp210x/new_id
> 
> and then setting the serial port in 115200 8N1 mode. The device
> announces ID_USB_VENDOR_ENC=Silicon\x20Labs and ID_USB_MODEL_ENC=PDS100
> 
> Signed-off-by: Christian Häggström <christian.haggstrom@orexplore.com>

Now applied, thanks.

Johan

