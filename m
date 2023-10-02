Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957CC7B5DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbjJBXvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJBXvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:51:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B39BD;
        Mon,  2 Oct 2023 16:51:35 -0700 (PDT)
Received: from localhost (node-1w7jr9sthgf5xzr3piazikqnn.ipv6.telus.net [IPv6:2001:569:befe:8000:ef1c:8591:564c:a1f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dbrouwer)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7175B66072AE;
        Tue,  3 Oct 2023 00:51:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696290693;
        bh=T9qfIyypSwGKAnZmRqXjeU/52cPdy4ah1kmYs3GXtoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGWpuLxZpe70s1gCjhjtWChNdiGUuU+zqv043kgfK/tVtRWzvAtsacxLQuDYzB9NQ
         q8uBo/sJ99Kq0FuEY7wOmiAtc+tNmgLljfjZJO3Ggq2Xw1P0SDxUgdbSJJh9qzmMQO
         sV2sfle+Y81AMVH7sdVsCeVhXL0gf8Sg5c49hBlmpKZZjSZCsthtgHnUw9oxXRJbz3
         +PnJGnzYB53WIC8w9OxjMhG0Vrss3AHmqxBLXM3tlIHmTzbtOy5Ly6OlVE641AVKca
         3jRAxFeVQkKqtrlDA3Ndiwyk0v1mcSxLJpclecj+DtCNCNfqM6/4D4nr2gKq5dwoAE
         80qGb8WxALXnw==
Date:   Mon, 2 Oct 2023 16:51:28 -0700
From:   Deborah Brouwer <deborah.brouwer@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v12 5/7] media: chips-media: wave5: Add the v4l2 layer
Message-ID: <ZRtXgMhSS3D6H3/4@db550>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-5-92fc66cd685d@collabora.com>
 <b7aa9a5a-018a-4d78-b001-4ba84acb1e24@xs4all.nl>
 <7b159731dfbc2ab8243396eaec8f41be10af5160.camel@collabora.com>
 <6ae8a639-b9f5-4426-be49-5340a8b8b5e9@xs4all.nl>
 <330a177320fd766af8eddb76f57ea728b2e36afe.camel@collabora.com>
 <d9af2b98-8da5-4487-8125-3c68eefcf77c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9af2b98-8da5-4487-8125-3c68eefcf77c@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:19:46AM +0200, Hans Verkuil wrote:
