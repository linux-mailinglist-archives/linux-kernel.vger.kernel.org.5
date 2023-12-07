Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD795808F05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443525AbjLGRq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443447AbjLGRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:46:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F6122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:46:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso1010567e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701971191; x=1702575991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGUmHRmln8DP4EE62sw2lHmfeRIdxm/F82mL/B18p/E=;
        b=y+4ylONgVwGIAeYF0YkvSF00YeTcc5LsYRLoA/XpKYeqq+sp2tuivQgOKRT9n7XmsM
         X10//SEDgND0UwG4JtPxiCfF/t1Cs0yD7FvHIQ1AU/iI+jbGDelYt4CScDztEkHMlwXG
         27eWdGqsVSi3kY+J0Rg5oymTF6mwrx8h8ohXc0eFtb8wLEgoVDaAtutIwf3TKVQs22EH
         Guh6RmuSMYOKMFn6FJBmm1l2Nl3XZNcYAKP1S3ybZjxgsoYsTqdyZI4JQ9Gq5mCt9L7h
         8SdKuw3duKFwoyD7vHB2oR8TKlUuhhoBAfo/9DpRSuWDLuxhYyIbp9OUaAN4z9kqnPLL
         VDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971191; x=1702575991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGUmHRmln8DP4EE62sw2lHmfeRIdxm/F82mL/B18p/E=;
        b=KPlRJzIAg8XvBR6/46ECFKM9uRRsKrg21aSpcwbMwBzBligPDg7jKDOj33sVBJy8fh
         ns0on3hQZO9q9VqE6o7mr5lVeKvIElJcJIYPJESRx1/PaDZr7eJGJx82cyuZs3hJ/Dak
         UHmKlvOZtDTELr6UqY26D2/r1QWD+61YgPsLo53QVyP9iGBT/fVX5XF58HURGxc10NnA
         7KpCgxhISWy0PSQl9ZYb+othJEx4ylCgz4MNlj+0pH5Mu9UU808ObbAA+DcHBDGow2PN
         LJsRzUpIXHn+IIR4lmH/jCXCCYSGSVysYG/lJIgMD3AD3PV9NeiI2wU0Xz3BAIqqPdsR
         7siA==
X-Gm-Message-State: AOJu0YyNFz+2XJzQFO39ch4dJy6zigF5vvcaVaoIL4Tkv7QrndJhfSiZ
        8zi4SLtIJPcdU+jyTs5pPm2KYg==
X-Google-Smtp-Source: AGHT+IGId3IiWKAJbXeNT1pFpXcM//meJSbjrhj6lRBl8HMJKQpzFOSvyCV90rS4L6aJzvAqrhw9pQ==
X-Received: by 2002:a05:6512:1089:b0:50b:e52a:3099 with SMTP id j9-20020a056512108900b0050be52a3099mr2028897lfg.32.1701971191012;
        Thu, 07 Dec 2023 09:46:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24e71000000b0050bf4b084c0sm6275lfs.164.2023.12.07.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:46:30 -0800 (PST)
Message-ID: <ce2a739b-dfff-4913-a76e-bc99a22f7d7f@linaro.org>
Date:   Thu, 7 Dec 2023 19:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: aux-hpd: Replace of_device.h with explicit
 include
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231207162501.2629952-1-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231207162501.2629952-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 18:25, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. Soon the implicit includes are going to be removed.
> 
> of_device.h isn't needed, but of.h is for of_node_put().
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/bridge/aux-hpd-bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

