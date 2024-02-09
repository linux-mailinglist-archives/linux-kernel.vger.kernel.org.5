Return-Path: <linux-kernel+bounces-59165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1484F26E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F091F23AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382467C7D;
	Fri,  9 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bmjJuNIe"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CA6773B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471690; cv=none; b=PLWaPYmrAB0uCbDPtjQHIqMheigNkNeRe8G+O0w/sOnHBmI5j/Lt8ZY72srwbov5kYVibQRQ98Zcv1Xz6CkXwsx3JnOyQ3wASxuEFmwteD0Y86B0D8GgVStgIPT7xtnV8oSnKjAJz0RnJf1lq/xOze/CwyOLjxiEGta4dKuv4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471690; c=relaxed/simple;
	bh=oWEmMBTGiNvL9yQtN+r090K337WkWzdHP+zNHBXpTKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Uxr3GLIaMcu0IG3x6hcFCX4w4qSjNSiTZwBEUgzYL0Qds981Q9ut4GGMH30ErH2aOxLP0uKPTWSLuySmbDPVgmUnUKgfR0RqotzAi7IoVU77HjGqs2NH2FBwMaddKTZGJ7jFsmRvtZq68tvIJlXIk3EtLMgjkkijHRd7vLbaPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bmjJuNIe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209094121euoutp024152c3a8ecb90438cea4d6f61d642217~yKHKIKM3r2627926279euoutp02S
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:41:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209094121euoutp024152c3a8ecb90438cea4d6f61d642217~yKHKIKM3r2627926279euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707471681;
	bh=mZ6dOajC4BmQglcSLlWCGzdZBLyDJUYRGvJyIpUfgEo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bmjJuNIeqCQNRV3sswRZC0ITvdK5w3vF/j2Z3L1OueRrbVHrSFmryF+r5bXp3+axF
	 07IDsKTlgAINtA4CxlWVt/1jMT+xvfK25Nf8MBa3FW4cb9KN87ng64I2IGrrDZbQnk
	 qffcqZk0znulIfSc26pO4r+BJCiH9wXd5Z+hzmK8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209094120eucas1p2cb9b256dbee76a0a65ccf777cb8721f8~yKHJ90uvW1039510395eucas1p25;
	Fri,  9 Feb 2024 09:41:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.67.09814.043F5C56; Fri,  9
	Feb 2024 09:41:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209094120eucas1p191178d28da0f0dcae85f951fd9589f8b~yKHJuFS1T0522605226eucas1p18;
	Fri,  9 Feb 2024 09:41:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209094120eusmtrp2c6fefe0fa14282ea213c79f56bf22495~yKHJtha-k2066020660eusmtrp2T;
	Fri,  9 Feb 2024 09:41:20 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-77-65c5f3408da4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.D2.10702.043F5C56; Fri,  9
	Feb 2024 09:41:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209094120eusmtip1d3c309897edbe524265b6e942d7bf19f~yKHJTIzMI2623826238eusmtip1V;
	Fri,  9 Feb 2024 09:41:20 +0000 (GMT)
