Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCF806E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377684AbjLFLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377585AbjLFLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:33:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F11BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:33:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c09dfa03cso38315255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862385; x=1702467185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVOy+xIVPDzsighaco+7FzAHWPggjXl/SyI7kXPYVS4=;
        b=QRRm2VuFsvdhsh+gx/mGSmSu2BHlFwGhUxOZm2vEG5v1r4SUKT+8Si9AMrRl0dqaLO
         iCx8zYz2TybmQRZtilolJAqulibi74L04+cNFZvz2szXaG5Bv6B91N3x8E6gM6c/piXl
         xd62SQ1F3BEoEwvVVZzPgJmPsqxG/rEKOWRjUdG2uKdyjXOaAjD8XRJqJ8qjB95GrCfl
         4TdQzvEzW408Iy9ETs64fUn3BjtL6eRUzZctbh3OqHF/ke8Un4KIFCN78011BsmDmA0g
         uYIwSnS2PSMsEZUwg8PYVRtUG5RT1hC3q9iQ0UZhea8Op777oO0hfSABz1vPHGKAo3iL
         oVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862385; x=1702467185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOy+xIVPDzsighaco+7FzAHWPggjXl/SyI7kXPYVS4=;
        b=Wpy7iN2Fq0lK0MSh/Q63a4/Achut45ZZsPI0X4zwkjuulp9ms2fHQb7UZyn3TZ80MN
         azLP89pzvR0BR7TFb1SArrv8AFGKkJKrB0x/OjAChie/vzN2x3mII6LZszpO68yJPZMn
         KyOHwjGjIlHaqXOzNpir/DmX4tKA/+EJ4F4ON4eaB8USZfEhS2iuYHVKUJ4b3PzP2fUj
         QDmMYs3Owcuz3xaO4YFoljPYIW77s90bbJL5sD6zs/Vxtvi1vNeHP8oBjaFct9Ivby+/
         LUlyxpMlGGC7pKuPOMdGL4nP0HC0Z5632G7nTF8auataZhHgwfCKXu480qE178SQelq3
         NrCQ==
X-Gm-Message-State: AOJu0YzYKIrw8sc9kH2Tc/j2tQseeMXwwUGOMxSTURqwjhfMloisHGtB
        KTHv7CoJg4N702JJkSoqXcgucQ==
X-Google-Smtp-Source: AGHT+IFTLrukb+Vz598ttYpjIdkTKcdA6ZNWu7MtBTIc70l0z/SJbaXoUx1RTGJOmn2t2Ku6ghisbg==
X-Received: by 2002:a05:600c:4a12:b0:40b:5e21:d338 with SMTP id c18-20020a05600c4a1200b0040b5e21d338mr526890wmp.65.1701862384945;
        Wed, 06 Dec 2023 03:33:04 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id e5-20020a5d4e85000000b0033333bee379sm13279430wru.107.2023.12.06.03.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:33:04 -0800 (PST)
Message-ID: <43046604-c67c-455e-8878-01425be40c60@linaro.org>
Date:   Wed, 6 Dec 2023 12:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <12337662.O9o76ZdvQC@kreacher> <4882089.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4882089.31r3eYUQgx@kreacher>
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

On 05/12/2023 13:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, input processing need not be done under the thermal zone lock
> in any of these functions.
> 
> Rework trip_point_temp_store() and trip_point_hyst_store() to address
> the above, move the part of thermal_zone_set_trip() that is still
> useful to a new function called thermal_zone_trip_updated() and drop
> the rest of it.
> 
> While at it, make trip_point_hyst_store() reject negative hysteresis
> values.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

