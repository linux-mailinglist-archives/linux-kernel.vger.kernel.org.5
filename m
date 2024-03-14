Return-Path: <linux-kernel+bounces-103695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632F87C313
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309481C20D62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7E75807;
	Thu, 14 Mar 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjmJfN7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C974E31;
	Thu, 14 Mar 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442306; cv=none; b=hIsJtxS8AlroJrRYxFvOsDWs6mF9ATgzsx3WvTSei68DlOcKuVvVSF05OJnVvloMTKxPjMoc29222aodVLExU9xtEBHXfKB9/Q7Q9EN+zVceLJMC3NFwgHx9whXNL1V1uViEN30pTj14aNf7Riob8XHYwiXtG0apBMMDoH9Gvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442306; c=relaxed/simple;
	bh=B0auFNMU0a2qEU1slHJdFpiMI6+4YftAqt/icEkgVKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHcNwBScT6qPMB7OXk5rRCtzBwta2p220hj+29wBKN7Ks3wpip54C8e4Xw58hjaIs5fLrw3CiHl9AuMDpCo0cNfLCPC5MeomZ8wvKKBPNk/5hqt8voOIWGE6NaMZXsbPxQfnMUNNacD0gVLezNQvDv7U1f9rOq7c7bZj09uWfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjmJfN7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8BC433C7;
	Thu, 14 Mar 2024 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710442306;
	bh=B0auFNMU0a2qEU1slHJdFpiMI6+4YftAqt/icEkgVKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZjmJfN7MyaEbp4Xbutg1wA2Lo1MsCQTBKzs0/lewVbywhaT6mUeRjnmcO4B+NRC0F
	 NZsFQENePXBG4AcMvR5LUNRgzk3//c2YKRQ/vMqSzhofey4shYU7u6piJygFHAITBb
	 wx5BPwpjmJdQFUVZ9LbYuNcHF4unWChsD4Zp5nhXWq3C7Bq/Mn9E9ahByEGfTGU8Xq
	 t0zX+cYbW7mNCqCj8YldRl3/Vq3KDHCzzju3RCCJONVtPPIjAlICRD+2+zWDiBX/dM
	 brionX4mnMUTUilAMbOgNfrk62dvpsoGn53VWfCHOta9yKbfpssch46SHiwTYgjxhh
	 AbL5gHwGun1JA==
Date: Thu, 14 Mar 2024 11:51:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 1/5] ptp: clockmatrix: support 32-bit
 address space
Message-ID: <20240314115144.56836fe5@kernel.org>
In-Reply-To: <LV3P220MB120256EDF5276AB8F65C1ABDA0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
References: <LV3P220MB120256EDF5276AB8F65C1ABDA0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 11:37:03 -0400 Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.

Please provide cover letters for series longer than 2 patches.

Apart from that:

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


