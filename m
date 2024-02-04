Return-Path: <linux-kernel+bounces-51413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AC848AF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBED286526
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12C1C17;
	Sun,  4 Feb 2024 03:50:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110A6FD1;
	Sun,  4 Feb 2024 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707018640; cv=none; b=Z1OGlCG3/XwWGkC7nlGbmSizeDagCsQeYneHYgim4wvb5lAWIy5ehTw6HF68Z49+sLPN/sEDDR1Rpbe3/q9GHyR/MrEClTMccIr3qnLJ0O3nyoWxefc0SHab+Av62VrqXfHVZHzdr3JISxo48lVTg2EB6ynvwywNJgheWrDotqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707018640; c=relaxed/simple;
	bh=XJqqCkQY6hDhXX2alQOZaD95C4OOCP5Ii2WSEKcnwxs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ex3Jir630BAB43BXbn8YoY0lp2koPPUuBdyo/yeBA4uI3Ti97urXfxm8RJsRjWJIpClrY89pd7YMMcP8fUhSQ4s6yC9tzjeofsf6kZzevGuzLhh9n+19LhgtEzbD4/8NiGHYG6VZBHvIKYgu02vZdROI+WkTPLG5mtN6lK5YTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSFrB6Wp1z1xn8j;
	Sun,  4 Feb 2024 11:49:30 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DD3041A016B;
	Sun,  4 Feb 2024 11:50:34 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 4 Feb
 2024 11:50:34 +0800
Subject: Re: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
To: Jason Wang <jasowang@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
 <20240130113710.34511-6-linyunsheng@huawei.com>
 <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
 <dfc3dcb0-511c-945b-6099-c4d7ccbf3253@huawei.com>
 <CACGkMEsHLis66LntKTG01Eg7cMv-S7u05B3W6CizKRahJ5gDOw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <16dd5732-06d1-8dd9-85b4-8de7686bd73e@huawei.com>
Date: Sun, 4 Feb 2024 11:50:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsHLis66LntKTG01Eg7cMv-S7u05B3W6CizKRahJ5gDOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/2/4 9:30, Jason Wang wrote:
> On Fri, Feb 2, 2024 at 8:24 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/2/2 12:05, Jason Wang wrote:
>>> On Tue, Jan 30, 2024 at 7:38 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> introduce vhost_net_test basing on virtio_test to test
>>>> vhost_net changing in the kernel.
>>>
>>> Let's describe what kind of test is being done and how it is done here.
>>
>> How about something like below:
>>
>> This patch introduces testing for both vhost_net tx and rx.
>> Steps for vhost_net tx testing:
>> 1. Prepare a out buf
>> 2. Kick the vhost_net to do tx processing
>> 3. Do the receiving in the tun side
>> 4. verify the data received by tun is correct
>>
>> Steps for vhost_net rx testing::
>> 1. Prepare a in buf
>> 2. Do the sending in the tun side
>> 3. Kick the vhost_net to do rx processing
>> 4. verify the data received by vhost_net is correct
> 
> It looks like some important details were lost, e.g the logic for batching etc.

I am supposeing you are referring to the virtio desc batch handling，
right?

It was a copy & paste code of virtio_test.c, I was thinking about removing
the virtio desc batch handling for now, as this patchset does not require
that to do the testing, it mainly depend on the "sock->sk->sk_sndbuf" to
be INT_MAX to call vhost_net_build_xdp(), which seems to be the default
case for vhost_net.

> 
>>

..

>>>> +static void vdev_create_socket(struct vdev_info *dev)
>>>> +{
>>>> +       struct ifreq ifr;
>>>> +
>>>> +       dev->sock = socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
>>>> +       assert(dev->sock != -1);
>>>> +
>>>> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
>>>
>>> Nit: it might be better to accept the device name instead of repeating
>>> the snprintf trick here, this would facilitate the future changes.
>>
>> I am not sure I understand what did you mean by "accept the device name"
>> here.
>>
>> The above is used to get ifindex of the tun netdevice created in
>> tun_alloc(), so that we can use it in vdev_send_packet() to send
>> a packet using the tun netdevice created in tun_alloc(). Is there
>> anything obvious I missed here?
> 
> I meant a const char *ifname for this function and let the caller to
> pass the name.

Sure.

> 
>>

>>>> +
>>>> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
>>>> +                       bool delayed, int batch, int bufs)
>>>> +{
>>>> +       const bool random_batch = batch == RANDOM_BATCH;
>>>> +       long long spurious = 0;
>>>> +       struct scatterlist sl;
>>>> +       unsigned int len;
>>>> +       int r;
>>>> +
>>>> +       for (;;) {
>>>> +               long started_before = vq->started;
>>>> +               long completed_before = vq->completed;
>>>> +
>>>> +               do {
>>>> +                       if (random_batch)
>>>> +                               batch = (random() % vq->vring.num) + 1;
>>>> +
>>>> +                       while (vq->started < bufs &&
>>>> +                              (vq->started - vq->completed) < batch) {
>>>> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + TEST_BUF_LEN);
>>>> +
>>>> +                               r = virtqueue_add_inbuf(vq->vq, &sl, 1,
>>>> +                                                       dev->res_buf + vq->started,
>>>> +                                                       GFP_ATOMIC);
>>>> +                               if (unlikely(r != 0)) {
>>>> +                                       if (r == -ENOSPC &&
>>>
>>> Drivers usually maintain a #free_slots, this can help to avoid the
>>> trick for checking ENOSPC?
>>
>> The above "(vq->started - vq->completed) < batch" seems to ensure that
>> the 'r' can't be '-ENOSPC'?
> 
> Well, if this is true any reason we still check ENOSPEC here?

As mentioned above, It was a copy & paste code of virtio_test.c.
Will remove 'r == -ENOSPC' checking.

> 
>> We just need to ensure the batch <= desc_num,
>> and the 'r == -ENOSPC' checking seems to be unnecessary.
>>
>>>
>>>> +                                           vq->started > started_before)
>>>> +                                               r = 0;
>>>> +                                       else
>>>> +                                               r = -1;
>>>> +                                       break;
>>>> +                               }
>>>> +
>>>> +                               ++vq->started;
>>>> +
>>>> +                               vdev_send_packet(dev);
>>>> +
>>>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>>>> +                                       r = -1;
>>>> +                                       break;
>>>> +                               }
>>>> +                       }
>>>> +
>>>> +                       if (vq->started >= bufs)
>>>> +                               r = -1;
>>>> +
>>>> +                       /* Flush out completed bufs if any */
>>>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
>>>> +                               struct ether_header *eh;
>>>> +
>>>> +                               eh = (struct ether_header *)(dev->res_buf + HDR_LEN);
>>>> +
>>>> +                               /* tun netdev is up and running, ignore the
>>>> +                                * non-TEST_PTYPE packet.
>>>> +                                */
>>>
>>> I wonder if it's better to set up some kind of qdisc to avoid the
>>> unexpected packet here, or is it too complicated?
>>
>> Yes, at least I don't know to do that yet.
> 
> For example, the blackhole qdisc?

It seems the blackhole_enqueue() just drop everything, which includes
the packet sent using the raw socket in vdev_send_packet()?

We may bypass qdisc for the raw socket in vdev_send_packet()，but it
means other caller may bypass qdisc, and even cook up a packet with
ethertype being ETH_P_LOOPBACK, there is part of the reason I added a
simple payload verification in verify_res_buf().

> 
> Thanks
> 
> .
> 

