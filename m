Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A537EA963
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjKNEOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjKNEOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:14:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE5D0;
        Mon, 13 Nov 2023 20:14:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc4d306fe9so8276045ad.0;
        Mon, 13 Nov 2023 20:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699935255; x=1700540055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muBwcP9mUDyva964KLM9ef52aqzazwIwTn3pnbunHbA=;
        b=lDCCvnyyXbncsR5wwyXYZJLwdMrBf5KzO9UocCk2ZiTexXRkmlXvh9B61GdVxA6gpr
         JdIUIZKoFGfc2Gc/khmOrOG/b1MeCyQ7a6KSqz8rACOon1cz1okpuHlzUPkVM0i3r0MY
         A4tvovDrgZsGomf/0kHhHhU+ajaZ3deOAeyM/OPnWDEl9QifryIPNwwA91v/I3q2pueU
         znrKhwvhoyBHR9aA1pqGkpT3oFI8UR1c4oQFxweqnyKV81YGpPuCitY5y0hirSB7Zcs7
         Sm1tcgnLNZ2ZY11fTCquayciMDwKRlQYLIyw8KJrhWqoCBAqektzAVjOH6+WZbwqYYBA
         gTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935255; x=1700540055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muBwcP9mUDyva964KLM9ef52aqzazwIwTn3pnbunHbA=;
        b=MGtvPPEuHPR15OQGaSwLGx0JKfNz5X3Y0N6VtM42kBVHFvmqYb/wVSsKHAXm09OHlk
         kr6vTFDXOvosh9Fp5PaLKLvoFUQNcN0CwWjuHuOOAIwzkmDF++NNEALuNfHTDBWipIB8
         Af0XCFlOUPykfx0+VSbjsbEYuR2dyL0EnLjTbeqm+iMjGpCG73J/vBAyBt8ol6lPOT3I
         4aN5MEBcyNnee5ng4VaZx3Is04OnBZevqCooPqNamoPYS8mBOo2rjr+kiYkc3EWas1Ul
         JD8FdfWpwJ8ZClB8H28KZw5iSQaj7+ifNa8r5L6fo1JBj1qXi8b28u1uP5BzdvsyXwjE
         LXcw==
X-Gm-Message-State: AOJu0Yz/78R7p/oPvkKqyvO9z1tNThn+dVY053Dqd8pfFtyL7MzwpEy1
        ZOP10kZnSIdfkQNT25vZT8U=
X-Google-Smtp-Source: AGHT+IEGGyweHVZKhRyo7BS5bHq4rv9HAHBCRFbKwuBJWnxmFui/U17RUIycDcmIlYxbBMGHjI35uQ==
X-Received: by 2002:a05:6a21:789b:b0:17b:170c:2d11 with SMTP id bf27-20020a056a21789b00b0017b170c2d11mr1373664pzc.6.1699935255028;
        Mon, 13 Nov 2023 20:14:15 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7838e000000b006c345e192cfsm344097pfm.119.2023.11.13.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:14:14 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:14:12 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Min Li <lnimi@hotmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next RFC 1/1] ptp: use extts interface for the
 measured external offset
Message-ID: <ZVL0FDZ4Dn4qo7hn@hoboy.vegasvil.org>
References: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 04:50:25PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the
> phase offset between PHC signal and the external signal, such
> as GNSS. With this change, ts2phc can use the existing extts
> interface to retrieve measurement offset so that the alignment
> between PHC and the external signal can be achieved.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clock.c          | 12 +++++++++---
>  include/linux/ptp_clock_kernel.h |  2 ++
>  include/uapi/linux/ptp_clock.h   |  9 +++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 3134568af622..c87954c8642f 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -48,14 +48,19 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
>  	s64 seconds;
>  	u32 remainder;
>  
> -	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
> +	if(src->type != PTP_CLOCK_EXTOFF)

Space after 'if' keyword please.

> +		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
>  
>  	spin_lock_irqsave(&queue->lock, flags);
>  
>  	dst = &queue->buf[queue->tail];
>  	dst->index = src->index;
> -	dst->t.sec = seconds;
> -	dst->t.nsec = remainder;
> +	if(src->type != PTP_CLOCK_EXTOFF) {

ditto.

> +		dst->t.sec = seconds;
> +		dst->t.nsec = remainder;
> +	} else {
> +		dst->o = src->offset;
> +	}
>  
>  	if (!queue_free(queue))
>  		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
> @@ -416,6 +421,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
>  		break;
>  
>  	case PTP_CLOCK_EXTTS:
> +	case PTP_CLOCK_EXTOFF:
>  		/* Enqueue timestamp on selected queues */
>  		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
>  		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 1ef4e0f9bd2a..7f2d1e1cc185 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -200,6 +200,7 @@ struct ptp_clock;
>  enum ptp_clock_events {
>  	PTP_CLOCK_ALARM,
>  	PTP_CLOCK_EXTTS,
> +	PTP_CLOCK_EXTOFF,
>  	PTP_CLOCK_PPS,
>  	PTP_CLOCK_PPSUSR,
>  };
> @@ -218,6 +219,7 @@ struct ptp_clock_event {
>  	int index;
>  	union {
>  		u64 timestamp;
> +		s64 offset;
>  		struct pps_event_time pps_times;
>  	};
>  };
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index da700999cad4..61e0473cdf53 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -32,6 +32,7 @@
>  #define PTP_RISING_EDGE    (1<<1)
>  #define PTP_FALLING_EDGE   (1<<2)
>  #define PTP_STRICT_FLAGS   (1<<3)
> +#define PTP_EXT_OFFSET     (1<<4)
>  #define PTP_EXTTS_EDGES    (PTP_RISING_EDGE | PTP_FALLING_EDGE)
>  
>  /*
> @@ -40,7 +41,8 @@
>  #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
>  				 PTP_RISING_EDGE |	\
>  				 PTP_FALLING_EDGE |	\
> -				 PTP_STRICT_FLAGS)
> +				 PTP_STRICT_FLAGS |	\
> +				 PTP_EXT_OFFSET)
>  
>  /*
>   * flag fields valid for the original PTP_EXTTS_REQUEST ioctl.
> @@ -228,7 +230,10 @@ struct ptp_pin_desc {
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
>  
>  struct ptp_extts_event {
> -	struct ptp_clock_time t; /* Time event occured. */
> +	union {
> +		struct ptp_clock_time t; /* Time event occured. */
> +		__s64 o; /* measured offset */

How about calling it offset_ns so that the unit is clear?

> +	};
>  	unsigned int index;      /* Which channel produced the event. */
>  	unsigned int flags;      /* Reserved for future use. */
>  	unsigned int rsv[2];     /* Reserved for future use. */
> -- 
> 2.39.2
> 
