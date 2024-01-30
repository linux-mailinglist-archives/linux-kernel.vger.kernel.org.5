Return-Path: <linux-kernel+bounces-44884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BE842888
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0511B24AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318768612D;
	Tue, 30 Jan 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myibXwsh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8385C67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630326; cv=none; b=iXTrjcW2Vgmryq2SPBzjahLJKTfnnqAJPsNoOzSmZXW15bbqsDNMC4sELAY6dwBOzBKrMS1IEbnxzIRTfLSYDGts7IJvLWlZmIJWF/PVU3P6rWZoU1hc2jZwuLXfi2pQPsg4yR+FCTHMJp0zQyz/ONeTiMr/EC9uy2RL1rObyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630326; c=relaxed/simple;
	bh=igZZcV/zWtQctF2QKGyC6Gn9cB3ebUyhI2KC+rnG7SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EITj1tyduSXOFtD6DJvdhYm54+sh3rNppmlX1MAz/MDad3nXHdp5+bxhsTI2/6EqYyOR+mfYDVl4C66yfSgJagPI0RJs/mwu+rV77wCCCjkA+Qp5PjiC543xzTf9AUXNfQrZr9BqnQqqL/15dXK1N7xXierAH4emuw3j6U246rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myibXwsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E8C43394;
	Tue, 30 Jan 2024 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630325;
	bh=igZZcV/zWtQctF2QKGyC6Gn9cB3ebUyhI2KC+rnG7SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myibXwshLj1afq3Gsz9VBx1m/Gwuvd80L1wMgOGnJFiGBH3fh5pHt07L7gIbQVAUF
	 IZxpvXjm2QcuSDBU7uj9nhHYLIgpsBz0qfegJoWrnefhWGUIwZL4tylg850ieisaex
	 Jr0gs19ebJf1fkiH7Gn99mxMxJjzT/D9FSLxJnN6JoOMai4qIZGFKZAJbLeTxF/TvM
	 a5umkR43R+BjzziFyquL5NUuJ6Cjkzi5HkMdwVzA7TK92Xa2KCkdzVPzTukTTL0f4w
	 UcpG7fr4xGMUNl5kdaWvCni1a+5V6FGxfy0jGbuf5RIXnNjUBF3tXkU7ZOERdi1Ooj
	 uSNATDh50VGwQ==
Date: Tue, 30 Jan 2024 21:28:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 02/13] soundwire: amd: update license
Message-ID: <ZbkcsYHBVYnxSe9e@matsya>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
 <20240129055147.1493853-3-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129055147.1493853-3-Vijendar.Mukunda@amd.com>

On 29-01-24, 11:21, Vijendar Mukunda wrote:
> Update license to dual license to align with Sound Open Firmware (SOF)
> driver as SOF uses dual license.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

