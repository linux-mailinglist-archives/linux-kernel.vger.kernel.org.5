Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52A7C4D29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJKIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJKIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:30:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606BAF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:30:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406618d0992so63217535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697013040; x=1697617840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q89QYEKjqqOkXqmFwAemha7CMh3b6/u3A5jv/kKqyco=;
        b=xAyM2udP+76S0R2tHE2+PDrLlP0UdXRhNb2Sm4OrmAYWds9uTRRKyN2lhuZ21ZMj+a
         ZNqp5Zewle7LKAERhEhdtd73Njx+hJlnElbiIs9NIfXiLAOv/oldlahTvlwqnluoT39q
         cTvS2aUK5/0GlYmsiPlKCCRd0Z+OYS04xbacgNCYfTBz7H4WX10iK6ZrMBAKX/CoNwyh
         9LSOSMwDWANrR8szzHZq5bjM/dum4MKJ+k9kkOboTgTw4rxg+Q/qQ/pz58oOP0XLJd8Q
         S92UpF63KgEZ6eN5QDACIvpqwYm2dyJxuvadkD2zwcbUGSAhh+hwuwTZjxs+irEOqtE/
         Mntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013040; x=1697617840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q89QYEKjqqOkXqmFwAemha7CMh3b6/u3A5jv/kKqyco=;
        b=YZtJZTeMDEaHZ9o2SZdVfHNgF2GYb4xffBHLgFhBEONeZ/cZVz2SL7PPEe5qjlC8+o
         iRqi07MJLS66ROMogqQ4EQhY0BRPg8Ra4WAeuoJgz+QoLS5xqy1BLN/INjmbqcGIniPa
         zJTFgeCidGniJjMS5TtYZ/D0+T5FqpjcDj4Th0HLhu1jdRxoSiTsichi1f0lMS3CHY2M
         j6wF4u7E9+kyjQOuEKjkRna3+zW2NYxV1Z87PGTp5BJiMbrQbjo6YxEDjSOZPcudwhj2
         YzP51jDf9Rv9NQ5JzIXQJABIpmb3QX5qoirV45tTY7A1zOg/L3O9NyvtoXjQNcjEnA8g
         QwXQ==
X-Gm-Message-State: AOJu0Ywcrh/39T6XYvgrAzulTgcNAOVpX1YbOR3HiFnBbdhIchmue8Wa
        j7K7Jg7ajuypjYyBRX5e15IQgg==
X-Google-Smtp-Source: AGHT+IEJmj7FAG63W5BOcG9j3NXU2+CNVoNONMNIj83jrlLyDxWA9M4uPvwB67jJNTTTdbOoGmdHUA==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id n9-20020a7bc5c9000000b0040302724414mr17978269wmk.0.1697013040063;
        Wed, 11 Oct 2023 01:30:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id 11-20020a05600c230b00b004053a6b8c41sm16036062wmo.12.2023.10.11.01.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:30:39 -0700 (PDT)
Message-ID: <a56ea45c-f1cb-4f9a-bfc9-d6af3282b13a@linaro.org>
Date:   Wed, 11 Oct 2023 10:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm
 after finalizing cpucaps
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
References: <20230907133410.3817800-1-mark.rutland@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230907133410.3817800-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 15:34, Mark Rutland wrote:
> We attempt to initialize each CPU's arch_timer event stream in
> arch_timer_evtstrm_enable(), which we call from the
> arch_timer_starting_cpu() cpu hotplug callback which is registered early
> in boot. As this is registered before we initialize the system cpucaps,
> the test for ARM64_HAS_ECV will always be false for CPUs present at boot
> time, and will only be taken into account for CPUs onlined late
> (including those which are hotplugged out and in again).
> 
> Due to this, CPUs present and boot time may not use the intended divider
> and scale factor to generate the event stream, and may differ from other
> CPUs.
> 
> Correct this by only initializing the event stream after cpucaps have been
> finalized, registering a separate CPU hotplug callback for the event stream
> configuration. Since the caps must be finalized by this point, use
> spus_have_final_cap() to verify this.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

