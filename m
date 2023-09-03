Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B5790F08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbjICWhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbjICWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:37:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2810F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:37:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31de47996c8so756565f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780661; x=1694385461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuInZybgE5C4HgdNIAED9cdqS6tn29myqOzFJ+qiKTc=;
        b=tg5yMk3TYnurFTljJZThZ2O05kKe5cOo55EJ7x2/er1L2m+boxPMhmf0U76AtOLBNK
         AEv9Z0Q1vWyN6xTWgUpsgx1iyXaS24Fv8kq79SV/NIHVp4++uRs/cuTjWfxExtnXkPmC
         kKMldMGyIW11KVQ8HVGPQsmRlCPW8hEsiEK5hJYGdBCqq0yy7vKKBcQZrQtBsXKI0iwQ
         IrFE+65BfzF7YW5pRF7FexQG92f43HhSP7wBh4jxs4e3NDeTm7ChRuklEb+hm2jWozPf
         41Dw2wWWAxncDoaekN0/ilw+7nQsyAl2RrL6S8yxPFCympLlfdzqCRPnjh5CBD5cYJlN
         w7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780661; x=1694385461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuInZybgE5C4HgdNIAED9cdqS6tn29myqOzFJ+qiKTc=;
        b=fb4UmcaSbwJUOlhIDFP5jaXDrxS5TpVsTg+tljXR5c1q8Jrdhag6A2LC5/a323/Z5i
         cvVMh3zbuz//kvfn7O/0GLlHRJt1VO+3FCa0Uen1h5WdMe7iPAHsdtRqvks/6G3W+c71
         tClf1ew8Rzy9rgA+JzmjspVyYu66ILgSMWvTj7wq5PxL3K0E3ySeoMK2vSR1KXSQfHz2
         Jaa1nnpV1Ghuq4iIYPKP90EPc3duKYZGISlHaz4Xm+TlmeLqb5UJQA9c3iKzA25nwg0G
         HyZjg3qsSAWZCDR/C5x36ODsC0HI66jPocCLe+rggoNKffur8L8ZimqHrrIy8aX/Z1kx
         kPLg==
X-Gm-Message-State: AOJu0Yy7qYmx9eC+qphGslZWKa4h1acgjbh32AOR1bZuAv6PYBxAaa3Z
        ByuSIwiKpsNk4ORHEM15Bg5DMmyXrmu2IDmyoXU=
X-Google-Smtp-Source: AGHT+IEE16n0PDj07eAurnl3CVbsLgtJrkqgHUlTveydUibtGonutI7dAHGUS2oR1eZ0UqelpiUnPg==
X-Received: by 2002:a5d:424b:0:b0:317:3dff:7189 with SMTP id s11-20020a5d424b000000b003173dff7189mr6066598wrr.66.1693780661484;
        Sun, 03 Sep 2023 15:37:41 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:37:41 -0700 (PDT)
Message-ID: <642a5b5b-0979-4d9b-a5e3-9432afe062d4@linaro.org>
Date:   Mon, 4 Sep 2023 01:37:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/msm/dp: Use drm_dp_read_sink_count() helper
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230829184735.2841739-1-swboyd@chromium.org>
 <20230829184735.2841739-3-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-3-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 21:47, Stephen Boyd wrote:
> Use the common function drm_dp_read_sink_count() instead of open-coding
> it. This shrinks the kernel text a tiny bit.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

