Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628E67B38FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjI2R3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjI2R3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:29:21 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1F1720;
        Fri, 29 Sep 2023 10:29:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 23ACD320092E;
        Fri, 29 Sep 2023 13:29:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 13:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696008539; x=1696094939; bh=eh
        ieEWBFWNEtqLISekzJUElBV+gYQ+pS/wzD/+8Hv8g=; b=SwAEQRVqXdKNYYzKIK
        nAu8o0rU2I8QgsVWLi96yIZudeda6AMsuZytEw7q9duQNSnhyhGI1clxPZilgE38
        MyoRO4Xs184RsaoHsVCUbSkGGd4wyIUt3pEJujwW7OjqZuPnM7GpxTccJO/HGGL+
        0Xd7UdjDsK+XBZioaJTaSZwAVYDjLH5WicB3plLPllwQXdc1/+qJVWh5CvCnLDRC
        aa8SmqEM4xZcZiS47fyXZ23SeACevUEGQ8xJkLwyq4KjRRAP+i8QaBbpcROiRh9g
        bixlco8FHudPKzLiOHI6z9veiF0mc/oCLg2mPyo0Dsp0nV696uLgwtf11Ay92JGT
        5VUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696008539; x=1696094939; bh=ehieEWBFWNEtq
        LISekzJUElBV+gYQ+pS/wzD/+8Hv8g=; b=hg4nIFQcIDu1ILxhUsY+EmR04XZO7
        b86mKeP/y9ZaeXwrtOXAN9aErJB7VqeT9x8vfHru1tosRIJHqmZpRORPXyW5n0EF
        +aVq9LpCZSkJwh9r5fafg3FOqxXw6O649jP2JlNZbVer7TrByDXoXqB85GoZ4k9e
        gDdg66DUN9IYcHZ+O9lFmdvQKi7QbninXL+Cp1M35VTjzcEoYm0QzFOB5xfte3Do
        MOzC2qN5+1JgO1Sn65ymb/eOZdMW4gynwr0EbREpbhivOpsUrdvHMksu2XGRIICt
        rqbQ36qS9FK5texZHjizBuf6oF2s/6WgQNK4N4gn8SjL2Qwm4fiNrsWWQ==
X-ME-Sender: <xms:WQkXZUN3CaelKMM8nCq55tDE1iw53RrLMwqzdwZiqd2wi1rmPCVu9A>
    <xme:WQkXZa8V6PNVpOiQDz3028MN8gSgBLV4mRv5-KdoJ9LGcc8zapA5RfkhhhNRUw7GG
    CUnLGtuZKIPQ0rHMHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WQkXZbTNABQD2pJZ4oeFeN_HgFeeG5kGrO9XKou276D0rm72FBVkMA>
    <xmx:WQkXZcu5-jtl51EYO3dPiB0AN33ViisFM2H1myTw4N6u0RPbM4eWnw>
    <xmx:WQkXZcdBFVqIhmzum_0EwoOOy4N-3xP4QLVd_eFGX-oxxdbG55x3nw>
    <xmx:WwkXZdXTewiVL15vJIwXRdbOmdhgOlFjNHJm_MbWmDo7WOUxKuQ_ng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ADB23B60089; Fri, 29 Sep 2023 13:28:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <74b2d869-0d96-46f9-a180-b405992e6c51@app.fastmail.com>
In-Reply-To: <20230929133320.74848-2-graf@amazon.com>
References: <20230929133320.74848-1-graf@amazon.com>
 <20230929133320.74848-2-graf@amazon.com>
Date:   Fri, 29 Sep 2023 13:28:37 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Graf" <graf@amazon.com>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] misc: Add Nitro Secure Module driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023, at 09:33, Alexander Graf wrote:
> When running Linux inside a Nitro Enclave, the hypervisor provides a
> special virtio device called "NSM". This device has 2 main functions:
>
>   1) Provide attestation reports
>   2) Modify PCR state
>   3) Provide entropy
>
> This patch adds the core NSM driver that exposes a /dev/nsm device node
> which user space can use to request attestation documents and influence
> PCR states. A follow up patch will add a hwrng driver to feed its entropy
> into the kernel.
>
> Originally-by: Petre Eftime <petre.eftime@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Hi Alex,

I've taken a first look at this driver and have some minor comments.
The main point here is that I think we need to look at possible
alternatives for the user space interface, and (if possible) change
to a set of higher-level ioctl commands from the simple passthrough. 

> +/* Virtio MMIO device definition */
> +struct virtio_mmio_device {
> +	struct virtio_device vdev;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	unsigned long version;
> +
> +	/* a list of queues so we can dispatch IRQs */
> +	spinlock_t lock;
> +	struct list_head virtqueues;
> +};
> +
> +/* Virtqueue list entry */
> +struct virtio_mmio_vq_info {
> +	/* The actual virtqueue */
> +	struct virtqueue *vq;
> +
> +	/* The list node for the virtqueues list */
> +	struct list_head node;
> +};


