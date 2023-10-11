Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0487C521E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjJKLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbjJKLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:31:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCFCC;
        Wed, 11 Oct 2023 04:31:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A0D105C02EA;
        Wed, 11 Oct 2023 07:31:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 07:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697023893; x=1697110293; bh=8w
        +7mDwPsiBnKPGH1LyHznFeYNxdTZ8AWbEyIeygWIU=; b=beiEXjqOrTRkvtXHuG
        P2gPpNlIoGpG8zO448swpIQD9zreYqqK4GdBONBs795ns7+aG7YFOl1j6IXoQJ8h
        FMr9c2e8xlaC6RUVYq4OrM9tXyI2WjLvZiRsRFJKMgx27Af/ArU1NQ4TYruPmmBy
        yLJF/IxIzofKAk76tmJg9Dn966ZnGcKVtgNLKUd3C9MkW+iUBWO7OpnjvyX3C9Lw
        R2YaJrLeKIc/bIev1QWFe778S3snKAA5lathjomRFibXivh7gVUj3q3RC/w9aGl9
        i33mbdthBp4VzvOb1tLAtlGwgsQxrj7iNu1AfXc67asZ3IYMdPtKsduDv9MRMKfN
        Af/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697023893; x=1697110293; bh=8w+7mDwPsiBnK
        PGH1LyHznFeYNxdTZ8AWbEyIeygWIU=; b=mlkVwgCmR9cgvYHsUvyALoskenKK9
        wbipV7OO+6YRzHHpSv+e318axit5q35GoX35xcp6ETfKc3My+irgrdDJvrNAnz8W
        rZbVOKZHNIC+rA4E7WHIhoQ44oe/aJuNpGVJP9GUZXNfQRC00ZA12xQRFUuZwMgK
        5aLaIPfaBUS8/TjLrs1YsY0ov7Ld9WMv5sJk41nLrPB/wqa0CPbtJt3s+TDiePfM
        AQ3NA+EIp/QCNSRE7SpIlOoGL0LJGGMfh+jGo39PYgn0uBsFmmMFi6LK6J4E7O59
        rz1wBk/zsotRZUPTv/4Q/+ILVzPId2Ci3xPMONoyEcRm9W+0K64LiietA==
X-ME-Sender: <xms:k4cmZTqZKJLbWMFZzIt0UqDiB_xZrNvapYlVmKWhTAQT5OJhIKpfig>
    <xme:k4cmZdp1YYpxmpP-oHi4gOxtRkOLue--_G_iJHdnqcwBisLNh-W4QHYklv6SZO-Bp
    VZF_X2yfZjsbci2Kpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:k4cmZQNiuSPqemdlDzfXnyoAXgoF6I7XZE3lwrCLpqrCdz-MKxm6eQ>
    <xmx:k4cmZW7ZpP2wE1HxtD5Lira4jDG6c_3Ga-Vgw5bIPmqHtZa43u13yg>
    <xmx:k4cmZS4sNSyiaLkNK372fZ9SjlC0ZKs1uU1AmPkiM8gVf-t3PD-xcA>
    <xmx:lYcmZaicyRuQxnT1qgI84mRQLcnlL7Hn4owrvVaTunOnx9-77EAGyw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BEB5EB60089; Wed, 11 Oct 2023 07:31:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <fd43fb0d-5d52-423d-bb1d-bc10e64ea3ee@app.fastmail.com>
In-Reply-To: <20231010213420.93725-1-graf@amazon.com>
References: <20231010213420.93725-1-graf@amazon.com>
Date:   Wed, 11 Oct 2023 13:31:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Graf" <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6] misc: Add Nitro Secure Module driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, at 23:34, Alexander Graf wrote:
> This patch adds a driver for NSM that exposes a /dev/nsm device node which
> user space can issue an ioctl on this device with raw NSM CBOR formatted
> commands to request attestation documents, influence PCR states, read
> entropy and enumerate status of the device. In addition, the driver
> implements a hwrng backend.

I haven't had a chance to actually read the v3 submission in enough
detail, but assuming we're going to go with the simple pass-through
interface here, I've looked for some mostly cosmetic improvements
that you may want to integrate.

