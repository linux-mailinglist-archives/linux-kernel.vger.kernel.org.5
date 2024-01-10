Return-Path: <linux-kernel+bounces-22189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8978A829AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF646B2627E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58E4879F;
	Wed, 10 Jan 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e078sTl6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C003482E4;
	Wed, 10 Jan 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BEB07FC;
	Wed, 10 Jan 2024 13:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704890946;
	bh=089TikI/mHqxiGpYRCRA5lqKhmjSHYwQUEDLqHl2dao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e078sTl6TevbDn71HOvC4RJz3J9D7+PHttAHi5Ya8LLg8h4TvdAYyean+EjYlyLrW
	 5NUePzgcYsuaqloHzb6Lky9S6UB7bmf+zve176aPaO3wPOpPIbIeeqf3kMvF7xXVTo
	 yiVtrqpEbJHdm3NElOy6RfSXC2G6RCjA5+lTeVF8=
Message-ID: <0b85defe-c334-4317-9057-5db45a480841@ideasonboard.com>
Date: Wed, 10 Jan 2024 14:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] media: v4l: implement virtual channels
Content-Language: en-US
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240110125103.215267-1-demonsingur@gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240110125103.215267-1-demonsingur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 10/01/2024 14:51, Cosmin Tanislav wrote:
> With experimental support for multiple streams per pad being added, the
> pieces are in place to support a virtual channel id per stream.
> 
> This is necessary because stream ids cannot be directly mapped to a virtual
> channel id, since the same virtual channel id can be assigned to multiple
> streams of data, each with a different data type.
> 
> To implement this, the following steps have been taken.
> 
> Add subdev ioctls for getting and setting the virtual channel for a
> specific pad and stream.
> 
> Add pad .get_vc() and .set_vc() ops.
> 
> Add the virtual channel to the stream config in V4L2 subdev central state.
> 
> Add a default .get_vc() implementation that retrieves the virtual channel
> from the central state, or, if that is not supported, default to virtual
> channel 0.

Why do you need this?

The design idea with streams was that the streams are not tied to CSI-2 
streams (or to any specific HW). The CSI-2 virtual channels should be 
handled by the drivers internally, and they should not be visible to the 
userspace at all.

  Tomi

> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 57 +++++++++++++++++++++++++++
>   include/media/v4l2-subdev.h           | 39 ++++++++++++++++++
>   include/uapi/linux/v4l2-subdev.h      | 18 +++++++++
>   3 files changed, 114 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index be86b906c985..8945bfd0fe12 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -535,6 +535,9 @@ subdev_ioctl_get_state(struct v4l2_subdev *sd, struct v4l2_subdev_fh *subdev_fh,
>   	case VIDIOC_SUBDEV_S_ROUTING:
>   		which = ((struct v4l2_subdev_routing *)arg)->which;
>   		break;
> +	case VIDIOC_SUBDEV_G_VC:
> +	case VIDIOC_SUBDEV_S_VC:
> +		which = ((struct v4l2_subdev_vc *)arg)->which;
>   	}
>   
>   	return which == V4L2_SUBDEV_FORMAT_TRY ?
> @@ -969,6 +972,26 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>   					routing->which, &krouting);
>   	}
>   
> +	case VIDIOC_SUBDEV_G_VC: {
> +		struct v4l2_subdev_vc *vc = arg;
> +
> +		if (!client_supports_streams)
> +			vc->stream = 0;
> +
> +		memset(vc->reserved, 0, sizeof(vc->reserved));
> +		return v4l2_subdev_call(sd, pad, get_vc, state, vc);
> +	}
> +
> +	case VIDIOC_SUBDEV_S_VC: {
> +		struct v4l2_subdev_vc *vc = arg;
> +
> +		if (!client_supports_streams)
> +			vc->stream = 0;
> +
> +		memset(vc->reserved, 0, sizeof(vc->reserved));
> +		return v4l2_subdev_call(sd, pad, set_vc, state, vc);
> +	}
> +
>   	case VIDIOC_SUBDEV_G_CLIENT_CAP: {
>   		struct v4l2_subdev_client_capability *client_cap = arg;
>   
> @@ -1602,6 +1625,20 @@ int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>   }
>   EXPORT_SYMBOL_GPL(v4l2_subdev_get_fmt);
>   
> +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
> +		       struct v4l2_subdev_vc *vc)
> +{
> +	u32 vc_id = 0;
> +
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS)
> +		vc_id = v4l2_subdev_state_get_stream_vc(state, vc->pad, vc->stream);
> +
> +	vc->vc = vc_id;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_subdev_get_vc);
> +
>   int v4l2_subdev_set_routing(struct v4l2_subdev *sd,
>   			    struct v4l2_subdev_state *state,
>   			    const struct v4l2_subdev_krouting *routing)
> @@ -1745,6 +1782,26 @@ v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>   }
>   EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_compose);
>   
> +u32 v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
> +				    unsigned int pad, u32 stream)
> +{
> +	struct v4l2_subdev_stream_configs *stream_configs;
> +	unsigned int i;
> +
> +	lockdep_assert_held(state->lock);
> +
> +	stream_configs = &state->stream_configs;
> +
> +	for (i = 0; i < stream_configs->num_configs; ++i) {
> +		if (stream_configs->configs[i].pad == pad &&
> +		    stream_configs->configs[i].stream == stream)
> +			return stream_configs->configs[i].vc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_stream_vc);
> +
>   int v4l2_subdev_routing_find_opposite_end(const struct v4l2_subdev_krouting *routing,
>   					  u32 pad, u32 stream, u32 *other_pad,
>   					  u32 *other_stream)
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index c1f90c1223a7..ed1fdd79c2bb 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -722,6 +722,7 @@ struct v4l2_subdev_stream_config {
>   	u32 stream;
>   	bool enabled;
>   
> +	u32 vc;
>   	struct v4l2_mbus_framefmt fmt;
>   	struct v4l2_rect crop;
>   	struct v4l2_rect compose;
> @@ -858,6 +859,12 @@ struct v4l2_subdev_pad_ops {
>   	int (*set_fmt)(struct v4l2_subdev *sd,
>   		       struct v4l2_subdev_state *state,
>   		       struct v4l2_subdev_format *format);
> +	int (*get_vc)(struct v4l2_subdev *sd,
> +		      struct v4l2_subdev_state *state,
> +		      struct v4l2_subdev_vc *vc);
> +	int (*set_vc)(struct v4l2_subdev *sd,
> +		      struct v4l2_subdev_state *state,
> +		      struct v4l2_subdev_vc *vc);
>   	int (*get_selection)(struct v4l2_subdev *sd,
>   			     struct v4l2_subdev_state *state,
>   			     struct v4l2_subdev_selection *sel);
> @@ -1494,6 +1501,23 @@ v4l2_subdev_lock_and_get_active_state(struct v4l2_subdev *sd)
>   int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
>   			struct v4l2_subdev_format *format);
>   
> +/**
> + * v4l2_subdev_get_vc() - Fill virtual channel based on state
> + * @sd: subdevice
> + * @state: subdevice state
> + * @vc: pointer to &struct v4l2_subdev_vc
> + *
> + * Fill @vc->vc field based on the information in the @vc struct.
> + *
> + * This function can be used by the subdev drivers which support active state to
> + * implement v4l2_subdev_pad_ops.get_vc if the subdev driver does not need to
> + * do anything special in their get_vc op.
> + *
> + * Returns 0 on success, error value otherwise.
> + */
> +int v4l2_subdev_get_vc(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
> +		       struct v4l2_subdev_vc *vc);
> +
>   /**
>    * v4l2_subdev_set_routing() - Set given routing to subdev state
>    * @sd: The subdevice
> @@ -1585,6 +1609,21 @@ struct v4l2_rect *
>   v4l2_subdev_state_get_stream_compose(struct v4l2_subdev_state *state,
>   				     unsigned int pad, u32 stream);
>   
> +/**
> + * v4l2_subdev_state_get_stream_vc() - Get the virtual channel of a stream
> + * @state: subdevice state
> + * @pad: pad id
> + * @stream: stream id
> + *
> + * This returns the virtual channel for the given pad + stream in the
> + * subdev state.
> + *
> + * If the state does not contain the given pad + stream, 0 is returned.
> + */
> +u32
> +v4l2_subdev_state_get_stream_vc(struct v4l2_subdev_state *state,
> +				unsigned int pad, u32 stream);
> +
>   /**
>    * v4l2_subdev_routing_find_opposite_end() - Find the opposite stream
>    * @routing: routing used to find the opposite side
> diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
> index b383c2fe0cf3..8e90405bb1e6 100644
> --- a/include/uapi/linux/v4l2-subdev.h
> +++ b/include/uapi/linux/v4l2-subdev.h
> @@ -187,6 +187,22 @@ struct v4l2_subdev_capability {
>   	__u32 reserved[14];
>   };
>   
> +/**
> + * struct v4l2_subdev_vc - Pad-level virtual channel settings
> + * @which: format type (from enum v4l2_subdev_format_whence)
> + * @pad: pad number, as reported by the media API
> + * @vc: virtual channel
> + * @stream: stream number, defined in subdev routing
> + * @reserved: drivers and applications must zero this array
> + */
> +struct v4l2_subdev_vc {
> +	__u32 which;
> +	__u32 pad;
> +	__u32 vc;
> +	__u32 stream;
> +	__u32 reserved[7];
> +};
> +
>   /* The v4l2 sub-device video device node is registered in read-only mode. */
>   #define V4L2_SUBDEV_CAP_RO_SUBDEV		0x00000001
>   
> @@ -268,6 +284,8 @@ struct v4l2_subdev_client_capability {
>   #define VIDIOC_SUBDEV_S_SELECTION		_IOWR('V', 62, struct v4l2_subdev_selection)
>   #define VIDIOC_SUBDEV_G_ROUTING			_IOWR('V', 38, struct v4l2_subdev_routing)
>   #define VIDIOC_SUBDEV_S_ROUTING			_IOWR('V', 39, struct v4l2_subdev_routing)
> +#define VIDIOC_SUBDEV_G_VC			_IOWR('V', 40, struct v4l2_subdev_vc)
> +#define VIDIOC_SUBDEV_S_VC			_IOWR('V', 41, struct v4l2_subdev_vc)
>   #define VIDIOC_SUBDEV_G_CLIENT_CAP		_IOR('V',  101, struct v4l2_subdev_client_capability)
>   #define VIDIOC_SUBDEV_S_CLIENT_CAP		_IOWR('V',  102, struct v4l2_subdev_client_capability)
>   


