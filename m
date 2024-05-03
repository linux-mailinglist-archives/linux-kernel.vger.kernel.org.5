Return-Path: <linux-kernel+bounces-167127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966E8BA4C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324D3286711
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DFA10949;
	Fri,  3 May 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3bOLnsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215ADDD7;
	Fri,  3 May 2024 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697897; cv=none; b=fGWl96vKhbaEsudi5oEytfVgRy6MN72Yv24oYEmWLpMgo2+2+r8xAE/MBRkjQNJ+dJX6JnlmxhhP12Tx9mZLN7poXd7VAna9mndSGTHasafUccWYUg/SsoYdKH4ou+ici0RaUi44qeSM5V0l6Q+GBnHq2+5XuQ5XE1i1TbRzmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697897; c=relaxed/simple;
	bh=NPJYCq/Nmp/ay0B+ICkOLx2ZcYbdv4cYgV1ZmwKaT5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADeFrsQWfefFWZeKtfb441EbtXmuq1Z9Smf/Ern0855b6mGZ2tE9Z7V2FyVRq7CJlwmVuEghf6+svXRnMCZbvvdXUI/CibgthZYDTb4VH4bYr9GzYJm/DDONIrzo+wjHI4Zjhpg2eS8CY0yvFHBxktCXn/oaRKlxAiypWvR2uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3bOLnsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F7C113CC;
	Fri,  3 May 2024 00:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714697897;
	bh=NPJYCq/Nmp/ay0B+ICkOLx2ZcYbdv4cYgV1ZmwKaT5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3bOLnsG+0cug0EOD22NzlS4d7zIGoZkZr7cQ7eCHRHxQYbTvsXU9DCH7LaWASRBJ
	 iruNRDTMnGqdfoZqk7VLfaIumaJYFRNSPtz1CmzQV3SoZToN4lGessZzXM3sA7fehT
	 h+6NTBMWrJtRMVrMZfg3DSclQQfunce6W+RRgwWxsHV4l4J6EjwDASkn8qeNgQ7o/g
	 Nr3eToPut+GhOuv5JLNaYggdAS1VAfSdyvRpO0cJDX5yS9TH8wchu67EA6bMLfTTIF
	 LuRHKOBp5DNP0D859FqIy7pgL7llY7XYVaw5t6mG5D5o3g1xdNHHthU9xLeSWkZ1bT
	 OMXh0q/kOnBLA==
Date: Thu, 2 May 2024 17:58:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, jgg@nvidia.com, leonro@nvidia.com, Andrew Morton
 <akpm@linux-foundation.org>, Tal Gilboa <talgi@nvidia.com>,
 linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Subject: Re: [PATCH net-next] lib: Allow for the DIM library to be modular
Message-ID: <20240502175815.4f1619c6@kernel.org>
In-Reply-To: <20240503002540.7154-1-florian.fainelli@broadcom.com>
References: <20240503002540.7154-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 17:25:40 -0700 Florian Fainelli wrote:
> Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
> module. This is particularly useful in an Android GKI (Google Kernel
> Image) configuration where everything is built as a module, including
> Ethernet controller drivers. Having to build DIMLIB into the kernel
> image with potentially no user is wasteful.

How big is it? Folks from Alibaba are trying to add the ability to
change the profiles, they'd need to change the calling conventions.
Which is not terrible, but also why make them suffer if the gain
isn't big..