Message-ID: <2cc401dc-bfeb-402e-967e-bd1653640949@samsung.com>
Date: Fri, 9 Feb 2024 10:41:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240208225359.pvnunirbzh32zjop@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzvd889L9TZ42i+1KIrrCYvrZdrqdiq3WZUZr2uuNwzWdy155Be
	tCvz0lGJLB1iyEkvnMk4DNdFylCqE0mhtW60cbWmmuo8Kv99Pp/v9/P7fj/f/ShMWIi7UNHy
	OIaVS2NEhC2/rn26Z02A5RHj23xpvbg9dYwUJ5dWEeI+fQEhLilPwcS66g98cbFuBIkri1vJ
	AFJSU3mRkLQU3iUlV5vOSWpbLEhiqVm2Gz9o6y9jYqITGNZna4TtsewP5ejEbc/E8lFfFap0
	UyMbCuh1MGLJJNTIlhLSFQh6VUYeR74gyCxrJDliQfAjIxVXI2rWoisDTtci6NbexDkyiSDN
	mIZb3xXQW6E+w8CzYj69Eu4VDs3p9tB5Y4xvxYtpVxgeyCOt2IGOgLbXGbM6RjvBwFjRrNeR
	9oLWxz2zK2F0HQ+6pwYxa4Gg/UA9oSas2IbeDKXjn0jO7ArJD/IxqwHofgr097JwLul2yMuv
	Qhx2AHNHLcnhpfCroYjHGdIQFP8YniNZCFQfB+Ycm+FN93fCegCMXgVVeh9ODoRvLb0Edxc7
	6J+w55awg+y66xgnCyA9Vch1e4Cm4/6/sW29z7EsJNLMu4tmXn7NvDia/3OLEb8SOTHxytgo
	RrlWzpz0VkpjlfHyKO9IRWwN+vODns50fKlHWvOktwHxKGRAQGEiR0FYmZERCmTSU6cZVhHO
	xscwSgNaQvFFTgJ3mSsjpKOkccxxhjnBsH+rPMrGRcXLOb1tuc0hv7yJ2x6lQ0EhHj0nTfZ7
	px22vw+sH1V0Ou6cUMTtr/AfDDnSnF6SUu+yYkfMXcCc3XYtujYCb+z0YXveDTxjTYObnLui
	/QM+f21LfIsnRq7PYBcmzITsSzg8nc1QBaGpnlHPfqVnsuNsRJJzQ2RTcFKyvH9vo2d6d3ap
	bspw5oWjyrTz8hE813RlMW0Ms1TkhPYZz8sPTaUEv9hQrTMNvxJO1nQMacfDys6Ce3hu34WX
	R2Xth6larwPYLbeNppx3sWuCtF2ZZ77xvzYeMAe79w/iJgV5Rb9ftuDJp8AdQXdGc70fJkXY
	bVhImX3Mmm1b+mY6R39W26/6LuIrj0n9VmOsUvob/vV26rADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7oOn4+mGtxfqWJxrO0Ju0Xz4vVs
	Fpd3zWGzWLSsldli44anLBYLNj5itFi14AC7A7vHplWdbB77565h95i4p85jy/7PjB6fN8kF
	sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUx6
	uoyxYKV6xbLHBg2MqxS6GDk4JARMJDYukehi5OIQEljKKLH77xamLkZOoLiMxMlpDawQtrDE
	n2tdbBBF7xklPrzZCpbgFbCT2NF9CKyBRUBFYu3cu1BxQYmTM5+wgNiiAvIS92/NYAexhQUS
	JA7e7AaLMwuIS9x6Mh+sV0RAR+LAifNMEPEdTBL3JipDLPvBKLFs20SwoWwChhJdb0Gu4OTg
	FLCWWPzmJTtEg5lE19YuRghbXqJ562zmCYxCs5DcMQvJvllIWmYhaVnAyLKKUSS1tDg3PbfY
	SK84Mbe4NC9dLzk/dxMjMOK2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuENWXIkVYg3JbGyKrUo
	P76oNCe1+BCjKTAwJjJLiSbnA2M+ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
	tQimj4mDU6qBaXKk1prMU2lnrDzu9qbdsmoPSzJ+EtSlsc7bZS9/EbPkyU6/75vuysxas/9E
	zmz+Sf7lPvOOLqhm5K0TVLI0bhQRV+5a8KkyZmP8jtBWmUrhHLnzRzYs+JD0IWp+6oqEy8vi
	L6uujMz5s/fgpx+er/Vslh3i2xgxYc3MtZdEPVT37nqWvCWQP+jwdOYljmo8PK2zJlsJ39lu
	9XX3NocvfF/nMyTIe4vz/QnZ+HrW9B13JrOzLC85mL1LcZpH6IIrzmXtT67drP55rFgmM85e
	MuB+nNRUYd955f8kjh5ZU/BK/nJEv873VV+7da8HiNUfSdv01GVJ3BNGvxNqjisEPr47prXH
	JW1X3pzU7QKFDUosxRmJhlrMRcWJAIR1K2hBAwAA
X-CMS-MailID: 20240209094120eucas1p191178d28da0f0dcae85f951fd9589f8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec
References: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
	<CGME20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec@eucas1p1.samsung.com>
	<4b5683cc-8e61-43c5-be0f-b5378639276a@samsung.com>
	<20240208225359.pvnunirbzh32zjop@synopsys.com>