> On 27/09/2023 01:29, Nicolas Dufresne wrote:
> > Le vendredi 22 septembre 2023 à 09:33 +0200, Hans Verkuil a écrit :
> >> On 21/09/2023 21:11, Nicolas Dufresne wrote:
> >>> Le mercredi 20 septembre 2023 à 17:13 +0200, Hans Verkuil a écrit :
> >>>> On 15/09/2023 23:11, Sebastian Fricke wrote:
> >>>>> From: Nas Chung <nas.chung@chipsnmedia.com>
> >>>>>
> >>>>> Add the decoder and encoder implementing the v4l2
> >>>>> API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> >>>>>
> >>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> >>>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >>>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> >>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> >>>>> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> >>>>> ---
> >>>>>  drivers/media/platform/chips-media/Kconfig         |    1 +
> >>>>>  drivers/media/platform/chips-media/Makefile        |    1 +
> >>>>>  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
> >>>>>  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
> >>>>>  .../platform/chips-media/wave5/wave5-helper.c      |  196 ++
> >>>>>  .../platform/chips-media/wave5/wave5-helper.h      |   30 +
> >>>>>  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1965 ++++++++++++++++++++
> >>>>>  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1825 ++++++++++++++++++
> >>>>>  .../media/platform/chips-media/wave5/wave5-vpu.c   |  331 ++++
> >>>>>  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
> >>>>>  10 files changed, 4454 insertions(+)
> >>>>>
> >>
> >> <snip>
> >>
> >>>>> +static int wave5_vpu_dec_set_eos_on_firmware(struct vpu_instance *inst)
> >>>>> +{
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	ret = wave5_vpu_dec_update_bitstream_buffer(inst, 0);
> >>>>> +	if (ret) {
> >>>>> +		dev_err(inst->dev->dev,
> >>>>> +			"Setting EOS for the bitstream, fail: %d\n", ret);
> >>>>
> >>>> Is this an error due to a driver problem, or because a bad bitstream is
> >>>> fed from userspace? In the first case, dev_err would be right, in the
> >>>> second dev_dbg would be more appropriate. Bad userspace input should not
> >>>> spam the kernel log in general.
> >>>
> >>> Its the first. To set the EOS flag, a command is sent to the firmware. That
> >>> command may never return (timeout) or may report an error. For this specific
> >>> command, if that happens we are likely facing firmware of driver problem (or
> >>> both).
> >>
> >> OK, I'd add that as a comment here as this is unexpected behavior.
> >>
> >>>
> >>>>
> >>>>> +		return ret;
> >>>>> +	}
> >>>>> +	return 0;
> >>>>> +}
> >>
> >> <snip>
> >>
> >>>>> +static int wave5_vpu_dec_create_bufs(struct file *file, void *priv,
> >>>>> +				     struct v4l2_create_buffers *create)
> >>>>> +{
> >>>>> +	struct v4l2_format *f = &create->format;
> >>>>> +
> >>>>> +	if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> >>>>> +		return -ENOTTY;
> >>>>
> >>>> Huh? Why is this needed?
> >>>
> >>> Minimally a comment should be added. The why is that we support CREATE_BUF for
> >>> OUTPUT queue (bitstream) but not for CAPTURE queues. This is simply not
> >>> supported by Wave5 firmware. Do you have any suggestion how this asymmetry can
> >>> be implemented better ?
> >>
> >> Certainly not with ENOTTY: the ioctl exists, it is just not supported for
> >> CAPTURE queues.
> >>
> >> How about -EPERM? And document this error as well in the VIDIOC_CREATE_BUFS
> >> documentation. And you want a dev_dbg here too.
> > 
> > The suggestion cannot be used since there is documentation for that one already,
> > and it does not match "unsupported".
> > 
> > "Permission denied. Can be returned if the device needs write permission, or
> > some special capabilities is needed (e. g. root)"
> > 
> > What about using the most logical error code, which name is actually obvious,
> > like ENOTSUP ?
> > 
> >    #define ENOTSUPP	524	/* Operation is not supported */
> > 
> 
> Let's go with EOPNOTSUPP. That seems to be the more commonly used error
> code in drivers.

Hi Hans,

Sorry to belabour this issue but when I change the return value
to EOPNOTSUPP, it now causes v4l2-compliance to fail because
v4l2-test-buffers.cpp expects ENOTTY if CREATE_BUFS is not supported.

We didn't get this warning before because there was a typo in the
buffer check and it was only checking for single-planar buffers.

How would you prefer to handle this? The options seem like
keep ENOTTY in this driver or
patch v4l2-compliance to warn if it also receives EOPNOTSUPP?

> 
> >>
> >> So I would propose that EPERM is returned if CREATE_BUFS is only supported
> >> for for one of the two queues of an M2M device.
> > 
> > Note that userspace does not care of the difference between an ioctl not being
> > implemented at all or not being implement for one queue. GStreamer have been
> > testing with both queue type for couple of years now. Adding this distinction is
> > just leaking an implementation details to userspace. I'm fine to just do what
> > you'd like, just stating the obvious that while it may look logical inside the
> > kernel, its a bit of a non-sense for our users.
> 
> I don't agree with that. If an ioctl returns ENOTTY, then userspace can be certain
> that that ioctl is not implemented for the given file descriptor. That's not the case
> here: it is implemented, the operation is just not supported for one of the queues.
> 
> Regards,
> 
> 	Hans
