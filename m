Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5163B7C82C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJMKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJMKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBEA9;
        Fri, 13 Oct 2023 03:15:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550C2C433C8;
        Fri, 13 Oct 2023 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697192112;
        bh=aGHVQsxuj9G9JKltllMhMOa3dCvnQ4pMTigq/zF8NLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLNNYRZdN7XfMueMEXlJR0cAn29QSfIqdxZNvFkEccpLvWfiNc85dmbjTyC5SlPGm
         WfRzRhbw0vcLCnj1w1EYrUv9og8yKuHG4IkaeUrAFLGTRsJs7eyDCcStliYuRvf7+X
         0yvwbE9Jx5QD0as+ThO/1xx+XpgKwGrj9Grhp+G7xoyAcvjsgSOYT1aBXNK/GyuZfs
         nXW7efCQJdHgydkQo2vFw4O4vjqGZQJu4JZshV1loWlwBxK9WEMcomWPAB54ld6AC+
         6Ar/esIUpp9h+kOaqc0Ia9aXJUPGq8Pe2nKJMYHYVBF1Gde4bLOdreGeE4uRVMOXVB
         UBcwJOclTtlHQ==
Date:   Fri, 13 Oct 2023 11:15:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid
 implementation
Message-ID: <20231013101507.GI8314@google.com>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <169710605745.1174112.5043840678154728515.b4-ty@kernel.org>
 <ZSkUDl6bIQkArUO0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSkUDl6bIQkArUO0@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023, Johan Hovold wrote:

> On Thu, Oct 12, 2023 at 11:20:57AM +0100, Lee Jones wrote:
> > On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:
> > > The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> > > that can lead to resource leaks and crashes. This series reworks the
> > > implementation so that can be used safely.
> > > 
> > > Included is also a rename of the SPMI device lookup helper which can
> > > hopefully help prevent similar leaks from being reintroduced.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/5] mfd: qcom-spmi-pmic: fix reference leaks in revid helper
> >       commit: 365cf70ff33fe20e749227346d7245f7f0dccb58
> > [2/5] mfd: qcom-spmi-pmic: fix revid implementation
> >       commit: 7370f9de463b1d21dcdf9480a0a15babecd14ac7
> > [3/5] mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
> >       commit: b5cd5e72a71e9d368e20271d3a772dd045ae220e
> 
> Thanks for picking these up, Lee. You don't seem to have pushed these
> out yet so I'm not sure if you intend to send them on for 6.6-rc or
> 6.7-rc1 yet.

Just pushed.  Should be in -next tomorrow.

These do not fix commits from this release and I'm not planning on
sending another PR for the current rcs, so these are due for v6.7-rc1.

> Either way, would it be possible to include also the related and
> dependant spmi cleanups?

With Acks, sure.

> Stephen, could you ack those changes so Lee can take them as well?


-- 
Lee Jones [李琼斯]