On 08.02.2024 23:54, Thinh Nguyen wrote:
> On Wed, Feb 07, 2024, Marek Szyprowski wrote:
>> On 19.01.2024 10:48, Uttkarsh Aggarwal wrote:
>>> In current scenario if Plug-out and Plug-In performed continuously
>>> there could be a chance while checking for dwc->gadget_driver in
>>> dwc3_gadget_suspend, a NULL pointer dereference may occur.
>>>
>>> Call Stack:
>>>
>>> 	CPU1:                           CPU2:
>>> 	gadget_unbind_driver            dwc3_suspend_common
>>> 	dwc3_gadget_stop                dwc3_gadget_suspend
>>>                                           dwc3_disconnect_gadget
>>>
>>> CPU1 basically clears the variable and CPU2 checks the variable.
>>> Consider CPU1 is running and right before gadget_driver is cleared
>>> and in parallel CPU2 executes dwc3_gadget_suspend where it finds
>>> dwc->gadget_driver which is not NULL and resumes execution and then
>>> CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
>>> it checks dwc->gadget_driver is already NULL because of which the
>>> NULL pointer deference occur.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 9772b47a4c29 ("usb: dwc3: gadget: Fix suspend/resume during device mode")
>>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
>> This patch landed some time ago in linux-next as commit 61a348857e86
>> ("usb: dwc3: gadget: Fix NULL pointer dereference in
>> dwc3_gadget_suspend"). Recently I found that it causes the following
>> warning when no USB gadget is bound to the DWC3 driver and a system
>> suspend/resume cycle is performed:
>>
>> dwc3 12400000.usb: wait for SETUP phase timed out
>> dwc3 12400000.usb: failed to set STALL on ep0out
>> ------------[ cut here ]------------
>> WARNING: CPU: 4 PID: 604 at drivers/usb/dwc3/ep0.c:289
>> dwc3_ep0_out_start+0xc8/0xcc
>> Modules linked in:
>> CPU: 4 PID: 604 Comm: rtcwake Not tainted 6.8.0-rc3-next-20240207 #7979
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>    unwind_backtrace from show_stack+0x10/0x14
>>    show_stack from dump_stack_lvl+0x58/0x70
>>    dump_stack_lvl from __warn+0x7c/0x1bc
>>    __warn from warn_slowpath_fmt+0x1a0/0x1a8
>>    warn_slowpath_fmt from dwc3_ep0_out_start+0xc8/0xcc
>>    dwc3_ep0_out_start from dwc3_gadget_soft_disconnect+0x16c/0x230
>>    dwc3_gadget_soft_disconnect from dwc3_gadget_suspend+0xc/0x90
>>    dwc3_gadget_suspend from dwc3_suspend_common+0x44/0x30c
>>    dwc3_suspend_common from dwc3_suspend+0x14/0x2c
>>    dwc3_suspend from dpm_run_callback+0x94/0x288
>>    dpm_run_callback from device_suspend+0x130/0x6d0
>>    device_suspend from dpm_suspend+0x124/0x35c
>>    dpm_suspend from dpm_suspend_start+0x64/0x6c
>>    dpm_suspend_start from suspend_devices_and_enter+0x134/0xbd8
>>    suspend_devices_and_enter from pm_suspend+0x2ec/0x380
>>    pm_suspend from state_store+0x68/0xc8
>>    state_store from kernfs_fop_write_iter+0x110/0x1d4
>>    kernfs_fop_write_iter from vfs_write+0x2e8/0x430
>>    vfs_write from ksys_write+0x5c/0xd4
>>    ksys_write from ret_fast_syscall+0x0/0x1c
>> Exception stack(0xf1421fa8 to 0xf1421ff0)
>> ...
>> irq event stamp: 14304
>> hardirqs last  enabled at (14303): [<c01a599c>] console_unlock+0x108/0x114
>> hardirqs last disabled at (14304): [<c0c229d8>]
>> _raw_spin_lock_irqsave+0x64/0x68
>> softirqs last  enabled at (13030): [<c010163c>] __do_softirq+0x318/0x4f4
>> softirqs last disabled at (13025): [<c012dd40>] __irq_exit_rcu+0x130/0x184
>> ---[ end trace 0000000000000000 ]---
>>
>> IMHO dwc3_gadget_soft_disconnect() requires some kind of a check if
>> dwc->gadget_driver is present or not, as it really makes no sense to do
> I don't think checking that is sufficient, and I don't think that's the
> case here.
>
>> any ep0 related operations if there is no gadget driver at all.
>>
> If there's indeed no gadget_driver present, then we wouldn't get this
> stack trace. (ie. dwc3_ep0_out_start should occurs when gadget_driver is
> present). This is a race happened between binding + suspend.

I have no gadget compiled into the kernel and no such created via 
configfs, so how can this be caused by a race?



> I think something like this should be sufficient. Would you mind giving
> it a try?
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 564976b3e2b9..1990d6371066 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2656,6 +2656,11 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>   	int ret;
>   
>   	spin_lock_irqsave(&dwc->lock, flags);
> +	if (!dwc->pullups_connected) {
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +		return 0;
> +	}
> +
>   	dwc->connected = false;
>   
>   	/*
>
This patch fixes the reported issue. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


