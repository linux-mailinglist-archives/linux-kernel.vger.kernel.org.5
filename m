Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDE810E57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjLMKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjLMKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:25:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CB11A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:25:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so40607845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463101; x=1703067901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQqqojXk0aiAP1brw8pMue6niPDLmrRewlYFgt6/ims=;
        b=eEP5dEaBOMN2t1V4TGiy6aVU0QBoe4XbEVcCLvwsnjVAAyWGN2mraUrat8mA7hrp5e
         VE2AmKgmP9K3agSLqVxTAyCB+QYfRYZ1zXLX33BpJJbJSiGgx5/qLRIjoMDCQMaW8SvS
         idlRbpgAtVOWhHgIyud001jw7ILz9ioEraOyQq8DYnhbM6zbUJJqvsfZgh2YyRZkW8bq
         XIvDKRUuXqR/+x7VwJrMsJIQJVQJgGLAc0DLk55HF6zca9xm3PnZE9UVDBZe9hXIT1+1
         s5k/k3FVWWWkEFnFSk/eF6IitkKKm/OJh5BaNnNWLtTdBrKBOxUGhoW7ykFl3lpestzC
         ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463101; x=1703067901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQqqojXk0aiAP1brw8pMue6niPDLmrRewlYFgt6/ims=;
        b=Kaj5cHVCIrJskoLFAvtBAdf2Af7MR5CO8F/kD4WuXZakqy3a5QNTnchKKw8xsDNs0C
         7psLays77qD9fIYryRUK9U53NCW+DKuA7slb7pdjkLj1hK0gjDmbr5TEui0PrL8+qeog
         hv02uCl195PQlxMjQbu7qreig6emtiYRCGqiGRipylshXO5a1MCjK02bgdpc7eeXG03E
         JwhVpDSs9OlKqsu9bXVO5PsSYqYHrcFitTgaK9naqEtGDh8xED/q49ZijEFHBAKkHdwm
         4yCyQ3Iv4/lINXwPxzJ5G8Szuu3yJiXkaDgh3Ud5/6BIdwdXlU/dmZoEioKIewtpLCIE
         TN6w==
X-Gm-Message-State: AOJu0YyDwcl7KpHK7ZeI8gTdFLo9SdhwyYCWMOfKQ28IlTbBpAZ0JfzM
        5b45JeVtosvGiLzxGTZZckg8qw==
X-Google-Smtp-Source: AGHT+IEPzbfJzr/BdclUpmYaPORvN85dIh7O66b3k4tt6I6WAd5SgTDBZuw+u0Hebr28LeFqG/jd/g==
X-Received: by 2002:a05:600c:2296:b0:40c:2b13:95ee with SMTP id 22-20020a05600c229600b0040c2b1395eemr3692466wmf.38.1702463100644;
        Wed, 13 Dec 2023 02:25:00 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:25:00 -0800 (PST)
Message-ID: <3312c21e-72a3-43ef-99a5-2f429ed21083@linaro.org>
Date:   Wed, 13 Dec 2023 11:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: netlink: Use for_each_trip() in
 thermal_genl_cmd_tz_get_trip()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <2912793.e9J7NaK4W3@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2912793.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 20:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make thermal_genl_cmd_tz_get_trip() use for_each_trip() instead of an open-
> coded loop over trip indices.
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

