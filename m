Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C817FDB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjK2P0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjK2P0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:26:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254F198C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:26:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9b5b72983so23282241fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701271579; x=1701876379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MyM4IfQS+Dzj09XRcPbJN6APwuXnnue+rHLpk7D24A=;
        b=NaUuA/z8JUN8doWGcUvBfOd95lTiEbeXWapz80P909bXMxUYMUc/fJzaf3TnH4YLVC
         iVBx2W/hOtkgSPq4oyo4tMHbz9EOVNKbl2azsibB5/qcyLVu3wjjn13Ce2wB9udgVgaY
         2Zr8jB9wBJm7+/A6RhKG+JntbIOkyIJXoYuv+OV0AO+U6sRXGf2uNvg4H5w16JtZuNHt
         nFKi16GPR7+13wDHHqCD35YD/J/um9FCX4V1sKuIeCuPubSgOl/BrKKKUfIA8wQKf6pk
         C/fXwyrrWsTPjVNY/tko9nbT676w2A69hWs8Ab0eFAgM+KqmO9xQ/4chkNGOkVjSIaN+
         RfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271579; x=1701876379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MyM4IfQS+Dzj09XRcPbJN6APwuXnnue+rHLpk7D24A=;
        b=R7HrWkMyPyOEawA2WwHT17T9m7kB2DEIx1lC8X37+20fulhOzJ8IbMmygPqoelmaWf
         GPjOSakKQCg1FLVaSeOBqH+v3UKp6lm8Sj0cPPEUVefa92QOec8vQDj2ckMwCWn3t24N
         1/9L++hWynABzf8rGH2LLV+prNf+6SMMEGmDMV4OAB8l5YHBhNcEXzgyYZeQQ2T21GfU
         2O0HtaWK6rJcWQy2KvkCGOBkfk/c3pxocXt+CdirjAGuqEhB8pnaUJ9nLRrsmg2vVC5H
         32UeuC/BK0eAnK9zD492CeF/4C94zrkSSMo+wFLZk1dv6GLisSin9D/9BDAYuV+e7+bZ
         y7vA==
X-Gm-Message-State: AOJu0Yz5mmNqQRT16CzXD+oYArKR2VMRa7jpwehtqLexTRXMYazEKSvG
        SdNBp60qCu7W6UbcZy9NSKZ8Fg==
X-Google-Smtp-Source: AGHT+IFEzPTXAhffGcN6uSmni/T4wlbocmnSoSxuj2CbSVcyNNseiVePyIRac19jF7lpHUv5DmWk3Q==
X-Received: by 2002:a2e:9a14:0:b0:2c9:abae:d05e with SMTP id cy20-20020a2e9a14000000b002c9abaed05emr5621870ljb.13.1701271578787;
        Wed, 29 Nov 2023 07:26:18 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id g18-20020a5d5552000000b0032f7e832cabsm14788668wrw.90.2023.11.29.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:26:18 -0800 (PST)
Message-ID: <185c1c0e-c9f8-416b-8bcf-34070b1d8a37@linaro.org>
Date:   Wed, 29 Nov 2023 16:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: trip: Drop a redundant check from
 thermal_zone_set_trip()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <12350772.O9o76ZdvQC@kreacher> <4897451.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4897451.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 14:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes in the thermal framework, a trip points array is
> required for registering a thermal zone that is not tripless, so the
> tz->trips pointer in thermal_zone_set_trip() is never NULL and the
> check involving it is redundant.  Drop that check.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

