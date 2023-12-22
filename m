Return-Path: <linux-kernel+bounces-9540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B281C740
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83449B21102
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B82F9D6;
	Fri, 22 Dec 2023 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhvmNcVF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080ABDF42
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CAFC433C8;
	Fri, 22 Dec 2023 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703236886;
	bh=lS5AXFMR/oA1w2ewrBpyK0zMvQfBfEvtG0ka4k7g5OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhvmNcVFQlhrA3YzfgfJlUsClmlAdlKlnEeQMz02ys1ywmYBKTzYXRusZ6P8mbu1N
	 QbE0jD+TwsMJOU1hMPOrY034LF6l9lQIXKX9HYFvAHYc2P8A0QKnspEe1KbcgElTyD
	 U2Zi3yfdyh228bg1AQ0V7B3tJ0gyJy/eaj4dHA0WeGY4d34HJ99qj1M8xl4UNqsaP+
	 J+RF78UUTZjltvyPMLfqA17n9TVR+LdryhCFMxOWPIk8akTfruy5zUeSYahXLWS36u
	 dFnJeI/9IAwzMmyynDIjlBtyNfXHyOfonE82wAoIOExpY0P+6UCOfC0jpEouL+KECA
	 NSyAyqfV8rxCg==
Date: Fri, 22 Dec 2023 14:51:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
Message-ID: <ZYVVD2mL5kAePXDE@matsya>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-5-Vijendar.Mukunda@amd.com>
 <ZYRqEbVADgU4fNtB@matsya>
 <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com>

On 22-12-23, 12:45, Mukunda,Vijendar wrote:
> On 21/12/23 22:08, Vinod Koul wrote:

> > so the code is copied from a GPL declared file to now and GPL + BSD one!
> > Have you had lawyers look into this... why change one file license ?
> As per recommendations from our legal team, we have updated the license as dual
> one for amd_init.c file.
> We have also observed that license terms should be updated for other files as
> well (amd_manager.c, amd_manager.h & sdw_amd.h) as dual one, which we have
> planned to submit as a supplement patch.

Lets change that first before we move code from one license file to
another

Btw why would you want to do the change of license form GPL to dual?

-- 
~Vinod

