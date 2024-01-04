Return-Path: <linux-kernel+bounces-16914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5768245FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B891F2249F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791424B2C;
	Thu,  4 Jan 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOdV5eYy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FE24A1B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704385104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3XWp8QN3y4K7hN9DZUfoTwKMLNHnu7aTZe5uSFvYx4=;
	b=iOdV5eYyhX6egrm3kbA8DvDLS3h4wnx0E2OhI9z2t3uI2rjzrFGBBvWdSJRFgF7ByLYC2m
	0onRQgRVANsghYoEOIZeUplaBSPYIdMHH2Q7kYPdZpr75dwQ9JqQCujFKxcZSdBW+Y9cfR
	LgrMtN6qoJTxWizLjla6wAHhy5ZVIME=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-aqHgIgmBNzqm1emCgN04AQ-1; Thu, 04 Jan 2024 11:18:23 -0500
X-MC-Unique: aqHgIgmBNzqm1emCgN04AQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e6f42b1482so9744307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385103; x=1704989903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3XWp8QN3y4K7hN9DZUfoTwKMLNHnu7aTZe5uSFvYx4=;
        b=YG5IVrRXv/bQGyAYNSknMoHt9BQ/QsvhpeYLvFGEzIZWtIPMAgxBEIYgbn27YPvsnE
         smUfzeBagDsT265ZF4fpmNYEi84D3IyBrlc+CFPasXfj5XMO67U7Uw5sx4jZ5wZsdmvQ
         m7DFclVfld42CQ6Mm/jm2bGO8cnWr77z/CM6Kl4DB3WQuAWvQa2DJ8oADATWE9cLPEP2
         b43NnbsjBoflTvZVLUIa+Wv3mfQiiEJnBv6I4dbom2Zq9KfnPbngPUzQNIPF9V35JIcX
         T7FQDIHrGHeM1oso0MnML87TtNyuQNEGkJ8urkL0JCVSblmk8VHqwBqKkugwAyv7Wphz
         T4wQ==
X-Gm-Message-State: AOJu0YypGlAjgcb0dDhfXKTRIeERGNr1rpPFb7AzWGghhUuc+mt8l9v3
	eZFI3usqnK3CIZ35l8AVCeDWl2nay2SLHijAUKNPU4SIKTCJkLQHIhDrNOYAd127EA804IGOEiA
	hu5cJCscpkrk3OKBWFf6tRKOas0A4JUSXpl2ozu04W9jmUxE4
X-Received: by 2002:a0d:c982:0:b0:5ed:25e4:c56 with SMTP id l124-20020a0dc982000000b005ed25e40c56mr760453ywd.8.1704385102909;
        Thu, 04 Jan 2024 08:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOWzTvWOZvyaQkSHdD1yAX5+O7d0o8RhRUzUypWHMXsO/kHfcX7GkiIzl31iG4JT/yvjOpXS4FoYPGsLTWe7M=
X-Received: by 2002:a0d:c982:0:b0:5ed:25e4:c56 with SMTP id
 l124-20020a0dc982000000b005ed25e40c56mr760432ywd.8.1704385102550; Thu, 04 Jan
 2024 08:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com> <20240103095650.25769-7-linyunsheng@huawei.com>
