Return-Path: <linux-kernel+bounces-150890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB18AA649
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74171C20FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100CEC3;
	Fri, 19 Apr 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YAp6FL07"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E82384;
	Fri, 19 Apr 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487297; cv=none; b=nYChgu4IizUa8BNggZhLhj8nJZ3TPMMI5Oo6AV3qiTdy+nsxyfwWIdA2v0iS60L1b2NSJC5KwwuhQ66D1qE8kLZCPSBOvX2/2oLsJQKUhWXSthigT3FHbyUBUBaElETzDlJRFogCEG6M3VnzHHrkAXx5a9c8MfrwzlGAiB8/YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487297; c=relaxed/simple;
	bh=BtPgHFImxFvTKpsFVQwf/LICHmKnDiiIqVPepV+1iJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVtKTFMjWElNqdjMPqODPhlFWmX0Ayc5du53pYwntApWMPMjEqKplZl9huZI/D5rCcrN0DSgbKAcPhBzdO+vKRdb6nr3V5UYSWcsZnvcN8rHNQi3L7k0OAyE9jgwQ794iiOeq/fOAnRoxJICZtRlkE4vaFWERZybygl9Fm8YiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=YAp6FL07; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713487290;
	bh=NHQNrd99LJ9MCuk0KL/kZIA73cOzGBuWiBRcno6RL5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YAp6FL07CTI4y3Sq9B2GU6XiWXcFkW9Dnb3nbVlsty3SZpOJYDW+PZQ1YdkkslClb
	 uHU+cHmAxw2ocGndLAqhSjEWmo1CbnohJjrXCbg5Zg8wUAoQr8b1Pu2TApfsiYFngh
	 L+jikFj2KqK6YLefc8J4RY1cfNQefRXouhndrq4HXUYNqiO48nrCcyZlcd4fSmNyhA
	 8jFDBWIlNwm3J6QzHT4e1C+Tx7DkMdi8wqKNd0DAY9bUFhVuSlsE0hAspeH0ISsyn8
	 akcTI07axeLP9ZToKe3hMQ4i1WFYFHI0j2rvVQOus+cEIBbRC8qhZMG3+Qz+Si2Eem
	 X12cZe8M1rpIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLG6d1yqHz4wcn;
	Fri, 19 Apr 2024 10:41:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Christensen <drc@linux.ibm.com>, dougmill@linux.ibm.com,
 davem@davemloft.net
Cc: pradeeps@linux.ibm.com, netdev@vger.kernel.org, Linux PPC
 <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: eth: mark IBM eHEA as an Orphan
In-Reply-To: <20240418195517.528577-1-drc@linux.ibm.com>
References: <20240418195517.528577-1-drc@linux.ibm.com>
Date: Fri, 19 Apr 2024 10:41:24 +1000
Message-ID: <87zftq9oaz.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Christensen <drc@linux.ibm.com> writes:
> Current maintainer Douglas Miller has left IBM and no replacement has
> been assigned for the driver. The eHEA hardware was last used on
> IBM POWER7 systems, the last of which reached end-of-support at the
> end of 2020.
>
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> Reviewed-by: Pradeep Satyanarayana <pradeeps@linux.ibm.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5b89687680b..bcbbc240e51d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7831,9 +7831,8 @@ W:	http://aeschi.ch.eu.org/efs/
>  F:	fs/efs/
>  
>  EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
> -M:	Douglas Miller <dougmill@linux.ibm.com>
>  L:	netdev@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/net/ethernet/ibm/ehea/
>  
>  ELM327 CAN NETWORK DRIVER
> -- 
> 2.39.3

