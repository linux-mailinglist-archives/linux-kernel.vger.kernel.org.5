Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066D279E866
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbjIMMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjIMMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:55:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1B19B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:55:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501ce655fcbso10952195e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694609709; x=1695214509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBLmprqMznqvsNo4BlY3BI8teGbJT5a4oyp31xLgPZc=;
        b=EfvuG5IhpO9s/BOLvdfd9W1RBXSQqtnVEVrxcd5SxrcEEqNGKcxAn5p9qyJC+kCrlI
         160iV0iuwsgdyhyfstozKoZvICCjkuCzyZBma/nBD1cHX8cgU6edJaPGLIqc1weKxfef
         4ad+vNdbrplJGjX4W+JhAR7VB7MOSibQ/sUcmEZa8aj4s5YT385PwbbIcUpchqjLEetW
         QuzXEDTPy7RUSFkQmbo9A5G9DlHyGcjSrb5XzU1PCks/9hJT2iVMfy8pzTEdZnkQmnX2
         85Os8DEzTIQrk2n1I5JVIM/uvqndSLte5KltUPqV00FLVeCj/FxlHBHZp2K+5CFwmAo8
         ZtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609709; x=1695214509;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBLmprqMznqvsNo4BlY3BI8teGbJT5a4oyp31xLgPZc=;
        b=nxPkpk8/juokyZ1vsVOKTntmHYpOsvc1TleK1zntUIUvs3/qpgj1kuiIbzhEkO7D4c
         QzNPkQf/0m/4wPHsw7dHMM6AlX9arttAcwMocELWjmPZwkHehkPHfFHmP8GPu1KJncVF
         8WObUCeN65IzEHAur+fhnycsPrT1lhLDeHt4NfNxyuhJa6BY358hOZJGnf+PUCaHT2h5
         pmPX5G+uYkqWeYaJPK7lajdt9d8rcT6IalqBAJKhsjfaeSakVc3k6mQ19huJIVM0syYp
         mEeYQo32staIyZMqJHdBBsWf4qDBKP0zdFB9U7M88L1xT/stzNUzu9Yhv5nZ82vLud+R
         +ySw==
X-Gm-Message-State: AOJu0YybyAV5EqSrapGCJ3wGNuWEU1hl/OTNAS/FvqrDLCTkxp4mpmcF
        ZyXPdD9qj88eqG5nmmFMLmJLlQ==
X-Google-Smtp-Source: AGHT+IEg2jjdFCghXpK0VKM5rNLUqnXfSFdE9B4y6LBztGWV/ddOAMCFxBCTTvTQ53MRyH3o0P6YKQ==
X-Received: by 2002:a05:6512:3f15:b0:500:bffa:5b85 with SMTP id y21-20020a0565123f1500b00500bffa5b85mr2378368lfa.32.1694609709518;
        Wed, 13 Sep 2023 05:55:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r21-20020ac252b5000000b00501be736dc8sm2138848lfm.300.2023.09.13.05.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:55:08 -0700 (PDT)
Message-ID: <e16ebefd-2014-4089-baad-6c0d09813144@linaro.org>
Date:   Wed, 13 Sep 2023 15:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] drm/bridge_connector: implement OOB HPD handling
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230824235636.1436665-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20230824235636.1436665-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 02:56, Dmitry Baryshkov wrote:
> Note, numbering for this series starts from v5, since there were several
> revisions for this patchset under a different series title ([1]).
> 
> USB altmodes code would send OOB notifications to the drm_connector
> specified in the device tree. However as the MSM DP driver uses
> drm_bridge_connector, there is no way to receive these event directly.
> Implement a bridge between oob_hotplug_event and drm_bridge's
> hpd_notify.
> 
> Merge strategy: since this series touches i915 code, it might make sense
> to merge all three patches through drm-intel.

Dear drm-misc and drm-intel maintainers. Since the merge window has 
ended and the trees are fully open for the patches, I'd like to massage 
this patch series. We have R-B on all three patches. Heikki has acked 
the first patch, so it seems to be fine from the i915 point of view.

Is it fine to be merged via drm-misc? Would you like to pick it up into 
drm-intel?


> 
> [1] https://patchwork.freedesktop.org/series/103449/
> 
> Changes since v6:
> - Rebased on top of linux-next. Fixed the freshly added
>    new drm_connector_oob_hotplug_event() call.
> 
> Changes since v5:
> - Fixed checkpatch warning in the first patch (noted by intel-gfx CI).
> 
> Changes since v4:
> - Picked up the patchset
> - Dropped msm-specific patches
> - Changed drm_bridge_connector_oob_hotplug_event to call connector's HPD
>    callback directly, rather than going through the last bridge's
>    hpd_notify
> - Added proper fwnode for the drm_bridge_connector
> 
> Bjorn Andersson (1):
>    drm: Add HPD state to drm_connector_oob_hotplug_event()
> 
> Dmitry Baryshkov (2):
>    drm/bridge_connector: stop filtering events in
>      drm_bridge_connector_hpd_cb()
>    drm/bridge_connector: implement oob_hotplug_event
> 
>   drivers/gpu/drm/drm_bridge_connector.c        | 34 ++++++++++++++-----
>   drivers/gpu/drm/drm_connector.c               |  6 ++--
>   .../gpu/drm/i915/display/intel_display_core.h |  3 ++
>   drivers/gpu/drm/i915/display/intel_dp.c       | 17 ++++++++--
>   drivers/usb/typec/altmodes/displayport.c      | 17 +++++-----
>   include/drm/drm_connector.h                   |  6 ++--
>   6 files changed, 60 insertions(+), 23 deletions(-)
> 

-- 
With best wishes
Dmitry

