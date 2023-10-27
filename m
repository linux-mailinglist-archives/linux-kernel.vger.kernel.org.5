Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFD7D9B58
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjJ0O1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345983AbjJ0O1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:27:15 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A73A191;
        Fri, 27 Oct 2023 07:27:13 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a87ac9d245so16045997b3.3;
        Fri, 27 Oct 2023 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416832; x=1699021632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJY4zviZdS18dBXZKEqxAy8PoPYbPPOJLPfQ223Zydg=;
        b=Jpq3dKDlCrNa66SAkczqbKuh9I1Lo62Xv7K+M1sbtail30TgF6+sgI4nab69y+pNDP
         0xzwLDFwAdKj2gQ9DS2JYRE6aReZQTRbbhdMr23DESDS04oZxrqPTkSl8wPOw2xGSOqh
         ZNlcUDAr6wx58G2ZaTfYQ3GBW3TjyYgWKby+UK9msNdNlG4Q8sI/7rvZFmMW3WW5VCz4
         G22Dxp9SYhID1hFO/8TiUCe7gr4gXceYILPRvp0ra9VgCn1ihUk1PanFvN4GnzaBli68
         HqfZmgpj7I6AhFuNbUD/Mk50OvCqx6r/uJwjYhn3s1p8ZocYUVsYzbzRFRtfeBW+Og62
         At8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416832; x=1699021632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJY4zviZdS18dBXZKEqxAy8PoPYbPPOJLPfQ223Zydg=;
        b=TJ5LCgqAGaNLglqdylzbqhuzp3IK5jZyBuUxPXyoKUjx++KCe6XxE7fhoVSywzLnT4
         PE1KopoXwy8A+K5PMQKco1hNDWDsSXSllGmwjl8fvs/zogeynIITGZ1P9YyMCThTT9e+
         oQMFH8066i2hrc02vv2QPhHql046UOIxDjNcouR++0t953w2YXCBsPPQryc3tgiWY5l+
         V52/NZJRM26/zZNE0kHwZwSJE9EtMyY1qZMN/MyXXCuHypCny3W45wllAtwTDmfFjwod
         biIRwRV76ZKliGAsWIpGyqiVjeU048yc9+mPFvPcsLdoDPvIuOZIBVgo8aFS1u/x0GXd
         ebBw==
X-Gm-Message-State: AOJu0YzR/NGyQVgxS6j5w7z6pZ1ass+0U2Vp7wwapkJ6ThJPH89t59aa
        gXFzbpTktohbnEXKlo0bcac=
X-Google-Smtp-Source: AGHT+IGbqWzi0BPDi/yZjuYEHOm9QT22riob1Yie07KjT0iN5R8LEzPcsdE+d5NPnHKiJfQS7iCegA==
X-Received: by 2002:a81:ae09:0:b0:5a7:dad7:61dd with SMTP id m9-20020a81ae09000000b005a7dad761ddmr2897846ywh.20.1698416832444;
        Fri, 27 Oct 2023 07:27:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n81-20020a817254000000b005a4da74b869sm296530ywc.139.2023.10.27.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:27:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Oct 2023 07:27:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Move PGOOD fix
Message-ID: <b193df0c-dd41-4c6f-8e09-3bd9322dda8a@roeck-us.net>
References: <20231027103352.918895-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027103352.918895-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:33:52AM +0000, Naresh Solanki wrote:
> The PGOOD fix was intended for MP2973 & MP2971 & not for MP2975.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Good catch. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/mp2975.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 5421af83a43bdcb646564fec238253d11009ad3f
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index 26ba50633100..b9bb469e2d8f 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -297,6 +297,11 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
>  	int ret;
>  
>  	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		ret ^= PB_STATUS_POWER_GOOD_N;
> +		break;
>  	case PMBUS_OT_FAULT_LIMIT:
>  		ret = mp2975_read_word_helper(client, page, phase, reg,
>  					      GENMASK(7, 0));
> @@ -380,11 +385,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
>  	int ret;
>  
>  	switch (reg) {
> -	case PMBUS_STATUS_WORD:
> -		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
> -		ret = pmbus_read_word_data(client, page, phase, reg);
> -		ret ^= PB_STATUS_POWER_GOOD_N;
> -		break;
>  	case PMBUS_OT_FAULT_LIMIT:
>  		ret = mp2975_read_word_helper(client, page, phase, reg,
>  					      GENMASK(7, 0));
