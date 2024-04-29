Return-Path: <linux-kernel+bounces-162112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60488B5610
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76360282AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD43C482;
	Mon, 29 Apr 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KpV7bInp"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70EBA2E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388951; cv=none; b=ZjbfAhRxeXtZ8vrj3yq1WHo6oF00JRi4MZnweUq2ue6njrEifdOj/ryEMjGqJH5YQ4CRpYeJDUu9tvPVerDRgRHKIJ9Gn2QN0lfgCC7kXautMCa9UdRYul63w6rrEz1wfbpQffIq2St9F9AbtmOQ9yUhku5IZRPJxGwIqnuEUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388951; c=relaxed/simple;
	bh=6MiAVCPQHqTwXfZ0T4aSAhDd+a56+OvAKAvHJp5f4EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OVsWQs8+5lZGOHkssrmQaZ17Ap6ha3Qod/QDBoFW91HNNhhTNamgmq4ALbGFsuyjhFABOpA/6NrKTeRI5JPXYq8d/9Rgd0cQ0WPqziHeONMHV1Tnr7znSn82NZ5j2279sS+Uw9GksHlVZJ4Q5zRWv2nJDkhImPkSjUxYzUo/0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KpV7bInp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240429110901epoutp044b46c9b1093610863b940401c37e3d18~Ku6iqdQYo0820708207epoutp04Q
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:09:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240429110901epoutp044b46c9b1093610863b940401c37e3d18~Ku6iqdQYo0820708207epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714388941;
	bh=yI6rvHNe0HVK+zJypDzL8W3sCGAxdHsuWeaHeULz33A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KpV7bInpc2MWj9oNaWmFItZuNzNBFJ/fj2Z8lvRPB40lqo9WI8M+hElX5JmWsuLNP
	 /ZkXNaaCZ735tkWosMsCi/uJi/UYtaqbFVyCCgvZMTnQEaL/twIcn0kWuGIbGraxQd
	 o43IetfqHgrtsyoFNMXsVO1pu1HjNwVOl2XKt/iM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240429110900epcas2p10a5f77865cb0b850e5eb1c26ca980677~Ku6iAsprv2511825118epcas2p1Y;
	Mon, 29 Apr 2024 11:09:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VSgZ36hdLz4x9QG; Mon, 29 Apr
	2024 11:08:59 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.F5.09639.BCF7F266; Mon, 29 Apr 2024 20:08:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240429110859epcas2p4a9a57d69c5a3ab865abf4832b1abb7d1~Ku6grFn-Q3045430454epcas2p4P;
	Mon, 29 Apr 2024 11:08:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240429110859epsmtrp103bf494241c46b17badf8065f338338e~Ku6gqSaen1557915579epsmtrp1a;
	Mon, 29 Apr 2024 11:08:59 +0000 (GMT)
