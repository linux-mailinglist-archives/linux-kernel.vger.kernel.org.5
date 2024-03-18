Return-Path: <linux-kernel+bounces-105640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3A87E1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D241C213E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A951D530;
	Mon, 18 Mar 2024 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAIvdc3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2518029;
	Mon, 18 Mar 2024 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727115; cv=none; b=E1SVx2yyFYznKwUbpypwHw9Z7gXAYJi2bACXWrB9CWa6KVu2bqSAHy2sdqgG0SSBJb+KJhWt19yPupzRFC3Dq+PtTRW8l/rfwJ8lyXv+9319d21GFdt5uYs/uKGOZt040lCiQw5655y45119KSO9p8wzsbGSTfuOSx8nT33IScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727115; c=relaxed/simple;
	bh=DcITcUi0UAzIfJfgwKPQR+v9uBz4blRpVUIme3CHnFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFB7oUWlaZy1S9LuLIQei7HvUopv+wqWl5PRuliKxnhW5fgMuoTuvbRRUdf2PM4yL1ioC91L8N6WSrUaduiMDTIGbb5t58mJf+vnBsHmNzRwylEuS1ZosHbi5NrnunexnP6oAy24ztEPm4U7aK1HhS8SwPBa+kuBNU8FwQGUAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAIvdc3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C89C433F1;
	Mon, 18 Mar 2024 01:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710727114;
	bh=DcITcUi0UAzIfJfgwKPQR+v9uBz4blRpVUIme3CHnFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAIvdc3+W8FabzOBdpjbNt/g0jAjRvax2T9f3NSY8kAOrB89h8mK4nw5jTJ1lrenD
	 Y5qJKBbqvraWed/nleybq9nkZkavn7X/B9pLcKMZ1RPzbmJIOqC6x55bnHDT4ptj2g
	 QSAQrQNFYvSN1c0wA/TAzTJSdNUGCbRKNvhLHnzIrkFXe7GKNV4g3jxQFKm2y92vQg
	 EGlj9Ghn5fxsugSIIZ46rB0m79t1yhi3O7zAJiCl+U8fDLM+HlwrAesQjIOxWwh0Sl
	 +sYxdTnEGNnsvz6zIZjBqEX4whzIGPHGiA3MjK/WIv240fYQj8/x76UwEfvan5BkyN
	 doWb5r1bfJjRw==
Date: Sun, 17 Mar 2024 21:58:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Subject: Re: [PATCH AUTOSEL 6.6 12/17] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Message-ID: <ZfefyOEkKM_GHvhC@sashalap>
References: <20240311151314.317776-1-sashal@kernel.org>
 <20240311151314.317776-12-sashal@kernel.org>
 <b13786b0-fdee-45a4-9f1a-33427cef5635@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b13786b0-fdee-45a4-9f1a-33427cef5635@amd.com>

On Mon, Mar 11, 2024 at 09:10:54PM +0530, Mukunda,Vijendar wrote:
>On 11/03/24 20:43, Sasha Levin wrote:
>> From: Jiawei Wang <me@jwang.link>
>>
>> [ Upstream commit 316a784839b21b122e1761cdca54677bb19a47fa ]
>>
>> The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
>> as detected with lspci:
>>
>> 64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
>>         ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)
>>
>> Signed-off-by: Jiawei Wang <me@jwang.link>
>> Link: https://msgid.link/r/20240228073914.232204-1-me@jwang.link
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch has to be reverted.
>Pci revision id 0x63 corresponds to Pink Sardine (PS) platform.
>Its not yellow corp platform.
>Already PS platform ACP driver with PDM controller support available
>in mainline kernel.
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/sound/soc/amd/ps?h=v6.7.9

I'll drop it, thanks.

-- 
Thanks,
Sasha

