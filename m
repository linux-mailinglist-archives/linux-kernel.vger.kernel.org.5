Return-Path: <linux-kernel+bounces-42545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA528402DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD171C22178
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E817254BF4;
	Mon, 29 Jan 2024 10:36:31 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AD537E2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524591; cv=none; b=bF+L5vAI33OBYTpCba34T8GOPNbYnQ215ro2ij2Z8vATQY14LpJIJRiiYq1wwkFSEfArTbYAwS0HZEqBcECCGXE7cyIF9+6PRLqSnm8ox6hXIzsMYVxAqSooEFcHx3pypiorQn78YdNmLYFmaPbI1cD5nmsSZIep3asL1rvUZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524591; c=relaxed/simple;
	bh=hAEN2veGrz/tm7lKx1WTCTriEvODMHZi3DDszdBe3+c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4p+XsBeRPdAaSpI3fzeMPtcQ0cFy1q+s0v0t/5KYmZoqn0D4YK0E+dFnnsdRB97wysQEHu5TWR6tbNI1I1jGtGmOe/JZERXV2ufazODRz8Un+dZBOsnJ48+XS55jzEFK1OL0rmCzDEK6u6rknZXcpHwc8nMM5WfLDfoRgQeyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4TNl831JqBzB0228;
	Mon, 29 Jan 2024 18:36:03 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 29 Jan
 2024 18:36:26 +0800
Date: Mon, 29 Jan 2024 18:36:25 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>
Subject: [RFC resend] sched: Can we rename 'core scheduling' to 'smt
 scheduling'?
Message-ID: <Zbd/qYQCQCELe+TF@fedora>
References: <202312191503+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312191503+0800-wangjinchao@xfusion.com>
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

On Tue, Dec 19, 2023 at 03:07:43PM +0800, Wang Jinchao wrote:
> The term 'core' in 'kernel/sched/' implies a relation to the kernel of sched,
> and at the same time, 'core' is used in 'core scheduling' to represent a CPU core.
> Both meanings coexist in the 'core.c' file and appear numerous times.
> 
> This can be confusing for newcomers.
> 
> --
> Wang Jinchao

Maybe we should rename sched/core_sched.c to sched/smt_sched.c, 
and move relevant code from sched/core.c to smt_sched.c.
I believe using "smt" in smt_sched.c would be clearer than "core" in core_sched.c, 
especially considering its association with core.c.