> +/* Timeout for NSM virtqueue respose in milliseconds. */
> +#define NSM_DEFAULT_TIMEOUT_MSECS (120000) /* 2 minutes */
> +
> +struct nsm {
> +	struct virtio_device *vdev;
> +	struct virtqueue     *vq;
> +	struct mutex          lock;
> +	wait_queue_head_t     wq;
> +	bool                  device_notified;

Instead of a manual wait queue plus a bool, using a
'struct completion' simplifies this a little bit.

> +
> +/* Maximum length input data */
> +struct nsm_data_req {
> +	__u32 len;
> +	__u8  data[NSM_REQUEST_MAX_SIZE];
> +};

> +/* Maximum length output data */
> +struct nsm_data_resp {
> +	__u32 len;
> +	__u8  data[NSM_RESPONSE_MAX_SIZE];
> +};

You have endian-conversion for some of the data fields
but not the 'len field here, I guess these should be
__le32 instead of __u32, with the appropriate le32_to_cpu()
and cpu_to_le32() conversion when passing the native
u32 word from userspace.

It does seem odd that you have a little-endian length field
here, but big-endian length fields inside of the cbor
data. 

> +#define CBOR_HEADER_SIZE_U8  (CBOR_HEADER_SIZE_SHORT + sizeof(u8))
> +#define CBOR_HEADER_SIZE_U16 (CBOR_HEADER_SIZE_SHORT + sizeof(u16))
> +#define CBOR_HEADER_SIZE_U32 (CBOR_HEADER_SIZE_SHORT + sizeof(u32))
> +#define CBOR_HEADER_SIZE_U64 (CBOR_HEADER_SIZE_SHORT + sizeof(u64))

Similarly, I guess these should be __be16/__be32/__be64?

> +	} else if (cbor_short_size == CBOR_LONG_SIZE_U32) {
> +		if (cbor_object_size < CBOR_HEADER_SIZE_U32)
> +			return -EFAULT;
> +		/* 4 bytes */
> +		array_len = cbor_object[1] << 24 |
> +			cbor_object[2] << 16 |
> +			cbor_object[3] << 8  |
> +			cbor_object[4];
> +		array_offset = CBOR_HEADER_SIZE_U32;
> +	} else if (cbor_short_size == CBOR_LONG_SIZE_U64) {
> +		if (cbor_object_size < CBOR_HEADER_SIZE_U64)
> +			return -EFAULT;
> +		/* 8 bytes */
> +		array_len = (u64) cbor_object[1] << 56 |
> +			  (u64) cbor_object[2] << 48 |
> +			  (u64) cbor_object[3] << 40 |
> +			  (u64) cbor_object[4] << 32 |
> +			  (u64) cbor_object[5] << 24 |
> +			  (u64) cbor_object[6] << 16 |
> +			  (u64) cbor_object[7] << 8  |
> +			  (u64) cbor_object[8];

These could use be{!6,32,64}_to_cpup() for clarity.

> +static int nsm_rng_read(struct hwrng *rng, void *data, size_t max, 
> bool wait)
> +{
> +	struct nsm *nsm = hwrng_to_nsm(rng);
> +	struct device *dev = &nsm->vdev->dev;
> +	struct nsm_msg *msg;
> +	int rc = 0;
> +
> +	/* NSM always needs to wait for a response */
> +	if (!wait)
> +		return 0;
> +
> +	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	rc = fill_req_get_random(nsm, &msg->req);
> +	if (rc != 0)
> +		goto out;
> +
> +	rc = nsm_sendrecv_msg(nsm, msg);
> +	if (rc != 0)
> +		goto out;
> +
> +	rc = parse_resp_get_random(nsm, &msg->resp, data, max);
> +	if (rc < 0)
> +		goto out;

It looks like the bulk of this function happens inside of
nsm_sendrecv_msg(), which uses a mutex for serialization.

In this case, I think you can replace the dynamic allocation
during read() with a preallocated buffer in the device that
always gets used here, after you extend the mutex out to the
entire fill_req_get_random()/nsm_sendrecv_msg()/parse_resp_get_random()
block.

> +static long nsm_dev_ioctl(struct file *file, unsigned int cmd,
> +	unsigned long arg)
> +{
> +	void __user *argp = u64_to_user_ptr((u64)arg);
> +	struct nsm *nsm = file_to_nsm(file);
> +	struct nsm_msg *msg;
> +	struct nsm_raw raw;
> +	int r = 0;
> +
> +	if (cmd != NSM_IOCTL_RAW)
> +		return -EINVAL;
> +
> +	if (_IOC_SIZE(cmd) != sizeof(raw))
> +		return -EINVAL;
> +
> +	/* Allocate message buffers to device */
> +	r = -ENOMEM;
> +	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		goto out;
> +
> +	/* Copy user argument struct to kernel argument struct */
> +	r = -EFAULT;
> +	if (copy_from_user(&raw, argp, _IOC_SIZE(cmd)))
> +		goto out;
> +
> +	/* Convert kernel argument struct to device request */
> +	r = fill_req_raw(nsm, &msg->req, &raw);
> +	if (r)
> +		goto out;
> +
> +	/* Send message to NSM and read reply */
> +	r = nsm_sendrecv_msg(nsm, msg);
> +	if (r)
> +		goto out;
> +
> +	/* Parse device response into kernel argument struct */
> +	r = parse_resp_raw(nsm, &msg->resp, &raw);
> +	if (r)
> +		goto out;

And the same is probably true here.

> +static int nsm_dev_file_open(struct inode *node, struct file *file)
> +{
> +	return 0;
> +}
> +
> +static int nsm_dev_file_close(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}

These are not needed if they don't do anything.

     Arnd
