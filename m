Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68C97ADC86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjIYP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjIYP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:59:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBF411C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:59:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3231d6504e1so3100319f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695657553; x=1696262353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GneicmgZfpXE6hx2WHE29gWRFXhiOHILZTpcrUZlhUs=;
        b=eO0GQOk9rO3VWfe5L4Zn1t3B+hziKSgid0CunDNrkfKvz2gGhHd/kaJupXAdSbrBlH
         ziOjRMiP/vofXhHsS18kTIp0+zArqtf2OT2oXPwHzLvlBjzmmH3oy/SbpEEMWV3GAeXG
         fMnfQZjQjC8f6VukFun6dGY3s0EnruVCWjJ/zIUhmOygioc1Zti0Q2nkm/Dahr+dv4lD
         JOaI+8Kzgk0fE3ZXtRonoVxk2qceLtQPmf4YvOd/RO0Sh6FHxdvGyKzuD8beWNScAtXK
         sgscV0wrXRnro5x10eh+O3OddhX6c7u7bPJFKdrvrPmnAp2inYWnh+tPCT+gErVJQlsP
         5qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657553; x=1696262353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GneicmgZfpXE6hx2WHE29gWRFXhiOHILZTpcrUZlhUs=;
        b=NpKVXWCzwrWwxkjGVf0TJ7gGyJJOjmtr2jihVf7JTEoCzhTVlJGHxYdnNU9CmsRng/
         Hy6qYvBOJjRbXJjVY5bcIsulBIhVEyRVrDJJ9xgvfk+hvhq8VzRgFiHC515mc9UyJJAt
         xCbnWHMtQcqH2B2FlgldbhuELqo8rb960lHVy9dwpfpDxA9vD+iukiiZ3N75hkbgUYfs
         2WWnJdkAf4m3ClNQKdl1tNZFkT1B7ME4rlznZK7ax5eqEng69NkOc1oifv8J6UwRqQBv
         TAcWIjcYsLuKE9115Ql9o3ceONXNfTUb9IwJ+aIyu/1aAvnu4bkjsWx8XBd4sVcgrRLM
         jAQA==
X-Gm-Message-State: AOJu0Ywr2VuazczvmEkwReGh4snGLfOK68KandD2dLKKvBfiYNoBrYfV
        snyoh52r20N9Mc3fp4dbpHf05hgTemsikfp2ebc=
X-Google-Smtp-Source: AGHT+IHaL2nHE+gPfmVIVjPbQh46rGimWfCVGxsyc2a2vOkwGLunOTR0JtGlIvoOswcgNExhEDbq/g==
X-Received: by 2002:a5d:6084:0:b0:320:7fa:c71e with SMTP id w4-20020a5d6084000000b0032007fac71emr6996682wrt.15.1695657552615;
        Mon, 25 Sep 2023 08:59:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id o13-20020adfeacd000000b00317f3fd21b7sm12307395wrn.80.2023.09.25.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:59:12 -0700 (PDT)
Message-ID: <9fcd9003-c210-be46-6a25-460ad6c0e53a@linaro.org>
Date:   Mon, 25 Sep 2023 17:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/9] ACPI: thermal: Determine the number of trip points
 earlier
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <1863318.tdWV9SEqCh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1863318.tdWV9SEqCh@kreacher>
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

On 12/09/2023 20:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Compute the number of trip points in acpi_thermal_add() so as to allow the
> driver's data structures to be simplified going forward.
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

