Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2137EBEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbjKOIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKOIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:44:09 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84F10F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:44:06 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c08c47c055so53686617b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700037845; x=1700642645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O435LHbyv7oQ7r66GVQ2a6a9TDfwdSVJ9URtMEVc7Uk=;
        b=N8kpExpZxhhvnMoSnOfcDGhC4PxvigNcTwlX3/d8MaLqUf3UjDMLKp5UYDWFitdLTo
         KyG4nwwnX22SigFXUklXM0JWi68RGRVYExPFQQdbjWINw1CYmdXRhF3WiRrjgfZBRuk1
         nyV1T5CFuMB7MNtAZ2sQjRdvDSZMIvGG4VhDmVnRHOutBUV7V3ZHoW3PzC7hRVeHT50R
         7lq9akVokC2luxIs9myICzLf2ujxbUP2nhPpwSq3EQRa+9aJmUA2Dw0AWVMBw8XXJ+wQ
         /cGOJm6UOCklgFXm4bzN12lGpmKalLSmfBmFAtdnFd3YPmU5yNBGE2jq+RXhh1NhHHTK
         lMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700037845; x=1700642645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O435LHbyv7oQ7r66GVQ2a6a9TDfwdSVJ9URtMEVc7Uk=;
        b=pK/y3bv9wWIcznGf6tnyY+1yuZlSNh6+i+bcnfmvbCwxKFrKZ7fUYXPlZgDZlUxOcH
         0ZmVLRL4lLJUacamYelPmAg7IRrt/lEsD2hj4+uMluGEQaD+vTsX3PwFSqmUCdPl+rRR
         VrNE5pYdcoe/zoyDlYcHE9l1UWoCzWFerludsjDTx0G9CHo4oEI8RohqM6zOq5Kzx80A
         rhm1cL9/1sQGrroQ6YEO0KPv3ZDC0pdhjm3ojgGT4o5AjHsJNDBGttbuEHDS1kXZ0Bw3
         /c6NN90Swna590aa6TcqQ8mM/KGcg7dJJjiKSIhHXSvdvHzYMgIGWxO+dE2yNLVq4w4t
         l+0w==
X-Gm-Message-State: AOJu0YzUutt096zqmBUUp2muIF3B/UUXc1RfKNh7Ph1CWAyVt46ixD9x
        tHrHEy3m52UoIUHNtuQTZ6Ooh3I/pyYgGi/ahyuAqfAHuzQesS7P
X-Google-Smtp-Source: AGHT+IGYyMbXo0cenT7MAhAK2LCaEB9+Xb+FoInpMblxB77kbQVUXJEQUSN6Df2UdZWuepVN2y/hrda9iVITRdFay/M=
X-Received: by 2002:a0d:cd86:0:b0:5a7:af0c:bf97 with SMTP id
 p128-20020a0dcd86000000b005a7af0cbf97mr12883973ywd.6.1700037845260; Wed, 15
 Nov 2023 00:44:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669012140.git.viresh.kumar@linaro.org> <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com> <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7> <20230216064727.GA2420@thinkpad>
 <20231011054858.3vvnr76u5enu5lf6@vireshk-i7> <20231115063201.rc3pf3pga6zhoqb5@vireshk-i7>
 <20231115075542.GA20982@workstation>
In-Reply-To: <20231115075542.GA20982@workstation>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 10:43:53 +0200
Message-ID: <CAA8EJpqhYxvgXsbQfdrYs=tdbbqE=uTwtB71kqFDBAfnTtNwAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 09:55, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> + Dmitry
>
> On Wed, Nov 15, 2023 at 12:02:01PM +0530, Viresh Kumar wrote:
> > On 11-10-23, 11:18, Viresh Kumar wrote:
> > > On 16-02-23, 12:17, Manivannan Sadhasivam wrote:
> > > > Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
> > > > for the rest of the Qcom SoCs.
> > > >
> > > > For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.
> > > >
> > > > Rob, here is the background on the issue that is being discussed in this
> > > > thread:
> > > >
> > > > Viresh submitted a series [2] back in July to improve the OPP framework, but
> > > > that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
> > > > was found that the series was expecting the clocks supplied to the OPP end
> > > > devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
> > > > the clocks for these nodes are supplied by a separate entity, like CPUFreq
> > > > (EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
> > > > the respective nodes. And these nodes are using OPP table to switch frequencies
> > > > dynamically.
> > > >
> > > > While the series was merged with a hack that still allows the OPP nodes without
> > > > clock property in DT, we came to an agreement that the clock hierarchy should
> > > > be modeled properly.
> > > >
> > > > So I submitted a series [3] that added clock provider support to cpufreq driver
> > > > and sourced the clock from cpufreq node to CPU nodes in DT.
> > > >
> > > > Likewise, it should be handled for the adreno GPUs whose clock is managed by
> > > > GMU on newer SoCs. Can you take a look at this?
> > >
> > > Any update on this ?
> >
> > Mani,
> >
> > Ping.
> >
>
> Dmitry, can you please look into this? Please read my above reply to Rob
> to get the background.

The issue is that we don't have an actual clock that corresponds to
the GPU frequency. Not even a read-only one.
Can we get away by manually setting config_clocks()?

Also could you please remind me, can we sleep inside the config_clks() callback?

-- 
With best wishes
Dmitry
