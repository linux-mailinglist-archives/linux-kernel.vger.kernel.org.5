Return-Path: <linux-kernel+bounces-49833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA5847036
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E44A1F2B348
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914AC14533C;
	Fri,  2 Feb 2024 12:24:31 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999914198A;
	Fri,  2 Feb 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876660; cv=none; b=ZEyARc5/s1SuFf1V5/bhsD7b1G0rU1u4ZLsbTglQEXbCBF03ZRDSwGibsHRiFddFdxF+QFRCwy+ZSF6Vw2sCIfHaU+bTgku2lXrryXDtSy2DaKwCz1I1/6IPl18ve22T9sZVekqv5pzdOKzCMNGovAiJjWPyizkoEbU+PelCw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876660; c=relaxed/simple;
	bh=2slv0zHi3v9XTecM8qQvxL7ef967yjxlXQ7dAoIhKrw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YXfNjxzwVk0R+bMZkY/cJKTTwXNLx+SwY7nu35BLe/GwYKuZBv0tYyED6b74aSy9+fyYVwp7G6WUjZRWY7jGfFvoZwKhIGnC74vEoCvP3iVmfOsYKXA/ja7SsMKvoXi16D7yJqnO8kgDR1N3vPNSAS7qpllK+o4AfzRrHXZZVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TRFFn6jbvz1FK8D;
	Fri,  2 Feb 2024 20:19:41 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F532140384;
	Fri,  2 Feb 2024 20:24:13 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 20:24:12 +0800
Subject: Re: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
To: Jason Wang <jasowang@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
 <20240130113710.34511-6-linyunsheng@huawei.com>
 <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <dfc3dcb0-511c-945b-6099-c4d7ccbf3253@huawei.com>
Date: Fri, 2 Feb 2024 20:24:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/2/2 12:05, Jason Wang wrote:
> On Tue, Jan 30, 2024 at 7:38 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> introduce vhost_net_test basing on virtio_test to test
>> vhost_net changing in the kernel.
> 
> Let's describe what kind of test is being done and how it is done here.

How about something like below:

This patch introduces testing for both vhost_net tx and rx.
Steps for vhost_net tx testing:
1. Prepare a out buf
2. Kick the vhost_net to do tx processing
3. Do the receiving in the tun side
4. verify the data received by tun is correct

Steps for vhost_net rx testing::
1. Prepare a in buf
2. Do the sending in the tun side
3. Kick the vhost_net to do rx processing
4. verify the data received by vhost_net is correct


