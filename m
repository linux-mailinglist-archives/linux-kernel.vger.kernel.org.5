Return-Path: <linux-kernel+bounces-83674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B8869D23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38AD1F2756F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F892032D;
	Tue, 27 Feb 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="odVUulp4";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="QEUyMi2g"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170C1EB40
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053599; cv=none; b=WgnRCL0hwHI/SqDhftHSz225o8iixNfDto9AfWH+HoXyR3kco6soHBTDSZg9TK/1J5iNlDqYU82FuYfIhxLF3FxsMR0TyRXi1skppEBogQzk2dBzJwWH7xVICL3ly+zaP9xU2VVT/5MVTVXE8j/yjl4xB7Ub5atMTxoFxjnVgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053599; c=relaxed/simple;
	bh=MebS9n5ZiCS4+c+fVej6vKE1hD4/nz20mid32q2t1s0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZvzDSpVyGondt/EnKsgGe0FCDLfCsSCogOw5weAoFrauh05XC4UBHiyAS57SnV/dpJ4WG72y9fdyylfHRDX4n+EvMlSDnd2CymUAYEQQnz1luHrhbjtObbH0BlIjFrhJGOQEWZ1f9dlGBnN9P5lMibgoYEZ2qdUc7s++fn7P880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=odVUulp4; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=QEUyMi2g; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 6DE4CC002E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1709053260;
	bh=MD+Aeir3B6NSv5VxdWchXqnIlbEpAOLGX4DiWLdrVQs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=odVUulp4NTJadskyMmbqTctpkueG6DuJQskXWlApGq9Of11jwpjc+jZO5lNzUvULZ
	 4bvfaTF5pihBqOcBZ4aR1kVPpxK3+yOftUV9Evv2ArDHGzfXGP8h5xdCEuxag8myTE
	 WBMEn60qMbaRZ36RLeTEVg53ecVqA2XHm/qYjJXvWiiszQrlAWsqGXp1F49zjZyms7
	 WBneShy6r8Q7lxT6xk9iXwBjR3ULiwe7TDnEKO3cjXmxrS02y0HjSbtWsq3TqCdqJW
	 dPEJpGGPAn6mCorXzK6eHLDuJp+0rfipZ6axfB4js2nRdXVYBK4So8wUrpdbhKvKdB
	 I5k50oiX+0Z/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1709053260;
	bh=MD+Aeir3B6NSv5VxdWchXqnIlbEpAOLGX4DiWLdrVQs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QEUyMi2grJRDP+vJgy1S9AD4Dh5Bl9f2gqJEX8jl10Wj0syR3GLEoi6sPoXtklDhj
	 XD13tipkqxWH2MiC965NxNSKfSN62lyCnhxs0syGb0uRvwMlJJWQtvEra1MvVUKTuu
	 hsFnLrLpSfxujVW8WsnZpGzdgClB5jnO1BcYFTQ5W8l8fIQkkzlIuzu1zDGLBrU2Xo
	 hYPC3LEVZbPKM0zzDEEc43vVfzcFbxk83TkYIpdlRJkI9kG/4+nPhkQGZfYDqVkWLv
	 vwHeE+HZK+9YUrsgeGEd9vgTEe7qQb1EE0tRlYdCZ0vMoCshElQrt3Pg4ShrDtaC74
	 qyXKMNMXXb/8w==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <linux-riscv@lists.infradead.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Atish Patra
	<atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2,RESEND 0/2] drivers: perf: fix crash with the legacy riscv driver
Date: Tue, 27 Feb 2024 20:00:00 +0300
Message-ID: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)

This series fix crash with the legacy riscv driver when configs:
CONFIG_RISCV_PMU_LEGACY=y and CONFIG_RISCV_PMU_SBI=n and you try
to perf record

Vadim Shakirov (2):
  drivers: perf: added capabilities for legacy PMU
  drivers: perf: ctr_get_width function for legacy is not defined

 drivers/perf/riscv_pmu.c        | 18 +++++-------------
 drivers/perf/riscv_pmu_legacy.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1


