Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF65F79413C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbjIFQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjIFQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:11:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0610C7;
        Wed,  6 Sep 2023 09:11:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f57f02442so2459682a91.0;
        Wed, 06 Sep 2023 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694016710; x=1694621510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dB58pkVoIwjiWud2KnolMWuExLTjjvxyLWmvQTfD5qM=;
        b=HN4V0fMXZC2IPgFFwxRifvRVdjw4lOpnKIB+safgJ2oM0dqmSwj4u09Jp2v1FaFByT
         9RR5m+ZVpn5jvzwP4fDtb62kq0Wv8GE6dxyEJibGyRSoYPzMHcH9OaU6i4l05P+VOPax
         o6YNjOfSLGDP/DKzgepnaD5HWMH6WaWXgddCOla/orFKv7C1i/THnZVY6BwD8MPwHF+w
         xIwwcpMBwt8PlX+lje0bCF6rAG/idnby37zTOYK4zYR03wx8PA1IpkDjKp3XNJxx5W5S
         +h0phqG+cNtKn/oEk12uh3RB6IHOD39OFD3h0d+QKf7MVbSQIxAXee54fu7c49vuRw0Y
         RC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016710; x=1694621510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB58pkVoIwjiWud2KnolMWuExLTjjvxyLWmvQTfD5qM=;
        b=XVdI4nh2/oxpqc4eX6i3UdpOiICI6mygjlfqRuUgEWP0m3gzzFD40An9ton12hVUS8
         d8c+JsKqZjjKlPdqgRuZuZPPTwfNM1MRYUvL2E4FLeN8svTGNG1TF3IyFf7M1yhWIBMF
         cj2gche7RNx7qJrPvCUoZ4fqp82oAU/O+f2CI7S2KsCQaPC4wSVzRqYPhZWyo14ghvAJ
         5KgdO4OyCkTngaOH2jHu+YId6YFkGDs3wjWWJv7lMnAWAE5PbFXgBmtJOVCgg+4erlhz
         nxIMlEuF1Y8X1qCX+QZa5CQ4D+kfig7vyUpKGXEB+DTdu1+CmKJHQi4qS5iU6QOAqLBG
         fXNg==
X-Gm-Message-State: AOJu0YxGcciJKrXqpsPR1KS4gpNmlttsUFyf7IU9QaDwTRipovGfC57g
        TVxVIFLfsp5zPo3dJHu5MLyDWsY+mtM=
X-Google-Smtp-Source: AGHT+IFGNcpCnCqeji0A5QnaU4hNO2vwGroWMiaFWURzCnHSB+4JDHE7SpKqB4yLR1Wt0zGLwnQHDg==
X-Received: by 2002:a17:90a:5184:b0:262:ecd9:ed09 with SMTP id u4-20020a17090a518400b00262ecd9ed09mr13698254pjh.33.1694016709948;
        Wed, 06 Sep 2023 09:11:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00271c5811019sm11995695pja.38.2023.09.06.09.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 09:11:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdce397e-716f-7478-4426-7583242386d2@roeck-us.net>
Date:   Wed, 6 Sep 2023 09:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/1] hwmon: max31790: support to config PWM as TACH
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 01:48, Delphine CC Chiu wrote:
> v1 - Support to config PWM as TACH in max31790 driver
> 
> Delphine CC Chiu (1):
>    hwmon: max31790: support to config PWM as TACH
> 
>   drivers/hwmon/max31790.c | 50 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 

An introduction email is not necessary for a single patch.
_If_ you insist sending it anyway, it should contain the rationale.

Please do not send both numbered and unnumbered patches like you
did. I have no idea which one is current.

Guenter

