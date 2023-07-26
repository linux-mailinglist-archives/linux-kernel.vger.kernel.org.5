Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490F76317B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjGZJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGZJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:16:19 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB015584
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:12:32 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2B6DF3F094;
        Wed, 26 Jul 2023 11:12:29 +0200 (CEST)
Date:   Wed, 26 Jul 2023 11:12:27 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: msm: sm6125-mdss: drop unneeded
 status from examples
Message-ID: <7yjwlgxtavrlk4vnzhlclri6znofmwill6ubne5qrlmb2hf7sj@m3sc6zdde6rk>
References: <20230725101610.75122-1-krzysztof.kozlowski@linaro.org>
 <5w2hvzmwzqm4ffopzewveaviebq2ig7awimeo6ipcehx5a43ae@mlwffkf2ctn5>
 <11eca956-9e91-f645-9cc7-4c9f534d9821@linaro.org>
 <5576059f-ba53-1096-396e-ccfb5f9d86f1@linaro.org>
 <6cdef93d-85af-f12c-0782-da31728809df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdef93d-85af-f12c-0782-da31728809df@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-26 10:42:24, Dmitry Baryshkov wrote:
> On 26/07/2023 10:31, Krzysztof Kozlowski wrote:
> > On 26/07/2023 09:27, Krzysztof Kozlowski wrote:
> >> On 25/07/2023 13:46, Marijn Suijten wrote:
> >>> On 2023-07-25 12:16:10, Krzysztof Kozlowski wrote:
> >>>> Example DTS should not have 'status' property.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>   .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml   | 6 ------
> >>>
> >>> This is not needed: it has already been corrected in v3 and v4 of the
> >>> respective series (among other changes) and the patches were only picked
> >>> to a preliminary (draft) pull to get an overview of the outstanding work
> >>> for this subsystem.  That branch happens to be included in regular -next
> >>> releases though.
> >>>
> >>> 6.6 drm/msm display pull: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/69
> >>> v3: https://lore.kernel.org/linux-arm-msm/20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org/
> >>> v4: https://lore.kernel.org/linux-arm-msm/20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org/
> >>
> >> What do you mean? The old code (one I am fixing) is in current next...
> >>
> >> If this was fixed, why next gets some outdated branches of drm next?
> >> Each maintainers next tree is supposed to be fed into the next, without
> >> delays.
> >>
> > 
> > Ah, I think I understood - some work in progress was applied to
> > work-in-progress branch of drm/msm and this somehow got pushed to
> > linux-next? How anyone is supposed to work on next branches if they are
> > outdated or have stuff known to be incomplete?
> 
> The drm/msm & bindings parts were considered final, but then I failed to 
> send 'applied' series for some reason. And then it was natural for 
> Marijn to send an updated revision.

There were comments on some of the patches that would have an effect on
the binding parts (including the examples).

- Marijn