>> +
>> +static int tun_alloc(struct vdev_info *dev)
>> +{
>> +       struct ifreq ifr;
>> +       int len = HDR_LEN;
> 
> Any reason you can't just use the virtio_net uapi?

I didn't find a macro for that in include/uapi/linux/virtio_net.h.

Did you mean using something like below?
sizeof(struct virtio_net_hdr_mrg_rxbuf)

> 
>> +       int fd, e;
>> +
>> +       fd = open("/dev/net/tun", O_RDWR);
>> +       if (fd < 0) {
>> +               perror("Cannot open /dev/net/tun");
>> +               return fd;
>> +       }
>> +
>> +       memset(&ifr, 0, sizeof(ifr));
>> +
>> +       ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
>> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
>> +
>> +       e = ioctl(fd, TUNSETIFF, &ifr);
>> +       if (e < 0) {
>> +               perror("ioctl[TUNSETIFF]");
>> +               close(fd);
>> +               return e;
>> +       }
>> +
>> +       e = ioctl(fd, TUNSETVNETHDRSZ, &len);
>> +       if (e < 0) {
>> +               perror("ioctl[TUNSETVNETHDRSZ]");
>> +               close(fd);
>> +               return e;
>> +       }
>> +
>> +       e = ioctl(fd, SIOCGIFHWADDR, &ifr);
>> +       if (e < 0) {
>> +               perror("ioctl[SIOCGIFHWADDR]");
>> +               close(fd);
>> +               return e;
>> +       }
>> +
>> +       memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
>> +       return fd;
>> +}
>> +
>> +static void vdev_create_socket(struct vdev_info *dev)
>> +{
>> +       struct ifreq ifr;
>> +
>> +       dev->sock = socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
>> +       assert(dev->sock != -1);
>> +
>> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> 
> Nit: it might be better to accept the device name instead of repeating
> the snprintf trick here, this would facilitate the future changes.

I am not sure I understand what did you mean by "accept the device name"
here.

The above is used to get ifindex of the tun netdevice created in
tun_alloc(), so that we can use it in vdev_send_packet() to send
a packet using the tun netdevice created in tun_alloc(). Is there
anything obvious I missed here?

> 
>> +       assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >= 0);
>> +
>> +       dev->ifindex = ifr.ifr_ifindex;
>> +
>> +       /* Set the flags that bring the device up */
>> +       assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >= 0);
>> +       ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
>> +       assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >= 0);
>> +}
>> +
>> +static void vdev_send_packet(struct vdev_info *dev)
>> +{
>> +       char *sendbuf = dev->test_buf + HDR_LEN;
>> +       struct sockaddr_ll saddrll = {0};
>> +       int sockfd = dev->sock;
>> +       int ret;
>> +
>> +       saddrll.sll_family = PF_PACKET;
>> +       saddrll.sll_ifindex = dev->ifindex;
>> +       saddrll.sll_halen = ETH_ALEN;
>> +       saddrll.sll_protocol = htons(TEST_PTYPE);
>> +
>> +       ret = sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
>> +                    (struct sockaddr *)&saddrll,
>> +                    sizeof(struct sockaddr_ll));
>> +       assert(ret >= 0);
>> +}
>> +

..

>> +
>> +static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
>> +{
>> +       struct vhost_vring_file backend = { .index = idx, .fd = fd };
>> +       struct vq_info *info = &dev->vqs[idx];
>> +       int r;
>> +
>> +       info->idx = idx;
>> +       info->kick = eventfd(0, EFD_NONBLOCK);
>> +       info->call = eventfd(0, EFD_NONBLOCK);
> 
> If we don't care about the callback, let's just avoid to set the call here?
> 
> (As I see vq_callback is a NULL)

Sure, will remove the vq_callback related code.

> 
>> +       r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
>> +       assert(r >= 0);
>> +       vq_reset(info, num, &dev->vdev);
>> +       vhost_vq_setup(dev, info);
>> +       info->fds.fd = info->call;
>> +       info->fds.events = POLLIN;
>> +
>> +       r = ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
>> +       assert(!r);
>> +}
>> +
>> +static void vdev_info_init(struct vdev_info *dev, unsigned long long features)
>> +{
>> +       struct ether_header *eh;
>> +       int i, r;
>> +
>> +       dev->vdev.features = features;
>> +       INIT_LIST_HEAD(&dev->vdev.vqs);
>> +       spin_lock_init(&dev->vdev.vqs_list_lock);
>> +
>> +       dev->buf_size = (HDR_LEN + TEST_BUF_LEN) * 2;
>> +       dev->buf = malloc(dev->buf_size);
>> +       assert(dev->buf);
>> +       dev->test_buf = dev->buf;
>> +       dev->res_buf = dev->test_buf + HDR_LEN + TEST_BUF_LEN;
>> +
>> +       memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
>> +       eh = (struct ether_header *)(dev->test_buf + HDR_LEN);
>> +       eh->ether_type = htons(TEST_PTYPE);
>> +       memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
>> +       memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
>> +
>> +       for (i = sizeof(*eh); i < TEST_BUF_LEN; i++)
>> +               dev->test_buf[i + HDR_LEN] = (char)i;
>> +
>> +       dev->control = open("/dev/vhost-net", O_RDWR);
>> +       assert(dev->control >= 0);
>> +
>> +       r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>> +       assert(r >= 0);
>> +
>> +       dev->mem = malloc(offsetof(struct vhost_memory, regions) +
>> +                         sizeof(dev->mem->regions[0]));
>> +       assert(dev->mem);
>> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>> +              sizeof(dev->mem->regions[0]));
>> +       dev->mem->nregions = 1;
>> +       dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
>> +       dev->mem->regions[0].userspace_addr = (long)dev->buf;
>> +       dev->mem->regions[0].memory_size = dev->buf_size;
>> +
>> +       r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
>> +       assert(r >= 0);
>> +
>> +       r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
>> +       assert(r >= 0);
>> +
>> +       dev->nvqs = 2;
>> +}
>> +
>> +static void wait_for_interrupt(struct vq_info *vq)
>> +{
>> +       unsigned long long val;
>> +
>> +       poll(&vq->fds, 1, -1);
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
>> +                       bool delayed, int batch, int bufs)
> 
> It might be better to describe the test design briefly above as a
> comment. Or we can start from simple test logic and add sophisticated
> ones on top.