In-Reply-To: <20240103095650.25769-7-linyunsheng@huawei.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 4 Jan 2024 17:17:46 +0100
Message-ID: <CAJaqyWfHLDRL4z9ooNS2w_yGE_jnHfi2spdYPP_=F0jgSj3mJQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> introduce vhost_net_test basing on virtio_test to test
> vhost_net changing in the kernel.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/virtio/Makefile         |   8 +-
>  tools/virtio/vhost_net_test.c | 574 ++++++++++++++++++++++++++++++++++
>  2 files changed, 579 insertions(+), 3 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index d128925980e0..e25e99c1c3b7 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all: test mod
> -test: virtio_test vringh_test
> +test: virtio_test vringh_test vhost_net_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
> +vhost_net_test: virtio_ring.o vhost_net_test.o
>
>  try-run =3D $(shell set -e;              \
>         if ($(1)) >/dev/null 2>&1;      \
> @@ -49,6 +50,7 @@ oot-clean: OOT_BUILD+=3Dclean
>
>  .PHONY: all test mod clean vhost oot oot-clean oot-build
>  clean:
> -       ${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cm=
d \
> -              vhost_test/Module.symvers vhost_test/modules.order *.d
> +       ${RM} *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
> +              vhost_test/.*.cmd vhost_test/Module.symvers \
> +              vhost_test/modules.order *.d
>  -include *.d
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> new file mode 100644
> index 000000000000..cfffcef53d94
> --- /dev/null
> +++ b/tools/virtio/vhost_net_test.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <getopt.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <sys/eventfd.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/virtio_types.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/in.h>
> +#include <linux/if_packet.h>
> +#include <netinet/ether.h>
> +
> +#define RANDOM_BATCH   -1
> +#define HDR_LEN                12
> +#define TEST_BUF_LEN   256
> +#define TEST_PTYPE     ETH_P_LOOPBACK
> +
> +/* Used by implementation of kmalloc() in tools/virtio/linux/kernel.h */
> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> +
> +struct vq_info {
> +       int kick;
> +       int call;
> +       int idx;
> +       long started;
> +       long completed;
> +       struct pollfd fds;
> +       void *ring;
> +       /* copy used for control */
> +       struct vring vring;
> +       struct virtqueue *vq;
> +};
> +
> +struct vdev_info {
> +       struct virtio_device vdev;
> +       int control;
> +       struct vq_info vqs[2];
> +       int nvqs;
> +       void *buf;
> +       size_t buf_size;
> +       char *test_buf;
> +       char *res_buf;
> +       struct vhost_memory *mem;
> +       int sock;
> +       int ifindex;
> +       unsigned char mac[ETHER_ADDR_LEN];
> +};
> +
> +static int tun_alloc(struct vdev_info *dev)
> +{
> +       struct ifreq ifr;
> +       int len =3D HDR_LEN;
> +       int fd, e;
> +
> +       fd =3D open("/dev/net/tun", O_RDWR);
> +       if (fd < 0) {
> +               perror("Cannot open /dev/net/tun");
> +               return fd;
> +       }
> +
> +       memset(&ifr, 0, sizeof(ifr));
> +
> +       ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> +
> +       e =3D ioctl(fd, TUNSETIFF, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETIFF]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, TUNSETVNETHDRSZ, &len);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETVNETHDRSZ]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, SIOCGIFHWADDR, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[SIOCGIFHWADDR]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
> +       return fd;
> +}
> +
> +static void vdev_create_socket(struct vdev_info *dev)
> +{
> +       struct ifreq ifr;
> +
> +       dev->sock =3D socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
> +       assert(dev->sock !=3D -1);
> +
> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> +       assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >=3D 0);
> +
> +       dev->ifindex =3D ifr.ifr_ifindex;
> +
> +       /* Set the flags that bring the device up */
> +       assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >=3D 0);
> +       ifr.ifr_flags |=3D (IFF_UP | IFF_RUNNING);
> +       assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >=3D 0);
> +}
> +
> +static void vdev_send_packet(struct vdev_info *dev)
> +{
> +       char *sendbuf =3D dev->test_buf + HDR_LEN;
> +       struct sockaddr_ll saddrll =3D {0};
> +       int sockfd =3D dev->sock;
> +       int ret;
> +
> +       memset(&saddrll, 0, sizeof(saddrll));
> +       saddrll.sll_family =3D PF_PACKET;
> +       saddrll.sll_ifindex =3D dev->ifindex;
> +       saddrll.sll_halen =3D ETH_ALEN;
> +       saddrll.sll_protocol =3D htons(TEST_PTYPE);
> +
> +       ret =3D sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
> +                    (struct sockaddr *)&saddrll,
> +                    sizeof(struct sockaddr_ll));
> +       assert(ret >=3D 0);
> +}
> +
> +static bool vq_notify(struct virtqueue *vq)
> +{
> +       struct vq_info *info =3D vq->priv;
> +       unsigned long long v =3D 1;
> +       int r;
> +
> +       r =3D write(info->kick, &v, sizeof(v));
> +       assert(r =3D=3D sizeof(v));
> +
> +       return true;
> +}
> +
> +static void vq_callback(struct virtqueue *vq)
> +{
> +}
> +
> +static void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
> +{
> +       struct vhost_vring_addr addr =3D {
> +               .index =3D info->idx,
> +               .desc_user_addr =3D (uint64_t)(unsigned long)info->vring.=
desc,
> +               .avail_user_addr =3D (uint64_t)(unsigned long)info->vring=
.avail,
> +               .used_user_addr =3D (uint64_t)(unsigned long)info->vring.=
used,
> +       };
> +       struct vhost_vring_state state =3D { .index =3D info->idx };
> +       struct vhost_vring_file file =3D { .index =3D info->idx };
> +       int r;
> +
> +       state.num =3D info->vring.num;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
> +       assert(r >=3D 0);
> +
> +       state.num =3D 0;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
> +       assert(r >=3D 0);
> +
> +       file.fd =3D info->kick;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
> +       assert(r >=3D 0);
> +
> +       file.fd =3D info->call;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
> +       assert(r >=3D 0);
> +}
> +
> +static void vq_reset(struct vq_info *info, int num, struct virtio_device=
 *vdev)
