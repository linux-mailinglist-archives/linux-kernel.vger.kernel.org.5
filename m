Return-Path: <linux-kernel+bounces-37433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03A983B007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EF628A784
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09417F7DD;
	Wed, 24 Jan 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r13+3IEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F47E785;
	Wed, 24 Jan 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117478; cv=none; b=nbauYesA5li973we9HLrb+sqXspXL4CYregT+gXLKdVlmuxqgD5sqBKOLCuHYgEtQTVGw2aI2LHDwMcxuwh9cAJZqapb1SDbpBSPlCzlRQdVevMONWcPrUD9zbsUo+vfzpKGHGOA4Ay9OPFL9gxkyxflC1xtOCZ7n8BLAb8MGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117478; c=relaxed/simple;
	bh=4i3f+mC95pZzM4upXPVoDH9MJFaV+q6ouUyL8R15aIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELIEqgfrLDNmVB9xbjjlyj7/DNw7f5TFXoCiBaMp/OH/sv9dStApsAQDVkV6UWG/VlMd46MFsJgTa5JqrwQ3f0NqWEHzOHgxsQrT758NVBBRvqNxW4HJAhTAOaiC+uizysk8dCTdWgi1GzYzeBFh84cvCMEdD7g1AmWMGzunk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r13+3IEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA91C433F1;
	Wed, 24 Jan 2024 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706117477;
	bh=4i3f+mC95pZzM4upXPVoDH9MJFaV+q6ouUyL8R15aIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r13+3IEndpxOwPc2rb0rb+L/VBPWTLnF3d0AptzCfPFIHyqYhqingzZM23pxJ3sHH
	 8W+Op5qL6FH57ZT1vlf0d7LDQa/KV1cPSTXiVWEMREbHyjyP3uaphj7JazWESD0E21
	 WUCVh7cEreV5Yk+0cFFzQ+CpZmQVpX6KXJfAwsMA=
Date: Wed, 24 Jan 2024 09:31:15 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 26/33] staging: greybus: spi: Follow renaming of SPI
 "master" to "controller"
Message-ID: <2024012407-wasting-uncouth-0327@gregkh>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <687fdfb1c7c050d00e5dca06af8ea1701893e163.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <687fdfb1c7c050d00e5dca06af8ea1701893e163.1705944943.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 22, 2024 at 07:07:21PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

