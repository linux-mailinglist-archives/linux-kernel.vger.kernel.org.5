Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0CD7B14DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjI1H2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1H2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:28:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C99C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:28:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317c3ac7339so12065866f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695886098; x=1696490898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+eHxg0xTah69doYWtwb3xmqSGP3W/4JsRuYUBMyy90=;
        b=HRzVT5LJFfeFHsA9PJuHANQuIMWT8jso4lvbqbCtgoAWcZtczokgNMafpmLBYZd1Qg
         4zs+evEFqWI+E6h7s6eQPzQnlwd9gU1viAiimV/JsLAggFPXqUqd1WrNXwbUebt7LYv8
         K86L8DYv1aAkawCZh92cVviCJ26zmrRg3zsfoSGkGGlKVO2dTZuDtnOi2IIpLU5fDYOJ
         MyBkLW1oFeQt2bTR5YQ7KQHwmqsgNkC7fZfkXvsg7BLV67/oq82EPQrstKwOzB/S9d2M
         HEo2bsQUlWD8avFFsVzw3mnwsDSgVbbcgA0M1g9zDv4eINdCMCzRseIMCud4jZ4D9w7a
         cX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695886098; x=1696490898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+eHxg0xTah69doYWtwb3xmqSGP3W/4JsRuYUBMyy90=;
        b=jaBbzWUVLQYtRV3xfDmHyIxxHVbyxiOPyk/QQTWbNmKhmG/5vN4JOKTfpZsWdCNlM7
         v99v1LwNP8KAuo+yleIYU/MEQsRs4wzkHjkNpYlB9wgvA7nXfEZZssV2qu0LwvrN8OBU
         3uh2B9GOI4oP4Udsks83SmZZaOUcy76Q6FSYOGqWn1sy68P+8t12pnicAL4VlzURDSFf
         JQBR+N0HKaMFDhzjlJgB0X4s8lKjwF/ua5MrLzb/Yghi646zJOp6I1Luhh1lrky9bKDt
         mt9XkpABYi3uSGRXLQlFyV3Ra5EYDEU/tOoT6P/eP+05rQ827HO8oPHKqZHomCvh5m49
         OBSQ==
X-Gm-Message-State: AOJu0YzKp0D/HHIpPZMqAmK+RD/r1bTUSAUf0BsDv5XeyemNZfJVMasO
        1RxrGU1DxLyCKQPTtaWQz55xyw==
X-Google-Smtp-Source: AGHT+IGm3aLmn1Vs2pRb4cnjAOVEm+CwfdP8RHwHV1ILVOpFUpwOuuXw0e0ssaSLKQ3S3zeXZTd9DQ==
X-Received: by 2002:a5d:4049:0:b0:31f:b0ba:f2ce with SMTP id w9-20020a5d4049000000b0031fb0baf2cemr557778wrp.9.1695886097861;
        Thu, 28 Sep 2023 00:28:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id u26-20020adfa19a000000b003232d122dbfsm8613143wru.66.2023.09.28.00.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:28:17 -0700 (PDT)
Message-ID: <a509f509-c9a8-15d3-cb79-fd6594cfb8af@linaro.org>
Date:   Thu, 28 Sep 2023 09:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 13/13] ACPI: thermal: Rename structure fields holding
 temperature in deci-Kelvin
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1968603.yKVeVyVuyW@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1968603.yKVeVyVuyW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 20:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1]
> 
> Rename structure fields holding temperature values in deci-Kelvin so as
> to avoid temperature units confusion.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

