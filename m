Return-Path: <linux-kernel+bounces-22401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A4829D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1331F22D92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685C4BAAC;
	Wed, 10 Jan 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCEtlv2i"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533C4C3A6;
	Wed, 10 Jan 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso3923901f8f.0;
        Wed, 10 Jan 2024 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704899565; x=1705504365; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQo49Z+U5JntuTThMEuTakcPkMbkdQOeL9TnCocsI8A=;
        b=LCEtlv2iSIBSwd7exVpEMOfUlwk8D2eABff/shmI1vFTmrfm62/bCiXVh6jQ1rGCTY
         opUcfFgBjCsV9WpBvxsc62ZVa/ARrnYu3JthEkfVlXMBDYnPVJmxTpT5GlMpDtBihqik
         xewe4iA8S2yhR/o4y71BMMlRkjZ/tvQLX1vMH3lO224o6tOYLDMXrIqx/LOQmqhfqnbR
         7mvg1PJfOFRCbWxWZHhhSgnQTNcg9NKFPMpEDKp7hiF9ZwJztmen5cpSI2RSlCl14APV
         gDnPz0S+d6oNHSo2aRa6dCWGePq/M8shsa0MH+G+nNtFMkwbRMBNKwDqX+RKPgT2ZeSl
         MveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899565; x=1705504365;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQo49Z+U5JntuTThMEuTakcPkMbkdQOeL9TnCocsI8A=;
        b=hjYVQ7jJumVPNwdEjGy4awy2vfoM8/4hpskADjr2qJcpqS0kGtxmoEqABuqorxYuPN
         QRpvdE2UTs07LKcFijPmip4IXuVAiSaz1x00HUIu2d+UU7D5KKtgI92Ee5/68kroAQmJ
         AYOKO3ZkvhrrfMlEb/RUI0xWzc1n8eBJqhWiW0exYeZ+dOy50HOacYPmzAIquKYS30n9
         jRcCvFMmBPoARxhQI1NmkpqX12tYNGpxy94dFBY1nmhI/foCl5y5q1KHQEEfkc7le8UE
         Sj2QSjIoLbumWYQchrzxw2Nc6xvKuYuqd1kBzplpUB1Trz9RSty6jmMy7oLSqBbqUM6Z
         K30Q==
X-Gm-Message-State: AOJu0Yz5aA8uPsO5ciYl6+PHedqfwD8p71rp4E5m4S7ijkG9E8zAyiMs
	Vx729vZ/moFeAYz0uZ5CbiE=
X-Google-Smtp-Source: AGHT+IEgITlSUV/ObiL33JehWyl66PfUPb733rDtUs8LlyJSBbWfT89LA/M7WyuoS/lvg4o9K6czvg==
X-Received: by 2002:a5d:62cb:0:b0:336:5fd5:6bd1 with SMTP id o11-20020a5d62cb000000b003365fd56bd1mr683006wrv.62.1704899565170;
        Wed, 10 Jan 2024 07:12:45 -0800 (PST)
Received: from [10.76.84.150] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b0033662fb321esm5118204wrn.33.2024.01.10.07.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:12:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------mc3GFwLRzhlonFEzaB54iAQ2"
Message-ID: <964be974-bdd1-4858-b278-ae78cc34c5b9@gmail.com>
Date: Wed, 10 Jan 2024 17:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] media: v4l: implement virtual channels
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240110125103.215267-1-demonsingur@gmail.com>
 <0b85defe-c334-4317-9057-5db45a480841@ideasonboard.com>
 <356e7696-7d12-416d-8fee-9d391b4dc3b3@gmail.com>
 <33c54fe5-67a5-496a-87fb-14242c2fd9fd@ideasonboard.com>
From: Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <33c54fe5-67a5-496a-87fb-14242c2fd9fd@ideasonboard.com>

This is a multi-part message in MIME format.
--------------mc3GFwLRzhlonFEzaB54iAQ2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/10/24 15:36, Tomi Valkeinen wrote:
> Hi,
>
> On 10/01/2024 15:27, Cosmin Tanislav wrote:
>> Hi, Tomi.
>>
>> The usecase for this is crossbar devices that allow for mapping virtual channel
>>
>> ids dynamically.
>>
>> The remapping happens based on VC and DT. DT can be determined based on
>>
>> the pixel code, but VC has no way of being determined at runtime through
>>
>> standard V4L2 APIs.
>
> The DT shouldn't be determined based on the pixel code. The DT, and the VC, should be queried from the source subdev using the get_frame_desc() subdev op.
>
> So, in general, the streams API presents a logical view of the streams without a strict direct mapping to the hardware. When the streaming is started, the subdev drivers need to figure out the hardware details, and, specifically for the DT & VC of incoming streams, can ask details from the source subdevice using get_frame_desc().
>
> Or if I misunderstand your case, can you provide a concrete example of the pipeline and the media tree in question to help the discussion.
>
>  Tomi

---------------------------------------------------------------------------

I've attached the result of media-ctl --print-dot. I'm not sure if this is
visible in the mailing list.

There are 4 cameras attached to 4 serializers, which connect to 4 ports of
a single deserializer.

I've split each device into multiple subdevs and introduced crossbar
devices which can have their routing table changed.
This mostly matches the hardware blocks available within the chip.

The connection between cameras and serializer PHYs, and between serializer
links and deserializer links are specified in device tree using the
standard graph API.

In each serializer, the phy_pipe_xbar subdev allows mapping the output of
each PHY to a pipe, allowing stream duplication. One serializer can have
multiple PHYs, although this is not pictured here.
The pipe_link_xbar subdev allows mapping the output of each pipe to a
hardware stream of the link. This mapping is 1:1. One serializer can have
multiple pipes, as pictured here for serializer 0 and serializer 1.

