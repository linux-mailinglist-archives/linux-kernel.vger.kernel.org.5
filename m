Return-Path: <linux-kernel+bounces-54414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92784AEF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F52B20A24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB8128803;
	Tue,  6 Feb 2024 07:24:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A2128810;
	Tue,  6 Feb 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204249; cv=none; b=utVAZW3jCGiYCM+JeDO4Xvn56rKelRcOmbZtQqrI5kTmo6TM+hEOwYinxBluGLGqn+o4jVTBFuHY4HeORiC/Eb1aidLwZDSVA9DZ8epaC9Cs/HGkLNHkPnCHXsnNzQzCb1V0lm7Xo2lw2BMbiotUUX2G/xmdztLa6qx5jpCU1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204249; c=relaxed/simple;
	bh=iiVDTBtOx/9NOmmUzGulxkNRXQLjiCBuy+JJbqYZsAc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KHiXN7hZLyoMr/wCsgfRUpfSKw9aDn90kDpDDI9qLsWaMdvLUQ6WcPdqTElthLGcgiDaqRxOrn8A5lL2gmyCIUg+wmcPgchNj/mkSWhYZptMzR1pLklEz0MMh7hY0oAENPZeOLFH3ih8v9IVvwSz4lbsoWjmIU8srJkJ6Unwl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTZTW0XDbz1xnMQ;
	Tue,  6 Feb 2024 15:22:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ECB31A016B;
	Tue,  6 Feb 2024 15:24:01 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 15:23:58 +0800
Subject: Re: [PATCH net-next v5 5/5] tools: virtio: introduce vhost_net_test
To: Jason Wang <jasowang@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
References: <20240205124506.57670-1-linyunsheng@huawei.com>
 <20240205124506.57670-6-linyunsheng@huawei.com>
 <CACGkMEsKHOefArPd56RAYPsJE8kf=jGb6B-V6eNJiViCAD7GYA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <7416cf5f-b6dc-285f-6acc-f437dcb74a42@huawei.com>
Date: Tue, 6 Feb 2024 15:23:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsKHOefArPd56RAYPsJE8kf=jGb6B-V6eNJiViCAD7GYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/2/6 11:08, Jason Wang wrote:

..

>> +
>> +static void wait_for_interrupt(struct vq_info *vq)
>> +{
>> +       unsigned long long val;
>> +
>> +       poll(&vq->fds, 1, -1);
> 
> It's not good to wait indefinitely.

How about a timeout value of 100ms as below?
poll(&vq->fds, 1, 100);

> 
>> +
>> +       if (vq->fds.revents & POLLIN)
>> +               read(vq->fds.fd, &val, sizeof(val));
>> +}
>> +
>> +static void verify_res_buf(char *res_buf)
>> +{
>> +       int i;
>> +
>> +       for (i = ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
>> +               assert(res_buf[i] == (char)i);
>> +}
>> +
>> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
>> +                       bool delayed, int bufs)
>> +{
>> +       long long spurious = 0;
>> +       struct scatterlist sl;
>> +       unsigned int len;
>> +       int r;
>> +
>> +       for (;;) {
>> +               long started_before = vq->started;
>> +               long completed_before = vq->completed;
>> +
>> +               virtqueue_disable_cb(vq->vq);
>> +               do {
>> +                       while (vq->started < bufs &&
>> +                              (vq->started - vq->completed) < 1) {
>> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN + TEST_BUF_LEN);
>> +                               r = virtqueue_add_outbuf(vq->vq, &sl, 1,
>> +                                                        dev->test_buf + vq->started,
>> +                                                        GFP_ATOMIC);
>> +                               if (unlikely(r != 0))
>> +                                       break;
>> +
>> +                               ++vq->started;
> 
> If we never decrease started/completed shouldn't we use unsigned here?
> (as well as completed)
> 
> Otherwise we may get unexpected results for vq->started as well as
> vq->completed.

We have "vq->started < bufs" checking before the increasing as above,
and there is 'assert(nbufs > 0)' when getting optarg in main(), which
means we never allow started/completed to be greater than nbufs as
my understanding.

> 
>> +
>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>> +                                       r = -1;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (vq->started >= bufs)
>> +                               r = -1;
> 
> Which condition do we reach here?

It is also a copy & paste of virtio_test.c
It means we have finished adding the outbuf in virtqueue, and set 'r'
to be '-1' so that we can break the inner while loop if there is no
result for virtqueue_get_buf() as my understanding.

> 
>> +
>> +                       /* Flush out completed bufs if any */
>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
>> +                               int n;
>> +
>> +                               n = recvfrom(dev->sock, dev->res_buf, TEST_BUF_LEN, 0, NULL, NULL);
>> +                               assert(n == TEST_BUF_LEN);
>> +                               verify_res_buf(dev->res_buf);
>> +
>> +                               ++vq->completed;
>> +                               r = 0;
>> +                       }
>> +               } while (r == 0);
>> +
>> +               if (vq->completed == completed_before && vq->started == started_before)
>> +                       ++spurious;
>> +
>> +               assert(vq->completed <= bufs);
>> +               assert(vq->started <= bufs);
>> +               if (vq->completed == bufs)
>> +                       break;
>> +
>> +               if (delayed) {
>> +                       if (virtqueue_enable_cb_delayed(vq->vq))
>> +                               wait_for_interrupt(vq);
>> +               } else {
>> +                       if (virtqueue_enable_cb(vq->vq))
>> +                               wait_for_interrupt(vq);
>> +               }
> 
> This could be simplified with
> 
> if (delayed)
> else
> 
> wait_for_interrupt(vq)

I am not sure if I understand the above comment.
The wait_for_interrupt() is only called conditionally depending on the
returning of virtqueue_enable_cb_delayed() and virtqueue_enable_cb().

> 
>> +       }
>> +       printf("TX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
>> +              spurious, vq->started, vq->completed);
>> +}
>> +

..

>> +
>> +                       /* Flush out completed bufs if any */
>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
>> +                               struct ether_header *eh;
>> +
>> +                               eh = (struct ether_header *)(dev->res_buf + HDR_LEN);
>> +
>> +                               /* tun netdev is up and running, ignore the
>> +                                * non-TEST_PTYPE packet.
>> +                                */
>> +                               if (eh->ether_type != htons(TEST_PTYPE)) {
>> +                                       ++vq->completed;
>> +                                       r = 0;
>> +                                       continue;
>> +                               }
>> +
>> +                               assert(len == TEST_BUF_LEN + HDR_LEN);
>> +                               verify_res_buf(dev->res_buf + HDR_LEN);
> 
> Let's simply the logic here:
> 
> if (ether_type == htons()) {
>     assert()
>     verify_res_buf()
> }
> 
> r = 0;
> ++vq->completed;

Sure.

> 
> Others look good.

Thanks for the reviewing.

> 
> Thanks
> 
> .
> 

