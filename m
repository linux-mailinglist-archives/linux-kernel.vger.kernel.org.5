Return-Path: <linux-kernel+bounces-8228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2F81B402
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859121F220D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361487408A;
	Thu, 21 Dec 2023 10:41:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CB745D8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5g3808z4xPh;
	Thu, 21 Dec 2023 21:40:55 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rohan McLure <rmclure@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Aneesh <aneesh.kumar@kernel.org>
In-Reply-To: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
References: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/5] powerpc/smp: Topology and shared processor optimizations
Message-Id: <170315510022.2192823.3630103323682637969.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 23:37:10 +0530, Srikar Dronamraju wrote:
> PowerVM systems configured in shared processors mode have some unique
> challenges. Some device-tree properties will be missing on a shared
> processor. Hence some sched domains may not make sense for shared processor
> systems.
> 
> Most shared processor systems are over-provisioned. Underlying PowerVM
> Hypervisor would schedule at a Big Core granularity. The most recent power
> processors support two almost independent cores. In a lightly loaded
> condition, it helps the overall system performance if we pack to lesser
> number of Big Cores.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/smp: Enable Asym packing for cores on shared processor
      https://git.kernel.org/powerpc/c/aa80c6343fcf53cbc29f84ba9f89ca87d4e41350
[2/5] powerpc/smp: Disable MC domain for shared processor
      https://git.kernel.org/powerpc/c/0e1c1986e0e65746daa05405d7747ce882f83cf1
[3/5] powerpc/smp: Add __ro_after_init attribute
      https://git.kernel.org/powerpc/c/fd535a858ebeb1f478b1d065b6c057f52aad483a
[4/5] powerpc/smp: Avoid asym packing within thread_group of a core
      https://git.kernel.org/powerpc/c/0e93f1c780e8fd315f1262467b7d35eb6f766d2f
[5/5] powerpc/smp: Dynamically build Powerpc topology
      https://git.kernel.org/powerpc/c/c46975715f5a7b941aa09bc0539a8dbe297f308f

cheers

