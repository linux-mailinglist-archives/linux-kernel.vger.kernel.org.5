Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962337F4BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjKVQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:09:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B69F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:09:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a98517f3so9177579e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700669370; x=1701274170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLCWxiFA7VVYyF6ZRceYWPi2g1OSM3YQHP6IyA6ESAk=;
        b=ONACCp9/wK3Od6y+KFsy5Hq1EHZWGKas/BW2Z44LBcurHbfQ3oCfX1jxA0/Kv1rRx6
         k3BEhfRSZy/KxCJpkSp98CEuadfGS/gZmx7fdqfH4ZC2yv6y3HTkN32jhNgL+AwXuk+5
         eMeAzl/waL5HT2JDERtSqnJlK48QAZYH352G7JKkbxpO+MOajAREvjfrcK7J+tcpBCAk
         tdtZVpg1cIS6dbPIjBSbpPuwgyjXXpn/j8RCNiRhTyTLulelyH8pyrBMTnSy9EY5mxy+
         WUGNUd0TeydJzP+O6Ou607o4BwV3Texu7I83cQMUv8jH8tbTMKDAJTTYw+HzGz+NbFCq
         7odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669370; x=1701274170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLCWxiFA7VVYyF6ZRceYWPi2g1OSM3YQHP6IyA6ESAk=;
        b=qhhHE+UtRHzxeLHNzeEX4J+Hfpvpuoreu1iUIE3nJBDMCfuTXgOhKvhCJi+tJivaMo
         0eJKZjiTaoe/hLn3SBY1VtnZ68CXEF9N02cAaJF5CMWjWSugsGRcmcD3Ie3ZjSTW7PYa
         wjjeQb54l9XEz9gu/Xv8tmfvQGxfmvdXLLNKj+mKiEA4DLIbB7tvQkinlHy1jXPgEkza
         keg1sgv+dNea9B6qyXB93o9T89kZgww3Nkxv+KCrXcU5NL1fZfscJ4L3URUUcGZRNetN
         HDDD49rk+T3as8JAuIsxCtyohKC3roazjepdc+2U2MOQ9lmf1ESIEo47+U2vEKYcDZzj
         yHTg==
X-Gm-Message-State: AOJu0Yw5G9VQHl1LxusglyN0zVhzcXqi1KSTP/GnuNH+BR898zsm7/fx
        wXpDlS753pfp8ixLCXpY9pFKbQ==
X-Google-Smtp-Source: AGHT+IERsO0nW03FwqjG4/xdsmEc+txIkZDHtnrRfnMv3I/o25pWcNZV6M93k6oa7AovrtcZR5Fl2A==
X-Received: by 2002:a19:5519:0:b0:507:ba28:1bc5 with SMTP id n25-20020a195519000000b00507ba281bc5mr2003640lfe.3.1700669369885;
        Wed, 22 Nov 2023 08:09:29 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m10-20020a0565120a8a00b004fb9536bc99sm1882136lfu.169.2023.11.22.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:09:29 -0800 (PST)
Message-ID: <124fd3be-ac01-4c1e-b9d6-63429487cf1e@linaro.org>
Date:   Wed, 22 Nov 2023 17:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a690: Fix reg values for a690
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231121162137.60488-1-robdclark@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121162137.60488-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 17:21, Rob Clark wrote:
> From: Danylo Piliaiev <dpiliaiev@igalia.com>
> 
> KGSL doesn't support a690 so all reg values were the same as
> on a660. Now we know the values and they are different from the
> windows driver.
> 
> This fixes hangs on D3D12 games and some CTS tests.
> 
> Signed-off-by: Danylo Piliaiev <dpiliaiev@igalia.com>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
Very interesting.. did you document how to get these on windows?

Konrad
