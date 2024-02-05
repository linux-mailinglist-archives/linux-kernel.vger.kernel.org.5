Return-Path: <linux-kernel+bounces-53280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2F84A306
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4BAB2788E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC34A9B0;
	Mon,  5 Feb 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QK1V4NEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5C48CFD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159772; cv=none; b=aczzGNLkS32tQgS34ZILCYyw66v4eFkYCsQHMTI1AfVQUYqri+xrvXNk0bMKRfM6cHwF5Pmc4J+vpEWWmm7X5MiOh1cWyRHJ/eOQ5Nrs3Yv3JzG0+qi189j4vu3qF5IEvK/IywoN2zfPQkLFS4BYc+PySWcm89S3Lxvre/Y+LJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159772; c=relaxed/simple;
	bh=wDiHOzc4ncmuKrZmIqIjum1q/1JepiL3RZh/D8Jmayk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSqzeZgfo+YnbZErerIuuJKlpMjQnZj3rnZmcXINP81cOU+RX5DJ/Fmcd69dFRmkqMeWVv81PN40LqLkjMau/+cCnQZuRRFWsFuE1z0+nK729YtXEMH2IDqRojXRbcT6AI5pQh9COyioRmFqhvNsVuwtvqg5ZCKPz2/hOT9lbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QK1V4NEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A17C433F1;
	Mon,  5 Feb 2024 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159771;
	bh=wDiHOzc4ncmuKrZmIqIjum1q/1JepiL3RZh/D8Jmayk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QK1V4NEZpX8eT8hTZfMmTZ7ZJSWGzqV1XLTR87UfH2/TgkgX3VZiuRmVKoMIs/xr4
	 fD5RAPOJIMOel6Q+2c1dYD7ML2PI8y4IxXuZQT7x7rs/f4JLqcK6XhX4OayBv+kDIn
	 3bM1ESHJQWXB4SRvBHoPn3V7SKBvzwrob1CVs3uw=
Date: Mon, 5 Feb 2024 04:45:52 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] siox: make siox_bus_type const
Message-ID: <2024020546-spied-fraternal-d5e3@gregkh>
References: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>

On Sun, Feb 04, 2024 at 07:26:42PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Move the siox_bus_type variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

