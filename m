Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5027F0F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjKTKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:01:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493718F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:01:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839807e82so9063645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700474459; x=1701079259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jq9JRUdKOLTnT8WnnlX5Kjk7fKbCoaZLOG+eigQvj6U=;
        b=xxTwifqSPMxiTonOMCQLpCOJ1jbDZaRva23XZDd6JInWcvf/E0ItuI9UVFn9HWuPxi
         vlys6XCMFuvFcwhwbP5XwrHjtkuhnOGral0CJvdKnkSxEauQA+GMtVcX3EQBtJVAJ5s7
         DsEAw18Tev6GcRNvyg2G0cllstNN5vj0bCEMm/3Wz5EKyCOGw993gcMufG/Xb3tDhQfU
         /BpW/H4XQMP8Ia+l49Il+VHjTcbL1Ieb8DvU/SYFntYxE8lYAJnV9M1d0X0KnwWLqCfW
         0rWZxbYsky5N64PjTv8jsUVLtCk8OnnXuyKJ5RysFPJku6cJ3XxImC7onDRr/QGAxy2s
         xkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474459; x=1701079259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq9JRUdKOLTnT8WnnlX5Kjk7fKbCoaZLOG+eigQvj6U=;
        b=QMgHYYO47geG3xqMzjhmj8D743fs03kpI5s2MDvFu7deP6UbikZ5sUBq9ndaVmEhET
         Ck7+jMOblyq/RUfoi1ILbrFtFJ3DGOBx4zivd6Km7FI7Ou/MHRx632vt2eQa4CrVlLL6
         6w1gIsjCwiG7r82STjKzafbChC0n2n9wnGAfv7NESeLRYMVnbSJQgBqil6v2FnS0iz27
         Q3Fu3CXwV2bx73iqMoBIjHdeMtjHm2cesVYBqwgsMndUrG1RM9q/JAP3/h+5fMZmWXto
         EUNQyPo3oJTrX/1RCA1+dL9bnCoK8CiR9Fz2ZMfRqG5eq62uaEhdo9xNBuwNvMRmYqhW
         fJcg==
X-Gm-Message-State: AOJu0YzuhymVxOlxvFB+YbsOCGVgRsf156v8f6kYnNavg4A+ieNFYAVH
        +RiAHeGSzeowBLjaQub7+jYMEg==
X-Google-Smtp-Source: AGHT+IHgsSU9xj0hKPWpxT9Vk1ZeDlmDhlQtZDVSmlX098fSTuAZhRxTckOXWCNL1Om5eh3w7fsDHA==
X-Received: by 2002:a05:600c:348b:b0:405:2d29:1648 with SMTP id a11-20020a05600c348b00b004052d291648mr10756789wmq.19.1700474458629;
        Mon, 20 Nov 2023 02:00:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c214c00b004065daba6casm17018246wml.46.2023.11.20.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:00:58 -0800 (PST)
Date:   Mon, 20 Nov 2023 05:00:55 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: Re: [PATCH v2 04/15] staging: mmal-vchiq: Add support for event
 callbacks
