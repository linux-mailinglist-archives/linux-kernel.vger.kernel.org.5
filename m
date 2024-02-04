Return-Path: <linux-kernel+bounces-51691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A188E848E48
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457111F21C08
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29F225A9;
	Sun,  4 Feb 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SENKWiXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE3224F2;
	Sun,  4 Feb 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056038; cv=none; b=dHmd03/s420DV+bYztgWDVG1eGYraV34n0jx4odn1W+n12MAaeOecuxCZ81gHGscyHQrzqUzyY8cNLGf6TXG95ewJqbdCip2/5gUwCLNBR18khxO8L4O3Ci4wzIGgbJrSoudV3Oe0nUvcf0S6Sq6mR9MQhDTv2UjbX0NUC3H3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056038; c=relaxed/simple;
	bh=gilLb08zxYQMzyLKES/nyzXUv4HtI7+E31+bIoADmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdcuZTZ28rdYQYAk8v3MJAWKtik9ZtKwI3rUSquRtgFC72IbhFWcOZa9kTJ9N+sla3hUBLT4Ih0fGvhMXAU8JMerv5pad3dKSijUpylDOP8qWruUIHMhDbIGg0qkClt99/klKt8M+5FMdxlo9Jm8v4aKaVCwFDaL3jIAQdVI21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SENKWiXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02FDC433C7;
	Sun,  4 Feb 2024 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707056037;
	bh=gilLb08zxYQMzyLKES/nyzXUv4HtI7+E31+bIoADmVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SENKWiXWLWvjvowgEjx3z5h8D9ZsCoq3ZuO9MH/IAoOrpYfMiAklN6O0TTd/vV6CZ
	 BbvcPNSFVTv16eylYN+uSp0bp+l/fHNwumRVf7YK+cQC6Bam9xCCI7Q2C9uvWsgJMH
	 ItsRUOZ4oc5BEtT4iYkZhWoy0pxs6Zy151ldmwOs=
Date: Sun, 4 Feb 2024 06:13:56 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <2024020427-trio-clubbed-37b2@gregkh>
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <2024020410-bungee-number-f643@gregkh>
 <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>

On Sun, Feb 04, 2024 at 04:15:43PM +0300, Стас Ничипорович wrote:
> this issue also in 6.8-rc3 and 6.7.4-rc2 (

Oh good (well good in that this isn't unique to this tree.)

Please work with the networking developers to get this resolved.

thanks,

greg k-h