> +{
> +       if (info->vq)
> +               vring_del_virtqueue(info->vq);
> +
> +       memset(info->ring, 0, vring_size(num, 4096));
> +       vring_init(&info->vring, num, info->ring, 4096);
> +       info->vq =3D vring_new_virtqueue(info->idx, num, 4096, vdev, true=
, false,
> +                                      info->ring, vq_notify, vq_callback=
, "test");
> +       assert(info->vq);
> +       info->vq->priv =3D info;
> +}
> +
> +static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
> +{
> +       struct vhost_vring_file backend =3D { .index =3D idx, .fd =3D fd =
};
> +       struct vq_info *info =3D &dev->vqs[idx];
> +       int r;
> +
> +       info->idx =3D idx;
> +       info->kick =3D eventfd(0, EFD_NONBLOCK);
> +       info->call =3D eventfd(0, EFD_NONBLOCK);
> +       r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +       assert(r >=3D 0);
> +       vq_reset(info, num, &dev->vdev);
> +       vhost_vq_setup(dev, info);
> +       info->fds.fd =3D info->call;
> +       info->fds.events =3D POLLIN;
> +
> +       r =3D ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
> +       assert(!r);
> +}
> +
> +static void vdev_info_init(struct vdev_info *dev, unsigned long long fea=
tures)
> +{
> +       struct ether_header *eh;
> +       int i, r;
> +
> +       dev->vdev.features =3D features;
> +       INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
> +
> +       dev->buf_size =3D (HDR_LEN + TEST_BUF_LEN) * 2;
> +       dev->buf =3D malloc(dev->buf_size);
> +       assert(dev->buf);
> +       dev->test_buf =3D dev->buf;
> +       dev->res_buf =3D dev->test_buf + HDR_LEN + TEST_BUF_LEN;
> +
> +       memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
> +       eh =3D (struct ether_header *)(dev->test_buf + HDR_LEN);
> +       eh->ether_type =3D htons(TEST_PTYPE);
> +       memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
> +       memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
> +
> +       for (i =3D sizeof(*eh); i < TEST_BUF_LEN; i++)
> +               dev->test_buf[i + HDR_LEN] =3D (char)i;
> +
> +       dev->control =3D open("/dev/vhost-net", O_RDWR);
> +       assert(dev->control >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> +       assert(r >=3D 0);
> +
> +       dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> +                         sizeof(dev->mem->regions[0]));
> +       assert(dev->mem);
> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> +              sizeof(dev->mem->regions[0]));
> +       dev->mem->nregions =3D 1;
> +       dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].memory_size =3D dev->buf_size;
> +
> +       r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> +       assert(r >=3D 0);
> +
> +       dev->nvqs =3D 2;
> +}
> +
> +static void wait_for_interrupt(struct vq_info *vq)
> +{
> +       unsigned long long val;
> +
> +       poll(&vq->fds, 1, -1);
> +
> +       if (vq->fds.revents & POLLIN)
> +               read(vq->fds.fd, &val, sizeof(val));
> +}
> +
> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int batch, int bufs)
> +{
> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               virtqueue_disable_cb(vq->vq);
> +               do {
> +                       if (random_batch)
> +                               batch =3D (random() % vq->vring.num) + 1;
> +
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < batch) {
> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN +=
 TEST_BUF_LEN);
> +                               r =3D virtqueue_add_outbuf(vq->vq, &sl, 1=
,
> +                                                        dev->test_buf + =
vq->started,
> +                                                        GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0)) {
> +                                       if (r =3D=3D -ENOSPC &&
> +                                           vq->started > started_before)
> +                                               r =3D 0;
> +                                       else
> +                                               r =3D -1;
> +                                       break;
> +                               }
> +
> +                               ++vq->started;
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               int n, i;
> +
> +                               n =3D recvfrom(dev->sock, dev->res_buf, T=
EST_BUF_LEN, 0, NULL, NULL);
> +                               assert(n =3D=3D TEST_BUF_LEN);
> +
> +                               for (i =3D ETHER_HDR_LEN; i < n; i++)
> +                                       assert(dev->res_buf[i] =3D=3D (ch=
ar)i);
> +
> +                               ++vq->completed;
> +                               r =3D 0;
> +                       }
> +               } while (r =3D=3D 0);
> +
> +               if (vq->completed =3D=3D completed_before && vq->started =
=3D=3D started_before)
> +                       ++spurious;
> +
> +               assert(vq->completed <=3D bufs);
> +               assert(vq->started <=3D bufs);
> +               if (vq->completed =3D=3D bufs)
> +                       break;
> +
> +               if (delayed) {
> +                       if (virtqueue_enable_cb_delayed(vq->vq))
> +                               wait_for_interrupt(vq);
> +               } else {
> +                       if (virtqueue_enable_cb(vq->vq))
> +                               wait_for_interrupt(vq);
> +               }
> +       }
> +       printf("TX spurious wakeups: 0x%llx started=3D0x%lx completed=3D0=
x%lx\n",
> +              spurious, vq->started, vq->completed);
> +}
> +
> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int batch, int bufs)
> +{
> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               do {
> +                       if (random_batch)
> +                               batch =3D (random() % vq->vring.num) + 1;
> +
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < batch) {
> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + =
TEST_BUF_LEN);
> +
> +                               r =3D virtqueue_add_inbuf(vq->vq, &sl, 1,
> +                                                       dev->res_buf + vq=
->started,
> +                                                       GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0)) {
> +                                       if (r =3D=3D -ENOSPC &&
> +                                           vq->started > started_before)
> +                                               r =3D 0;
> +                                       else
> +                                               r =3D -1;
> +                                       break;
> +                               }
> +
> +                               ++vq->started;
> +
> +                               vdev_send_packet(dev);
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               struct ether_header *eh;
> +                               int i;
> +
> +                               eh =3D (struct ether_header *)(dev->res_b=
uf + HDR_LEN);
> +
> +                               /* tun netdev is up and running, ignore t=
he
> +                                * non-TEST_PTYPE packet.
> +                                */
> +                               if (eh->ether_type !=3D htons(TEST_PTYPE)=
) {
> +                                       ++vq->completed;
> +                                       r =3D 0;
> +                                       continue;
> +                               }
> +
> +                               assert(len =3D=3D TEST_BUF_LEN + HDR_LEN)=
;
> +
> +                               for (i =3D ETHER_HDR_LEN; i < TEST_BUF_LE=
N; i++)
> +                                       assert(dev->res_buf[i + HDR_LEN] =
=3D=3D (char)i);
> +
> +                               ++vq->completed;
> +                               r =3D 0;
> +                       }
> +               } while (r =3D=3D 0);
> +               if (vq->completed =3D=3D completed_before && vq->started =
=3D=3D started_before)
> +                       ++spurious;
> +
> +               assert(vq->completed <=3D bufs);
> +               assert(vq->started <=3D bufs);
> +               if (vq->completed =3D=3D bufs)
> +                       break;
> +       }
> +
> +       printf("RX spurious wakeups: 0x%llx started=3D0x%lx completed=3D0=
x%lx\n",
> +              spurious, vq->started, vq->completed);
> +}

