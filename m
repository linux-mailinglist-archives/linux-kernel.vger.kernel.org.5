Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619097AC762
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIXJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjIXJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:41:54 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749710B;
        Sun, 24 Sep 2023 02:41:46 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id kJQ6q4SUuWU1ckLcYqXMUv; Sun, 24 Sep 2023 09:41:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id kLcXqnsVhVpk9kLcXqe4I9; Sun, 24 Sep 2023 09:41:45 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=65100459
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LJpKFYI8HAurZQUNChdEApljY9SFiaiFueT/5w9ez8A=; b=WyNj3hQ4m7k99wwrLc5UCHs1Jc
        69JnjimjP16rPGM6Z286Pdu1EnpdBf8mvn8UjKRtZI4bAMSZGQvQ1d9x7xbbF7jhGmj8i/KfgpVr7
        c6kMdlOOArSNLIvPI7ALTr7ZlFSq7jOM6qDaQO6AiuyehwfBegbjTZSqAQxzkVDGe842WreDX4kmx
        XHRRkPtm2Lm/yGKMlAU/xXjqaVY17tUk+7nbeeqd30QAFyaig/PT4oxogP8/FHPvh54Qsp4aKp1TB
        3O/2rSe65FJAdRxmlsC+oYSc83Oe5/HxuSX2iIA+whoUWfQqwbJkO09DT4sckq66htTHHi6PRZ1hS
        7w0+uMIg==;
Received: from [94.239.20.48] (port=43422 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjkgF-000Q0w-1S;
        Fri, 22 Sep 2023 13:15:07 -0500
Message-ID: <1916c681-cc7b-c101-de7d-5e9e0746c0c1@embeddedor.com>
Date:   Fri, 22 Sep 2023 20:15:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Emma Anholt <emma@anholt.net>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@Intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-5-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922173216.3823169-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkgF-000Q0w-1S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCxE3WD6exDlnOmD0zV1OLqGyrFfBSwzJN2uXCqrNCXIUzfLGJUZDcVlAOdUJPv8yknQV64bkxokpOyYPpucOmwJL0QXtLOzhU65rg8kdbdKDCEfpbIV
 eFHr8Sp1pJQJQX2baE4fEWLNBr1QU5paOTJ81dbAdrygtecAzaFRr+H8lo3+nZLgIn+rJD7IECLw1QvXaPZCrpyDZA2WJWRegOzib6NQuaJXS91zpVB93dKi
 LTbUHZZpKryO5t3d8KJePW5ML/XCdXKSQEJvfL7HARlzlZOKBpaC627BA6hz+81fA0ano0YowWq4hg4VsvWsuQ==
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:32, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> index 6ae25d3e7f45..c011227f7052 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> @@ -82,7 +82,7 @@ struct nvkm_perfdom {
>   	u8  mode;
>   	u32 clk;
>   	u16 signal_nr;
> -	struct nvkm_perfsig signal[];
> +	struct nvkm_perfsig signal[] __counted_by(signal_nr);
>   };
>   
>   struct nvkm_funcdom {