On the deserializer side, the link_pipe_xbar subdev allows selecting which
link maps to which pipe. Some deserializer chips don't support automatic
link hardware stream detection, in which case each deserializer link will
have a source port for each hardware stream, and the link_pipe_xbar will
have a source port for each hardware stream of each link too. This subdev
also allows stream duplication by having multiple pipes receive data from
the same link + hardware stream. It also allows multiple pipes to receive
data from the same link but different hardware streams.

Further down there's a pipe_phy_xbar subdev. This is the one where this
patch is necessary. It allows remapping the DT and VC of all incoming data
streams to new values. This is useful because we might have a downstream
device that is able to multiplex the incoming data streams into separate
video devices based on VC, allowing us to connect multiple cameras over
the same CSI interface, but having them show up as multiple video devices.

I know this is a very complicated pipeline, but doing all this logic
automatically and correctly is very hard, while configuring it manually is
pretty easy, which is why we would like to expose all these configurations
to the user, which is able to take better decisions based on their usecase.

>
>>
>> The alternative would be to hardcode them in device tree, which is not very
>>
>> nice, and cannot account for all possible user configurations.
>>
>> I'm aware that VC is a bus-specific feature, which is why this is an RFC.
>>
>> Having a V4L2 implementation would solve a lot of devices having to
>>
>> hardcode VCs.
>>
>>
>> On 1/10/24 14:50, Tomi Valkeinen wrote:
>>> Hi!
>>>
>>> On 10/01/2024 14:51, Cosmin Tanislav wrote:
>>>> With experimental support for multiple streams per pad being added, the
>>>> pieces are in place to support a virtual channel id per stream.
>>>>
>>>> This is necessary because stream ids cannot be directly mapped to a virtual
>>>> channel id, since the same virtual channel id can be assigned to multiple
>>>> streams of data, each with a different data type.
>>>>
>>>> To implement this, the following steps have been taken.
>>>>
>>>> Add subdev ioctls for getting and setting the virtual channel for a
>>>> specific pad and stream.
>>>>
>>>> Add pad .get_vc() and .set_vc() ops.
>>>>
>>>> Add the virtual channel to the stream config in V4L2 subdev central state.
>>>>
>>>> Add a default .get_vc() implementation that retrieves the virtual channel
>>>> from the central state, or, if that is not supported, default to virtual
>>>> channel 0.
>>>
>>> Why do you need this?
>>>
>>> The design idea with streams was that the streams are not tied to CSI-2 streams (or to any specific HW). The CSI-2 virtual channels should be handled by the drivers internally, and they should not be visible to the userspace at all.
>>>
>>>   Tomi
>>>
>>>> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
>>>> ---
>>>>    drivers/media/v4l2-core/v4l2-subdev.c | 57 +++++++++++++++++++++++++++
>>>>    include/media/v4l2-subdev.h           | 39 ++++++++++++++++++
>>>>    include/uapi/linux/v4l2-subdev.h      | 18 +++++++++
>>>>    3 files changed, 114 insertions(+)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> index be86b906c985..8945bfd0fe12 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> @@ -535,6 +535,9 @@ subdev_ioctl_get_state(struct v4l2_subdev *sd, struct v4l2_subdev_fh *subdev_fh,
>>>>        case VIDIOC_SUBDEV_S_ROUTING:
>>>>            which = ((struct v4l2_subdev_routing *)arg)->which;
>>>>            break;
>>>> +    case VIDIOC_SUBDEV_G_VC:
>>>> +    case VIDIOC_SUBDEV_S_VC:
>>>> +        which = ((struct v4l2_subdev_vc *)arg)->which;
>>>>        }
>>>>          return which == V4L2_SUBDEV_FORMAT_TRY ?
>>>> @@ -969,6 +972,26 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>>>>                        routing->which, &krouting);
>>>>        }
>>>>    +    case VIDIOC_SUBDEV_G_VC: {
>>>> +        struct v4l2_subdev_vc *vc = arg;
>>>> +
>>>> +        if (!client_supports_streams)
>>>> +            vc->stream = 0;
>>>> +
>>>> +        memset(vc->reserved, 0, sizeof(vc->reserved));
>>>> +        return v4l2_subdev_call(sd, pad, get_vc, state, vc);
>>>> +    }
>>>> +
>>>> +    case VIDIOC_SUBDEV_S_VC: {
>>>> +        struct v4l2_subdev_vc *vc = arg;
>>>> +
>>>> +        if (!client_supports_streams)
>>>> +            vc->stream = 0;
>>>> +
>>>> +        memset(vc->reserved, 0, sizeof(vc->reserved));
>>>> +        return v4l2_subdev_call(sd, pad, set_vc, state, vc);
>>>> +    }
>>>> +
>>>>        case VIDIOC_SUBDEV_G_CLIENT_CAP: {
>>>>            struct v4l2_subdev_client_capability *client_cap = arg;
>>>>    @@ -1602,6 +1625,20 @@ int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(v4l2_subdev_get_fmt);
>>>>    +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>>> +               struct v4l2_subdev_vc *vc)
>>>> +{
>>>> +    u32 vc_id = 0;
>>>> +
>>>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS)
>>>> +        vc_id = v4l2_subdev_state_get_stream_vc(state, vc->pad, vc->stream);
>>>> +
>>>> +    vc->vc = vc_id;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(v4l2_subdev_get_vc);
>>>> +
>>>>    int v4l2_subdev_set_routing(struct v4l2_subdev *sd,
>>>>                    struct v4l2_subdev_state *state,
>>>>                    const struct v4l2_subdev_krouting *routing)
>>>> @@ -1745,6 +1782,26 @@ v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_compose);
>>>>    +u32 v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
>>>> +                    unsigned int pad, u32 stream)
>>>> +{
>>>> +    struct v4l2_subdev_stream_configs *stream_configs;
>>>> +    unsigned int i;
>>>> +
>>>> +    lockdep_assert_held(state->lock);
>>>> +
>>>> +    stream_configs = &state->stream_configs;
>>>> +
>>>> +    for (i = 0; i < stream_configs->num_configs; ++i) {
>>>> +        if (stream_configs->configs[i].pad == pad &&
>>>> +            stream_configs->configs[i].stream == stream)
>>>> +            return stream_configs->configs[i].vc;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_vc);
>>>> +
>>>>    int v4l2_subdev_routing_find_opposite_end(const struct v4l2_subdev_krouting *routing,
>>>>                          u32 pad, u32 stream, u32 *other_pad,
>>>>                          u32 *other_stream)
>>>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
>>>> index c1f90c1223a7..ed1fdd79c2bb 100644
>>>> --- a/include/media/v4l2-subdev.h
>>>> +++ b/include/media/v4l2-subdev.h
>>>> @@ -722,6 +722,7 @@ struct v4l2_subdev_stream_config {
>>>>        u32 stream;
>>>>        bool enabled;
>>>>    +    u32 vc;
>>>>        struct v4l2_mbus_framefmt fmt;
>>>>        struct v4l2_rect crop;
>>>>        struct v4l2_rect compose;
>>>> @@ -858,6 +859,12 @@ struct v4l2_subdev_pad_ops {
>>>>        int (*set_fmt)(struct v4l2_subdev *sd,
>>>>                   struct v4l2_subdev_state *state,
>>>>                   struct v4l2_subdev_format *format);
>>>> +    int (*get_vc)(struct v4l2_subdev *sd,
>>>> +              struct v4l2_subdev_state *state,
>>>> +              struct v4l2_subdev_vc *vc);
>>>> +    int (*set_vc)(struct v4l2_subdev *sd,
>>>> +              struct v4l2_subdev_state *state,
>>>> +              struct v4l2_subdev_vc *vc);
>>>>        int (*get_selection)(struct v4l2_subdev *sd,
>>>>                     struct v4l2_subdev_state *state,
>>>>                     struct v4l2_subdev_selection *sel);
>>>> @@ -1494,6 +1501,23 @@ v4l2_subdev_lock_and_get_active_state(struct v4l2_subdev *sd)
>>>>    int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>>>                struct v4l2_subdev_format *format);
>>>>    +/**
>>>> + * v4l2_subdev_get_vc() - Fill virtual channel based on state
>>>> + * @sd: subdevice
>>>> + * @state: subdevice state
>>>> + * @vc: pointer to &struct v4l2_subdev_vc
>>>> + *
>>>> + * Fill @vc->vc field based on the information in the @vc struct.
>>>> + *
>>>> + * This function can be used by the subdev drivers which support active state to
>>>> + * implement v4l2_subdev_pad_ops.get_vc if the subdev driver does not need to
>>>> + * do anything special in their get_vc op.
>>>> + *
>>>> + * Returns 0 on success, error value otherwise.
>>>> + */
>>>> +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>>> +               struct v4l2_subdev_vc *vc);
>>>> +
>>>>    /**
>>>>     * v4l2_subdev_set_routing() - Set given routing to subdev state
>>>>     * @sd: The subdevice
>>>> @@ -1585,6 +1609,21 @@ struct v4l2_rect *
>>>>    v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>>>>                         unsigned int pad, u32 stream);
>>>>    +/**
>>>> + * v4l2_subdev_state_get_stream_vc() - Get the virtual channel of a stream
>>>> + * @state: subdevice state
>>>> + * @pad: pad id
>>>> + * @stream: stream id
>>>> + *
>>>> + * This returns the virtual channel for the given pad + stream in the
>>>> + * subdev state.
>>>> + *
>>>> + * If the state does not contain the given pad + stream, 0 is returned.
>>>> + */
>>>> +u32
>>>> +v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
>>>> +                unsigned int pad, u32 stream);
>>>> +
>>>>    /**
>>>>     * v4l2_subdev_routing_find_opposite_end() - Find the opposite stream
>>>>     * @routing: routing used to find the opposite side
>>>> diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
>>>> index b383c2fe0cf3..8e90405bb1e6 100644
>>>> --- a/include/uapi/linux/v4l2-subdev.h
>>>> +++ b/include/uapi/linux/v4l2-subdev.h
>>>> @@ -187,6 +187,22 @@ struct v4l2_subdev_capability {
>>>>        __u32 reserved[14];
>>>>    };
>>>>    +/**
>>>> + * struct v4l2_subdev_vc - Pad-level virtual channel settings
>>>> + * @which: format type (from enum v4l2_subdev_format_whence)
>>>> + * @pad: pad number, as reported by the media API
>>>> + * @vc: virtual channel
>>>> + * @stream: stream number, defined in subdev routing
>>>> + * @reserved: drivers and applications must zero this array
>>>> + */
>>>> +struct v4l2_subdev_vc {
>>>> +    __u32 which;
>>>> +    __u32 pad;
>>>> +    __u32 vc;
>>>> +    __u32 stream;
>>>> +    __u32 reserved[7];
>>>> +};
>>>> +
>>>>    /* The v4l2 sub-device video device node is registered in read-only mode. */
>>>>    #define V4L2_SUBDEV_CAP_RO_SUBDEV        0x00000001
>>>>    @@ -268,6 +284,8 @@ struct v4l2_subdev_client_capability {
>>>>    #define VIDIOC_SUBDEV_S_SELECTION        _IOWR('V', 62, struct v4l2_subdev_selection)
>>>>    #define VIDIOC_SUBDEV_G_ROUTING            _IOWR('V', 38, struct v4l2_subdev_routing)
>>>>    #define VIDIOC_SUBDEV_S_ROUTING            _IOWR('V', 39, struct v4l2_subdev_routing)
>>>> +#define VIDIOC_SUBDEV_G_VC            _IOWR('V', 40, struct v4l2_subdev_vc)
>>>> +#define VIDIOC_SUBDEV_S_VC            _IOWR('V', 41, struct v4l2_subdev_vc)
>>>>    #define VIDIOC_SUBDEV_G_CLIENT_CAP        _IOR('V',  101, struct v4l2_subdev_client_capability)
>>>>    #define VIDIOC_SUBDEV_S_CLIENT_CAP        _IOWR('V',  102, struct v4l2_subdev_client_capability)
>>>>    
>>>
>
--------------mc3GFwLRzhlonFEzaB54iAQ2
Content-Type: application/msword-template; name="graph.dot"
Content-Disposition: attachment; filename="graph.dot"
Content-Transfer-Encoding: base64

ZGlncmFwaCBib2FyZCB7CglyYW5rZGlyPVRCCgluMDAwMDAwMDEgW2xhYmVsPSJ7ezxwb3J0
MD4gMCB8IDxwb3J0MT4gMSB8IDxwb3J0Mj4gMn0gfCBjcm9zc2JhclxuL2Rldi92NGwtc3Vi
ZGV2MCB8IHs8cG9ydDM+IDMgfCA8cG9ydDQ+IDR9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxl
PWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMDAxOnBvcnQzIC0+IG4wMDAwMDAw
Nzpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDAwMTpwb3J0NCAtPiBuMDAwMDAwMTI6cG9y
dDAgW3N0eWxlPWJvbGRdCgluMDAwMDAwMDcgW2xhYmVsPSJ7ezxwb3J0MD4gMH0gfCBteGNf
aXNpLjBcbi9kZXYvdjRsLXN1YmRldjEgfCB7PHBvcnQxPiAxfX0iLCBzaGFwZT1NcmVjb3Jk
LCBzdHlsZT1maWxsZWQsIGZpbGxjb2xvcj1ncmVlbl0KCW4wMDAwMDAwNzpwb3J0MSAtPiBu
MDAwMDAwMGEgW3N0eWxlPWJvbGRdCgluMDAwMDAwMGEgW2xhYmVsPSJteGNfaXNpLjAuY2Fw
dHVyZVxuL2Rldi92aWRlbzAiLCBzaGFwZT1ib3gsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9y
PXllbGxvd10KCW4wMDAwMDAxMiBbbGFiZWw9Int7PHBvcnQwPiAwfSB8IG14Y19pc2kuMVxu
L2Rldi92NGwtc3ViZGV2MiB8IHs8cG9ydDE+IDF9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxl
PWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMDEyOnBvcnQxIC0+IG4wMDAwMDAx
NSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDAxNSBbbGFiZWw9Im14Y19pc2kuMS5jYXB0dXJlXG4v
ZGV2L3ZpZGVvMSIsIHNoYXBlPWJveCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9eWVsbG93
XQoJbjAwMDAwMDFkIFtsYWJlbD0ibXhjX2lzaS5vdXRwdXRcbiIsIHNoYXBlPWJveCwgc3R5
bGU9ZmlsbGVkLCBmaWxsY29sb3I9eWVsbG93XQoJbjAwMDAwMDFkIC0+IG4wMDAwMDAwMTpw
b3J0MiBbc3R5bGU9Ym9sZF0KCW4wMDAwMDAyNCBbbGFiZWw9Int7PHBvcnQwPiAwfSB8IGNz
aXMtMzJlNTAwMDAuY3NpXG4vZGV2L3Y0bC1zdWJkZXYzIHwgezxwb3J0MT4gMX19Iiwgc2hh
cGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwMjQ6
cG9ydDEgLT4gbjAwMDAwMDAxOnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMDI5IFtsYWJl
bD0ie3s8cG9ydDA+IDB9IHwgY3Npcy0zMmU0MDAwMC5jc2lcbi9kZXYvdjRsLXN1YmRldjQg
fCB7PHBvcnQxPiAxfX0iLCBzaGFwZT1NcmVjb3JkLCBzdHlsZT1maWxsZWQsIGZpbGxjb2xv
cj1ncmVlbl0KCW4wMDAwMDAyOTpwb3J0MSAtPiBuMDAwMDAwMDE6cG9ydDAgW3N0eWxlPWJv
bGRdCgluMDAwMDAwMmUgW2xhYmVsPSJ7ezxwb3J0MT4gMX0gfCBkZXMgcGh5MVxuL2Rldi92
NGwtc3ViZGV2NSB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxl
ZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMDJlOnBvcnQwIC0+IG4wMDAwMDAyOTpwb3J0
MCBbc3R5bGU9ZGFzaGVkXQoJbjAwMDAwMDMzIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgZGVz
IHBoeTJcbi9kZXYvdjRsLXN1YmRldjE2IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29y
ZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwMzM6cG9ydDAgLT4g
bjAwMDAwMDI0OnBvcnQwIFtzdHlsZT1kYXNoZWRdCgluMDAwMDAwMzYgW2xhYmVsPSJ7ezxw
b3J0MT4gMX0gfCBkZXMgcGlwZTBcbi9kZXYvdjRsLXN1YmRldjYgfCB7PHBvcnQwPiAwfX0i
LCBzaGFwZT1NcmVjb3JkLCBzdHlsZT1maWxsZWQsIGZpbGxjb2xvcj1ncmVlbl0KCW4wMDAw
MDAzNjpwb3J0MCAtPiBuMDAwMDAwNGU6cG9ydDQgW3N0eWxlPWJvbGRdCgluMDAwMDAwMzkg
W2xhYmVsPSJ7ezxwb3J0MT4gMX0gfCBkZXMgcGlwZTFcbi9kZXYvdjRsLXN1YmRldjcgfCB7
PHBvcnQwPiAwfX0iLCBzaGFwZT1NcmVjb3JkLCBzdHlsZT1maWxsZWQsIGZpbGxjb2xvcj1n
cmVlbl0KCW4wMDAwMDAzOTpwb3J0MCAtPiBuMDAwMDAwNGU6cG9ydDUgW3N0eWxlPWJvbGRd
CgluMDAwMDAwM2MgW2xhYmVsPSJ7ezxwb3J0MT4gMX0gfCBkZXMgcGlwZTJcbi9kZXYvdjRs
LXN1YmRldjggfCB7PHBvcnQwPiAwfX0iLCBzaGFwZT1NcmVjb3JkLCBzdHlsZT1maWxsZWQs
IGZpbGxjb2xvcj1ncmVlbl0KCW4wMDAwMDAzYzpwb3J0MCAtPiBuMDAwMDAwNGU6cG9ydDYg
W3N0eWxlPWJvbGRdCgluMDAwMDAwM2YgW2xhYmVsPSJ7ezxwb3J0MT4gMX0gfCBkZXMgcGlw
ZTNcbi9kZXYvdjRsLXN1YmRldjkgfCB7PHBvcnQwPiAwfX0iLCBzaGFwZT1NcmVjb3JkLCBz
dHlsZT1maWxsZWQsIGZpbGxjb2xvcj1ncmVlbl0KCW4wMDAwMDAzZjpwb3J0MCAtPiBuMDAw
MDAwNGU6cG9ydDcgW3N0eWxlPWJvbGRdCgluMDAwMDAwNDIgW2xhYmVsPSJ7ezxwb3J0MD4g
MH0gfCBkZXMgbGluazBcbi9kZXYvdjRsLXN1YmRldjEwIHwgezxwb3J0MT4gMX19Iiwgc2hh
cGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwNDI6
cG9ydDEgLT4gbjAwMDAwMDYzOnBvcnQ0IFtzdHlsZT1ib2xkXQoJbjAwMDAwMDQ1IFtsYWJl
bD0ie3s8cG9ydDA+IDB9IHwgZGVzIGxpbmsxXG4vZGV2L3Y0bC1zdWJkZXYxMSB8IHs8cG9y
dDE+IDF9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVu
XQoJbjAwMDAwMDQ1OnBvcnQxIC0+IG4wMDAwMDA2Mzpwb3J0NSBbc3R5bGU9Ym9sZF0KCW4w
MDAwMDA0OCBbbGFiZWw9Int7PHBvcnQwPiAwfSB8IGRlcyBsaW5rMlxuL2Rldi92NGwtc3Vi
ZGV2MTIgfCB7PHBvcnQxPiAxfX0iLCBzaGFwZT1NcmVjb3JkLCBzdHlsZT1maWxsZWQsIGZp
bGxjb2xvcj1ncmVlbl0KCW4wMDAwMDA0ODpwb3J0MSAtPiBuMDAwMDAwNjM6cG9ydDYgW3N0
eWxlPWJvbGRdCgluMDAwMDAwNGIgW2xhYmVsPSJ7ezxwb3J0MD4gMH0gfCBkZXMgbGluazNc
bi9kZXYvdjRsLXN1YmRldjEzIHwgezxwb3J0MT4gMX19Iiwgc2hhcGU9TXJlY29yZCwgc3R5
bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwNGI6cG9ydDEgLT4gbjAwMDAw
MDYzOnBvcnQ3IFtzdHlsZT1ib2xkXQoJbjAwMDAwMDRlIFtsYWJlbD0ie3s8cG9ydDQ+IDQg
fCA8cG9ydDU+IDUgfCA8cG9ydDY+IDYgfCA8cG9ydDc+IDd9IHwgZGVzIHBpcGVfcGh5X3hi
YXIwXG4vZGV2L3Y0bC1zdWJkZXYxNCB8IHs8cG9ydDA+IDAgfCA8cG9ydDE+IDEgfCA8cG9y
dDI+IDIgfCA8cG9ydDM+IDN9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmls
bGNvbG9yPWdyZWVuXQoJbjAwMDAwMDRlOnBvcnQxIC0+IG4wMDAwMDAyZTpwb3J0MSBbc3R5
bGU9Ym9sZF0KCW4wMDAwMDA0ZTpwb3J0MiAtPiBuMDAwMDAwMzM6cG9ydDEgW3N0eWxlPWJv
bGRdCgluMDAwMDAwNjMgW2xhYmVsPSJ7ezxwb3J0ND4gNCB8IDxwb3J0NT4gNSB8IDxwb3J0
Nj4gNiB8IDxwb3J0Nz4gN30gfCBkZXMgbGlua19waXBlX3hiYXIwXG4vZGV2L3Y0bC1zdWJk
ZXYxNSB8IHs8cG9ydDA+IDAgfCA8cG9ydDE+IDEgfCA8cG9ydDI+IDIgfCA8cG9ydDM+IDN9
fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAw
MDAwMDYzOnBvcnQwIC0+IG4wMDAwMDAzNjpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDA2
Mzpwb3J0MSAtPiBuMDAwMDAwMzk6cG9ydDEgW3N0eWxlPWJvbGRdCgluMDAwMDAwNjM6cG9y
dDIgLT4gbjAwMDAwMDNjOnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMDYzOnBvcnQzIC0+
IG4wMDAwMDAzZjpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDA3ZSBbbGFiZWw9Int7PHBv
cnQxPiAxIHwgPHBvcnQyPiAyIHwgPHBvcnQzPiAzIHwgPHBvcnQ0PiA0fSB8IHNlcl8wIGxp
bmswXG4vZGV2L3Y0bC1zdWJkZXYyNCB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1yZWNvcmQs
IHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMDdlOnBvcnQwIC0+IG4w
MDAwMDA0Mjpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDA4NCBbbGFiZWw9Int7PHBvcnQw
PiAwfSB8IHNlcl8wIHBoeTBcbi9kZXYvdjRsLXN1YmRldjE3IHwgezxwb3J0MT4gMX19Iiwg
c2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAw
ODQ6cG9ydDEgLT4gbjAwMDAwMDkzOnBvcnQ0IFtzdHlsZT1ib2xkXQoJbjAwMDAwMDg3IFts
YWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzAgcGlwZTBcbi9kZXYvdjRsLXN1YmRldjE4IHwg
ezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9
Z3JlZW5dCgluMDAwMDAwODc6cG9ydDAgLT4gbjAwMDAwMGEzOnBvcnQ0IFtzdHlsZT1ib2xk
XQoJbjAwMDAwMDhhIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzAgcGlwZTFcbi9kZXYv
djRsLXN1YmRldjE5IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9Zmls
bGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwOGE6cG9ydDAgLT4gbjAwMDAwMGEzOnBv
cnQ1IFtzdHlsZT1ib2xkXQoJbjAwMDAwMDhkIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2Vy
XzAgcGlwZTJcbi9kZXYvdjRsLXN1YmRldjIwIHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJl
Y29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwOGQ6cG9ydDAg
LT4gbjAwMDAwMGEzOnBvcnQ2IFtzdHlsZT1ib2xkXQoJbjAwMDAwMDkwIFtsYWJlbD0ie3s8
cG9ydDE+IDF9IHwgc2VyXzAgcGlwZTNcbi9kZXYvdjRsLXN1YmRldjIxIHwgezxwb3J0MD4g
MH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCglu
MDAwMDAwOTA6cG9ydDAgLT4gbjAwMDAwMGEzOnBvcnQ3IFtzdHlsZT1ib2xkXQoJbjAwMDAw
MDkzIFtsYWJlbD0ie3s8cG9ydDQ+IDR9IHwgc2VyXzAgcGh5X3BpcGVfeGJhcjBcbi9kZXYv
djRsLXN1YmRldjIyIHwgezxwb3J0MD4gMCB8IDxwb3J0MT4gMSB8IDxwb3J0Mj4gMiB8IDxw
b3J0Mz4gM319Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3Jl
ZW5dCgluMDAwMDAwOTM6cG9ydDAgLT4gbjAwMDAwMDg3OnBvcnQxIFtzdHlsZT1ib2xkXQoJ
bjAwMDAwMDkzOnBvcnQxIC0+IG4wMDAwMDA4YTpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAw
MDA5Mzpwb3J0MiAtPiBuMDAwMDAwOGQ6cG9ydDEgW3N0eWxlPWJvbGRdCgluMDAwMDAwOTM6
cG9ydDMgLT4gbjAwMDAwMDkwOnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMGEzIFtsYWJl
bD0ie3s8cG9ydDQ+IDQgfCA8cG9ydDU+IDUgfCA8cG9ydDY+IDYgfCA8cG9ydDc+IDd9IHwg
c2VyXzAgcGlwZV9saW5rX3hiYXIwXG4vZGV2L3Y0bC1zdWJkZXYyMyB8IHs8cG9ydDA+IDAg
fCA8cG9ydDE+IDEgfCA8cG9ydDI+IDIgfCA8cG9ydDM+IDN9fSIsIHNoYXBlPU1yZWNvcmQs
IHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMGEzOnBvcnQwIC0+IG4w
MDAwMDA3ZTpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDBhMzpwb3J0MSAtPiBuMDAwMDAw
N2U6cG9ydDIgW3N0eWxlPWJvbGRdCgluMDAwMDAwYTM6cG9ydDIgLT4gbjAwMDAwMDdlOnBv
cnQzIFtzdHlsZT1ib2xkXQoJbjAwMDAwMGEzOnBvcnQzIC0+IG4wMDAwMDA3ZTpwb3J0NCBb
c3R5bGU9Ym9sZF0KCW4wMDAwMDBiZSBbbGFiZWw9Int7PHBvcnQxPiAxIHwgPHBvcnQyPiAy
IHwgPHBvcnQzPiAzIHwgPHBvcnQ0PiA0fSB8IHNlcl8xIGxpbmswXG4vZGV2L3Y0bC1zdWJk
ZXYzMiB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmls
bGNvbG9yPWdyZWVuXQoJbjAwMDAwMGJlOnBvcnQwIC0+IG4wMDAwMDA0NTpwb3J0MCBbc3R5
bGU9Ym9sZF0KCW4wMDAwMDBjNCBbbGFiZWw9Int7PHBvcnQwPiAwfSB8IHNlcl8xIHBoeTBc
bi9kZXYvdjRsLXN1YmRldjI1IHwgezxwb3J0MT4gMX19Iiwgc2hhcGU9TXJlY29yZCwgc3R5
bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwYzQ6cG9ydDEgLT4gbjAwMDAw
MGQzOnBvcnQ0IFtzdHlsZT1ib2xkXQoJbjAwMDAwMGM3IFtsYWJlbD0ie3s8cG9ydDE+IDF9
IHwgc2VyXzEgcGlwZTBcbi9kZXYvdjRsLXN1YmRldjI2IHwgezxwb3J0MD4gMH19Iiwgc2hh
cGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwYzc6
cG9ydDAgLT4gbjAwMDAwMGUzOnBvcnQ0IFtzdHlsZT1ib2xkXQoJbjAwMDAwMGNhIFtsYWJl
bD0ie3s8cG9ydDE+IDF9IHwgc2VyXzEgcGlwZTFcbi9kZXYvdjRsLXN1YmRldjI3IHwgezxw
b3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3Jl
ZW5dCgluMDAwMDAwY2E6cG9ydDAgLT4gbjAwMDAwMGUzOnBvcnQ1IFtzdHlsZT1ib2xkXQoJ
bjAwMDAwMGNkIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzEgcGlwZTJcbi9kZXYvdjRs
LXN1YmRldjI4IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVk
LCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwY2Q6cG9ydDAgLT4gbjAwMDAwMGUzOnBvcnQ2
IFtzdHlsZT1ib2xkXQoJbjAwMDAwMGQwIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzEg
cGlwZTNcbi9kZXYvdjRsLXN1YmRldjI5IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29y
ZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwZDA6cG9ydDAgLT4g
bjAwMDAwMGUzOnBvcnQ3IFtzdHlsZT1ib2xkXQoJbjAwMDAwMGQzIFtsYWJlbD0ie3s8cG9y
dDQ+IDR9IHwgc2VyXzEgcGh5X3BpcGVfeGJhcjBcbi9kZXYvdjRsLXN1YmRldjMwIHwgezxw
b3J0MD4gMCB8IDxwb3J0MT4gMSB8IDxwb3J0Mj4gMiB8IDxwb3J0Mz4gM319Iiwgc2hhcGU9
TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAwZDM6cG9y
dDAgLT4gbjAwMDAwMGM3OnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMGQzOnBvcnQxIC0+
IG4wMDAwMDBjYTpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDBkMzpwb3J0MiAtPiBuMDAw
MDAwY2Q6cG9ydDEgW3N0eWxlPWJvbGRdCgluMDAwMDAwZDM6cG9ydDMgLT4gbjAwMDAwMGQw
OnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMGUzIFtsYWJlbD0ie3s8cG9ydDQ+IDQgfCA8
cG9ydDU+IDUgfCA8cG9ydDY+IDYgfCA8cG9ydDc+IDd9IHwgc2VyXzEgcGlwZV9saW5rX3hi
YXIwXG4vZGV2L3Y0bC1zdWJkZXYzMSB8IHs8cG9ydDA+IDAgfCA8cG9ydDE+IDEgfCA8cG9y
dDI+IDIgfCA8cG9ydDM+IDN9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmls
bGNvbG9yPWdyZWVuXQoJbjAwMDAwMGUzOnBvcnQwIC0+IG4wMDAwMDBiZTpwb3J0MSBbc3R5
bGU9Ym9sZF0KCW4wMDAwMDBlMzpwb3J0MSAtPiBuMDAwMDAwYmU6cG9ydDIgW3N0eWxlPWJv
bGRdCgluMDAwMDAwZTM6cG9ydDIgLT4gbjAwMDAwMGJlOnBvcnQzIFtzdHlsZT1ib2xkXQoJ
bjAwMDAwMGUzOnBvcnQzIC0+IG4wMDAwMDBiZTpwb3J0NCBbc3R5bGU9Ym9sZF0KCW4wMDAw
MDBmZSBbbGFiZWw9Int7PHBvcnQxPiAxIHwgPHBvcnQyPiAyIHwgPHBvcnQzPiAzIHwgPHBv
cnQ0PiA0fSB8IHNlcl8yIGxpbmswXG4vZGV2L3Y0bC1zdWJkZXYzNyB8IHs8cG9ydDA+IDB9
fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAw
MDAwMGZlOnBvcnQwIC0+IG4wMDAwMDA0ODpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDEw
NCBbbGFiZWw9Int7PHBvcnQwPiAwfSB8IHNlcl8yIHBoeTBcbi9kZXYvdjRsLXN1YmRldjMz
IHwgezxwb3J0MT4gMX19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29s
b3I9Z3JlZW5dCgluMDAwMDAxMDQ6cG9ydDEgLT4gbjAwMDAwMTBhOnBvcnQxIFtzdHlsZT1i
b2xkXQoJbjAwMDAwMTA3IFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzIgcGlwZTBcbi9k
ZXYvdjRsLXN1YmRldjM0IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9
ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAxMDc6cG9ydDAgLT4gbjAwMDAwMTEx
OnBvcnQ0IFtzdHlsZT1ib2xkXQoJbjAwMDAwMTBhIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwg
c2VyXzIgcGh5X3BpcGVfeGJhcjBcbi9kZXYvdjRsLXN1YmRldjM1IHwgezxwb3J0MD4gMH19
Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAw
MDAxMGE6cG9ydDAgLT4gbjAwMDAwMTA3OnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMTEx
IFtsYWJlbD0ie3s8cG9ydDQ+IDR9IHwgc2VyXzIgcGlwZV9saW5rX3hiYXIwXG4vZGV2L3Y0
bC1zdWJkZXYzNiB8IHs8cG9ydDA+IDAgfCA8cG9ydDE+IDEgfCA8cG9ydDI+IDIgfCA8cG9y
dDM+IDN9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVu
XQoJbjAwMDAwMTExOnBvcnQwIC0+IG4wMDAwMDBmZTpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4w
MDAwMDExMTpwb3J0MSAtPiBuMDAwMDAwZmU6cG9ydDIgW3N0eWxlPWJvbGRdCgluMDAwMDAx
MTE6cG9ydDIgLT4gbjAwMDAwMGZlOnBvcnQzIFtzdHlsZT1ib2xkXQoJbjAwMDAwMTExOnBv
cnQzIC0+IG4wMDAwMDBmZTpwb3J0NCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDEyMyBbbGFiZWw9
Int7PHBvcnQxPiAxIHwgPHBvcnQyPiAyIHwgPHBvcnQzPiAzIHwgPHBvcnQ0PiA0fSB8IHNl
cl8zIGxpbmswXG4vZGV2L3Y0bC1zdWJkZXY0MiB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1y
ZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMTIzOnBvcnQw
IC0+IG4wMDAwMDA0Yjpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDEyOSBbbGFiZWw9Int7
PHBvcnQwPiAwfSB8IHNlcl8zIHBoeTBcbi9kZXYvdjRsLXN1YmRldjM4IHwgezxwb3J0MT4g
MX19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCglu
MDAwMDAxMjk6cG9ydDEgLT4gbjAwMDAwMTJmOnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAw
MTJjIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzMgcGlwZTBcbi9kZXYvdjRsLXN1YmRl
djM5IHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJlY29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxs
Y29sb3I9Z3JlZW5dCgluMDAwMDAxMmM6cG9ydDAgLT4gbjAwMDAwMTM2OnBvcnQ0IFtzdHls
ZT1ib2xkXQoJbjAwMDAwMTJmIFtsYWJlbD0ie3s8cG9ydDE+IDF9IHwgc2VyXzMgcGh5X3Bp
cGVfeGJhcjBcbi9kZXYvdjRsLXN1YmRldjQwIHwgezxwb3J0MD4gMH19Iiwgc2hhcGU9TXJl
Y29yZCwgc3R5bGU9ZmlsbGVkLCBmaWxsY29sb3I9Z3JlZW5dCgluMDAwMDAxMmY6cG9ydDAg
LT4gbjAwMDAwMTJjOnBvcnQxIFtzdHlsZT1ib2xkXQoJbjAwMDAwMTM2IFtsYWJlbD0ie3s8
cG9ydDQ+IDR9IHwgc2VyXzMgcGlwZV9saW5rX3hiYXIwXG4vZGV2L3Y0bC1zdWJkZXY0MSB8
IHs8cG9ydDA+IDAgfCA8cG9ydDE+IDEgfCA8cG9ydDI+IDIgfCA8cG9ydDM+IDN9fSIsIHNo
YXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMTM2
OnBvcnQwIC0+IG4wMDAwMDEyMzpwb3J0MSBbc3R5bGU9Ym9sZF0KCW4wMDAwMDEzNjpwb3J0
MSAtPiBuMDAwMDAxMjM6cG9ydDIgW3N0eWxlPWJvbGRdCgluMDAwMDAxMzY6cG9ydDIgLT4g
bjAwMDAwMTIzOnBvcnQzIFtzdHlsZT1ib2xkXQoJbjAwMDAwMTM2OnBvcnQzIC0+IG4wMDAw
MDEyMzpwb3J0NCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDE0OCBbbGFiZWw9Int7fSB8IG92eDAz
YSAxMC0wMDM2XG4vZGV2L3Y0bC1zdWJkZXY0MyB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1y
ZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAwMTQ4OnBvcnQw
IC0+IG4wMDAwMDA4NDpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDE0YyBbbGFiZWw9Int7
fSB8IG92eDAzYSAxMS0wMDM2XG4vZGV2L3Y0bC1zdWJkZXY0NCB8IHs8cG9ydDA+IDB9fSIs
IHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVuXQoJbjAwMDAw
MTRjOnBvcnQwIC0+IG4wMDAwMDBjNDpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4wMDAwMDE1MCBb
bGFiZWw9Int7fSB8IG92eDAzYSAxMi0wMDM2XG4vZGV2L3Y0bC1zdWJkZXY0NSB8IHs8cG9y
dDA+IDB9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNvbG9yPWdyZWVu
XQoJbjAwMDAwMTUwOnBvcnQwIC0+IG4wMDAwMDEwNDpwb3J0MCBbc3R5bGU9Ym9sZF0KCW4w
MDAwMDE1NCBbbGFiZWw9Int7fSB8IG92eDAzYSAxMy0wMDM2XG4vZGV2L3Y0bC1zdWJkZXY0
NiB8IHs8cG9ydDA+IDB9fSIsIHNoYXBlPU1yZWNvcmQsIHN0eWxlPWZpbGxlZCwgZmlsbGNv
bG9yPWdyZWVuXQoJbjAwMDAwMTU0OnBvcnQwIC0+IG4wMDAwMDEyOTpwb3J0MCBbc3R5bGU9
Ym9sZF0KfQo=

--------------mc3GFwLRzhlonFEzaB54iAQ2--

