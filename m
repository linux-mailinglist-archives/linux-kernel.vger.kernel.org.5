Return-Path: <linux-kernel+bounces-111429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC797886C40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889891F2680F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E6446A2;
	Fri, 22 Mar 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etwQ4ss9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936F1E4A2;
	Fri, 22 Mar 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111117; cv=none; b=qhaaYHeFvt/cnXr0WJeIPrp/BOGuojdz8WzDVysjrsOyvb6loYZ53DT7MhPiovEvhemwGgtCECAwXjDcEfDhHkmm1YsIdzYgQplczFwJH3C5B/A0QQG5sUSaQW9MCEXn6AuDJjjRGoBJTOOTfUZlBsLNA02lr8wfG+ZmNKtFgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111117; c=relaxed/simple;
	bh=XxILMj4XdG/qv+Kctnfsta1+uF+9o+xl3R90tXyQLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClSpxbb0OV6V0uvdUvuIeN8yC7ZxklFfViQJnU3qCMgQPHO0iGqtr/ZEJwpeDcYoRHEcvVsXg1BCS3IgRahs28R6YfwAiQYcysKCvnQwMSlWdUPE4yYZ1OWpCorQIAiAJ8TuivGoiXtYya8yom6Vz3ms9R1yEsDTUug2xN6nYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etwQ4ss9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671A6C433F1;
	Fri, 22 Mar 2024 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711111117;
	bh=XxILMj4XdG/qv+Kctnfsta1+uF+9o+xl3R90tXyQLRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etwQ4ss9MTb4RqS1UUqa8VHriNf7HlrWilgcT8C6XavL8Zp0DhJlS9a8ik0Y58BHl
	 ABYIZsjh/cj2o6nEBpTceLHCqhInOjFhq/C+q4sHkB9ql5/wnsuIF4S0a1Zk91Wmpx
	 1l70Kt9FiOPXuf0EF2kIpk8B3VGO2ZbnvCYkYBbt+Fkgz5REvshaI17FUT+hIUZA/e
	 Mz4xOBcvMKCKq/rM4TeopsTXtml0NA6ssy8x96ojQF8KJMN8BNvWRMMn518fqNlrrp
	 +SD5K7tNpSE0OfGL+QdrqKNRZvZQiB/9gAssJ+qYozREU5MF7DPhCgsW+Q1Q244qRi
	 6ymO+dY0moI1g==
Date: Fri, 22 Mar 2024 12:38:33 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V1] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
Message-ID: <20240322123833.GC372561@kernel.org>
References: <20240322064650.275174-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322064650.275174-1-Raju.Lakkaraju@microchip.com>

On Fri, Mar 22, 2024 at 12:16:50PM +0530, Raju Lakkaraju wrote:
> PCI11x1x Rev B0 devices might drop packets when receiving back to back frames
> at 2.5G link speed. Change the B0 Rev device's Receive filtering Engine FIFO
> threshold parameter from its hardware default of 4 to 3 dwords to prevent the
> problem. Rev C0 and later hardware already defaults to 3 dwords.
> 
> Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Change List:
> ------------
> V0 -> V1:
>   - misc_ctl change from int to unsigned int
>   - Use FIELD_PREP macro instead of logical shift operator
>   - Change 0x3 to macro RFE_RD_FIFO_TH_3_DWORDS

Thanks for the updates,

Reviewed-by: Simon Horman <horms@kernel.org>


