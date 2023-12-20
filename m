Return-Path: <linux-kernel+bounces-7350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF9681A65A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F461F24347
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013AB47A46;
	Wed, 20 Dec 2023 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXU/E7x8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFA47A42;
	Wed, 20 Dec 2023 17:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4D1C433C9;
	Wed, 20 Dec 2023 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703093469;
	bh=3ALHVlWB+PX+DTCOyPpV5lt+1CtMC3kBzeg1rz6uRTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXU/E7x8QOKJ7b/4L5+5USipxCBBtRBDmIvdoXeYevwaMj8lIO90SwiWEK3dKaVN1
	 kNtnduiUBcF2RZbEBQqvIvM7hwSz+wLdKibkRXv/O75+wDhj9q1YFbepqTf6SsRPSq
	 m95G/UqBrWUYKsdn5pOUktCTb6n/4xbcIvYCBVJMK8kXqNiCmTRANnFyulwjxZreEz
	 8dNvL6IbgsKovfNYcf0aHNTVXdGqu0eE5euDDG8R4dO13pc3OzSBEHdhgqhJLYsvek
	 TwjDqKr4wPdD2dSira0b3ME7EerMC0IcCio6owER49rvkEytEsyCSbJWB9NL6dp8Kw
	 mgoPW2ckiZtCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 28FFF403EF; Wed, 20 Dec 2023 14:31:07 -0300 (-03)
Date: Wed, 20 Dec 2023 14:31:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, james.clark@arm.com,
	coresight@lists.linaro.org, suzuki.poulose@arm.com,
	mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
	al.grant@arm.com, mathieu.poirier@linaro.org, tor@ti.com,
	acme@redhat.com
Subject: Re: [PATCH 0/3] perf scripts python: arm-cs-trace-disasm.py:
Message-ID: <ZYMk2zh7jTzMiz8K@kernel.org>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 14, 2023 at 08:33:01PM +0800, Ruidong Tian escreveu:
> Now the instruction flow disasmed by arm-cs-trace-disasm.py is
> ambiguous and uncorrect, fix them in one patch set. Please refer to
> each patch for details.
> 
> Ruidong Tian (3):
>   perf scripts python: arm-cs-trace-disasm.py: print dso base address
>   perf scripts python: arm-cs-trace-disasm.py: set start vm addr of
>     exectable file to 0
>   perf scripts python: arm-cs-trace-disasm.py: do not ignore disam first
>     sample

Picked patches 2 and 3, waiting for further discussion about the other
one.

- Arnaldo

