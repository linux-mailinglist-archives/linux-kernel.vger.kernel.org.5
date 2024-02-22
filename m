Return-Path: <linux-kernel+bounces-76550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4385F901
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3BD2887B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2D012F377;
	Thu, 22 Feb 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo4CXFzb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D725FBA5;
	Thu, 22 Feb 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606635; cv=none; b=rKfducqcUFSQidYuxst6UVACUFmwUM7lFLci6uhsUKpaIxJ/mxM7PpxB/6uPqbplR67YgsRIIiEWS1+tUx5CEfgJRs5UfR195cwBBPqh7nHfBlIz8KpMqdLn44JwmAwgI9RTgqQwVXYeFQXwMXVMzus7WANfRXUKzT3pXOeeAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606635; c=relaxed/simple;
	bh=4N9VQX8XQjbKM+N/jKxzFbt+x+0lnhEwnlDnVtB0aHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVM+oWwvdfWP2P++IntuyiDJUCByYz3ut7GRQsuVVICnfcUbs18SEY1yhkyAFlTVO9/gf8l9W9dFwY0YS5lSIA1U7gLzQIZN6SYmJUPr1lbW2k7CcY0UmM8AyryINZWYGjT2p6DVLcMBK2DXMX4xPvEDPwOPvDdJ2hU0/6GrnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo4CXFzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC981C433F1;
	Thu, 22 Feb 2024 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708606634;
	bh=4N9VQX8XQjbKM+N/jKxzFbt+x+0lnhEwnlDnVtB0aHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo4CXFzbVxSJYX0QdbZjgug39vxUiwHJyviufPnO0hwbBKfJ7JKFCF87QIJILu7iX
	 eDIyjKzhPD8NtjDej/5zvsJk005Q4QYvuojR8Ypb6JWRSepVjeoOvluE+3YrRFu43+
	 nfrLbzexZQ7icbj/FMAN6x8QQGZXpWaScGIc0Pd/+ZwJgc5jMyr04BGedeuTeNroEX
	 k6UWLlT1h+Roq1yUXwk0g7m9uCOhdJHdo0C26OyMog0smempNAFYdvqZQapptNwLD2
	 X+Q2bycRgG175EeY09Bll4gWHA5/N8MNVXIeCXUXreFkfJMhOHu3PERDvOR0gPcGtQ
	 +VfDZ+L4inCdg==
Date: Thu, 22 Feb 2024 12:57:08 +0000
From: Will Deacon <will@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, palmer@dabbelt.com
Cc: Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/4] StarFive's StarLink PMU Support
Message-ID: <20240222125707.GA8589@willie-the-truck>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 29, 2024 at 05:51:37PM +0800, Ji Sheng Teoh wrote:
> This patch series adds support for StarFive's Starlink Performance
> Monitor Unit(PMU).
> StarFive's StarLink PMU integrates one or more CPU cores with
> a shared L3 memory system. The PMU supports overflow interrupt,
> up to 16 programmable 64bit event counters, and an independent
> 64bit cycle counter.
> StarLink PMU is accessed via MMIO.
> 
> Example Perf stat output:
> [root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
>         -e /starfive_starlink_pmu/read_miss/ \
>         -e /starfive_starlink_pmu/read_hit/ \
>         -e /starfive_starlink_pmu/release_request/  \
>         -e /starfive_starlink_pmu/write_hit/ \
>         -e /starfive_starlink_pmu/write_miss/ \
>         -e /starfive_starlink_pmu/write_request/ \
>         -e /starfive_starlink_pmu/writeback/ \
>         -e /starfive_starlink_pmu/read_request/ \
>         -- openssl speed rsa2048
> Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
> 2.84s
> Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
> 2.42s
> version: 3.0.11
> built on: Tue Sep 19 13:02:31 2023 UTC
> options: bn(64,64)
> CPUINFO: N/A
>                   sign    verify    sign/s verify/s
> rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
> /////////
>  Performance counter stats for 'system wide':
> 
>          649991998      starfive_starlink_pmu/cycles/
>            1009690      starfive_starlink_pmu/read_miss/
>            1079750      starfive_starlink_pmu/read_hit/
>            2089405      starfive_starlink_pmu/release_request/
>                129      starfive_starlink_pmu/write_hit/
>                 70      starfive_starlink_pmu/write_miss/
>                194      starfive_starlink_pmu/write_request/
>             150080      starfive_starlink_pmu/writeback/
>            2089423      starfive_starlink_pmu/read_request/
> 
>       27.062755678 seconds time elapsed
> 
> Ji Sheng Teoh (4):
>   perf: starfive: Add StarLink PMU support
>   dt-bindings: perf: starfive: Add JH8100 StarLink PMU
>   docs: perf: Add description for StarFive's StarLink PMU
>   MAINTAINERS: Add entry for StarFive StarLink PMU
> 
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  .../perf/starfive_starlink_pmu.rst            |  46 ++
>  .../perf/starfive,jh8100-starlink-pmu.yaml    |  46 ++
>  MAINTAINERS                                   |   7 +
>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/starfive_starlink_pmu.c          | 643 ++++++++++++++++++
>  7 files changed, 753 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst
>  create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
>  create mode 100644 drivers/perf/starfive_starlink_pmu.c

Palmer, are you ok with me taking this via the perf tree? I usually
leave the Risc-V stuff for you, but this one doesn't touch the arch code
at all.

Cheers,

Will

