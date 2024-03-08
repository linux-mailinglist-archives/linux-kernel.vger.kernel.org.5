Return-Path: <linux-kernel+bounces-96417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C2875BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CD21F2249D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159E22F11;
	Fri,  8 Mar 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6O/ulSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B32137F;
	Fri,  8 Mar 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860184; cv=none; b=npR8HLfxMrzDwPIZbXLpTrmkuiGB8nmWso5DWN0TrEaCSnkNKH50ZjLWeufR7q7a5nBbldJ4yucus2UQ8QFSYWLr/+kFDEAUt3CkkFLyfeHg0iNHFFklikh5g9dUURA972tuPiA2fExLTcSg5jDgx99RL1lGZudG+hFbVheRDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860184; c=relaxed/simple;
	bh=6jfEzgjlq7T04s/g4A4UKzuSt74I9RRtooGDdmDJHag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/GYYm06qzUT4WbfFNc44EoDkOSNbLmASB/muTwTSIzJrKnPIr9EMd+QmWoT/VUdHxR9piN5fOMtq2UkW8YsdAKF+GADbGNjA4tKBn9qA1dyvsW3exOGYrh7KBciIrfbZk896iGzxbtgTovZNZ4yx2x/wzkxUJntMycFFX8Yffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6O/ulSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86F2C433C7;
	Fri,  8 Mar 2024 01:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709860184;
	bh=6jfEzgjlq7T04s/g4A4UKzuSt74I9RRtooGDdmDJHag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6O/ulSZGkNdWeCN06SwOY+JXGKRjC4B/cduVr9S6yWAlahqln+GhpQ/HUdyHtAVX
	 7MoHfoxFFPnXxMq7QaSq6NKVnLz3YCs3TZQti58y9OyRjP9/A8txqslsxXIdu3gh+5
	 wm8fFZevLk/QHEh7zD7S3FctIa1OoiZ3MJFQlQdzg5vYJzmfrNIsJpzOGB/B5c46ww
	 CEw/X7kogUgK8jYRhPTc2onGfjDLnS5JjOYMGzQzO78OYs3T4d40HpbLBDGkSRYzcr
	 3tgU8bjTWUIFoqQTXGZ23wcRPjUaCL/PJGPH3wFB8xcEtJM4qHjExqHgRHq8jE+vOD
	 e0JcnaUiTvj4g==
Date: Thu, 7 Mar 2024 17:09:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
 <michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next] net: axienet: Fix kernel doc warnings
Message-ID: <20240307170942.6ada3f79@kernel.org>
In-Reply-To: <MN0PR12MB59536E9DFE0751049F15C1A6B7202@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240306091921.8665-1-suraj.gupta2@amd.com>
	<MN0PR12MB59536E9DFE0751049F15C1A6B7202@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 16:34:35 +0000 Pandey, Radhey Shyam wrote:
> > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>  
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Hi, FWIW the patch itself never made it to any kernel mailing list:
https://lore.kernel.org/all/20240306091921.8665-1-suraj.gupta2@amd.com/
you may need to resend