Message-ID: <2a3cb5ad-4791-4d37-a6a1-785432d5dd46@suswa.mountain>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-5-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109210309.638594-5-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:02:56PM -0500, Umang Jain wrote:
> +static void event_to_host_cb(struct vchiq_mmal_instance *instance,
> +			     struct mmal_msg *msg, u32 msg_len)
> +{
> +	int comp_idx = msg->u.event_to_host.client_component;
> +	struct vchiq_mmal_component *component =
> +					&instance->component[comp_idx];
> +	struct vchiq_mmal_port *port = NULL;
> +	struct mmal_msg_context *msg_context;
> +	u32 port_num = msg->u.event_to_host.port_num;
> +
> +	if (msg->u.buffer_from_host.drvbuf.magic == MMAL_MAGIC) {
> +		pr_err("%s: MMAL_MSG_TYPE_BUFFER_TO_HOST with bad magic\n",
> +		       __func__);
> +		return;
> +	}
> +
> +	switch (msg->u.event_to_host.port_type) {
> +	case MMAL_PORT_TYPE_CONTROL:
> +		if (port_num) {
> +			pr_err("%s: port_num of %u >= number of ports 1",

This message is confusing.  Perhaps:

	pr_err("%s: invalid port_num %u (should be zero)", ...

> +			       __func__, port_num);
> +			return;
> +		}
> +		port = &component->control;
> +		break;
> +	case MMAL_PORT_TYPE_INPUT:
> +		if (port_num >= component->inputs) {
> +			pr_err("%s: port_num of %u >= number of ports %u",

	pr_err("%s: port_num (%u) >= component->inputs (%u)",


> +			       __func__, port_num,
> +			       port_num >= component->inputs);
> +			return;
> +		}
> +		port = &component->input[port_num];
> +		break;
> +	case MMAL_PORT_TYPE_OUTPUT:
> +		if (port_num >= component->outputs) {
> +			pr_err("%s: port_num of %u >= number of ports %u",


	pr_err("%s: port_num (%u) >= component->outputs (%u)",

> +			       __func__, port_num,
> +			       port_num >= component->outputs);
> +			return;
> +		}
> +		port = &component->output[port_num];
> +		break;
> +	case MMAL_PORT_TYPE_CLOCK:
> +		if (port_num >= component->clocks) {
> +			pr_err("%s: port_num of %u >= number of ports %u",
> +			       __func__, port_num,
> +			       port_num >= component->clocks);
> +			return;
> +		}
> +		port = &component->clock[port_num];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!mutex_trylock(&port->event_context_mutex)) {
> +		pr_err("dropping event 0x%x\n", msg->u.event_to_host.cmd);
> +		return;
> +	}
> +	msg_context = port->event_context;
> +
> +	if (msg->h.status != MMAL_MSG_STATUS_SUCCESS) {
> +		/* message reception had an error */
> +		pr_err("%s: error %d in reply\n", __func__, msg->h.status);
> +
> +		msg_context->u.bulk.status = msg->h.status;
> +	} else if (msg->u.event_to_host.length > MMAL_WORKER_EVENT_SPACE) {
> +		/* data is not in message, queue a bulk receive */
> +		pr_err("%s: payload not in message - bulk receive??! NOT SUPPORTED\n",
> +		       __func__);
> +		msg_context->u.bulk.status = -1;
> +	} else {
> +		memcpy(msg_context->u.bulk.buffer->buffer,
> +		       msg->u.event_to_host.data,
> +		       msg->u.event_to_host.length);
> +
> +		msg_context->u.bulk.buffer_used =
> +		    msg->u.event_to_host.length;
> +
> +		msg_context->u.bulk.mmal_flags = 0;
> +		msg_context->u.bulk.dts = MMAL_TIME_UNKNOWN;
> +		msg_context->u.bulk.pts = MMAL_TIME_UNKNOWN;
> +		msg_context->u.bulk.cmd = msg->u.event_to_host.cmd;
> +
> +		pr_debug("event component:%u port type:%d num:%d cmd:0x%x length:%d\n",
> +			 msg->u.event_to_host.client_component,
> +			 msg->u.event_to_host.port_type,
> +			 msg->u.event_to_host.port_num,
> +			 msg->u.event_to_host.cmd, msg->u.event_to_host.length);
> +	}
> +
> +	schedule_work(&msg_context->u.bulk.work);
> +}
> +
>  /* deals with receipt of buffer to host message */
>  static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
>  			      struct mmal_msg *msg, u32 msg_len)
> @@ -1329,6 +1421,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
>  				mmalbuf->mmal_flags = 0;
>  				mmalbuf->dts = MMAL_TIME_UNKNOWN;
>  				mmalbuf->pts = MMAL_TIME_UNKNOWN;
> +				mmalbuf->cmd = 0;
>  				port->buffer_cb(instance,
>  						port, 0, mmalbuf);
>  			}
> @@ -1630,6 +1723,43 @@ int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
>  }
>  EXPORT_SYMBOL_GPL(mmal_vchi_buffer_cleanup);
>  
> +static void init_event_context(struct vchiq_mmal_instance *instance,
> +			       struct vchiq_mmal_port *port)
> +{
> +	struct mmal_msg_context *ctx = get_msg_context(instance);
> +
> +	mutex_init(&port->event_context_mutex);
> +
> +	port->event_context = ctx;
> +	ctx->u.bulk.instance = instance;
> +	ctx->u.bulk.port = port;
> +	ctx->u.bulk.buffer =
> +		kzalloc(sizeof(*ctx->u.bulk.buffer), GFP_KERNEL);

This is 79 chars.  Delete the line break.

> +	if (!ctx->u.bulk.buffer)
> +		goto release_msg_context;
> +	ctx->u.bulk.buffer->buffer = kzalloc(MMAL_WORKER_EVENT_SPACE,
> +					     GFP_KERNEL);

regards,
dan carpenter