Hi!

I think the tests are great! Maybe both run_rx_test and run_tx_test
(and virtio_test.c:run_test) can be merged into a common function with
some callbacks? Not sure if it will complicate the code more.

Thanks!

> +
> +static const char optstring[] =3D "h";
> +static const struct option longopts[] =3D {
> +       {
> +               .name =3D "help",
> +               .val =3D 'h',
> +       },
> +       {
> +               .name =3D "event-idx",
> +               .val =3D 'E',
> +       },
> +       {
> +               .name =3D "no-event-idx",
> +               .val =3D 'e',
> +       },
> +       {
> +               .name =3D "indirect",
> +               .val =3D 'I',
> +       },
> +       {
> +               .name =3D "no-indirect",
> +               .val =3D 'i',
> +       },
> +       {
> +               .name =3D "virtio-1",
> +               .val =3D '1',
> +       },
> +       {
> +               .name =3D "no-virtio-1",
> +               .val =3D '0',
> +       },
> +       {
> +               .name =3D "delayed-interrupt",
> +               .val =3D 'D',
> +       },
> +       {
> +               .name =3D "no-delayed-interrupt",
> +               .val =3D 'd',
> +       },
> +       {
> +               .name =3D "buf-num",
> +               .val =3D 'n',
> +               .has_arg =3D required_argument,
> +       },
> +       {
> +               .name =3D "batch",
> +               .val =3D 'b',
> +               .has_arg =3D required_argument,
> +       },
> +       {
> +       }
> +};
> +
> +static void help(int status)
> +{
> +       fprintf(stderr, "Usage: vhost_net_test [--help]"
> +               " [--no-indirect]"
> +               " [--no-event-idx]"
> +               " [--no-virtio-1]"
> +               " [--delayed-interrupt]"
> +               " [--buf-num]"
> +               " [--batch=3Drandom/N]"
> +               "\n");
> +
> +       exit(status);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       unsigned long long features =3D (1ULL << VIRTIO_RING_F_INDIRECT_D=
ESC) |
> +               (1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VER=
SION_1);
> +       long batch =3D 1, nbufs =3D 0x100000;
> +       struct vdev_info dev;
> +       bool delayed =3D false;
> +       int o, fd;
> +
> +       for (;;) {
> +               o =3D getopt_long(argc, argv, optstring, longopts, NULL);
> +               switch (o) {
> +               case -1:
> +                       goto done;
> +               case '?':
> +                       help(2);
> +               case 'e':
> +                       features &=3D ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> +                       break;
> +               case 'h':
> +                       help(0);
> +               case 'i':
> +                       features &=3D ~(1ULL << VIRTIO_RING_F_INDIRECT_DE=
SC);
> +                       break;
> +               case '0':
> +                       features &=3D ~(1ULL << VIRTIO_F_VERSION_1);
> +                       break;
> +               case 'D':
> +                       delayed =3D true;
> +                       break;
> +               case 'b':
> +                       if (!strcmp(optarg, "random")) {
> +                               batch =3D RANDOM_BATCH;
> +                       } else {
> +                               batch =3D strtol(optarg, NULL, 10);
> +                               assert(batch > 0);
> +                               assert(batch < (long)INT_MAX + 1);
> +                       }
> +                       break;
> +               case 'n':
> +                       nbufs =3D strtol(optarg, NULL, 10);
> +                       assert(nbufs > 0);
> +                       break;
> +               default:
> +                       assert(0);
> +                       break;
> +               }
> +       }
> +
> +done:
> +       memset(&dev, 0, sizeof(dev));
> +
> +       fd =3D tun_alloc(&dev);
> +       assert(fd >=3D 0);
> +
> +       vdev_info_init(&dev, features);
> +       vq_info_add(&dev, 0, 256, fd);
> +       vq_info_add(&dev, 1, 256, fd);
> +       vdev_create_socket(&dev);
> +
> +       run_rx_test(&dev, &dev.vqs[0], delayed, batch, nbufs);
> +       run_tx_test(&dev, &dev.vqs[1], delayed, batch, nbufs);
> +
> +       return 0;
> +}
> --
> 2.33.0
>
>


