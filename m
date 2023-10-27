Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CA7D96C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbjJ0Lgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0Lgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:36:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EDC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:36:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc1e1e74beso5790705ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698406607; x=1699011407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDwjqowg7Zrd4/ylWaFwQEbjnWgohyg1A6T4D72inu4=;
        b=dUBNPgM5hYoLY2rDo/jvFaCp9Jr5pI1m4zWNKsa/n9D03i6ope8qnAS+XmwXjLjNYf
         FBVi21BpkkzaDS1ulIvBxl0PuiiamwrLTRI9xbkqofyUO6B4YuyzBHFRqZzrt9rP6Qmr
         jJi2o5WCbp5R/1JBQD9Ldeql2JXa0/11FkOKSMnSoRV5j7AiSvSm2dHfYqSV/QfYoDnM
         jjzk601F3eQdryINzRzvAjLQfwCnC8VlcOhb4Elx7SkpNPdh7nSUTc0JxoF5NhkY9hde
         GOAYS8h1+sfj0BZwDy5eaYPXQI1mlKG9cGO52dK31rGmj9snZdKbTmA5IWKORQgDYLv2
         A3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698406607; x=1699011407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDwjqowg7Zrd4/ylWaFwQEbjnWgohyg1A6T4D72inu4=;
        b=mt2t7Q+VmbeGcLz9df+3qEzw1aGotTiuABDn0i91tAZ5f+IeU8J/Q1DmGz/bJble1g
         bGbDaPxRb7MrFEC+QFpH7T/qwFG4XjMqRV3dW3vu+UiLXROKEqH/Bj+IrfpS6Ud6aKM2
         Xo9TF4UJNd01f6QooyRAinaIQaYgXKQxFGEaK7zdHVsV6VV9ROwUwb1/+oBmr1dQdcqD
         /vw2IjvutpOtZxbhP/EPfDqmRZO0ESjEE0ojI9lagWRlQqk5O+UDSQJRegnUB575Ggms
         lQkRtNq3HksnU2W+NiiPq9FNFG4nf8+N0nlVfsXneIpSsmkWsnAH42kaZSN/vfSjgH/F
         G0fA==
X-Gm-Message-State: AOJu0Yy/jkrGgryTG0lAATQXBNVeZ6Qq5WQjJ59dVp2PhyTTC/Qsnw8l
        O4KXQWiS8PY64vcSx2v58kg5LQ==
X-Google-Smtp-Source: AGHT+IHVsIfoDbOy4+X8I5FT6mPSPc0z0mqlYPS9uLRfLK2ofGl7sjmUBXMd3PVlCTJhP9bmcosN3w==
X-Received: by 2002:a17:902:da84:b0:1c3:323f:f531 with SMTP id j4-20020a170902da8400b001c3323ff531mr2565938plx.20.1698406607299;
        Fri, 27 Oct 2023 04:36:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:c232:f53e:32d4:5510? (2403-580d-82f4-0-c232-f53e-32d4-5510.ip6.aussiebb.net. [2403:580d:82f4:0:c232:f53e:32d4:5510])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b392bf9192sm1345104plx.145.2023.10.27.04.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 04:36:46 -0700 (PDT)
Message-ID: <ac79297c-9f4d-4776-a48e-2f06e348b38c@tweaklogic.com>
Date:   Fri, 27 Oct 2023 22:06:38 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <ZTuZ/Y2Go/RGOG7U@smile.fi.intel.com>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <ZTuZ/Y2Go/RGOG7U@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please, do not send so often this big patches (~1.5kLoC!), let reviewers a bit
> of time, please.
> 
> Since I have my message postponed, I finish review on the v1, and I believe
> 100% of those comments will be applicable here.
> 
Hi Andy,
v1 broke the kernel build, which was bit embarrassing as I skipped compilation on
latest kernel and only tested on my embedded test bench, so I submitted v2 that early,
sorry about that, I understand, won't happen again. I am not in a hurry either!

Regards,
Subhajit Ghosh

