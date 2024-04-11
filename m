Return-Path: <linux-kernel+bounces-140336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B558A12ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E90285119
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373D14A4E7;
	Thu, 11 Apr 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vvAFkGBE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620D14A4D6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834859; cv=none; b=PEGpe1o11JVynILKyq6oCMzuhxEvMUNz+Zz4baNB9wfblZTSQmdTV312xNPvN54SyvYSccSYXFEI5aoVT27L1eYu+k6t96qT+bfXWBlQsXUM3Rz9OutO7N7RMhz4RLdNBniB1DJvCVQRfvjS7J3DBHRtWonmtNPm6JoNOlHUHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834859; c=relaxed/simple;
	bh=6UhPqP7WY/fhmTWWvAmCBusG5RaOuI6S3pgD3LIFLFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wwk4fnFK0ceZpo4uSSMHxqY2ApDty7CUKAYKRuFtsCjdKo1NNHKrt9k8WjK3loytvwhO0nIfoxfxAmz3vRZEvTHfhFDf2m77NdikZOpeOketiZEHwUcBQXKrt4mM4Cy9SCHqyMnn+C7p92j25CGd4U5ya9IxUo45fUEThpDW1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vvAFkGBE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712834856;
	bh=6UhPqP7WY/fhmTWWvAmCBusG5RaOuI6S3pgD3LIFLFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vvAFkGBE5Cw6eaqOb+YAYcxpW3do2gxI9M1RsF9qcDxPpXHxX+OP4qELGkUjIFYhR
	 i3vbBDyF+A3/l7r6il+C39UPnm0k58MSmbtH6ke2wtJnWnZvAT6eKbyEOh4xN8GYM4
	 4cdBmBqi+EhPP+YY/pg0Ld6syjD1Ka8RdLH0zb7PE+KNBqGF9cnzJm1VnXaNigZ1bq
	 fPvbkrb6NQJN8SQZ3oXH2GzTJznvpMObR8YT4hHTXwwbxllDzv6aK13O+K4fSQV7td
	 OkSZhukw0RiaIl3QbPaAcCOF5Z4HvNJjWQgHjyLdWKDxsSGtZm+/2UmEpj0YT57VrJ
	 O+rDcEsgzPqkg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E155B37820A1;
	Thu, 11 Apr 2024 11:27:35 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [patch 0/2] x86/cpu/amd: Fixup the topology rework fallout
Date: Thu, 11 Apr 2024 13:27:43 +0200
Message-Id: <20240411112743.232798-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240410194002.909839385@linutronix.de>
References: <20240410194002.909839385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/10/24 21:45, Thomas Gleixner wrote:
> Testing at Collabora unearthed two issues in the new AMD topology parser
> code:
> 
>    1) The CPUID 0x80000008 parser initializes the wrong topology domain
>       level.
> 
>    2) The NODEID_MSR parser uses bitfields in a union wrongly which results
>       in reading out the wrong value and finally in a division by zero.
> 
> Many thanks to Laura for helping to debug this issue.
> 
>         tglx
> 
> 

Thanks a lot for investigating and solving the issue!

I confirm that with this series applied the kernel boots correctly on 
all three AMD Stoney Ridge Chromebooks that were affected by the 
regression.

I tested the patches on top of c749ce39 (culprit commit identified by
the bisection) - reference test job:
https://lava.collabora.dev/scheduler/job/13339645

The series doesn't apply directly to next, but I manually applied the
changes on top of next-20240411 and can confirm the kernel boots
correctly with this revision too - reference test job:
https://lava.collabora.dev/scheduler/job/13340321

The regression was originally reported by KernelCI, so:

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Tested-by: Laura Nao <laura.nao@collabora.com>

I'll make sure to update the Regzbot tag when the series is merged.

Best,

Laura


