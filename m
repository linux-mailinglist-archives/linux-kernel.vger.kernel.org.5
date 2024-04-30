Return-Path: <linux-kernel+bounces-163520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F78B6C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F044283DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82AE45035;
	Tue, 30 Apr 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2NJdLHwk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257245030;
	Tue, 30 Apr 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464423; cv=none; b=Pzr5ywgt6JuLS3T+1kQW8bt08OMB9wKgI6hkH3utD8ImE1eZlq8j+EwufiOlmCY39G6FCIevWYFqlgJ8zbZUBJBEZP5SJW0kh41OPVFOoghAlI4Wc3C6JbAvOVbEihaOhf49xZwVf1M2JpJlmtTaG/vTmODEsjFCPFdTU6xiyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464423; c=relaxed/simple;
	bh=Osr7eFEucb5rOKuNzPfxNMn5ZpBN425PobQ7rVqTlEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTN6FUY4q6cv+z/vMSH0AvYGlOX2U5hPkunWkYGFlK889DG0FFFCnkD6w1u1nRqD76T3CVZdfnJc1/UUxlGTNqD9Y4wIyHlTE9U2TAzSAfHKiTRQdCKv6IMUQVM20HzAGZfrwle5RIN68LZxGmQGt1u65kNUNdTN5PR//RDlfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2NJdLHwk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714464418;
	bh=Osr7eFEucb5rOKuNzPfxNMn5ZpBN425PobQ7rVqTlEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2NJdLHwkvUNNWPY9ys+b2DBlF/DDbReqj6ap9n8BoRHenxv7IIFNzSCrjL0MweFdi
	 04nQrbossfIq29p4RzMeBrlh1WKXR4WA4T8/bn/f3jPXQj2tnaPu0JGZrPTpMZTE3z
	 q5g3EscUoqmZHbqjp+r/q3ZxehczZGAUq6ZX2iSMIgklh6xO1eZbpbvD+Bzq3Oz0Kn
	 FUZdZoP2KRZHP7A8RuIcuTTxuhmsZiEVy8hrRLAWP0yFs2BuqhK0RB6kPynmeu8ssj
	 BOWMeXkzG/qdpVkMWactE9oi6nOSksMTf6fRH4Isw/qqOG4k3qcx6c7iYbW7CLM0Kj
	 Yb7a1vbjzmqEg==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05CEC37820F9;
	Tue, 30 Apr 2024 08:06:57 +0000 (UTC)
Message-ID: <fffb9372-7b25-450a-b466-51afe82ad126@collabora.com>
Date: Tue, 30 Apr 2024 10:06:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] net/9p/usbg: Add new usb gadget function transport
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
 <20240116-ml-topic-u9p-v3-2-c62a36eccda1@pengutronix.de>
 <915890fa-e763-470a-a82b-eda97c47c0c8@collabora.com>
 <ZjAueNMN8nSbsqvI@pengutronix.de>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <ZjAueNMN8nSbsqvI@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

W dniu 30.04.2024 o 01:34, Michael Grzeschik pisze:
> Hi Andrzej!
> 
> Based on your feedback I rolled out v4.
> 
> https://lore.kernel.org/r/20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de

Thanks. I will be able to have a look and try it next week. Should you not hear
from me until 10 May I wouldn't mind being pinged afterwards.

Regards,

Andrzej

