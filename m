Return-Path: <linux-kernel+bounces-22230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697D829B30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4619C1C21D78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30F48CE1;
	Wed, 10 Jan 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZkRJB60"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A148CDD;
	Wed, 10 Jan 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33678156e27so3771794f8f.1;
        Wed, 10 Jan 2024 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704893225; x=1705498025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNnBcU1UrTgTveQYjwqmT+lVQXizulPgsLCg0OM24Pw=;
        b=aZkRJB60ABFxhRdTvMuRv0v3gbeyrqpisPy8vn4phgtvSIP5qM7fJau3vvZW4GexWk
         RIvY0eYm8+/JIZyb0xj7NanT/es6gm30fPo3opk/MXsYkXjPHaH2KX2tzKSxBkE94RLV
         f8PJxrUrbLuRNqmMTrnqMpLgz/zNIutWKrWCMHvMZmRlVgjVnfTqsd8QXY/ohIs8sk/v
         9LJxO4U/ffW//qs6WFLUqUuD81ib5XxTLpZb4oXmjrjFMh1/0tSQuuc8YQ81Wwf2Xvou
         9bjPvNrYrUaXrNWmYCFuQPFKdM6IO/iUPaszra/f0r4AX4ZB6JSnXm4g5SLGiriRCO9D
         TgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893225; x=1705498025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNnBcU1UrTgTveQYjwqmT+lVQXizulPgsLCg0OM24Pw=;
        b=HGch7iLv8BL65RUehFRs3EuuP5BkCZvW95qPvnAa17ep24Pqyf8DQZGXkh4sAK/fnE
         UjabM/cSJ5FhO0c5wOvXgYrZRQU1wPwQ0F2tt3h/WBdr1MgJoC48rjyPDnJA2nZ/Df8z
         f4g7dhprJ5cwMFYETGzGuOJxxXQtNYXYXJBcL02PQS3f96LbSh5QFDMHlG8ku9FAxEiI
         Sh9+2JlQDPzOw1BqugCE2xkG/bbeyK3GqbvqizaWw/3HsROtr/yzb3g1bcCjeKi1ii+z
         9FUSgKi5w8Tqvyut3suAVz0QNVL2Zk7l2oDYExT50UKEQmL9JDAJ9fsKd6TgwFzRrXx+
         7pVA==
X-Gm-Message-State: AOJu0Yz0miQ82mnyK/4V98SrFhznbnUpYHSn+xph21iSEDwLS6aBTKBo
	sZQXtmTD8cJ7K6MDF5ygFDw=
X-Google-Smtp-Source: AGHT+IEUimGzZQyfHMOy6cq6O/Y/PrEnDer34bwL8vAi+h1qHYMUhmJxsbg0VG26aAKW/IHi1SH8Ug==
X-Received: by 2002:a5d:530e:0:b0:336:6e42:ec4 with SMTP id e14-20020a5d530e000000b003366e420ec4mr543819wrv.107.1704893225136;
        Wed, 10 Jan 2024 05:27:05 -0800 (PST)
Received: from [10.76.84.150] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id cr8-20020a05600004e800b00336673a4153sm4901687wrb.80.2024.01.10.05.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:27:04 -0800 (PST)
Message-ID: <356e7696-7d12-416d-8fee-9d391b4dc3b3@gmail.com>
Date: Wed, 10 Jan 2024 15:27:03 +0200
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
From: Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <0b85defe-c334-4317-9057-5db45a480841@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Tomi.

The usecase for this is crossbar devices that allow for mapping virtual channel

ids dynamically.

The remapping happens based on VC and DT. DT can be determined based on

the pixel code, but VC has no way of being determined at runtime through

standard V4L2 APIs.

The alternative would be to hardcode them in device tree, which is not very

nice, and cannot account for all possible user configurations.

I'm aware that VC is a bus-specific feature, which is why this is an RFC.

Having a V4L2 implementation would solve a lot of devices having to

hardcode VCs.


