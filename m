Return-Path: <linux-kernel+bounces-58279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D613B84E401
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729651F27DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6167BAE3;
	Thu,  8 Feb 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LODppW7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35441E525;
	Thu,  8 Feb 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405833; cv=none; b=AjA1QGVB3YdZONV8n88PyVwHnSBU5X+vf7D55xdzcDD/YXg99uKb/JckxSnZj5tStVmwZ5gmfZtiXuaMT3+0LCTP4e99zhhr6f+2NB6Infi6zHz9WkX/htnboSkuHLTD2WloTD5ougRq2seKqPjHQIK3tovVSoS2FTmhj4X9zNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405833; c=relaxed/simple;
	bh=vUl54UiVAR4pVki952Goznem4donRfaYG3IjD6EekXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkdwlfXiV/tA3dHmNJRhUWLPQxchgd9saY+h+GOuDJDy9zBPtg05Wx9fU0heidj7h8XwaKO27WOi1U6zf1+/cinFcdrEDHAjyUL3DLIEgCpwitup1yOMLm1u2W83h2tnD3dINqI8aGWXQ338bDdGyA+QymYC8QEV/LRQk1qwn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LODppW7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ACCC433C7;
	Thu,  8 Feb 2024 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707405833;
	bh=vUl54UiVAR4pVki952Goznem4donRfaYG3IjD6EekXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LODppW7PtGvkE4PNz81HxVQ1dcOwNal6ChR1BqpOMA9BuRbKEX7HNjyed+nY29NnQ
	 n3q1wE/Iy/RIaiVzIWAtsKMxHOncuAmgcl6g2XkgATi32YD34dO0uF6EVMHSNl+3fk
	 3XiSZ2kBzQwiQdPgXkQIePu0O+wVm+h0w6x90174waTE0kwX+mG0RU2r0Z8W9Vuxup
	 kxJk3ulzlmsOep+relRv9BJbFwvbjQz+WR+GJwYa2rI6Ey9lYeZxI/2EXvL7Ozuijw
	 BODRWTXPZrQS0Dd4urDd12MoG9lc5+IUOM4BK75NF1QddfmcU/qJorb2nDqZgrkOep
	 AfaM9v9wX6NQg==
Date: Thu, 8 Feb 2024 07:23:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 vladimir.oltean@nxp.com, laforge@gnumonks.org
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20240208072351.3a806dda@kernel.org>
In-Reply-To: <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
References: <20240131134621.1017530-1-hayatake396@gmail.com>
	<20240131131258.47c05b7e@kernel.org>
	<CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
	<CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 16:34:49 +0900 Takeru Hayasaka wrote:
> Hello Jakub-san, and all reviewers and maintainers,
> 
> It has been a week since I last received any feedback on this patch. I
> apologize for the inconvenience during this busy period, but I would
> greatly appreciate it if you could continue the review.

We're expecting a v7 with the patch split into two.

