Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3367C7A9D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjIUTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIUTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE333AE964
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:05:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-501eec0a373so2259977e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319554; x=1695924354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHB7MokjFazEBVZHVWPQWx+ouAjuzlds+fkP2tznoWg=;
        b=yTVwZZvTgzvQw5/xo4pYB6JTeBEgz5aAvlGxX1M8YxJcRJc58ZfR3jfmxDCDwlHhE4
         oZeF6pMWj7vlGVzM6QX2lR9fRV30dL0cjyAQ1PSX5GTXFv4ju4hNRTqhyB69dNKl4vlI
         3zHmzyCmUsWyvcBP8TMfDDCLrLRTbCG6XCb913w/xouSYo0tOV3JxQ2syA9NOThK4FEJ
         Bx8/ZAG9Bup2WzBi3+9uEBvIMj2r0GBVuVnecLPEW/KiffTBzk/qhijHu7EmyYM6HS0q
         +py2xFK6gjAFnPHmjeG2zxYds1mzc6smuXJ3nl1Ewf10/gmi2MN3nNUfQta+PIQ97+bQ
         9Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319554; x=1695924354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHB7MokjFazEBVZHVWPQWx+ouAjuzlds+fkP2tznoWg=;
        b=In30wE0vRidsAqsOwSJWt1aXFmXISHS7cop7jTYaejtrBv36VIIcOyklH1gvGrrMWK
         k6dYyzE+IsP+kyg+kNWtoJBZwJp6i+3TLU9ZDeGrozLf5KZf6ezVcSSlEqF3esr21RoI
         NRUam02SUfJYFVk01tz6gRBVuoPrpuDREZyj5C/F0aJp1R5cuH+fVzGrRhSw8AVv9gS4
         FGR+uuPuI45VOc1zn+dUEiDQk/Em+MpRiCr3KmY4IWRuoyJwEfyAgqVEj5C81Xtl3I8T
         0cHMZwphCeRl3tGhsnWt0KO2gcmXPFtacino157iQfM7q2MJ/PoRNAL/7GPNN6XrEDHP
         tPcw==
X-Gm-Message-State: AOJu0YyoMWB7DzDQJDT66wJ5HL+qrltU3s5d7p53c6GGmy5L0kq9HaHW
        B6Ncs4Su8ZtMpD+lJNRVn7QG8g1CwBR6yQ9Nr1w=
X-Google-Smtp-Source: AGHT+IGcpjHnDw8LA8Dyh0T2ryjOdihtn8w38po8JoSvFO1h83wyuE62Gs1r8YrosYCllwS5Zi78ew==
X-Received: by 2002:a17:906:109e:b0:9a9:ef41:e5a6 with SMTP id u30-20020a170906109e00b009a9ef41e5a6mr4612465eju.1.1695292568673;
        Thu, 21 Sep 2023 03:36:08 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id gv10-20020a170906f10a00b0099cd008c1a4sm825012ejb.136.2023.09.21.03.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:36:08 -0700 (PDT)
Message-ID: <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
Date:   Thu, 21 Sep 2023 12:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

(Adding Andy for commit 54b45ee8bd42 "serial: core: Remove
unused PORT_* definitions").

On 20/9/23 22:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its type
> definition from 8250 code. As with previous removals, I checked with
> Debian Code Search that 'PORT_AR7' is not used in userspace.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 7 -------
>   include/uapi/linux/serial_core.h    | 1 -
>   2 files changed, 8 deletions(-)


> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index add349889d0a..3b51901926f9 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -32,7 +32,6 @@
>   #define PORT_XSCALE	15
>   #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
>   #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
> -#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */

I'm a bit surprised definitions are removed from the uAPI, isn't
it expected to be very stable? Shouldn't it be better to keep it
defined but modify the comment, mentioning "obsolete" or "deprecated"?

Regards,

Phil.

>   #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
>   #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
>   #define PORT_XR17D15X	21	/* Exar XR17D15x UART */