Does something described in the comment log as suggested by you make
sense to you?
Steps for vhost_net tx testing:
1. Prepare a out buf
2. Kick the vhost_net to do tx processing
3. Do the receiving in the tun side
4. verify the data received by tun is correct

> 
>> +{
>> +       const bool random_batch = batch == RANDOM_BATCH;
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
>> +                       if (random_batch)
>> +                               batch = (random() % vq->vring.num) + 1;
>> +
>> +                       while (vq->started < bufs &&
>> +                              (vq->started - vq->completed) < batch) {
>> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN + TEST_BUF_LEN);
>> +                               r = virtqueue_add_outbuf(vq->vq, &sl, 1,
>> +                                                        dev->test_buf + vq->started,
>> +                                                        GFP_ATOMIC);
>> +                               if (unlikely(r != 0)) {
>> +                                       if (r == -ENOSPC &&
>> +                                           vq->started > started_before)
>> +                                               r = 0;
>> +                                       else
>> +                                               r = -1;
>> +                                       break;
>> +                               }
>> +
>> +                               ++vq->started;
>> +
>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>> +                                       r = -1;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (vq->started >= bufs)
>> +                               r = -1;
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
>> +       }
>> +       printf("TX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
>> +              spurious, vq->started, vq->completed);
>> +}
>> +
>> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
>> +                       bool delayed, int batch, int bufs)
>> +{
>> +       const bool random_batch = batch == RANDOM_BATCH;
>> +       long long spurious = 0;
>> +       struct scatterlist sl;
>> +       unsigned int len;
>> +       int r;
>> +
>> +       for (;;) {
>> +               long started_before = vq->started;
>> +               long completed_before = vq->completed;
>> +
>> +               do {
>> +                       if (random_batch)
>> +                               batch = (random() % vq->vring.num) + 1;
>> +
>> +                       while (vq->started < bufs &&
>> +                              (vq->started - vq->completed) < batch) {
>> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + TEST_BUF_LEN);
>> +
>> +                               r = virtqueue_add_inbuf(vq->vq, &sl, 1,
>> +                                                       dev->res_buf + vq->started,
>> +                                                       GFP_ATOMIC);
>> +                               if (unlikely(r != 0)) {
>> +                                       if (r == -ENOSPC &&
> 
> Drivers usually maintain a #free_slots, this can help to avoid the
> trick for checking ENOSPC?

The above "(vq->started - vq->completed) < batch" seems to ensure that
the 'r' can't be '-ENOSPC'? We just need to ensure the batch <= desc_num,
and the 'r == -ENOSPC' checking seems to be unnecessary.

> 
>> +                                           vq->started > started_before)
>> +                                               r = 0;
>> +                                       else
>> +                                               r = -1;
>> +                                       break;
>> +                               }
>> +
>> +                               ++vq->started;
>> +
>> +                               vdev_send_packet(dev);
>> +
>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>> +                                       r = -1;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (vq->started >= bufs)
>> +                               r = -1;
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
> 
> I wonder if it's better to set up some kind of qdisc to avoid the
> unexpected packet here, or is it too complicated?

Yes, at least I don't know to do that yet.

> 
> Thanks
> 
> .
> 

