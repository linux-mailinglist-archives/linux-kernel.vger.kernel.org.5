Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFC75B793
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGTTK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGTTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:10:54 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B19E;
        Thu, 20 Jul 2023 12:10:53 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D3A55202E0;
        Thu, 20 Jul 2023 21:10:50 +0200 (CEST)
Date:   Thu, 20 Jul 2023 21:10:49 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Message-ID: <m425lafv5gvrnyhoarasqgkoumntgsxiqdpmsudcxrwspvf6ed@al5sr3t2mwec>
References: <20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org>
 <20230718-sm6125-dpu-v3-6-6c5a56e99820@somainline.org>
 <3ce19d8f-97d8-15b6-5148-78e200b112e9@linaro.org>
 <tpkiplw7l2mzdwekynkrg6dwm7svktwm2zooodb3c42btyvo3e@yjrpqem26wtx>
 <CAA8EJprHEes5T1z4-sxg_Xk+VjuyoTH0Ra-VyMnrWjTv7qG9EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprHEes5T1z4-sxg_Xk+VjuyoTH0Ra-VyMnrWjTv7qG9EA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-20 01:24:27, Dmitry Baryshkov wrote:
> On Thu, 20 Jul 2023 at 01:09, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > On 2023-07-19 01:06:03, Dmitry Baryshkov wrote:
> > > On 19/07/2023 00:24, Marijn Suijten wrote:
> > > > SM6125 is identical to SM6375 except that while downstream also defines
> > > > a throttle clock, its presence results in timeouts whereas SM6375
> > > > requires it to not observe any timeouts.  This is represented by
> > > > reducing the clock array length to 6 so that it cannot be passed.  Note
> > > > that any SoC other than SM6375 (currently SC7180 and SM6350) are
> > > > unconstrained and could either pass or leave out this "throttle" clock.
> > >
> > > Could you please describe, what kind of timeouts do you observe? Is this
> > > the DSI underruns issue?
> >
> > Ping-pong timeouts and low(er) framerate.  However, they were previosuly
> > not happening on a random boot out of tens... and now I can no longer
> > reproduce the timeout on 4 consecutive boots after adding the throttle
> > clock.  Could it perhaps be the power domains and opps that we added in
> > v2 and v3?
> 
> Quite unlikely, but who knows. My main question is whether we should
> continue skipping the throttle clocks or if it should be enabled now.

And that "main question" could ... drum roll please ... only be answered
by knowing if this got "accidentally" fixed by providing the right PMs
or some other change entirely while I changed base branch and defconfig.
Or if this is just a fluke that persisted multiple boots but will fall
apart in some time and/or when someone else runs this on their device?

- Marijn

<snip>
