Return-Path: <linux-kernel+bounces-71153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D085A16C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5281F22739
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124E28E26;
	Mon, 19 Feb 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV0zLHHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854C1C10;
	Mon, 19 Feb 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339961; cv=none; b=p8uSi6z7cvc/swQWR4Vi2lZJouL1Of/2k9IHmB1/5i+bRGD9OzcZggOrNI+BKnBIfwGBe+Byp3ezomE8AchQd7EGMZIU1C02CV5zCoFr0GsiZRlPpCeXBtx3N+hmneQkuPH5eKYDEBAZueCZWIdNpezSAXCzU066aNjnxVWc66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339961; c=relaxed/simple;
	bh=Q4NsvvYSuir97OFwMmHvNRy3c3JBCxlYJttiAWiO/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dILRw0nBrQN6ZFmstluOoRKvECEfFZWgd5dFiwL2Ce7hIKj2gONSGReCU7dvHGL6/eup5sujeO+i3Hl99abjlxe0JqzF6pLUe/Jovdg3EOa6VeInVgHJgUsr1BPypjc7bg++sZHUdNYrEB8uSZ4vG9HMKFg4liV8iSvcWUvcGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV0zLHHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74408C433F1;
	Mon, 19 Feb 2024 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339960;
	bh=Q4NsvvYSuir97OFwMmHvNRy3c3JBCxlYJttiAWiO/xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV0zLHHlb0odT0Raki8ppmoWy0b04lWRSANyB3IJV3PIkFEnw7P4U8M3lKyz+jiMU
	 6Zb90NlIGbYBflGZpakkvh0oWcmCVG/JuXsG9Ue8BOik42Plq0EG5h+im9QUy8sT66
	 epdVKGzH4DtI7y1rjrsvmNVasLr4TmCZe5Rxi2IMhe1OsB2pz67LeDQwMhnjIP9S7V
	 U6WdLEPYm/AqXKZ8Zbi/vWZ2swE5HMyKcTDb/RhyV+OYMY305iS1uh0psL0caweCyf
	 o/TCIDQlU+JcXtrTq4+1EjQJF71P/PQJ9Ns0HuvUN5rSBfYlFWOZ7caXbjo3zWU9CI
	 FHpiKb2PZRC0Q==
Date: Mon, 19 Feb 2024 10:52:36 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wireless: Add KHZ_PER_GHZ to units.h and
 reuse
Message-ID: <20240219105236.GY40273@kernel.org>
References: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>

On Thu, Feb 15, 2024 at 05:41:36PM +0200, Andy Shevchenko wrote:
> The KHZ_PER_GHZ might be used by others (with the name aligned
> with similar constants). Define it in units.h and convert
> wireless to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


