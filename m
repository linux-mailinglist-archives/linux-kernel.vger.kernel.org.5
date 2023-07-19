Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C4759AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGSQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:33:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A91BB;
        Wed, 19 Jul 2023 09:33:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686708c986so7149081b3a.0;
        Wed, 19 Jul 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689784402; x=1692376402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rkgwj3RYm4LsR2kUFzce9c9w0vDBqvLHq+ZZijTomMQ=;
        b=d44nzLV9XOWH2OtdXgxFZUSlte1CnWFuUZ84jB+QYfpM/E9KUebT2DGdsDhOy7Y1tj
         B8sH/1zD6/pt+iYVEpEU6Pyhpvx0jHVMuuQF+wltYfJvSXzAw3FEBO0pii5MqD/eY5R2
         X5AwWv/0GsxkEbbnRuCXZCpKTJJmr5yxGeaB15gRMzsKIRja7KKRi7tCQvbGtsEGxhcq
         kndXtAC38Vx7On7RcWcisloBUOQ/Ar1inybmFUid90Chxdq6oXXc2ED/s2ljrFGUZkAB
         gjKVWA1W4JpMu1cBMUwaDr2DV3tdvghA1si8/2CU4rtJEk1ky8XTq9HpJq7uXl8Obkn6
         vmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784402; x=1692376402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkgwj3RYm4LsR2kUFzce9c9w0vDBqvLHq+ZZijTomMQ=;
        b=d3JFbULlHyZE9oqk4ihTILWAKr2+4fogvCv8m9/TqNRHtaUI0kr2Ee20ZL3qJmNaHU
         h4fujp6afLFz09gmu3qP8QtwuYafzTvqbLds7rwZyhw5WoEnqs1Src5mudDus6D/oBug
         COFHpNtelMSroKQb+IS+QJkpFwvMqrO/mzoOFh9WQ0O442XcOX7CvJOWAiJk54sn88yL
         HujQ+S+VY+PZSw19YLxjl+EAnoDY4SIsI2Kr/wJgP6/mescPLc4MDcEiA4iMf/cOpVhN
         9xRWjkxwx+rXxxAbtjTzRAqHYH3PKbnY7AmssOkH0m9NrK/X6gN16Y7zCedHsxR2Oh8H
         fhNQ==
X-Gm-Message-State: ABy/qLZKZ+d1dj8fNJEwxKVjq9cWCs6QDhWXbOyPjuwhSl9CYiSGtDwu
        SfeB5TeJtBy698USm69LUOsk3Tj0ibE=
X-Google-Smtp-Source: APBJJlGTjg0V9Geix6gFBaSKQkZs41vPcky5XH8Lu7X8hlUWJ0ALyN3gqhZAqnV//KSFOJjQa6lH5g==
X-Received: by 2002:a05:6a20:7f9f:b0:12e:5f07:7ede with SMTP id d31-20020a056a207f9f00b0012e5f077edemr25162748pzj.41.1689784401803;
        Wed, 19 Jul 2023 09:33:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001acae9734c0sm4195351plf.266.2023.07.19.09.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:33:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7fd7dbd0-23f7-228a-2645-ada0a60102fd@roeck-us.net>
Date:   Wed, 19 Jul 2023 09:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
 <20230719153518.13073-2-henning.schild@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230719153518.13073-2-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 08:35, Henning Schild wrote:
> If a user did choose to enable Siemens Simatic platform support they
> likely want that driver to be enabled without having to flip more config
> switches. So we make the watchdog driver config switch default to the
> platform driver switches value.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..04e9b40cf7d5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1681,6 +1681,7 @@ config NIC7018_WDT
>   config SIEMENS_SIMATIC_IPC_WDT
>   	tristate "Siemens Simatic IPC Watchdog"
>   	depends on SIEMENS_SIMATIC_IPC
> +	default y
>   	select WATCHDOG_CORE
>   	select P2SB
>   	help