> 
> On Wed, Mar 06, 2024 at 04:18:54PM +0100, Andrzej Pietrasiewicz wrote:
>> W dniu 26.02.2024 o 14:56, Michael Grzeschik pisze:
>>> Add the new gadget function for 9pfs transport. This function is
>>> defining an simple 9pfs transport interface that consists of one in and
>>> one out endpoint. The endpoints transmit and receive the 9pfs protocol
>>> payload when mounting a 9p filesystem over usb.
>>
>> Reading the earlier discussions on v1 and v2 I was somehow under the impression
>> that what you submitted here does not contain configfs support.
>>
>> But once I started reading the code I realized it does.
>>
>> It worked for me, both as a legacy gadget and when composed with configfs.
>>
>> I noticed that when you stop the forwarder at the host side when 9pfs remains
>> mounted at the gadget side, umount hangs at the gadget side until the forwarder
>> is restarted. I know that once the host-side software dies, not much can be
>> done, however, unmounting a dead filesystem seems a reasonable thing to do
>> and the way usb9pfs worked for me it is not possible to unmount in this
>> situation. Any ideas on improving this?
> 
> As Dominique suggested I implemented conn_cancel to ensure the
> connection to be removed on the gadget side. Regarding the stopped
> correspondence from the host-side, there is not much we can do.
> However for the v4 I ensured that a mount -f would work out
> by checking the connection status before sending anything
> to the host.
> 
> With this changes I was able to mount and unmount several times
> and always reuse the gadget connection by restarting the host side.
> 
>> Please find my review below.
>>
>>>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>
>>> ---
>>> v2 -> v3: -
>>> v1 -> v2:
>>>   - move the driver to net/9p/trans_usbg.c
>>>   - fixed the commit title
>>>   - fix %zu usage in p9_debug for size_t type
>>>   - define functions static that are only used localy
>>>   - return 0 in alloc_requests
>>>   - use id_alloc_max instead of ida_simple_get
>>>   - call ida_free in usb9pfs_free_func
>>>   - call kfree for usb9pfs->tag and usb9pfs in usb9pfs_free_func
>>>   - add MODULE_ALIAS_9P to load this module automatic when mounting
>>>   - improved the documentation
>>>   - added depends on USB_GADGET in Kconfig
>>> ---
>>>  Documentation/filesystems/9p.rst |  15 +
>>>  net/9p/Kconfig                   |   6 +
>>>  net/9p/Makefile                  |   4 +
>>>  net/9p/trans_usbg.c              | 871 +++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 896 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
>>> index 1e0e0bb6fdf91..64439068a8fc5 100644
>>> --- a/Documentation/filesystems/9p.rst
>>> +++ b/Documentation/filesystems/9p.rst
>>> @@ -53,6 +53,20 @@ mount points. Each 9P export is seen by the client as a 
>>> virtio device with an
>>>  associated "mount_tag" property. Available mount tags can be
>>>  seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
>>> +USBG Usage
>>> +==========
>>> +
>>> +To mount a 9p FS on a USB Host accessible via the gadget at runtime::
>>> +
>>> +    mount -t 9p -o trans=usbg,aname=/path/to/fs <mount_tag> /mnt/9
>>> +
>>> +To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
>>> +
>>> +    root=<mount_tag> rootfstype=9p 
>>> rootflags=trans=usbg,cache=loose,uname=root,access=0,dfltuid=0,dfltgid=0,aname=/path/to/rootfs
>>> +
>>> +where mount_tag is the tag associated by the usb gadget transport. The
>>> +pattern is usb9pfs0, usb9pfs1, ...
>>
>> I'd reword to use "generated" instead of "associated" which would emphasize
>> that it is the usb gadget transport part that comes up with the name.
>> The word "associated" suggests that maybe the name comes from elsewhere.
>>
>> I'm wondering if it would make sense to treat instance name, e.g.
>>
>> "my_9pfs" from
>>
>> $ mkdir /sys/kernel/config/usb_gadget/g9pfs/functions/usb9pfs.my_9pfs
>>
>> as device name known above as "<mount_tag>?"
>>
>> FunctionFS uses this strategy and IMO it makes sense to follow this pattern.
>>
>> BTW, isn't this being called "mount_tag" an implementation detail of 9pfs?
>> When doing "mount" users usually expect a "device name" (even if not a "real"
>> device).
> 
> Fair point about the mount_tag. I reworked it to be used like with ffs.
> 
>>> +
>>>  Options
>>>  =======
>>> @@ -68,6 +82,7 @@ Options
>>>              virtio      connect to the next virtio channel available
>>>                    (from QEMU with trans_virtio module)
>>>              rdma      connect to a specified RDMA channel
>>> +            usbg      connect to a specified usb gadget channel
>>>              ========  ============================================
>>>    uname=name    user name to attempt mount as on the remote server.  The
>>> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
>>> index 00ebce9e5a657..c3d357eb8bb37 100644
>>> --- a/net/9p/Kconfig
>>> +++ b/net/9p/Kconfig
>>> @@ -39,6 +39,12 @@ config NET_9P_XEN
>>>        This builds support for a transport for 9pfs between
>>>        two Xen domains.
>>> +config NET_9P_USBG
>>> +    bool "9P USB Gadget Transport"
>>> +    depends on USB_GADGET
>>> +    help
>>> +      This builds support for a transport for 9pfs over
>>> +      usb gadget.
>>>  config NET_9P_RDMA
>>>      depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
>>> diff --git a/net/9p/Makefile b/net/9p/Makefile
>>> index 1df9b344c30bd..22794a451c3f7 100644
>>> --- a/net/9p/Makefile
>>> +++ b/net/9p/Makefile
>>> @@ -4,6 +4,7 @@ obj-$(CONFIG_NET_9P_FD) += 9pnet_fd.o
>>>  obj-$(CONFIG_NET_9P_XEN) += 9pnet_xen.o
>>>  obj-$(CONFIG_NET_9P_VIRTIO) += 9pnet_virtio.o
>>>  obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
>>> +obj-$(CONFIG_NET_9P_USBG) += 9pnet_usbg.o
>>>  9pnet-objs := \
>>>      mod.o \
>>> @@ -23,3 +24,6 @@ obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
>>>  9pnet_rdma-objs := \
>>>      trans_rdma.o \
>>> +
>>> +9pnet_usbg-objs := \
>>> +    trans_usbg.o \
>>> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
>>> new file mode 100644
>>> index 0000000000000..93d9606a806d8
>>> --- /dev/null
>>> +++ b/net/9p/trans_usbg.c
>>> @@ -0,0 +1,871 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * trans_usbg.c - USB peripheral usb9pfs configuration driver and transport.
>>> + *
>>> + * Copyright (C) 2024 Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> + */
>>> +
>>> +/* Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs
>>> + * transport to mount host exported filesystem via usb gadget.
>>> + */
>>> +
>>> +/*     +--------------------------+    |    +--------------------------+
>>> + *     |  9PFS mounting client    |    |    |  9PFS exporting server   |
>>> + *  SW |                          |    |    |                          |
>>> + *     |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
>>> + *     +-------------^------------+    |    +-------------^------------+
>>> + *                   |                 |                  |
>>> + * ------------------|------------------------------------|-------------
>>> + *                   |                 |                  |
>>> + *     +-------------v------------+    |    +-------------v------------+
>>> + *     |                          |    |    |                          |
>>> + *  HW |   USB Device Controller  <--------->   USB Host Controller    |
>>> + *     |                          |    |    |                          |
>>> + *     +--------------------------+    |    +--------------------------+
>>> + */
>>> +
>>> +#include <linux/slab.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/err.h>
>>> +#include <linux/usb/composite.h>
>>> +#include <linux/usb/u_f.h>
>>> +
>>> +#include <net/9p/9p.h>
>>> +#include <net/9p/client.h>
>>> +#include <net/9p/transport.h>
>>> +
>>> +#define DEFAULT_BUFLEN        16384
>>> +
>>> +struct f_usb9pfs {
>>> +    struct p9_client *client;
>>> +
>>> +    struct p9_req_t *p9_tx_req;
>>> +
>>> +    struct list_head tx_req_list;
>>> +
>>> +    /* 9p request lock for en/dequeue */
>>> +    spinlock_t lock;
>>> +    /* usb request lock for en/dequeue */
>>> +    spinlock_t req_lock;
>>> +
>>> +    struct usb_request *in_req;
>>> +    struct usb_request *out_req;
>>> +
>>> +    struct usb_ep *in_ep;
>>> +    struct usb_ep *out_ep;
>>> +
>>> +    unsigned int buflen;
>>> +
>>> +    bool inuse;
>>> +    char *tag;
>>> +
>>> +    int index;
>>> +
>>> +    struct usb_function function;
>>> +
>>> +    struct list_head function_list;
>>
>> usb9pfs_instance ?
> 
> Sounds good. I changed it.
> 
>>> +};
>>> +
>>> +static inline struct f_usb9pfs *func_to_usb9pfs(struct usb_function *f)
>>> +{
>>> +    return container_of(f, struct f_usb9pfs, function);
>>> +}
>>> +
>>> +struct f_usb9pfs_opts {
>>> +    struct usb_function_instance func_inst;
>>> +    unsigned int buflen;
>>> +
>>> +    /* Read/write access to configfs attributes is handled by configfs.
>>> +     *
>>> +     * This is to protect the data from concurrent access by read/write
>>> +     * and create symlink/remove symlink.
>>> +     */
>>> +    struct mutex lock;
>>> +    int refcnt;
>>> +};
>>> +
>>> +static DEFINE_IDA(usb9pfs_ida);
>>> +static DEFINE_MUTEX(usb9pfs_ida_lock); /* protects access do usb9pfs_ida */
>>> +
>>> +static DEFINE_MUTEX(usb9pfs_lock);
>>> +static struct list_head usbg_function_list;
>>
>> This name seems too generic to me, it creates an impression that the list
>> contains all functions of USB gadgets. It really doesn't and what it
>> contains is a number of 9pfs instances. What about usb9pfs_instance_list?
> 
> I will go with usb9pfs_instance_list.
> 
>>> +
>>> +static int usb9pfs_tx_fill(struct f_usb9pfs *usb9pfs, struct usb_request *req,
>>
>> given what this function effectively does...
>>
>>> +               gfp_t gfp_flags)
>>> +{
>>> +    struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
>>> +    int retval = -ENOMEM;
>>> +
>>> +    if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacket))
>>> +        req->zero = 1;
>>> +
>>> +    req->buf = usb9pfs->p9_tx_req->tc.sdata;
>>> +    req->length = usb9pfs->p9_tx_req->tc.size;
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero: %d\n",
>>> +        usb9pfs->in_ep->name, req->actual, req->length, req->zero);
>>> +
>>> +    retval = usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
>>
>> ... (which is usb_ep_queue), I'd rather name it e.g. usb9pfs_tx_queue.
>> Or maybe usb9pfs_queue_tx to not create an impression that the function
>> is a queue of some sort (because rather than being a queue it does queueing).
> 
> I changed it to usb9pfs_queue_tx.
> 
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", retval);
>>> +
>>> +    return retval;
>>> +}
>>
>> The return value of this function is never used.
> 
> Right, I fixed that at each caller.
> 
>>
>>> +
>>> +static int usb9pfs_rx_fill(struct f_usb9pfs *usb9pfs, struct usb_request *req,
>>
>> usb9pfs_queue_rx() ?
> 
> I changed it to usb9pfs_queue_rx.
> 
>>> +               gfp_t gfp_flags)
>>> +{
>>> +    struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
>>> +    int retval = -ENOMEM;
>>> +
>>> +    retval = usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", retval);
>>> +
>>> +    return retval;
>>> +}
>>
>> The return value of this function is never used.
> 
> Right, I fixed that at each caller.
> 
>>> +
>>> +static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
>>
>> Might be worth documenting that this needs to be called with req_lock held.
> 
> I wrote a comment above the function name.
> 
>>> +{
>>> +    struct p9_req_t *p9_req = NULL;
>>> +    unsigned long flags;
>>> +    int ret = 0;
>>> +
>>> +    spin_lock_irqsave(&usb9pfs->lock, flags);
>>> +
>>> +    if (usb9pfs->p9_tx_req) {
>>> +        spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    p9_req = list_first_entry_or_null(&usb9pfs->tx_req_list, struct 
>>> p9_req_t, req_list);
>>> +    if (!p9_req) {
>>> +        spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>> +        return -ENOENT;
>>> +    }
>>> +
>>> +    list_del(&p9_req->req_list);
>>> +
>>> +    usb9pfs->p9_tx_req = p9_req;
>>> +
>>> +    p9_req_get(usb9pfs->p9_tx_req);
>>> +
>>> +    usb9pfs_tx_fill(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);
>>> +
>>> +    spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = ep->driver_data;
>>> +    struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
>>> +
>>> +    /* reset zero packages */
>>> +    req->zero = 0;
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>> +        ep->name, req->status, req->actual, req->length);
>>> +
>>> +    switch (req->status) {
>>
>> Are more cases expected here? I'm asking because for now it seems
>> that "if - else" would do the job.
> 
> You are right if else is doing the job just well. I changed it.
> 
>>> +    case 0:                /* normal completion? */
>>> +        spin_lock(&usb9pfs->req_lock);
>>> +
>>> +        WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
>>> +
>>> +        p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
>>> +
>>> +        usb9pfs_rx_fill(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
>>> +
>>> +        spin_unlock(&usb9pfs->req_lock);
>>> +
>>> +        break;
>>> +
>>> +    default:
>>> +        dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>> +            ep->name, req->status, req->actual, req->length);
>>> +        usb_ep_free_request(ep == usb9pfs->in_ep ?
>>> +                    usb9pfs->out_ep : usb9pfs->in_ep,
>>> +                    req->context);
>>> +        free_ep_req(ep, req);
>>> +        return;
>>
>> Is this return necessary? The "default" branch does contain some statements,
>> so there's no need to silence the compiler.
> 
> I removed it.
> 
>>> +    }
>>> +}
>>> +
>>> +static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
>>> +                      struct usb_request *req)
>>
>> It seems that the logic of this function does not depend on anything USB.
>> It is all p9 stuff, so I'd rather accept a plain buffer instead of usb_request.
> 
> Good point. I moved it to use the plain buffer instead.
> 
>>> +{
>>> +    struct p9_req_t *p9_rx_req;
>>> +    struct p9_fcall    rc;
>>> +    int ret;
>>> +
>>> +    /* start by reading header */
>>> +    rc.sdata = req->buf;
>>> +    rc.offset = 0;
>>> +    rc.capacity = P9_HDRSZ;
>>> +    rc.size = P9_HDRSZ;
>>> +
>>> +    p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
>>> +         rc.capacity - rc.offset);
>>> +
>>> +    ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
>>> +    if (ret) {
>>> +        p9_debug(P9_DEBUG_ERROR,
>>> +             "error parsing header: %d\n", ret);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    p9_debug(P9_DEBUG_TRANS,
>>> +         "mux %p pkt: size: %d bytes tag: %d\n",
>>> +         usb9pfs, rc.size, rc.tag);
>>> +
>>> +    p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
>>> +    if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
>>> +        p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
>>> +        return NULL;
>>> +    }
>>> +
>>
>> I know nothing about p9 proper, but it seems that at this point
>> you have p9_rx_req...
>>
>>> +    if (rc.size > p9_rx_req->rc.capacity) {
>>> +        p9_debug(P9_DEBUG_ERROR,
>>> +             "requested packet size too big: %d for tag %d with capacity 
>>> %zd\n",
>>> +             rc.size, rc.tag, p9_rx_req->rc.capacity);
>>> +        return NULL;
>>
>> ... which you don't "put" here, but...
> 
> Nice catch. I added p9_req_put here aswell.
> 
>>> +    }
>>> +
>>> +    if (!p9_rx_req->rc.sdata) {
>>> +        p9_debug(P9_DEBUG_ERROR,
>>> +             "No recv fcall for tag %d (req %p), disconnecting!\n",
>>> +             rc.tag, p9_rx_req);
>>> +        p9_req_put(usb9pfs->client, p9_rx_req);
>>
>> ... you do "put" it here. Not sure if this is ok or not ok, just asking,
>> because judging by the return value the caller of this function seems unable
>> to know which of the above "return" statements caused a NULL, hence it is
>> unable to tell whether it (the caller) should "put" or not.
>>
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return p9_rx_req;
>>> +}
>>> +
>>> +static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = ep->driver_data;
>>> +    struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
>>> +    struct p9_req_t *p9_rx_req;
>>> +    unsigned long flags;
>>> +
>>> +    switch (req->status) {
>>> +    case 0:                /* normal completion? */
>>> +        spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>> +        p9_rx_req = usb9pfs_rx_header(usb9pfs, req);
>>> +        if (!p9_rx_req) {
>>> +            spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>> +            goto free_req;
>>> +        }
>>> +
>>> +        memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
>>> +        p9_rx_req->rc.size = req->actual;
>>> +
>>> +        p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
>>> +        p9_req_put(usb9pfs->client, p9_rx_req);
>>> +
>>> +        usb9pfs->p9_tx_req = NULL;
>>> +
>>> +        usb9pfs_transmit(usb9pfs);
>>> +
>>> +        spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>> +
>>> +        return;
>>> +free_req:
>>> +    default:
>>> +        dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>> +            ep->name, req->status, req->actual, req->length);
>>> +        usb_ep_free_request(ep == usb9pfs->in_ep ?
>>> +                    usb9pfs->out_ep : usb9pfs->in_ep,
>>> +                    req->context);
>>> +        free_ep_req(ep, req);
>>> +        return;
>>
>> I assume this return means that p9_client_cb() should not be called if
>> either "free_req" or "default" cases happen?
>>
>> But then anything after the end of this "switch" instruction seems unreachable
>> code.
> 
> Right, it was some leftover. I removed the p9_client_cb.
> 
>>> +    }
>>> +
>>> +    p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_ERROR);
>>> +}
>>> +
>>> +static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
>>> +{
>>> +    int value;
>>> +
>>> +    value = usb_ep_disable(ep);
>>> +    if (value < 0)
>>> +        dev_info(&cdev->gadget->dev, "disable %s --> %d\n", ep->name, value);
>>> +}
>>> +
>>> +static void disable_endpoints(struct usb_composite_dev *cdev,
>>> +                  struct usb_ep *in, struct usb_ep *out,
>>> +                  struct usb_ep *iso_in, struct usb_ep *iso_out)
>>
>> iso_in and iso_out are never used
>>
>>> +{
>>> +    disable_ep(cdev, in);
>>> +    disable_ep(cdev, out);
>>
>> I'm not sure how useful this whole function is...
>>
>>> +}
>>> +
>>> +static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
>>> +{
>>> +    struct usb_composite_dev *cdev;
>>> +
>>> +    cdev = usb9pfs->function.config->cdev;
>>> +    disable_endpoints(cdev, usb9pfs->in_ep, usb9pfs->out_ep, NULL, NULL);
>>
>> ... why not
>>     disable_ep(cdev, usb9pfs->in_ep);
>>     disable_ep(cdev, usb9pfs->out_ep);
>> ?
> 
> I removed the function and use the disable calls directly.
> 
>>> +    dev_dbg(&cdev->gadget->dev, "%s disabled\n", usb9pfs->function.name);
>>> +}
>>> +
>>> +static inline struct usb_request *usb9pfs_alloc_ep_req(struct usb_ep *ep, 
>>> int len)
>>> +{
>>> +    return alloc_ep_req(ep, len);
>>> +}
>>
>> What is the purpose of this wrapper?
> 
> Leftover from some copy paste section. I removed it.
> 
>>> +
>>> +static int alloc_requests(struct usb_composite_dev *cdev,
>>> +              struct f_usb9pfs *usb9pfs)
>>> +{
>>> +    usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
>>> +    if (!usb9pfs->in_req)
>>> +        goto fail;
>>> +
>>> +    usb9pfs->out_req = usb9pfs_alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
>>> +    if (!usb9pfs->out_req)
>>> +        goto fail_in;
>>> +
>>> +    usb9pfs->in_req->complete = usb9pfs_tx_complete;
>>> +    usb9pfs->out_req->complete = usb9pfs_rx_complete;
>>> +
>>> +    /* length will be set in complete routine */
>>> +    usb9pfs->in_req->context = usb9pfs;
>>> +    usb9pfs->out_req->context = usb9pfs;
>>> +
>>> +    return 0;
>>> +
>>> +fail_in:
>>> +    usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
>>> +fail:
>>> +    return 0;
>>> +}
>>
>> This funcion returns a zero no matter what. Such a return value carries
>> no information. I saw something in the changelog regarding returning 0,
>> was it about this function? But then why return always 0 instead of void?
> 
> I changed it to proper return values.
> 
>>> +
>>> +static int enable_endpoint(struct usb_composite_dev *cdev,
>>> +               struct f_usb9pfs *usb9pfs, struct usb_ep *ep)
>>> +{
>>> +    int result;
>>> +
>>> +    result = config_ep_by_speed(cdev->gadget, &usb9pfs->function, ep);
>>> +    if (result)
>>> +        goto out;
>>> +
>>> +    result = usb_ep_enable(ep);
>>> +    if (result < 0)
>>> +        goto out;
>>> +
>>> +    ep->driver_data = usb9pfs;
>>> +
>>> +    result = 0;
>>> +
>>> +out:
>>> +    return result;
>>
>> I assume this is "a single point of return". You'd save 3 lines of code
>> by returning "result" on the spot instead of gotos and explicitly
>> returning a zero. Who knows, maybe modern compilers are smart enough
>> to figure this out. Not a deal breaker for me, though.
> 
> I squashed it as you suggested.
> 
>>> +}
>>> +
>>> +static int
>>> +enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
>>> +{
>>> +    int result = 0;
>>> +
>>> +    result = enable_endpoint(cdev, usb9pfs, usb9pfs->in_ep);
>>> +    if (result)
>>> +        goto out;
>>> +
>>> +    result = enable_endpoint(cdev, usb9pfs, usb9pfs->out_ep);
>>> +    if (result)
>>> +        goto disable_in;
>>> +
>>> +    result = alloc_requests(cdev, usb9pfs);
>>> +    if (result)
>>> +        goto disable_out;
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "%s enabled\n", usb9pfs->function.name);
>>> +    return 0;
>>> +
>>> +disable_out:
>>> +    usb_ep_disable(usb9pfs->out_ep);
>>> +disable_in:
>>> +    usb_ep_disable(usb9pfs->in_ep);
>>> +out:
>>> +    return result;
>>> +}
>>> +
>>> +static int p9_usbg_create(struct p9_client *client, const char *devname, 
>>> char *args)
>>> +{
>>> +    struct usb_composite_dev *cdev;
>>> +    struct f_usb9pfs *usb9pfs;
>>> +    struct f_usb9pfs *tmp;
>>> +    struct usb_function *f;
>>> +    int ret = -ENOENT;
>>> +    int found = 0;
>>> +
>>> +    if (!devname)
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&usb9pfs_lock);
>>> +    list_for_each_entry_safe(usb9pfs, tmp, &usbg_function_list, 
>>> function_list) {
>>> +        if (!usb9pfs->tag)
>>> +            continue;
>>> +        if (!strncmp(devname, usb9pfs->tag, strlen(devname))) {
>>> +            if (!usb9pfs->inuse) {
>>> +                usb9pfs->inuse = true;
>>> +                found = 1;
>>> +                break;
>>> +            }
>>> +            ret = -EBUSY;
>>> +            break;
>>> +        }
>>> +    }
>>> +    mutex_unlock(&usb9pfs_lock);
>>> +
>>> +    if (!found) {
>>> +        pr_err("no channels available for device %s\n", devname);
>>> +        return ret;
>>> +    }
>>> +
>>> +    INIT_LIST_HEAD(&usb9pfs->tx_req_list);
>>> +
>>> +    spin_lock_init(&usb9pfs->lock);
>>> +    spin_lock_init(&usb9pfs->req_lock);
>>> +
>>> +    f = &usb9pfs->function;
>>> +    cdev = f->config->cdev;
>>> +
>>> +    client->trans = (void *)usb9pfs;
>>> +    client->status = Connected;
>>> +    usb9pfs->client = client;
>>> +
>>> +    client->trans_mod->maxsize = usb9pfs->buflen;
>>> +
>>> +    disable_usb9pfs(usb9pfs);
>>> +
>>> +    return enable_usb9pfs(cdev, usb9pfs);
>>
>> This looks a bit weird. Clearly some side effect is intended here.
>> Can you document here, why and what is expected?
> 
> This is probably due to some copy paste left over. I removed the extra
> disable path.
> 
>>> +}
>>> +
>>> +static void p9_usbg_close(struct p9_client *client)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = client->trans;
>>> +
>>> +    disable_usb9pfs(usb9pfs);
>>> +}
>>> +
>>> +static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = client->trans;
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&usb9pfs->lock, flags);
>>> +    list_add_tail(&p9_req->req_list, &usb9pfs->tx_req_list);
>>> +    spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>> +
>>> +    spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>> +    usb9pfs_transmit(usb9pfs);
>>> +    spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/* We don't currently allow canceling of requests */
>>
>> What would we gain by allowing those? In other words,
>> what are we losing?
> 
> As suggested by Dominique I added the cancel callback.
> 
>> Regards,
>>
>> Andrzej
>>
>>> +static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
>>> +{
>>> +    return 1;
>>> +}
>>> +
>>> +static struct p9_trans_module p9_usbg_trans = {
>>> +    .name = "usbg",
>>> +    .create = p9_usbg_create,
>>> +    .close = p9_usbg_close,
>>> +    .request = p9_usbg_request,
>>> +    .cancel = p9_usbg_cancel,
>>> +    .owner = THIS_MODULE,
>>> +};
>>> +
>>> +/*-------------------------------------------------------------------------*/
>>> +
>>> +#define USB_PROTOCOL_9PFS    0x09
>>> +
>>> +static struct usb_interface_descriptor usb9pfs_intf = {
>>> +    .bLength =        sizeof(usb9pfs_intf),
>>> +    .bDescriptorType =    USB_DT_INTERFACE,
>>> +
>>> +    .bNumEndpoints =    2,
>>> +    .bInterfaceClass =    USB_CLASS_VENDOR_SPEC,
>>> +    .bInterfaceSubClass =    USB_SUBCLASS_VENDOR_SPEC,
>>> +    .bInterfaceProtocol =   USB_PROTOCOL_9PFS,
>>> +
>>> +    /* .iInterface = DYNAMIC */
>>> +};
>>> +
>>> +/* full speed support: */
>>> +
>>> +static struct usb_endpoint_descriptor fs_usb9pfs_source_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bEndpointAddress =    USB_DIR_IN,
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +};
>>> +
>>> +static struct usb_endpoint_descriptor fs_usb9pfs_sink_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bEndpointAddress =    USB_DIR_OUT,
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +};
>>> +
>>> +static struct usb_descriptor_header *fs_usb9pfs_descs[] = {
>>> +    (struct usb_descriptor_header *)&usb9pfs_intf,
>>> +    (struct usb_descriptor_header *)&fs_usb9pfs_sink_desc,
>>> +    (struct usb_descriptor_header *)&fs_usb9pfs_source_desc,
>>> +    NULL,
>>> +};
>>> +
>>> +/* high speed support: */
>>> +
>>> +static struct usb_endpoint_descriptor hs_usb9pfs_source_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +    .wMaxPacketSize =    cpu_to_le16(512),
>>> +};
>>> +
>>> +static struct usb_endpoint_descriptor hs_usb9pfs_sink_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +    .wMaxPacketSize =    cpu_to_le16(512),
>>> +};
>>> +
>>> +static struct usb_descriptor_header *hs_usb9pfs_descs[] = {
>>> +    (struct usb_descriptor_header *)&usb9pfs_intf,
>>> +    (struct usb_descriptor_header *)&hs_usb9pfs_source_desc,
>>> +    (struct usb_descriptor_header *)&hs_usb9pfs_sink_desc,
>>> +    NULL,
>>> +};
>>> +
>>> +/* super speed support: */
>>> +
>>> +static struct usb_endpoint_descriptor ss_usb9pfs_source_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +    .wMaxPacketSize =    cpu_to_le16(1024),
>>> +};
>>> +
>>> +static struct usb_ss_ep_comp_descriptor ss_usb9pfs_source_comp_desc = {
>>> +    .bLength =        USB_DT_SS_EP_COMP_SIZE,
>>> +    .bDescriptorType =    USB_DT_SS_ENDPOINT_COMP,
>>> +    .bMaxBurst =        0,
>>> +    .bmAttributes =        0,
>>> +    .wBytesPerInterval =    0,
>>> +};
>>> +
>>> +static struct usb_endpoint_descriptor ss_usb9pfs_sink_desc = {
>>> +    .bLength =        USB_DT_ENDPOINT_SIZE,
>>> +    .bDescriptorType =    USB_DT_ENDPOINT,
>>> +
>>> +    .bmAttributes =        USB_ENDPOINT_XFER_BULK,
>>> +    .wMaxPacketSize =    cpu_to_le16(1024),
>>> +};
>>> +
>>> +static struct usb_ss_ep_comp_descriptor ss_usb9pfs_sink_comp_desc = {
>>> +    .bLength =        USB_DT_SS_EP_COMP_SIZE,
>>> +    .bDescriptorType =    USB_DT_SS_ENDPOINT_COMP,
>>> +    .bMaxBurst =        0,
>>> +    .bmAttributes =        0,
>>> +    .wBytesPerInterval =    0,
>>> +};
>>> +
>>> +static struct usb_descriptor_header *ss_usb9pfs_descs[] = {
>>> +    (struct usb_descriptor_header *)&usb9pfs_intf,
>>> +    (struct usb_descriptor_header *)&ss_usb9pfs_source_desc,
>>> +    (struct usb_descriptor_header *)&ss_usb9pfs_source_comp_desc,
>>> +    (struct usb_descriptor_header *)&ss_usb9pfs_sink_desc,
>>> +    (struct usb_descriptor_header *)&ss_usb9pfs_sink_comp_desc,
>>> +    NULL,
>>> +};
>>> +
>>> +/* function-specific strings: */
>>> +static struct usb_string strings_usb9pfs[] = {
>>> +    [0].s = "usb9pfs input to output",
>>> +    {  }            /* end of list */
>>> +};
>>> +
>>> +static struct usb_gadget_strings stringtab_usb9pfs = {
>>> +    .language    = 0x0409,    /* en-us */
>>> +    .strings    = strings_usb9pfs,
>>> +};
>>> +
>>> +static struct usb_gadget_strings *usb9pfs_strings[] = {
>>> +    &stringtab_usb9pfs,
>>> +    NULL,
>>> +};
>>> +
>>> +/*-------------------------------------------------------------------------*/
>>> +
>>> +static int usb9pfs_func_bind(struct usb_configuration *c,
>>> +                 struct usb_function *f)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
>>> +    struct usb_composite_dev *cdev = c->cdev;
>>> +    int ret;
>>> +    int id;
>>> +
>>> +    /* allocate interface ID(s) */
>>> +    id = usb_interface_id(c, f);
>>> +    if (id < 0)
>>> +        return id;
>>> +    usb9pfs_intf.bInterfaceNumber = id;
>>> +
>>> +    id = usb_string_id(cdev);
>>> +    if (id < 0)
>>> +        return id;
>>> +    strings_usb9pfs[0].id = id;
>>> +    usb9pfs_intf.iInterface = id;
>>> +
>>> +    /* allocate endpoints */
>>> +    usb9pfs->in_ep = usb_ep_autoconfig(cdev->gadget,
>>> +                       &fs_usb9pfs_source_desc);
>>> +    if (!usb9pfs->in_ep)
>>> +        goto autoconf_fail;
>>> +
>>> +    usb9pfs->out_ep = usb_ep_autoconfig(cdev->gadget,
>>> +                        &fs_usb9pfs_sink_desc);
>>> +    if (!usb9pfs->out_ep)
>>> +        goto autoconf_fail;
>>> +
>>> +    /* support high speed hardware */
>>> +    hs_usb9pfs_source_desc.bEndpointAddress =
>>> +        fs_usb9pfs_source_desc.bEndpointAddress;
>>> +    hs_usb9pfs_sink_desc.bEndpointAddress = 
>>> fs_usb9pfs_sink_desc.bEndpointAddress;
>>> +
>>> +    /* support super speed hardware */
>>> +    ss_usb9pfs_source_desc.bEndpointAddress =
>>> +        fs_usb9pfs_source_desc.bEndpointAddress;
>>> +    ss_usb9pfs_sink_desc.bEndpointAddress = 
>>> fs_usb9pfs_sink_desc.bEndpointAddress;
>>> +
>>> +    ret = usb_assign_descriptors(f, fs_usb9pfs_descs, hs_usb9pfs_descs,
>>> +                     ss_usb9pfs_descs, ss_usb9pfs_descs);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    dev_dbg(&cdev->gadget->dev, "%s speed %s: IN/%s, OUT/%s\n",
>>> +        (gadget_is_superspeed(c->cdev->gadget) ? "super" :
>>> +        (gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full")),
>>> +            f->name, usb9pfs->in_ep->name, usb9pfs->out_ep->name);
>>> +    return 0;
>>> +
>>> +autoconf_fail:
>>> +    ERROR(cdev, "%s: can't autoconfigure on %s\n",
>>> +          f->name, cdev->gadget->name);
>>> +    return -ENODEV;
>>> +}
>>> +
>>> +static void usb9pfs_free_func(struct usb_function *f)
>>> +{
>>> +    struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
>>> +    struct f_usb9pfs_opts *opts;
>>> +
>>> +    ida_free(&usb9pfs_ida, usb9pfs->index);
>>> +    kfree(usb9pfs->tag);
>>> +    kfree(usb9pfs);
>>> +
>>> +    opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
>>> +
>>> +    mutex_lock(&opts->lock);
>>> +    opts->refcnt--;
>>> +    mutex_unlock(&opts->lock);
>>> +
>>> +    usb_free_all_descriptors(f);
>>> +}
>>> +
>>> +static int usb9pfs_set_alt(struct usb_function *f,
>>> +               unsigned int intf, unsigned int alt)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static void usb9pfs_disable(struct usb_function *f)
>>> +{
>>> +}
>>> +
>>> +static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)
>>> +{
>>> +    struct f_usb9pfs_opts *usb9pfs_opts;
>>> +    struct f_usb9pfs *usb9pfs;
>>> +
>>> +    usb9pfs = kzalloc(sizeof(*usb9pfs), GFP_KERNEL);
>>> +    if (!usb9pfs)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
>>> +
>>> +    mutex_lock(&usb9pfs_opts->lock);
>>> +    usb9pfs_opts->refcnt++;
>>> +    mutex_unlock(&usb9pfs_opts->lock);
>>> +
>>> +    usb9pfs->buflen = usb9pfs_opts->buflen;
>>> +
>>> +    usb9pfs->function.name = "usb9pfs";
>>> +    usb9pfs->function.bind = usb9pfs_func_bind;
>>> +    usb9pfs->function.set_alt = usb9pfs_set_alt;
>>> +    usb9pfs->function.disable = usb9pfs_disable;
>>> +    usb9pfs->function.strings = usb9pfs_strings;
>>> +
>>> +    usb9pfs->function.free_func = usb9pfs_free_func;
>>> +
>>> +    mutex_lock(&usb9pfs_ida_lock);
>>> +
>>> +    usb9pfs->index = ida_alloc_max(&usb9pfs_ida, U8_MAX, GFP_KERNEL);
>>> +    if (usb9pfs->index < 0) {
>>> +        struct usb_function *ret = ERR_PTR(usb9pfs->index);
>>> +
>>> +        kfree(usb9pfs);
>>> +        mutex_unlock(&usb9pfs_ida_lock);
>>> +        return ret;
>>> +    }
>>> +
>>> +    mutex_unlock(&usb9pfs_ida_lock);
>>> +
>>> +    usb9pfs->tag = kasprintf(GFP_KERNEL, "%s%d", usb9pfs->function.name,
>>> +                 usb9pfs->index);
>>> +
>>> +    INIT_LIST_HEAD(&usb9pfs->function_list);
>>> +
>>> +    mutex_lock(&usb9pfs_lock);
>>> +    list_add_tail(&usb9pfs->function_list, &usbg_function_list);
>>> +    mutex_unlock(&usb9pfs_lock);
>>> +
>>> +    return &usb9pfs->function;
>>> +}
>>> +
>>> +static inline struct f_usb9pfs_opts *to_f_usb9pfs_opts(struct config_item 
>>> *item)
>>> +{
>>> +    return container_of(to_config_group(item), struct f_usb9pfs_opts,
>>> +                func_inst.group);
>>> +}
>>> +
>>> +static void usb9pfs_attr_release(struct config_item *item)
>>> +{
>>> +    struct f_usb9pfs_opts *usb9pfs_opts = to_f_usb9pfs_opts(item);
>>> +
>>> +    usb_put_function_instance(&usb9pfs_opts->func_inst);
>>> +}
>>> +
>>> +static struct configfs_item_operations usb9pfs_item_ops = {
>>> +    .release        = usb9pfs_attr_release,
>>> +};
>>> +
>>> +static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, char *page)
>>> +{
>>> +    struct f_usb9pfs_opts *opts = to_f_usb9pfs_opts(item);
>>> +    int result;
>>> +
>>> +    mutex_lock(&opts->lock);
>>> +    result = sprintf(page, "%d\n", opts->buflen);
>>> +    mutex_unlock(&opts->lock);
>>> +
>>> +    return result;
>>> +}
>>> +
>>> +static ssize_t f_usb9pfs_opts_buflen_store(struct config_item *item,
>>> +                       const char *page, size_t len)
>>> +{
>>> +    struct f_usb9pfs_opts *opts = to_f_usb9pfs_opts(item);
>>> +    int ret;
>>> +    u32 num;
>>> +
>>> +    mutex_lock(&opts->lock);
>>> +    if (opts->refcnt) {
>>> +        ret = -EBUSY;
>>> +        goto end;
>>> +    }
>>> +
>>> +    ret = kstrtou32(page, 0, &num);
>>> +    if (ret)
>>> +        goto end;
>>> +
>>> +    opts->buflen = num;
>>> +    ret = len;
>>> +end:
>>> +    mutex_unlock(&opts->lock);
>>> +    return ret;
>>> +}
>>> +
>>> +CONFIGFS_ATTR(f_usb9pfs_opts_, buflen);
>>> +
>>> +static struct configfs_attribute *usb9pfs_attrs[] = {
>>> +    &f_usb9pfs_opts_attr_buflen,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct config_item_type usb9pfs_func_type = {
>>> +    .ct_item_ops    = &usb9pfs_item_ops,
>>> +    .ct_attrs    = usb9pfs_attrs,
>>> +    .ct_owner    = THIS_MODULE,
>>> +};
>>> +
>>> +static void usb9pfs_free_instance(struct usb_function_instance *fi)
>>> +{
>>> +    struct f_usb9pfs_opts *usb9pfs_opts;
>>> +
>>> +    usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
>>> +    kfree(usb9pfs_opts);
>>> +}
>>> +
>>> +static struct usb_function_instance *usb9pfs_alloc_instance(void)
>>> +{
>>> +    struct f_usb9pfs_opts *usb9pfs_opts;
>>> +
>>> +    usb9pfs_opts = kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
>>> +    if (!usb9pfs_opts)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    mutex_init(&usb9pfs_opts->lock);
>>> +
>>> +    usb9pfs_opts->func_inst.free_func_inst = usb9pfs_free_instance;
>>> +
>>> +    usb9pfs_opts->buflen = DEFAULT_BUFLEN;
>>> +
>>> +    config_group_init_type_name(&usb9pfs_opts->func_inst.group, "",
>>> +                    &usb9pfs_func_type);
>>> +
>>> +    return &usb9pfs_opts->func_inst;
>>> +}
>>> +DECLARE_USB_FUNCTION(usb9pfs, usb9pfs_alloc_instance, usb9pfs_alloc);
>>> +
>>> +static int __init usb9pfs_modinit(void)
>>> +{
>>> +    int ret;
>>> +
>>> +    INIT_LIST_HEAD(&usbg_function_list);
>>> +
>>> +    ret = usb_function_register(&usb9pfsusb_func);
>>> +    if (!ret)
>>> +        v9fs_register_trans(&p9_usbg_trans);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void __exit usb9pfs_modexit(void)
>>> +{
>>> +    usb_function_unregister(&usb9pfsusb_func);
>>> +    v9fs_unregister_trans(&p9_usbg_trans);
>>> +}
>>> +
>>> +module_init(usb9pfs_modinit);
>>> +module_exit(usb9pfs_modexit);
>>> +
>>> +MODULE_ALIAS_9P("usbg");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("USB gadget 9pfs transport");
>>> +MODULE_AUTHOR("Michael Grzeschik");
>>>
>>
>>
>>
> 


