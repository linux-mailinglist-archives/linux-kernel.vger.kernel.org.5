Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8047AEF79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjIZPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:17:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E414116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:17:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso58171825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695741437; x=1696346237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FWdB7qhp/3C5VtANSk0XKiYCoQcsCA0ol/IvxkxQeo=;
        b=AvshJ6ESUgBnI8Ov2PCIPVkjyY1YNqZecyG9RXB4qwy6Jy52CqPyQam+14vgyz1LdX
         VlG1P+ghPv+ZJ+8hf+b/RwAc5Z9dDnZQCM7C/ZcxMiVFDMibQ9D+WTR03qhyiiOrSIae
         MolEZaaGzeDwrNH1Yw+xxIT5OWb1xuSRbRcS/NtKNTkuMz4WMCHUyJboykklmIm/lvMR
         f3R3TASw6hTMYL25+zhP6Jlc7VybKkuMdfmepSswFzMjNHs4J/RuwuFgBBHMBh0wpFmO
         IG+xP1TG0Ct7ebgSdmKq/NE6948eQXpn7kpYp8lj3WfdY5hB9+FaizFcRWxYhnoBLVNH
         Rh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741437; x=1696346237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FWdB7qhp/3C5VtANSk0XKiYCoQcsCA0ol/IvxkxQeo=;
        b=eiRz+RDW+yRLpVrUNX7FASgKYXsBkMIqtk4DeeRIx6TenAs1sRYTiNhZuSP9cZEb1T
         Un6mvOk2fXhyby0jK/pUUH8Wz1RSljAEG2MMyuJVHlU3bu/CVBpq4jArFMOZDKBTn4Dn
         P6os+MWhH9TjWjxvqYNidAXQKBuLV/fXNlN37Kd7RhKcvB1sPXkscI/8akW1UrCZrNaN
         mxPjjXWOGGdjva2SP2Uxry9U5L4bdPSMg2LM4bZqOZRFgsEE+PEpvixoG85FF/UciVNC
         i5YpUSwdYJ3Kd3BZtgYAhmNzRl07QHniMKLuCmIJKfUiuhLyJvFKRQKg/kLCoh61HtlO
         e4RQ==
X-Gm-Message-State: AOJu0Ywk46/ENoSlQ/8A91A3QHCLfUHqbyvUulLqIenKwkke2BS/STJB
        ExTNg6+3XUG1faHOZEHyMFXV4Q==
X-Google-Smtp-Source: AGHT+IHsvgVlVREkoHRutvomMmLWajv1KGTWZoTcUqi819hwRXvDmOVmKuYCDaeXtgrHC/2PQzXfew==
X-Received: by 2002:a05:600c:2198:b0:404:7462:1f6f with SMTP id e24-20020a05600c219800b0040474621f6fmr9265427wme.8.1695741436758;
        Tue, 26 Sep 2023 08:17:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x10-20020a05600c21ca00b004051b994014sm18189127wmj.19.2023.09.26.08.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:17:16 -0700 (PDT)
Message-ID: <0fb4f640-ad62-206f-7122-c0a3aaad319d@linaro.org>
Date:   Tue, 26 Sep 2023 17:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 01/13] ACPI: thermal: Add device list to struct
 acpi_thermal_trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <7586104.EvYhyI6sBW@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7586104.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 19:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The device lists present in struct acpi_thermal_passive and struct
> acpi_thermal_active can be located in struct acpi_thermal_trip which
> then will allow the same code to be used for handling both the passive
> and active trip points, so make that change.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

