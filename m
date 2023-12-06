Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70D806E16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377650AbjLFLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377543AbjLFLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:35:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48A10A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:35:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3333224c7b9so617874f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862532; x=1702467332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFi3RIKaDzGCbVA6KICHAZ/fzez2DnzNL78+4AOaMUg=;
        b=qTEqmaQl4jQyV1WEhUon5myflgy8sP2JOUSQ6KuBtPZkZ+M5SRZLG1dAkN+1RI8M3a
         rNn1R9eB53QSvSYt5eG/ESGyOTDkGs4UyWf88zocXArcpjjgDLx+PvqMkRHParzXLOSf
         ECDF3iPULQvsthKH9zsAzHSHRtrhVWQKm2KLIRPEi56K8d1idqS7SpRIp5F8Qz4rJNOS
         stFERw5W/XfGslakE7wblcBg5CO22HNgh3N/EKBYvJ905hJ/rBTOO7vPf3EdckG9LfWM
         3Qjgx/MtZq05kFBNPJU9KaHnflTue0JZpQHK79VOTsK49qWYf919vjBRQCoAOv0aQaBf
         d4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862532; x=1702467332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFi3RIKaDzGCbVA6KICHAZ/fzez2DnzNL78+4AOaMUg=;
        b=av8ZelEHWnT0QRBZU2rnbotiQSm221xI44cB91iFofzIr2+s2gJcQLO0/Mv+WWfCsk
         dWWDCYKTBVrzEbbjPXeCSjy+mmDVYKkxcVA1oUYADjGeMegimVlRJMPUh45JvVZKNgto
         I+EWDO5qn9/8WrkboYIrnaqlDEfE6JePzscA26w/fElgfZP0SY/dz8voE1zpiLewPS6c
         4rfv0TNE6fbwLOT9vJENEZ8gJfmTeq5734kdPjiIxRSaeLFfK584FKvE4TjDRreKgtc0
         lcyA7wUG/T7/jgUToqtsiMj7j5+E81ZYRsUDnkn12wVT7VIZz+Oc5oV0ieA5WBAknoL9
         oiyg==
X-Gm-Message-State: AOJu0Yzpq8hPxvlIjvPjHlxALpw0LRK8fYII9A66N3PlKeozAjJN4i4n
        qLughyvCmLtFVkHuQpgny35nnA==
X-Google-Smtp-Source: AGHT+IG1WDr950Oeo2ODHgV1WggcJ9DJetRbXRF39Itxtkz7EB5G09m3ExKEKMIjKUuFuvii6q+nHw==
X-Received: by 2002:adf:f686:0:b0:333:5446:922a with SMTP id v6-20020adff686000000b003335446922amr432257wrp.32.1701862531641;
        Wed, 06 Dec 2023 03:35:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q18-20020a05600000d200b003334041c3edsm9983744wrx.41.2023.12.06.03.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:35:31 -0800 (PST)
Message-ID: <54af71bb-60e8-4f9c-84d5-0d741e6964c8@linaro.org>
Date:   Wed, 6 Dec 2023 12:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] thermal: sysfs: Rework the reading of trip point
 attributes
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <12337662.O9o76ZdvQC@kreacher> <4854305.GXAFRqVoOG@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4854305.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 13:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rework the _show() callback functions for the trip point temperature,
> hysteresis and type attributes to avoid copying the values of struct
> thermal_trip fields that they do not use and make them carry out the
> same validation checks as the corresponding _store() callback functions.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v3 -> v4: Don't check trip_id against boundaries in the _show routines
>            for trip type, temperature and hysteresis (Daniel).
> 
> v2 -> v3: Drop a redundant 'ret' check at the end of trip_point_hyst_show.
> 
> v1 -> v2: Do not drop thermal zone locking from the _store() callback functions.
> 
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

