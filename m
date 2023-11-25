Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415B7F8858
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKYEua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 23:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYEu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 23:50:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B761707;
        Fri, 24 Nov 2023 20:50:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf6373ce31so18104775ad.0;
        Fri, 24 Nov 2023 20:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700887835; x=1701492635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mamSrcpFt6HpyIw0gTWr/PcEWD1KzFSebWUa31wxdEE=;
        b=gK9Y3PaE8lo2o0SUBMyM3Xm/KQn4COaN01qjsDLruzjddYMa/uN+maA/MZ0qpeN56M
         UdW+BbHx5YHrXN+c6coCaH0ycRt+cB76MCtgp3hJtxn43PYyXv77y3sdCFU2AJZNjHR2
         1oBRV2BX+aro38iXsr9JGAJiw5KDZv0H7lUSXCFxUNoawTWw1A4CV0TuChYTRle8RvRU
         zZanxUTQ4YTnMrtiYM1ruNBPvlJtD6xe0pXvBuSnS2zYGI+4XLm1co7zXYIRLkR5fCPT
         Yi2pmYuWhb6tqewUSEJ+XE94v1On+d8DIIRR4+/xiYiUpopRmO8Qq3gkp7VnGqI1FjpL
         s4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700887835; x=1701492635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mamSrcpFt6HpyIw0gTWr/PcEWD1KzFSebWUa31wxdEE=;
        b=CnV9jWVIftAM+tBn9HOEpmSpDCMi+DPK7xiuGOvQvX6nMo3iM7Hx0DJj6dSZJ8s6Hs
         y/6SCOFchafHArzFBJu5uQsL9zxMfsJHO3QqWpF2ToNT4+YAvpOZSD2M6VBZJx5uqa3R
         VX+W4MV4qLR+dn4f2asHHx0Hdxhvt1KubwXjYzs3wG89lerTGeqS4zagidR24aXMrK3A
         HRzJLMtdH/90A7j3wVlldWTl+Dr8mq8yAWoRy2q5oCADEh8O8RMsBXx+jkN9MS1Yq2W4
         D4m9K9W6nf1bDGveSPTp6OUg+tkxyYOKe95npDrn9a26qT1UFcLMWe/9APJmVgEx81u+
         KjUA==
X-Gm-Message-State: AOJu0Yx8egMTw/cqIAqxhHW/y60nXPDTgM1myW0QOsUe2mcBQDqAlF0i
        3x6DdGsJ8f4NNInqY/HLNfo=
X-Google-Smtp-Source: AGHT+IHRZPiZ9ixwmCHmArK+giTF174BwcqnMw9EhgGzBqrSTAosTB2z9ykBcOrikqeA+yaU2DjdMw==
X-Received: by 2002:a17:902:d487:b0:1ce:5bc8:4734 with SMTP id c7-20020a170902d48700b001ce5bc84734mr11967716plg.30.1700887834708;
        Fri, 24 Nov 2023 20:50:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8b5c:82d0:578f:d0])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090adf9000b00283991e2b8esm3670283pjv.57.2023.11.24.20.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 20:50:34 -0800 (PST)
Date:   Fri, 24 Nov 2023 20:50:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v4 2/2] Input: gpio-keys - Add system suspend support for
 dedicated wakeirqs
Message-ID: <ZWF9F9JHKJ-SjUjp@google.com>
References: <20231124083241.40780-1-tony@atomide.com>
 <20231124083241.40780-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124083241.40780-2-tony@atomide.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Fri, Nov 24, 2023 at 10:32:41AM +0200, Tony Lindgren wrote:
> +	/*
> +	 * Wakeirq shares the handler with the main interrupt, it's only
> +	 * active during system suspend. See gpio_keys_button_enable_wakeup()
> +	 * and gpio_keys_button_disable_wakeup().
> +	 */
> +	error = devm_request_any_context_irq(dev, bdata->wakeirq, isr,
> +					     irqflags, wakedesc, bdata);
> +	if (error < 0) {
> +		dev_err(dev, "Unable to claim wakeirq %d; error %d\n",
> +			bdata->irq, error);
> +		return error;
> +	}
> +
> +	/*
> +	 * Disable wakeirq until suspend. IRQF_NO_AUTOEN won't work if
> +	 * IRQF_SHARED was set based on !button->can_disable.
> +	 */
> +	disable_irq_nosync(bdata->wakeirq);

Why _nosync() here and below? Is there any harm in sing the normal
variant?

Thanks.

-- 
Dmitry
