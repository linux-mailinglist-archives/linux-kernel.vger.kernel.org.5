Return-Path: <linux-kernel+bounces-14326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D6821B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2BB283175
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CFF4E2;
	Tue,  2 Jan 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uiji7T/0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D1EAE5;
	Tue,  2 Jan 2024 12:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5172FC433C7;
	Tue,  2 Jan 2024 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704197321;
	bh=R6o9aFq/1eAraRvjOhvfwi4bZfBlxQ2kpClYSSZs+CU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uiji7T/0OzS685kV62eXWDRIHs2d8lB3uInDNlFZxH0rqcp2JKULQJjsV7wilSets
	 MXjQsh75rv3K2O4vZyKRfS2zO+z9PTtGEir2OrKIm0zQtUC0aybMoz8LJpWCjBaYf5
	 sMYZ3s1DQsZC5rh66GH74Q33k5cXVEPl8+DiYk/Naebf7y/Sev8Vi5Otz7G2CzEIFh
	 sf8ci0gvSNI/nfQV0T0spRhpvQP/Rh6Fz1aUMM1wW5P411okXOKkcsIS+eVy8N2tyb
	 Kxu/3ZF0UBhTRJhdAybdGVULt/LrMWNfgnLE2JfaQEG/wrLwkNeWrFpUrve7rWF2Ba
	 ky93mKhmq+Rzw==
Message-ID: <8302ad43-96db-4ec3-a969-3aced7eb4750@kernel.org>
Date: Tue, 2 Jan 2024 13:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests: net/mptcp: mptcp_connect.sh - Internal error: Oops:
 qdisc_block_add_dev (net/sched/sch_api.c:1191)
Content-Language: en-GB, fr-BE
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>,
 Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org
Cc: Victor Nogueira <victor@mojatatu.com>,
 "David S. Miller" <davem@davemloft.net>, Hangyu Hua <hbh25y@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvu_estw19VvZDXVXGmuXg87FZHk3x7ZNLM-KTGOmXRLQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+G9fYvu_estw19VvZDXVXGmuXg87FZHk3x7ZNLM-KTGOmXRLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Naresh,

On 02/01/2024 10:48, Naresh Kamboju wrote:
> Following kernel oops noticed on qemu-arm64 while running
> selftests: net/mptcp: mptcp_connect.sh test cases on Linux next-20240102

Thank you for having cc MPTCP list for this failure with an MPTCP selftest.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ---
> # selftests: net/mptcp: mptcp_connect.sh
> # INFO: set ns3-6593b550-fBKovo dev ns3eth2: ethtool -K  gso off
> # INFO: set ns4-6593b550-fBKovo dev ns4eth3: ethtool -K  gro off
> # Created /tmp/tmp.vFrp4xubYR (size 219663 /tmp/tmp.vFrp4xubYR)
> containing data sent by client
> # Created /tmp/tmp.FrEUtOwsBN (size 5630063 /tmp/tmp.FrEUtOwsBN)
> containing data sent by server
> # New MPTCP socket can be blocked via sysctl [ OK ]
> # INFO: validating network environment with pings
> <6>[   32.891365] netem: version 1.3
> <1>[   32.901072] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> <1>[   32.901926] Mem abort info:
> <1>[   32.903342]   ESR = 0x0000000086000004
> <1>[   32.903768]   EC = 0x21: IABT (current EL), IL = 32 bits
> <1>[   32.904589]   SET = 0, FnV = 0
> <1>[   32.905415]   EA = 0, S1PTW = 0
> <1>[   32.905914]   FSC = 0x04: level 0 translation fault
> <1>[   32.909254] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103097000
> <1>[   32.909914] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> <0>[   32.913724] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
> <4>[   32.914739] Modules linked in: sch_netem crct10dif_ce sm3_ce sm3
> sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables
> x_tables
> <4>[   32.916764] CPU: 0 PID: 438 Comm: tc Not tainted
> 6.7.0-rc8-next-20240102 #1
> <4>[   32.917555] Hardware name: linux,dummy-virt (DT)
> <4>[   32.918608] pstate: 63400809 (nZCv daif +PAN -UAO +TCO +DIT
> -SSBS BTYPE=-c)
> <4>[   32.919392] pc : 0x0
> <4>[ 32.920396] lr : qdisc_block_add_dev (net/sched/sch_api.c:1191)

It doesn't look like to be an issue with MPTCP, but with TC (QDisc).

It seems like the issue has already been reported. There is even a patch
that has been proposed by Victor (but it looks like a new version is
expected):

https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojatatu.com/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

