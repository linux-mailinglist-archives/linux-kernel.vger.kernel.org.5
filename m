Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE47F1076
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjKTKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:34:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A6C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:34:04 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd644a96so5826304e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700476443; x=1701081243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+/A67yCsKCYjT4OzekwJL7Zg9Z+4KiWMU478yrnJ6A=;
        b=Rr4vj8DYG1C9mB75c8LFHJqqARMge/NuWS+2AtgEoULQOpK3EgbcwE+nwV4UOFuqyr
         jhYSD/zdXWpOuxwlmHvBCxn5TfO+0c3J5IQWUNns6lP8BBKaPdOI3FuRcGqIPbeMlQGp
         U8FfwUEquCGoAMCn8ArSHDbL7kBnizbHE9j3WNsBPpe6rPz1bYVTpEoG/7asIauO0XEV
         n3ctmu1yxTpnI/RILbf3bFcIl6bOjuRtPahxEmoiubSmFF7aofvTepGGKuYi2ipRF6i0
         thYEuRgl3yiRxOYnC2+BjD3YytpvFAt3pcAp7JJkVZC7pH0BCJ361uEHYzDgC5pECxkM
         ZLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476443; x=1701081243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+/A67yCsKCYjT4OzekwJL7Zg9Z+4KiWMU478yrnJ6A=;
        b=Ar5iRBl/60GzhZQKRGQusY1wDSEVCUeEnZYDSnM0LqDf+mk4LcXXPGxXlGu/4xx+SM
         bO9gqGpOour6KI8OCoCcHVZAyustcE0UP2b7R9rpQHbvMMDMQq94o6xgpLHWATGLQPRc
         1l2L0uCOE8CZIifbbyzi3eaxL/Dcs5Z5TpRcLE4d589GAgg9OkmXxPfxtDbT959Xe0lX
         trfSllneHUM8u1qMvJql0Usfm6nKqSuTP2LivMxznak11I1s14ugS9snpgxPlZs1CN18
         dmvjPcYv4kykk8X/nl4u4st1sN1NchWcTnFn7g7SwgtpnK5vfOT2nI/9XqU7ZKJP6Niq
         a5GQ==
X-Gm-Message-State: AOJu0YyKviwxyVw7Qp8ZOfLkR7AiLL04yNyDzF+raxG/rch0oP3LEhAI
        BVrJE/7OXkMMlRsaJYEMDke/6A==
X-Google-Smtp-Source: AGHT+IGC+q6OhZa2pu5cx3aVWD4t46z49DbuzV37RCxExtAfJLBJFt42IgxDX1xcBMYvlOiJRA17RQ==
X-Received: by 2002:a19:5517:0:b0:503:95b:db0a with SMTP id n23-20020a195517000000b00503095bdb0amr6382815lfe.12.1700476443129;
        Mon, 20 Nov 2023 02:34:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d49c8000000b0031984b370f2sm10768685wrs.47.2023.11.20.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:34:02 -0800 (PST)
Date:   Mon, 20 Nov 2023 05:33:59 -0500
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
        Naushir Patuck <naush@raspberrypi.com>
Subject: Re: [PATCH v2 10/15] staging: vc04_services: bcm2835-isp: Add a more
 complex ISP processing component
Message-ID: <fe7b0a08-941f-4dbc-b89f-d3da0a96ac32@suswa.mountain>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-11-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109210309.638594-11-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:03:02PM -0500, Umang Jain wrote:
> +static int media_controller_register(struct bcm2835_isp_dev *dev)
> +{
> +	char *name;
> +	unsigned int i;
> +	int ret;
> +
> +	v4l2_dbg(2, debug, &dev->v4l2_dev, "Registering with media controller\n");
> +	dev->mdev.dev = dev->dev;
> +	strscpy(dev->mdev.model, "bcm2835-isp",
> +		sizeof(dev->mdev.model));
> +	strscpy(dev->mdev.bus_info, "platform:bcm2835-isp",
> +		sizeof(dev->mdev.bus_info));
> +	media_device_init(&dev->mdev);
> +	dev->v4l2_dev.mdev = &dev->mdev;
> +
> +	v4l2_dbg(2, debug, &dev->v4l2_dev, "Register entity for nodes\n");
> +
> +	name = kmalloc(BCM2835_ISP_ENTITY_NAME_LEN, GFP_KERNEL);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto done;

Oh crap.  This function doesn't clean up after itself, but instead
returns to a One Magical Cleanup Function...  This style of error
handling is *ALWAYS* buggy.  But in this case I only see a very minor
leak.

These two cleanups are under one ->registered flag but they are
allocated separately.  So if we only complete one action and not the
second then the flag is not set and we don't call media_device_cleanup().
(This is one of many typical problems with One Magical Cleanup Function
Style).

> +	if (dev->media_device_registered) {
> +		media_device_unregister(&dev->mdev);
> +		media_device_cleanup(&dev->mdev);
> +		dev->media_device_registered = false;
> +	}

It's just such a headache to review...  (That's why it's so bug prone).

If you wrote it in Free the Last Thing Style then you could get rid
of a bunch of flags like ->media_device_registered and
->media_entity_registered because at that point you would always know
what you had done and hadn't done.

regards,
dan carpenter


> +	}
> +	snprintf(name, BCM2835_ISP_ENTITY_NAME_LEN, "bcm2835_isp0");
> +	dev->entity.name = name;
> +	dev->entity.obj_type = MEDIA_ENTITY_TYPE_BASE;
> +	dev->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
> +
> +	for (i = 0; i < BCM2835_ISP_NUM_NODES; i++) {
> +		dev->pad[i].flags = node_is_output(&dev->node[i]) ?
> +					MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
> +	}
> +
> +	ret = media_entity_pads_init(&dev->entity, BCM2835_ISP_NUM_NODES,
> +				     dev->pad);
> +	if (ret)
> +		goto done;
> +
> +	ret = media_device_register_entity(&dev->mdev, &dev->entity);
> +	if (ret)
> +		goto done;
> +
> +	dev->media_entity_registered = true;
> +	for (i = 0; i < BCM2835_ISP_NUM_NODES; i++) {
> 		ret = media_controller_register_node(dev, i);
> +		if (ret)
> +			goto done;
> +	}
> +
> +	ret = media_device_register(&dev->mdev);
> +	if (!ret)
> +		dev->media_device_registered = true;
> +done:
> +	return ret;
> +}

