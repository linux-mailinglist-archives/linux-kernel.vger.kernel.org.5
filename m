Return-Path: <linux-kernel+bounces-119740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454AA88CC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00414325EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E713CAB7;
	Tue, 26 Mar 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihaYLwbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63714265;
	Tue, 26 Mar 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479820; cv=none; b=N8CHiy2sAIJy6hElRVrAQXpJbf9nAw8X9RGJz07I/f0NxeJUJPwEc3KCk10DkTYFIRhuta1hz8Q25pjpXZEYNmoJVdCS30FzSlPbAHf9w4puVkAoOUTHS4zGcRavZXBZin1hZcjRYX1pnh/czVrYsrPdfDhkkh1m/ow/mKAlYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479820; c=relaxed/simple;
	bh=2O7P9bmVcg0Kq2po/kca7Jb6SbR0Yf2nXAhLTI+L0LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Pb+MpqMNC2G2B7zB/VPXpgciBM+HT9+5VaDILXvxhtWkKFCWNwOYqg7RTDu1LwdqgzeKulMfzsdarjgLmv2/7bsqMs0RXW41p5Z8SEh0UCPOeuTJbydgeKMozaKwAnm8PmJ9hcJ3+vfT/GFN3em/dj93kXCEou5TwEUHTmtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihaYLwbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9FDC433C7;
	Tue, 26 Mar 2024 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479820;
	bh=2O7P9bmVcg0Kq2po/kca7Jb6SbR0Yf2nXAhLTI+L0LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihaYLwbg6ft4kMBgQSW12OfNiBgvASonphe8YsY2QnG1VZFlZYfBRQzwIb/fha5Vw
	 hHCfKvytFVvPJYU+WHCeVzOkIFwpjlec4XkHtw8lrphvdsImcp/usqP1jIfVODZDsV
	 biEz59XE2frgLDLpP3MENKY6x8dR+ORYaaLJMqDofBfHbQboTqG4uCOpqE/AAUPcAO
	 e+OwLZLKsngtlGI6pJ1KLkMYGaG3DQHmNytjaEIctskuLrx2/8HX6AF/a8xsJ8FSTx
	 WuJ0W8DDJGHy3iW5IFPXeOIGInopzLc3sDrTJ1xAVWtwExD0WwtkhCYHb/CL3T6MTg
	 Wh9t8BAWMNxDg==
Date: Tue, 26 Mar 2024 20:03:36 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/64] i2c: bcm2835: reword according to newest
 specification
Message-ID: <ol3kgnpunujrt42nmhcr5mjl26gulxgyqm42em5snpkq2wic2c@g3s4ujaci3ry>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
 <20240322132619.6389-10-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322132619.6389-10-wsa+renesas@sang-engineering.com>

Hi Wolfram,

> @@ -391,7 +391,7 @@ static u32 bcm2835_i2c_func(struct i2c_adapter *adap)
>  }
>  
>  static const struct i2c_algorithm bcm2835_i2c_algo = {
> -	.master_xfer	= bcm2835_i2c_xfer,
> +	.xfer	= bcm2835_i2c_xfer,

Here you are breaking the alignment (even though I think a "tab"
alignment is not needed).

Andi