X-AuditID: b6c32a46-8ddfa700000025a7-1a-662f7fcbd6d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.46.19234.ACF7F266; Mon, 29 Apr 2024 20:08:58 +0900 (KST)
Received: from [172.27.222.155] (unknown [10.229.38.76]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240429110858epsmtip250c1e1fa0b88b790b74b189bdd57903b~Ku6garfoQ0541505415epsmtip2I;
	Mon, 29 Apr 2024 11:08:58 +0000 (GMT)
Message-ID: <639691db-dec3-e180-3681-00bd966c90a5@samsung.com>
Date: Mon, 29 Apr 2024 20:08:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.15.1
Subject: Re: [PATCH v3] locking/rwsem: Reintroduce reader optimistic
 spinning conditionally
Content-Language: en-US
To: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, corbet@lwn.net
Cc: gregkh@linuxfoundation.org, jstultz@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bongkyu7.kim@samsung.com
From: Bongkyu Kim <bongkyu7.kim@samsung.com>
In-Reply-To: <20240406081126.8030-1-bongkyu7.kim@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmme7pev00g8WnjCxeN75kslizpZHJ
	4smBdkaL5sXr2Sz+nNjIZrGwbQmLxeVdc9gsTh87wWJx6cACJovjvQeYLFrumDpwe+ycdZfd
	Y8GmUo/NK7Q8Nq3qZPPYP3cNu8fivsmsHu/3XWXz6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk
	/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoFuVFMoSc0qBQgGJxcVK+nY2
	RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZjfeaWQueXGWsWP8j
	sIFx1nLGLkZODgkBE4nXT78wdTFycQgJ7GCUuL76MjOE84lR4uyLeUwgVWDOi2nxMB1bZ39l
	hSjaySjR/OgblPOWUWLj25/MIFW8AnYSf99NALNZBFQlnm95wAIRF5Q4OfMJmC0qEC0xc9pC
	sDuEBWIlmg7+AIszC4hL3HoyH2yziEC5xNoXx8AWMAt0MkocuLoHbCibgI7E/9UzwIo4BWwl
	Dk9awwrRLC+x/e0cZohTT3BI3Pnr3sXIAWS7SEzty4AIC0u8Or6FHcKWknjZ3wZlF0tMfDkV
	7H0JgQZGiabX21kgEsYSs561M4LMYRbQlFi/Sx9ipLLEkVtQJ/NJdBz+yw4R5pXoaBOCaFST
	2P28lRXClpE4eHYtE4TtIbFs5VT2CYyKs5ACZRaS52ch+WUWwt4FjCyrGMVSC4pz01OLjQqM
	4JGdnJ+7iRGcjLXcdjBOeftB7xAjEwfjIUYJDmYlEd5Nc7TThHhTEiurUovy44tKc1KLDzGa
	AqNmIrOUaHI+MB/klcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXA
	5JfGOz2L4YHQo20VJ2dvVHKr+el20jfFrKQ25LH6tKtrdghu+Oy68/5ahgjXa5fTCiMk53Dm
	F5ld2P9zVdpXrRDlD+5rN9afjehy0JphKNSvu8rVvjBIw/pa/rxgs1drq0wMI5KPRq15u8zy
	ZXPv+7XFNjzRrbtqVbnWhm2MfrI2jVF7e/wmHSb9B4xGLLnVKa7tO3TaF5pF9r7o+lkxL1Sh
	WmqjmJK444J315sS+s6IX1L22xPa3Lp2IUPwbZ3Ml8s2hLN+ubhOpGyad5L68U/m/2vTZPWW
	Lb6wLvKPwJqUyQ13M69KzzZzcg9nnjfl5vSF0b5K+Uf3Rs48692YrmH7IX/lopRF3VnBsX+V
	WIozEg21mIuKEwF8H88RTwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvO6pev00g3mnbSxeN75kslizpZHJ
	4smBdkaL5sXr2Sz+nNjIZrGwbQmLxeVdc9gsTh87wWJx6cACJovjvQeYLFrumDpwe+ycdZfd
	Y8GmUo/NK7Q8Nq3qZPPYP3cNu8fivsmsHu/3XWXz6NuyitHj8ya5AM4oLpuU1JzMstQifbsE
	rozGe82sBU+uMlas/xHYwDhrOWMXIyeHhICJxNbZX1m7GLk4hAS2M0rMP/WeCSIhI3Ho31oo
	W1jifssRVhBbSOA1o8Ska8kgNq+AncTfdxOYQWwWAVWJ51sesEDEBSVOznwCZHNwiApES3S9
	NAYJCwvESjTtPQC2l1lAXOLWk/lg40UEyiVu390BdgOzQCejxP4lnYwQB01glOjonssGUsUm
	oCPxf/UMsA5OAVuJw5PWsIIsYBZQl1g/TwhiqLzE9rdzmCcwCs1CcsYsJPtmIXTMQtKxgJFl
	FaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZw3GkF7WBctv6v3iFGJg7GQ4wSHMxKIryb5min
	CfGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTAFOWgc4v40
	Xep1gd+zj8s8rp1d9fbFZ+MXrA/ZnBd8DH9SxFy0sCbdYKV1nhX3zuWcx9Ys2+D/hrlaaI9f
	6fcbXgx2+7f9ff3LYVn6Vyt3ZpFHdhMufeC7smzH5RX8jY8+5v7atTzm+oSbfiJ8fRKznbgL
	NP2iL7nafQ79uOzCJOHfM8437XdceNFXaH9NjtWf8EWfk0pDbKaac6rvDTrT/enklmfCK4yq
	mC6F2c/Zl3z13vu/cp6PRbcZneFRNN//+PfG3FLf5eq7fl2ZvGyLynFFq5uuK3jd9wm7612b
	1bvmYP1UbpnVcle+Ts7vT1zfMWmFj7zHHauCO5t8kl4tP79g/S3Zg9IT/ui7fruzcIUSS3FG
	oqEWc1FxIgBpf198KgMAAA==
X-CMS-MailID: 20240429110859epcas2p4a9a57d69c5a3ab865abf4832b1abb7d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240406081210epcas2p1736b44763ba01114ce3a552aff50d780
References: <CGME20240406081210epcas2p1736b44763ba01114ce3a552aff50d780@epcas2p1.samsung.com>
	<20240406081126.8030-1-bongkyu7.kim@samsung.com>

On 4/6/24 17:11, Bongkyu Kim wrote:
> Reader optimistic spinning is helpful when the reader critical section
> is short and there aren't that many readers around. It also improves
> the chance that a reader can get the lock as writer optimistic spinning
> disproportionally favors writers much more than readers.
> 
> Since commit 617f3ef95177 ("locking/rwsem: Remove reader optimistic
> spinning"), reader optimistic spinning was taken out is because of
> reader fragmentation especially now that we essentially wake up all the
> readers all at once when it is reader's turn to take the read lock.
> 
> But, on smaller systems with just a few CPU cores, reader optimistic
> spinning may help performance. So, reintroduce reader optimistic
> spinning and enable it when the number of cores in the system <= the
> threshold (default set to 8 cores). This threshold can be changed by
> "rwsem.rspin_maxcpus" commandline.
> 
> The simple heuristic of skipping optimistic spinning if the lock is
> reader owned is kept, reader optimistic spinning won't affect handoff
> handling which requires that an unlocker see the lock will be free and
> wake up the head of the wait queue.
> 
> Test result:
> This is 15 application startup performances in our exynos SoC.
> Reader optimistic spinning improves application startup time about 3.8%
> in average.
> - Cortex A78*2 + Cortex A55*6
> - android os
> - unit: ms (lower is better)
> 
> Application             base      rspin  Diff  Diff(%)
> --------------------  ------  ---------  ----  -------
> * Total(geomean)         343        330   -13    +3.8%
> --------------------  ------  ---------  ----  -------
> helloworld               110        108    -2    +1.8%
> Amazon_Seller            397        388    -9    +2.3%
> Whatsapp                 311        304    -7    +2.3%
> Simple_PDF_Reader        500        463   -37    +7.4%
> FaceApp                  330        317   -13    +3.9%
> Timestamp_Camera_Free    451        443    -8    +1.8%
> Kindle                   629        597   -32    +5.1%
> Coinbase                 243        233   -10    +4.1%
> Firefox                  425        399   -26    +6.1%
> Candy_Crush_Soda         552        538   -14    +2.5%
> Hill_Climb_Racing        245        230   -15    +6.1%
> Call_Recorder            437        426   -11    +2.5%
> Color_Fill_3D            190        180   -10    +5.3%
> eToro                    512        505    -7    +1.4%
> GroupMe                  281        266   -15    +5.3%
> 
> Signed-off-by: Bongkyu Kim <bongkyu7.kim@samsung.com>
> ---
> Changes v2 -> v3:
> - Enable reader optimistic spinning by rwsem_rspin_maxcpus
> - Use static_branch for rwsem_rspin_enabled
> - Modify commit messages
> 
> Changse v1 -> v2:
> - Move the rwsem_opt_rspin definition out of the "ifdef
>   CONFIG_RWSEM_SPIN_ON_OWNER" and add _ro_after_init to rwsem_opt_rspin.
> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  kernel/locking/lock_events_list.h             |   5 +-
>  kernel/locking/rwsem.c                        | 308 +++++++++++++++---
>  3 files changed, 275 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ef267fbf1b71..1e8d862acfb8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5780,6 +5780,12 @@
>  
>  	rw		[KNL] Mount root device read-write on boot
>  
> +	rwsem.rspin_maxcpus=	[KNL]
> +			Maximum number of cpus for enabling rwsem reader
> +			optimistic spinning. Reader optimistic spinning may
> +			help performance on a few CPU cores system. The default
> +			value is 8.
> +
>  	S		[KNL] Run init in single mode
>  
>  	s390_iommu=	[HW,S390]
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 97fb6f3f840a..270a0d351932 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -56,9 +56,12 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
>  LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
>  LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
>  LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
> -LOCK_EVENT(rwsem_opt_lock)	/* # of opt-acquired write locks	*/
> +LOCK_EVENT(rwsem_opt_rlock)	/* # of opt-acquired read locks		*/
> +LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
>  LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
>  LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
> +LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
> +LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
>  LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
>  LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
>  LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c6d17aee4209..7cc779b5f663 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -33,13 +33,19 @@
>  #include "lock_events.h"
>  
>  /*
> - * The least significant 2 bits of the owner value has the following
> + * The least significant 3 bits of the owner value has the following
>   * meanings when set.
>   *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
> - *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
> + *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
> + *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
>   *
> - * When the rwsem is reader-owned and a spinning writer has timed out,
> - * the nonspinnable bit will be set to disable optimistic spinning.
> + * When the rwsem is either owned by an anonymous writer, or it is
> + * reader-owned, but a spinning writer has timed out, both nonspinnable
> + * bits will be set to disable optimistic spinning by readers and writers.
> + * In the later case, the last unlocking reader should then check the
> + * writer nonspinnable bit and clear it only to give writers preference
> + * to acquire the lock via optimistic spinning, but not readers. Similar
> + * action is also done in the reader slowpath.
>  
>   * When a writer acquires a rwsem, it puts its task_struct pointer
>   * into the owner field. It is cleared after an unlock.
> @@ -59,9 +65,47 @@
>   * is previously owned by a writer and the following conditions are met:
>   *  - rwsem is not currently writer owned
>   *  - the handoff isn't set.
> + *
> + * Reader optimistic spinning is helpful when the reader critical section
> + * is short and there aren't that many readers around. It makes readers
> + * relatively more preferred than writers. When a writer times out spinning
> + * on a reader-owned lock and set the nospinnable bits, there are two main
> + * reasons for that.
> + *
> + *  1) The reader critical section is long, perhaps the task sleeps after
> + *     acquiring the read lock.
> + *  2) There are just too many readers contending the lock causing it to
> + *     take a while to service all of them.
> + *
> + * In the former case, long reader critical section will impede the progress
> + * of writers which is usually more important for system performance. In
> + * the later case, reader optimistic spinning tends to make the reader
> + * groups that contain readers that acquire the lock together smaller
> + * leading to more of them. That may hurt performance in some cases. In
> + * other words, the setting of nonspinnable bits indicates that reader
> + * optimistic spinning may not be helpful for those workloads that cause
> + * it.
> + *
> + * Therefore, any writers that had observed the setting of the writer
> + * nonspinnable bit for a given rwsem after they fail to acquire the lock
> + * via optimistic spinning will set the reader nonspinnable bit once they
> + * acquire the write lock. Similarly, readers that observe the setting
> + * of reader nonspinnable bit at slowpath entry will set the reader
> + * nonspinnable bits when they acquire the read lock via the wakeup path.
> + *
> + * Once the reader nonspinnable bit is on, it will only be reset when
> + * a writer is able to acquire the rwsem in the fast path or somehow a
> + * reader or writer in the slowpath doesn't observe the nonspinable bit.
> + *
> + * This is to discourage reader optmistic spinning on that particular
> + * rwsem and make writers more preferred. This adaptive disabling of reader
> + * optimistic spinning will alleviate the negative side effect of this
> + * feature.
>   */
>  #define RWSEM_READER_OWNED	(1UL << 0)
> -#define RWSEM_NONSPINNABLE	(1UL << 1)
> +#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
> +#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
> +#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
>  #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
>  
>  #ifdef CONFIG_DEBUG_RWSEMS
> @@ -78,6 +122,20 @@
>  # define DEBUG_RWSEMS_WARN_ON(c, sem)
>  #endif
>  
> +DEFINE_STATIC_KEY_FALSE(rwsem_rspin_enabled);
> +static int __ro_after_init rwsem_rspin_maxcpus = 8;
> +
> +static int __init parse_rwsem_param(char *arg)
> +{
> +	int val;
> +
> +	if (get_option(&arg, &val))
> +		rwsem_rspin_maxcpus = val;
> +
> +	return 0;
> +}
> +early_param("rwsem.rspin_maxcpus", parse_rwsem_param);
> +
>  /*
>   * On 64-bit architectures, the bit definitions of the count are:
>   *
> @@ -171,7 +229,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
>  					    struct task_struct *owner)
>  {
>  	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
> -		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
> +		(atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
>  
>  	atomic_long_set(&sem->owner, val);
>  }
> @@ -341,6 +399,7 @@ struct rwsem_waiter {
>  	enum rwsem_waiter_type type;
>  	unsigned long timeout;
>  	bool handoff_set;
> +	unsigned long last_rowner;
>  };
>  #define rwsem_first_waiter(sem) \
>  	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -480,6 +539,10 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  		 * the reader is copied over.
>  		 */
>  		owner = waiter->task;
> +		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
> +			owner = (void *)((unsigned long)owner | RWSEM_RD_NONSPINNABLE);
> +			lockevent_inc(rwsem_opt_norspin);
> +		}
>  		__rwsem_set_reader_owned(sem, owner);
>  	}
>  
> @@ -684,6 +747,30 @@ enum owner_state {
>  };
>  
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> +/*
> + * Try to acquire read lock before the reader is put on wait queue.
> + * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
> + * is ongoing.
> + */
> +static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
> +{
> +	long count = atomic_long_read(&sem->count);
> +
> +	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
> +		return false;
> +
> +	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
> +	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +		rwsem_set_reader_owned(sem);
> +		lockevent_inc(rwsem_opt_rlock);
> +		return true;
> +	}
> +
> +	/* Back out the change */
> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +	return false;
> +}
> +
>  /*
>   * Try to acquire write lock before the writer has been put on wait queue.
>   */
> @@ -695,14 +782,15 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>  		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
>  					count | RWSEM_WRITER_LOCKED)) {
>  			rwsem_set_owner(sem);
> -			lockevent_inc(rwsem_opt_lock);
> +			lockevent_inc(rwsem_opt_wlock);
>  			return true;
>  		}
>  	}
>  	return false;
>  }
>  
> -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
> +					   unsigned long nonspinnable)
>  {
>  	struct task_struct *owner;
>  	unsigned long flags;
> @@ -721,7 +809,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  	/*
>  	 * Don't check the read-owner as the entry may be stale.
>  	 */
> -	if ((flags & RWSEM_NONSPINNABLE) ||
> +	if ((flags & nonspinnable) ||
>  	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
>  		ret = false;
>  
> @@ -732,9 +820,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
>  
>  static inline enum owner_state
> -rwsem_owner_state(struct task_struct *owner, unsigned long flags)
> +rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long nonspinnable)
>  {
> -	if (flags & RWSEM_NONSPINNABLE)
> +	if (flags & nonspinnable)
>  		return OWNER_NONSPINNABLE;
>  
>  	if (flags & RWSEM_READER_OWNED)
> @@ -744,7 +832,7 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags)
>  }
>  
>  static noinline enum owner_state
> -rwsem_spin_on_owner(struct rw_semaphore *sem)
> +rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>  {
>  	struct task_struct *new, *owner;
>  	unsigned long flags, new_flags;
> @@ -753,7 +841,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  	lockdep_assert_preemption_disabled();
>  
>  	owner = rwsem_owner_flags(sem, &flags);
> -	state = rwsem_owner_state(owner, flags);
> +	state = rwsem_owner_state(owner, flags, nonspinnable);
>  	if (state != OWNER_WRITER)
>  		return state;
>  
> @@ -766,7 +854,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  		 */
>  		new = rwsem_owner_flags(sem, &new_flags);
>  		if ((new != owner) || (new_flags != flags)) {
> -			state = rwsem_owner_state(new, new_flags);
> +			state = rwsem_owner_state(new, new_flags, nonspinnable);
>  			break;
>  		}
>  
> @@ -816,12 +904,14 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
>  	return sched_clock() + delta;
>  }
>  
> -static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> +static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  {
>  	bool taken = false;
>  	int prev_owner_state = OWNER_NULL;
>  	int loop = 0;
>  	u64 rspin_threshold = 0;
> +	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
> +					   : RWSEM_RD_NONSPINNABLE;
>  
>  	/* sem->wait_lock should not be held when doing optimistic spinning */
>  	if (!osq_lock(&sem->osq))
> @@ -836,14 +926,15 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  	for (;;) {
>  		enum owner_state owner_state;
>  
> -		owner_state = rwsem_spin_on_owner(sem);
> +		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
>  		if (!(owner_state & OWNER_SPINNABLE))
>  			break;
>  
>  		/*
>  		 * Try to acquire the lock
>  		 */
> -		taken = rwsem_try_write_lock_unqueued(sem);
> +		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
> +			      : rwsem_try_read_lock_unqueued(sem);
>  
>  		if (taken)
>  			break;
> @@ -851,7 +942,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  		/*
>  		 * Time-based reader-owned rwsem optimistic spinning
>  		 */
> -		if (owner_state == OWNER_READER) {
> +		if (wlock && (owner_state == OWNER_READER)) {
>  			/*
>  			 * Re-initialize rspin_threshold every time when
>  			 * the owner state changes from non-reader to reader.
> @@ -860,7 +951,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  			 * the beginning of the 2nd reader phase.
>  			 */
>  			if (prev_owner_state != OWNER_READER) {
> -				if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
> +				if (rwsem_test_oflags(sem, nonspinnable))
>  					break;
>  				rspin_threshold = rwsem_rspin_threshold(sem);
>  				loop = 0;
> @@ -935,30 +1026,89 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  }
>  
>  /*
> - * Clear the owner's RWSEM_NONSPINNABLE bit if it is set. This should
> + * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
>   * only be called when the reader count reaches 0.
> + *
> + * This give writers better chance to acquire the rwsem first before
> + * readers when the rwsem was being held by readers for a relatively long
> + * period of time. Race can happen that an optimistic spinner may have
> + * just stolen the rwsem and set the owner, but just clearing the
> + * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
>   */
> -static inline void clear_nonspinnable(struct rw_semaphore *sem)
> +static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
>  {
> -	if (unlikely(rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)))
> -		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
> +	if (unlikely(rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE)))
> +		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
> +}
> +
> +/*
> + * This function is called when the reader fails to acquire the lock via
> + * optimistic spinning. In this case we will still attempt to do a trylock
> + * when comparing the rwsem state right now with the state when entering
> + * the slowpath indicates that the reader is still in a valid reader phase.
> + * This happens when the following conditions are true:
> + *
> + * 1) The lock is currently reader owned, and
> + * 2) The lock is previously not reader-owned or the last read owner changes.
> + *
> + * In the former case, we have transitioned from a writer phase to a
> + * reader-phase while spinning. In the latter case, it means the reader
> + * phase hasn't ended when we entered the optimistic spinning loop. In
> + * both cases, the reader is eligible to acquire the lock. This is the
> + * secondary path where a read lock is acquired optimistically.
> + *
> + * The reader non-spinnable bit wasn't set at time of entry or it will
> + * not be here at all.
> + */
> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> +					      unsigned long last_rowner)
> +{
> +	unsigned long owner = atomic_long_read(&sem->owner);
> +
> +	if (!(owner & RWSEM_READER_OWNED))
> +		return false;
> +
> +	if (((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK) &&
> +	    rwsem_try_read_lock_unqueued(sem)) {
> +		lockevent_inc(rwsem_opt_rlock2);
> +		lockevent_add(rwsem_opt_fail, -1);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
> +{
> +	return !osq_is_locked(&sem->osq);
>  }
>  
>  #else
> -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
> +					   unsigned long nonspinnable)
>  {
>  	return false;
>  }
>  
> -static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> +static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  {
>  	return false;
>  }
>  
> -static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
> +static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
> +
> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> +					      unsigned long last_rowner)
> +{
> +	return false;
> +}
> +
> +static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
> +{
> +	return false;
> +}
>  
>  static inline enum owner_state
> -rwsem_spin_on_owner(struct rw_semaphore *sem)
> +rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>  {
>  	return OWNER_NONSPINNABLE;
>  }
> @@ -984,7 +1134,7 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
>  		wake_type = RWSEM_WAKE_READERS;
>  	} else {
>  		wake_type = RWSEM_WAKE_ANY;
> -		clear_nonspinnable(sem);
> +		clear_wr_nonspinnable(sem);
>  	}
>  	rwsem_mark_wake(sem, wake_type, wake_q);
>  }
> @@ -995,32 +1145,64 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
>  static struct rw_semaphore __sched *
>  rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state)
>  {
> -	long adjustment = -RWSEM_READER_BIAS;
> +	long owner, adjustment = -RWSEM_READER_BIAS;
>  	long rcnt = (count >> RWSEM_READER_SHIFT);
>  	struct rwsem_waiter waiter;
>  	DEFINE_WAKE_Q(wake_q);
>  
>  	/*
>  	 * To prevent a constant stream of readers from starving a sleeping
> -	 * writer, don't attempt optimistic lock stealing if the lock is
> -	 * very likely owned by readers.
> +	 * waiter, don't attempt optimistic spinning if the lock is currently
> +	 * owned by readers.
>  	 */
> -	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
> -	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
> +	owner = atomic_long_read(&sem->owner);
> +	if ((owner & RWSEM_READER_OWNED) && (rcnt > 1) &&
> +	   !(count & RWSEM_WRITER_LOCKED))
>  		goto queue;
>  
>  	/*
> -	 * Reader optimistic lock stealing.
> +	 * Reader optimistic lock stealing
> +	 *
> +	 * We can take the read lock directly without doing
> +	 * rwsem_optimistic_spin() if the conditions are right.
> +	 * Also wake up other readers if it is the first reader.
>  	 */
> -	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
> +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
> +	    rwsem_no_spinners(sem)) {
>  		rwsem_set_reader_owned(sem);
>  		lockevent_inc(rwsem_rlock_steal);
> +		if (rcnt == 1)
> +			goto wake_readers;
> +		return sem;
> +	}
> +
> +	if (!static_branch_unlikely(&rwsem_rspin_enabled))
> +		goto queue;
> +
> +	/*
> +	 * Save the current read-owner of rwsem, if available, and the
> +	 * reader nonspinnable bit.
> +	 */
> +	waiter.last_rowner = owner;
> +	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
> +		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
> +
> +	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
> +		goto queue;
>  
> +	/*
> +	 * Undo read bias from down_read() and do optimistic spinning.
> +	 */
> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +	adjustment = 0;
> +	if (rwsem_optimistic_spin(sem, false)) {
> +		/* rwsem_optimistic_spin() implies ACQUIRE on success */
>  		/*
> -		 * Wake up other readers in the wait queue if it is
> -		 * the first reader.
> +		 * Wake up other readers in the wait list if the front
> +		 * waiter is a reader.
>  		 */
> -		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
> +wake_readers:
> +		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
>  			raw_spin_lock_irq(&sem->wait_lock);
>  			if (!list_empty(&sem->wait_list))
>  				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
> @@ -1029,6 +1211,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  			wake_up_q(&wake_q);
>  		}
>  		return sem;
> +	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
> +		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
> +		return sem;
>  	}
>  
>  queue:
> @@ -1045,7 +1230,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  		 * immediately as its RWSEM_READER_BIAS has already been set
>  		 * in the count.
>  		 */
> -		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
> +		if (adjustment && !(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
>  			/* Provide lock ACQUIRE */
>  			smp_acquire__after_ctrl_dep();
>  			raw_spin_unlock_irq(&sem->wait_lock);
> @@ -1058,7 +1243,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  	rwsem_add_waiter(sem, &waiter);
>  
>  	/* we're now waiting on the lock, but no longer actively locking */
> -	count = atomic_long_add_return(adjustment, &sem->count);
> +	if (adjustment)
> +		count = atomic_long_add_return(adjustment, &sem->count);
> +	else
> +		count = atomic_long_read(&sem->count);
>  
>  	rwsem_cond_wake_waiter(sem, count, &wake_q);
>  	raw_spin_unlock_irq(&sem->wait_lock);
> @@ -1100,21 +1288,43 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  	return ERR_PTR(-EINTR);
>  }
>  
> +/*
> + * This function is called by the a write lock owner. So the owner value
> + * won't get changed by others.
> + */
> +static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
> +						bool disable)
> +{
> +	if (unlikely(disable)) {
> +		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
> +		lockevent_inc(rwsem_opt_norspin);
> +	}
> +}
> +
>  /*
>   * Wait until we successfully acquire the write lock
>   */
>  static struct rw_semaphore __sched *
>  rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  {
> +	bool disable_rspin;
>  	struct rwsem_waiter waiter;
>  	DEFINE_WAKE_Q(wake_q);
>  
>  	/* do optimistic spinning and steal lock if possible */
> -	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
> +	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
> +	    rwsem_optimistic_spin(sem, true)) {
>  		/* rwsem_optimistic_spin() implies ACQUIRE on success */
>  		return sem;
>  	}
>  
> +	/*
> +	 * Disable reader optimistic spinning for this rwsem after
> +	 * acquiring the write lock when the setting of the nonspinnable
> +	 * bits are observed.
> +	 */
> +	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
> +
>  	/*
>  	 * Optimistic spinning failed, proceed to the slowpath
>  	 * and block until we can acquire the sem.
> @@ -1170,7 +1380,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		if (waiter.handoff_set) {
>  			enum owner_state owner_state;
>  
> -			owner_state = rwsem_spin_on_owner(sem);
> +			owner_state = rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE);
>  			if (owner_state == OWNER_NULL)
>  				goto trylock_again;
>  		}
> @@ -1182,6 +1392,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		raw_spin_lock_irq(&sem->wait_lock);
>  	}
>  	__set_current_state(TASK_RUNNING);
> +	rwsem_disable_reader_optspin(sem, disable_rspin);
>  	raw_spin_unlock_irq(&sem->wait_lock);
>  	lockevent_inc(rwsem_wlock);
>  	trace_contention_end(sem, 0);
> @@ -1348,7 +1559,7 @@ static inline void __up_read(struct rw_semaphore *sem)
>  	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
>  	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
>  		      RWSEM_FLAG_WAITERS)) {
> -		clear_nonspinnable(sem);
> +		clear_wr_nonspinnable(sem);
>  		rwsem_wake(sem);
>  	}
>  	preempt_enable();
> @@ -1720,3 +1931,14 @@ void up_read_non_owner(struct rw_semaphore *sem)
>  EXPORT_SYMBOL(up_read_non_owner);
>  
>  #endif
> +
> +static int __init rwsem_init(void)
> +{
> +	if (num_possible_cpus() <= rwsem_rspin_maxcpus) {
> +		static_branch_enable(&rwsem_rspin_enabled);
> +		pr_info("rwsem: reader optimistic spinning enabled\n");
> +	}
> +
> +	return 0;
> +}
> +core_initcall(rwsem_init);
Hi Longman,

I made a new patch as you suggested.
I would appreciate if if you could review it.

Thanks,
Bongkyu.

