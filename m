Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E5B7AFBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjI0HT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0HTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:19:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453E12A;
        Wed, 27 Sep 2023 00:19:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F389C433C7;
        Wed, 27 Sep 2023 07:19:48 +0000 (UTC)
Message-ID: <d9af2b98-8da5-4487-8125-3c68eefcf77c@xs4all.nl>
Date:   Wed, 27 Sep 2023 09:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] media: chips-media: wave5: Add the v4l2 layer
Content-Language: en-US, nl
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-5-92fc66cd685d@collabora.com>
 <b7aa9a5a-018a-4d78-b001-4ba84acb1e24@xs4all.nl>
 <7b159731dfbc2ab8243396eaec8f41be10af5160.camel@collabora.com>
 <6ae8a639-b9f5-4426-be49-5340a8b8b5e9@xs4all.nl>
 <330a177320fd766af8eddb76f57ea728b2e36afe.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <330a177320fd766af8eddb76f57ea728b2e36afe.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 01:29, Nicolas Dufresne wrote:
> Le vendredi 22 septembre 2023 à 09:33 +0200, Hans Verkuil a écrit :
>> On 21/09/2023 21:11, Nicolas Dufresne wrote:
>>> Le mercredi 20 septembre 2023 à 17:13 +0200, Hans Verkuil a écrit :
>>>> On 15/09/2023 23:11, Sebastian Fricke wrote:
>>>>> From: Nas Chung <nas.chung@chipsnmedia.com>
>>>>>
>>>>> Add the decoder and encoder implementing the v4l2
>>>>> API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
>>>>>
>>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>>>> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
>>>>> ---
>>>>>  drivers/media/platform/chips-media/Kconfig         |    1 +
>>>>>  drivers/media/platform/chips-media/Makefile        |    1 +
>>>>>  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
>>>>>  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
>>>>>  .../platform/chips-media/wave5/wave5-helper.c      |  196 ++
>>>>>  .../platform/chips-media/wave5/wave5-helper.h      |   30 +
>>>>>  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1965 ++++++++++++++++++++
>>>>>  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1825 ++++++++++++++++++
>>>>>  .../media/platform/chips-media/wave5/wave5-vpu.c   |  331 ++++
>>>>>  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
>>>>>  10 files changed, 4454 insertions(+)
>>>>>
>>
>> <snip>
>>
>>>>> +static int wave5_vpu_dec_set_eos_on_firmware(struct vpu_instance *inst)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = wave5_vpu_dec_update_bitstream_buffer(inst, 0);
>>>>> +	if (ret) {
>>>>> +		dev_err(inst->dev->dev,
>>>>> +			"Setting EOS for the bitstream, fail: %d\n", ret);
>>>>
>>>> Is this an error due to a driver problem, or because a bad bitstream is
>>>> fed from userspace? In the first case, dev_err would be right, in the
>>>> second dev_dbg would be more appropriate. Bad userspace input should not
>>>> spam the kernel log in general.
>>>
>>> Its the first. To set the EOS flag, a command is sent to the firmware. That
>>> command may never return (timeout) or may report an error. For this specific
>>> command, if that happens we are likely facing firmware of driver problem (or
>>> both).
>>
>> OK, I'd add that as a comment here as this is unexpected behavior.
>>
>>>
>>>>
>>>>> +		return ret;
>>>>> +	}
>>>>> +	return 0;
>>>>> +}
>>
>> <snip>
>>
>>>>> +static int wave5_vpu_dec_create_bufs(struct file *file, void *priv,
>>>>> +				     struct v4l2_create_buffers *create)
>>>>> +{
>>>>> +	struct v4l2_format *f = &create->format;
>>>>> +
>>>>> +	if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
>>>>> +		return -ENOTTY;
>>>>
>>>> Huh? Why is this needed?
>>>
>>> Minimally a comment should be added. The why is that we support CREATE_BUF for
>>> OUTPUT queue (bitstream) but not for CAPTURE queues. This is simply not
>>> supported by Wave5 firmware. Do you have any suggestion how this asymmetry can
>>> be implemented better ?
>>
>> Certainly not with ENOTTY: the ioctl exists, it is just not supported for
>> CAPTURE queues.
>>
>> How about -EPERM? And document this error as well in the VIDIOC_CREATE_BUFS
>> documentation. And you want a dev_dbg here too.
> 
> The suggestion cannot be used since there is documentation for that one already,
> and it does not match "unsupported".
> 
> "Permission denied. Can be returned if the device needs write permission, or
> some special capabilities is needed (e. g. root)"
> 
> What about using the most logical error code, which name is actually obvious,
> like ENOTSUP ?
> 
>    #define ENOTSUPP	524	/* Operation is not supported */
> 

Let's go with EOPNOTSUPP. That seems to be the more commonly used error
code in drivers.

>>
>> So I would propose that EPERM is returned if CREATE_BUFS is only supported
>> for for one of the two queues of an M2M device.
> 
> Note that userspace does not care of the difference between an ioctl not being
> implemented at all or not being implement for one queue. GStreamer have been
> testing with both queue type for couple of years now. Adding this distinction is
> just leaking an implementation details to userspace. I'm fine to just do what
> you'd like, just stating the obvious that while it may look logical inside the
> kernel, its a bit of a non-sense for our users.

I don't agree with that. If an ioctl returns ENOTTY, then userspace can be certain
that that ioctl is not implemented for the given file descriptor. That's not the case
here: it is implemented, the operation is just not supported for one of the queues.

Regards,

	Hans