On 1/10/24 14:50, Tomi Valkeinen wrote:
> Hi!
>
> On 10/01/2024 14:51, Cosmin Tanislav wrote:
>> With experimental support for multiple streams per pad being added, the
>> pieces are in place to support a virtual channel id per stream.
>>
>> This is necessary because stream ids cannot be directly mapped to a virtual
>> channel id, since the same virtual channel id can be assigned to multiple
>> streams of data, each with a different data type.
>>
>> To implement this, the following steps have been taken.
>>
>> Add subdev ioctls for getting and setting the virtual channel for a
>> specific pad and stream.
>>
>> Add pad .get_vc() and .set_vc() ops.
>>
>> Add the virtual channel to the stream config in V4L2 subdev central state.
>>
>> Add a default .get_vc() implementation that retrieves the virtual channel
>> from the central state, or, if that is not supported, default to virtual
>> channel 0.
>
> Why do you need this?
>
> The design idea with streams was that the streams are not tied to CSI-2 streams (or to any specific HW). The CSI-2 virtual channels should be handled by the drivers internally, and they should not be visible to the userspace at all.
>
>  Tomi
>
>> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 57 +++++++++++++++++++++++++++
>>   include/media/v4l2-subdev.h           | 39 ++++++++++++++++++
>>   include/uapi/linux/v4l2-subdev.h      | 18 +++++++++
>>   3 files changed, 114 insertions(+)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>> index be86b906c985..8945bfd0fe12 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -535,6 +535,9 @@ subdev_ioctl_get_state(struct v4l2_subdev *sd, struct v4l2_subdev_fh *subdev_fh,
>>       case VIDIOC_SUBDEV_S_ROUTING:
>>           which = ((struct v4l2_subdev_routing *)arg)->which;
>>           break;
>> +    case VIDIOC_SUBDEV_G_VC:
>> +    case VIDIOC_SUBDEV_S_VC:
>> +        which = ((struct v4l2_subdev_vc *)arg)->which;
>>       }
>>         return which == V4L2_SUBDEV_FORMAT_TRY ?
>> @@ -969,6 +972,26 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>>                       routing->which, &krouting);
>>       }
>>   +    case VIDIOC_SUBDEV_G_VC: {
>> +        struct v4l2_subdev_vc *vc = arg;
>> +
>> +        if (!client_supports_streams)
>> +            vc->stream = 0;
>> +
>> +        memset(vc->reserved, 0, sizeof(vc->reserved));
>> +        return v4l2_subdev_call(sd, pad, get_vc, state, vc);
>> +    }
>> +
>> +    case VIDIOC_SUBDEV_S_VC: {
>> +        struct v4l2_subdev_vc *vc = arg;
>> +
>> +        if (!client_supports_streams)
>> +            vc->stream = 0;
>> +
>> +        memset(vc->reserved, 0, sizeof(vc->reserved));
>> +        return v4l2_subdev_call(sd, pad, set_vc, state, vc);
>> +    }
>> +
>>       case VIDIOC_SUBDEV_G_CLIENT_CAP: {
>>           struct v4l2_subdev_client_capability *client_cap = arg;
>>   @@ -1602,6 +1625,20 @@ int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_subdev_get_fmt);
>>   +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>> +               struct v4l2_subdev_vc *vc)
>> +{
>> +    u32 vc_id = 0;
>> +
>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS)
>> +        vc_id = v4l2_subdev_state_get_stream_vc(state, vc->pad, vc->stream);
>> +
>> +    vc->vc = vc_id;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(v4l2_subdev_get_vc);
>> +
>>   int v4l2_subdev_set_routing(struct v4l2_subdev *sd,
>>                   struct v4l2_subdev_state *state,
>>                   const struct v4l2_subdev_krouting *routing)
>> @@ -1745,6 +1782,26 @@ v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_compose);
>>   +u32 v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
>> +                    unsigned int pad, u32 stream)
>> +{
>> +    struct v4l2_subdev_stream_configs *stream_configs;
>> +    unsigned int i;
>> +
>> +    lockdep_assert_held(state->lock);
>> +
>> +    stream_configs = &state->stream_configs;
>> +
>> +    for (i = 0; i < stream_configs->num_configs; ++i) {
>> +        if (stream_configs->configs[i].pad == pad &&
>> +            stream_configs->configs[i].stream == stream)
>> +            return stream_configs->configs[i].vc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_vc);
>> +
>>   int v4l2_subdev_routing_find_opposite_end(const struct v4l2_subdev_krouting *routing,
>>                         u32 pad, u32 stream, u32 *other_pad,
>>                         u32 *other_stream)
>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
>> index c1f90c1223a7..ed1fdd79c2bb 100644
>> --- a/include/media/v4l2-subdev.h
>> +++ b/include/media/v4l2-subdev.h
>> @@ -722,6 +722,7 @@ struct v4l2_subdev_stream_config {
>>       u32 stream;
>>       bool enabled;
>>   +    u32 vc;
>>       struct v4l2_mbus_framefmt fmt;
>>       struct v4l2_rect crop;
>>       struct v4l2_rect compose;
>> @@ -858,6 +859,12 @@ struct v4l2_subdev_pad_ops {
>>       int (*set_fmt)(struct v4l2_subdev *sd,
>>                  struct v4l2_subdev_state *state,
>>                  struct v4l2_subdev_format *format);
>> +    int (*get_vc)(struct v4l2_subdev *sd,
>> +              struct v4l2_subdev_state *state,
>> +              struct v4l2_subdev_vc *vc);
>> +    int (*set_vc)(struct v4l2_subdev *sd,
>> +              struct v4l2_subdev_state *state,
>> +              struct v4l2_subdev_vc *vc);
>>       int (*get_selection)(struct v4l2_subdev *sd,
>>                    struct v4l2_subdev_state *state,
>>                    struct v4l2_subdev_selection *sel);
>> @@ -1494,6 +1501,23 @@ v4l2_subdev_lock_and_get_active_state(struct v4l2_subdev *sd)
>>   int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>>               struct v4l2_subdev_format *format);
>>   +/**
>> + * v4l2_subdev_get_vc() - Fill virtual channel based on state
>> + * @sd: subdevice
>> + * @state: subdevice state
>> + * @vc: pointer to &struct v4l2_subdev_vc
>> + *
>> + * Fill @vc->vc field based on the information in the @vc struct.
>> + *
>> + * This function can be used by the subdev drivers which support active state to
>> + * implement v4l2_subdev_pad_ops.get_vc if the subdev driver does not need to
>> + * do anything special in their get_vc op.
>> + *
>> + * Returns 0 on success, error value otherwise.
>> + */
>> +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>> +               struct v4l2_subdev_vc *vc);
>> +
>>   /**
>>    * v4l2_subdev_set_routing() - Set given routing to subdev state
>>    * @sd: The subdevice
>> @@ -1585,6 +1609,21 @@ struct v4l2_rect *
>>   v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>>                        unsigned int pad, u32 stream);
>>   +/**
>> + * v4l2_subdev_state_get_stream_vc() - Get the virtual channel of a stream
>> + * @state: subdevice state
>> + * @pad: pad id
>> + * @stream: stream id
>> + *
>> + * This returns the virtual channel for the given pad + stream in the
>> + * subdev state.
>> + *
>> + * If the state does not contain the given pad + stream, 0 is returned.
>> + */
>> +u32
>> +v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
>> +                unsigned int pad, u32 stream);
>> +
>>   /**
>>    * v4l2_subdev_routing_find_opposite_end() - Find the opposite stream
>>    * @routing: routing used to find the opposite side
>> diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
>> index b383c2fe0cf3..8e90405bb1e6 100644
>> --- a/include/uapi/linux/v4l2-subdev.h
>> +++ b/include/uapi/linux/v4l2-subdev.h
>> @@ -187,6 +187,22 @@ struct v4l2_subdev_capability {
>>       __u32 reserved[14];
>>   };
>>   +/**
>> + * struct v4l2_subdev_vc - Pad-level virtual channel settings
>> + * @which: format type (from enum v4l2_subdev_format_whence)
>> + * @pad: pad number, as reported by the media API
>> + * @vc: virtual channel
>> + * @stream: stream number, defined in subdev routing
>> + * @reserved: drivers and applications must zero this array
>> + */
>> +struct v4l2_subdev_vc {
>> +    __u32 which;
>> +    __u32 pad;
>> +    __u32 vc;
>> +    __u32 stream;
>> +    __u32 reserved[7];
>> +};
>> +
>>   /* The v4l2 sub-device video device node is registered in read-only mode. */
>>   #define V4L2_SUBDEV_CAP_RO_SUBDEV        0x00000001
>>   @@ -268,6 +284,8 @@ struct v4l2_subdev_client_capability {
>>   #define VIDIOC_SUBDEV_S_SELECTION        _IOWR('V', 62, struct v4l2_subdev_selection)
>>   #define VIDIOC_SUBDEV_G_ROUTING            _IOWR('V', 38, struct v4l2_subdev_routing)
>>   #define VIDIOC_SUBDEV_S_ROUTING            _IOWR('V', 39, struct v4l2_subdev_routing)
>> +#define VIDIOC_SUBDEV_G_VC            _IOWR('V', 40, struct v4l2_subdev_vc)
>> +#define VIDIOC_SUBDEV_S_VC            _IOWR('V', 41, struct v4l2_subdev_vc)
>>   #define VIDIOC_SUBDEV_G_CLIENT_CAP        _IOR('V',  101, struct v4l2_subdev_client_capability)
>>   #define VIDIOC_SUBDEV_S_CLIENT_CAP        _IOWR('V',  102, struct v4l2_subdev_client_capability)
>>   
>

