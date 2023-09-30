Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891317B43E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjI3VWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjI3VWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:22:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF0DA;
        Sat, 30 Sep 2023 14:22:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690f2719ab2so3388702b3a.0;
        Sat, 30 Sep 2023 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696108920; x=1696713720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv5i3mrrvZiOpK3Rs/zvAgpY9dYr8stTD5j0ClQLZ9c=;
        b=Zkq0okBZrhVRR5fIa/DiUpMRaNTo9hvgcCM7IDjyGCRSNpo50HaxMeNCPjEFWaVhE4
         HoSWbR2NkDQrqoJNcARz69wrfBKQV0WgbQXWEZxT65TrYwYpnCr9bC2ISP8Quu6rQ/OQ
         0dO7X6JFmXareDBsKsBwfJleBNoCCqzd15MiuOXjs9yV3cbiQONVinZ/AY3wkfGpmcAv
         XHuBprLejAg1z/Hwb8fz2CIn2Lk/D3h3L4XF8pklP6ZHrgLW0XkVXjdZu1oDUWtwQV3q
         11GrORPV1Rbv2WJlT3XZ5qvu+Qn4JIGOEwlxhxDDSysfinkAMJdrMuP6zAHXxo7qzTmr
         o6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696108920; x=1696713720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv5i3mrrvZiOpK3Rs/zvAgpY9dYr8stTD5j0ClQLZ9c=;
        b=nWENbbhWHFtvWo7Nm9q7iCFpRbLE7uGLXqz6HIRBZr0tFNvsgc8KuPzkw8nNpaD16J
         3j5wc/xSk4eBHpKGFiVh/ZBcow6ytmH+5JstJz90lALkhv7ICYRvwZShwH0COaJm5ReB
         53fBRHVjENytM/fKgzdM9vEkxrLpV3u1BHk+dilXKbuECCCcgXiGcAerm33SB/NF1UaY
         OJ79ZfDMq7perYzGJc+YsJsVtm75vubFRUEYKyHS4h/OEFS1yAuD3X6dRi9LNQ0yq/Jk
         e/ZHWWStaDiNWTt9Xh625RZgS5AIicEkhNLatWPF3I4zxULBIrtbE9C5ilqycJfAgd69
         QGKg==
X-Gm-Message-State: AOJu0Yyv6iaYR7Nw1uJq85bj6yDzsVXXqcgxZh9BJYhXkfWyBBokUmHG
        A3CHCZvMU4Dv8Fl68FASjgg=
X-Google-Smtp-Source: AGHT+IE0Wg+xblA6Lk/5M925hSTiM/iXIlOW3J6hvGIch3WIIqvewJeLsBWSFHNbG6sjHCGqETP6ow==
X-Received: by 2002:a05:6a00:4691:b0:693:38c5:4d6d with SMTP id de17-20020a056a00469100b0069338c54d6dmr7350641pfb.2.1696108919695;
        Sat, 30 Sep 2023 14:21:59 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gx19-20020a056a001e1300b0069370f32688sm2699803pfb.194.2023.09.30.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:21:59 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:21:56 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
Message-ID: <ZRiRdL+JEKZfiOZo@hoboy.vegasvil.org>
References: <20230929023743.1611460-1-maheshb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929023743.1611460-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:37:43PM -0700, Mahesh Bandewar wrote:

> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 1f1e98966cff..73bd17055a37 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -166,6 +166,18 @@ struct ptp_sys_offset_extended {
>  	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
>  };
>  
> +struct ptp_sys_offset_any {
> +	unsigned int n_samples;		/* Desired number of measurements. */
> +	enum ptp_ts_types ts_type;	/* One of the TS types */

clockid_t other_clock;

Hm?

> +	unsigned int rsv[2];		/* Reserved for future use. */
> +	/*
> +	 * Array of [TS, phc, TS] time stamps. The kernel will provide
> +	 * 3*n_samples time stamps.
> +	 * TS is any of the ts_type requested.
> +	 */
> +	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
> +};

Thanks,
Richard
