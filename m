Return-Path: <linux-kernel+bounces-37435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E283B00B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE5228C13B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33085C7E;
	Wed, 24 Jan 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhL4KZBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC5128371;
	Wed, 24 Jan 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117498; cv=none; b=kZxYFIT9qVub/PmICxX3JGO2BUuonuxDxz5RkeYZ8pBlppQ6z/BctFGu/kc5x1v9STJHu6dmY0syEsovzCRjh6miQHlWhd2uu7If1mXMlEtuT171y/aTCalJOkJfmWLGmYXqaHOs781nvl05JMEikgPCJvbRdj1xxf3k62rRuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117498; c=relaxed/simple;
	bh=ZSjxwNZxgQqXe2BOuCzNUYDMffDoamSMVJAvz8N0Jp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boPhVNXRN/fGqsiLpykem3i7+WYJ8zvXPqdexgzdZHUuLUKgc3VNc0B32ndeDp+yJe9CD4luAetJjakqG2pPMF+2IbcpEo210nFeBaw2STM0NfKbz7IeitgSXmVmBwxSiOWmu0I5/GulwP11W+Ovx0HUMc5rdyC/r/V/87RB02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OhL4KZBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B501C433F1;
	Wed, 24 Jan 2024 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706117497;
	bh=ZSjxwNZxgQqXe2BOuCzNUYDMffDoamSMVJAvz8N0Jp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhL4KZBxcp2t0yMZMoCBrGcfBBoXaQZupv4MvaMDjAzB1kwV6ho5n3yY4ANGiv7cj
	 L3/Sz895iSgeKYbttN87BY05nBeydlLwSvKzLV8L9QoZfDeKXemE53FP3mijJ0tpxM
	 eSGUnVjCug4tUzAQ1EZ9ZhQGA1GXWyAzrinFo+9k=
Date: Wed, 24 Jan 2024 09:31:36 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 25/33] staging: fbtft: Follow renaming of SPI "master"
 to "controller"
Message-ID: <2024012428-annex-destruct-1c92@gregkh>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <d486dbb16fafd93a00013a555658a44e975115fd.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d486dbb16fafd93a00013a555658a44e975115fd.1705944943.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 22, 2024 at 07:07:20PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