It looks like you are duplicating these structures from the
virtio_mmio.c file, which seems like a bad idea for a number
of reasons. What is it that you actually need that the
virtio subsystem does not provide? Can you add interfaces
to the common code instead?

> +static struct virtio_device *nsm_vdev;
> +static struct nsm_hwrng *nsm_hwrng;
> +static struct mutex nsm_lock;
> +static wait_queue_head_t nsm_waitqueue;
> +static bool nsm_device_notified;

Instead of global structures, these should ideally all be
part of a per-device structure, even if you are sure that
there is only ever one of these devices.

> +/* Copy an entire message from user-space to kernel-space */
> +static int message_memdup_from_user(struct nsm_kernel_message *dst,
> +	struct nsm_message *src)
> +{
> +	struct nsm_message shallow_copy;
> +
> +	if (!src || !dst)
> +		return -EINVAL;
> +
> +	/* The destination's request and response buffers should be NULL. */
> +	if (dst->request.iov_base || dst->response.iov_base)
> +		return -EINVAL;
> +
> +	/* First, make a shallow copy to be able to read the inner pointers */
> +	if (copy_from_user(&shallow_copy, src, sizeof(shallow_copy)) != 0)
> +		return -EINVAL;
> +
> +	/* Verify the user input size. */
> +	if (shallow_copy.request.iov_len > NSM_REQUEST_MAX_SIZE)
> +		return -EMSGSIZE;
> +
> +	/* Allocate kernel memory for the user request */
> +	dst->request.iov_len = shallow_copy.request.iov_len;
> +	dst->request.iov_base = kmalloc(dst->request.iov_len, GFP_KERNEL);
> +	if (!dst->request.iov_base)
> +		return -ENOMEM;
> +
> +	/* Copy the request content */
> +	if (copy_from_user(dst->request.iov_base,
> +		shallow_copy.request.iov_base, dst->request.iov_len) != 0) {
> +		kfree(dst->request.iov_base);
> +		return -EFAULT;
> +	}

It looks like the ioctl interface just provides an interface
for passing through raw messages, which is often not the best
idea. Are you able to enumerate the possible request types and
provide a separate ioctl for each one?

> +/* Supported driver operations */
> +static const struct file_operations nsm_dev_fops = {
> +	.open = nsm_dev_file_open,
> +	.release = nsm_dev_file_close,
> +	.unlocked_ioctl = nsm_dev_ioctl,
> +};

This breaks on 32-bit userspace, which would need a separate .compat_ioctl
handler with the current command definition. It's often better to define
the ioctl interface to be the same on 32-bit and 64-bit userspace
and then use the trivial compat_ptr_ioctl wrapper.

> +/* Driver configuration */
> +static struct miscdevice nsm_driver_miscdevice = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= NSM_DEV_NAME,
> +	.fops	= &nsm_dev_fops,
> +	.mode	= 0666
> +};

I would suggest expanding NSM_DEV_NAME here, it's much easier to
grep for the actual string if a user wants to know which driver
is responsible. Probably even less code.

> +	if (nsm_hwrng)
> +		nsm_hwrng->probe(vdev);
> +
> +	pr_debug("NSM device has been probed.\n");
> +	return 0;
> +}

The debug statements can probably get removed, especially
the whitespace damaged ones.

> +int nsm_register_hwrng(struct nsm_hwrng *_nsm_hwrng)
> +{
> +	if (nsm_hwrng)
> +		return -EEXIST;
> +
> +	nsm_hwrng = _nsm_hwrng;
> +	if (nsm_vdev)
> +		nsm_hwrng->probe(nsm_vdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nsm_register_hwrng);

This should get easier of you reverse the dependency between
the two drivers and just call into the nsm_hwrng_probe()
function from the main driver's probe.

> +	mutex_init(&nsm_lock);
> +	init_waitqueue_head(&nsm_waitqueue);

You can simply use DEFINE_MUTEX() and DECLARE_WAIT_QUEUE_HEAD()
if you still need the global objects (rather than making them 
per device).

> +
> +	rc = register_virtio_driver(&virtio_nsm_driver);
> +	if (rc)
> +		pr_err("NSM driver initialization error: %d.\n", rc);
> +
> +	return rc;
> +}
> +
> +static void __exit nsm_driver_exit(void)
> +{
> +	unregister_virtio_driver(&virtio_nsm_driver);
> +	mutex_destroy(&nsm_lock);
> +	pr_debug("NSM driver exited.\n");
> +}
> +
> +module_init(nsm_driver_init);
> +module_exit(nsm_driver_exit);

Then this can use module_virtio_driver()

      Arnd
