Return-Path: <linux-kernel+bounces-130549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0A8979CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E611F27D65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC9155A5B;
	Wed,  3 Apr 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fbni1UMr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE943AB6;
	Wed,  3 Apr 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176078; cv=none; b=ryQ+vSx5aKmBPYU28d0P7jx0c9LQTCdVvaZu+APQRfktosQ6EOi9ctsS8qZ1zAYn0d1rUE0oieGQrgTbyJ5QCTic67s6OXPfkZ0kLs7PV8f7Nc30P0I/W4H6hJmLv/cTBykXR90hsVYO3Lxsi0G6Hk7D3L8vinMGT0c66foGrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176078; c=relaxed/simple;
	bh=XHvAvMoXgu7sPpDI3qeu0ABKCV3BEWhlCfPnZ6zc33o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkT5hQdpsBptP3lZcqJXBrqyC6ejiF+/1rOWh5RoQCuj5jW0VfqOX+QEiBKYfn2TT+Km6WWg8KrYcbOJZZiwudzPDMfH46QHOmSD5PdHwd2mO2dzl/znX2O+P5pmtxtKxc5cBLX7LMSjToROdSyEhOeQoNN4cuFXhOD3AbIz0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fbni1UMr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=J8OXQtjrrbGAGM1hq+9WwIxNq7gS8NJhOgS52sp/+eo=; b=Fbni1UMrSD0nW1RKHJStNsL6PV
	I4KXwNid8jwhPQE/gQyvpL8IpHu3Lj143/BqJDNzhGUekgs+Y2xuW6SIb+vD5jn+98pPR024hq71p
	O6vf0vdEAKT4lzPwhz5kl4iNQBi3WGIgaoolwRmt+9Mw4et1fUo4kUfVi9y5HpdRil8iIQe10Nx1H
	Vfl6I4Gb6FwOKqcTZDbdDAt1uLgu0sL7VrSVbSfcm+07jUCDaCY64mplxz3OcogXms9gMMM5v7hAl
	VEgF7jVTOMPOdZiE73ZZ/exSJP4hMC93pBaRwnoAZQKJ2DsOBb1wmP4HHjMJNFU4ZFDeUZKryMJ3Q
	hIwyi3fQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs7D7-0000000064h-1Oy3;
	Wed, 03 Apr 2024 20:27:53 +0000
Message-ID: <9a079670-bbed-4f5d-9ef6-876bb1d82d39@infradead.org>
Date: Wed, 3 Apr 2024 13:27:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/core-api: Update events_freezable_power
 references.
To: Audra Mitchell <audra@redhat.com>, corbet@lwn.net
Cc: tj@kernel.org, jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, raquini@redhat.com, aros@gmx.com
References: <20240403180022.16248-1-audra@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240403180022.16248-1-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/3/24 11:00 AM, Audra Mitchell wrote:
> Due to commit 8318d6a6362f ("workqueue: Shorten
> events_freezable_power_efficient name") we now have some stale
> references in the workqeueue documentation, so updating those
> references accordingly.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/workqueue.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
> index ed73c612174d..bcc370c876be 100644
> --- a/Documentation/core-api/workqueue.rst
> +++ b/Documentation/core-api/workqueue.rst
> @@ -671,7 +671,7 @@ configuration, worker pools and how workqueues map to the pools: ::
>    events_unbound           unbound  9  9 10 10  8
>    events_freezable         percpu   0  2  4  6
>    events_power_efficient   percpu   0  2  4  6
> -  events_freezable_power_  percpu   0  2  4  6
> +  events_freezable_pwr_ef  percpu   0  2  4  6
>    rcu_gp                   percpu   0  2  4  6
>    rcu_par_gp               percpu   0  2  4  6
>    slub_flushwq             percpu   0  2  4  6
> @@ -694,7 +694,7 @@ Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
>    events_unbound              38306     0      0.1       -       7       -       -
>    events_freezable                0     0      0.0       0       0       -       -
>    events_power_efficient      29598     0      0.2       0       0       -       -
> -  events_freezable_power_        10     0      0.0       0       0       -       -
> +  events_freezable_pwr_ef        10     0      0.0       0       0       -       -
>    sock_diag_events                0     0      0.0       0       0       -       -
>  
>                                total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
> @@ -704,7 +704,7 @@ Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
>    events_unbound              38322     0      0.1       -       7       -       -
>    events_freezable                0     0      0.0       0       0       -       -
>    events_power_efficient      29603     0      0.2       0       0       -       -
> -  events_freezable_power_        10     0      0.0       0       0       -       -
> +  events_freezable_pwr_ef        10     0      0.0       0       0       -       -
>    sock_diag_events                0     0      0.0       0       0       -       -
>  
>    ...

-- 
#Randy

