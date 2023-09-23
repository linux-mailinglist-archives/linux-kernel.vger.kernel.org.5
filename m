Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7427AC33B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjIWP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:28:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F69E;
        Sat, 23 Sep 2023 08:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695482923; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WRR5qXILQ/0v+FvqfCNEmSmZNSLURXpL5KJKgbUY5i26LItL4b5Fgsl1lPRel56t1I
    VMs46pgGdCaznk3qvsQ1EbpN8tCS+s/GIoB4YYZV+7yuVPV8MWCb6hNY/PuiRPlZhW0w
    NhDd0/7QLeYjJw4hnu1iPKlF84P6QbjjRjNeTpb/K0prjdx/SFDCJp5cqfjM3m9D59DS
    eHIcwKuEZ1CAawVsQJn+E2h9BlK8o3EQGv7xiLrXNTvb9CrGNokvIofr52pbZGEX4qK1
    KKJg2XtuZsmETGLP6Pb+ghWAOZ6tNaPfsOg2bU9cYkfi356lnIMUeIGGzqPu7OpUhBtQ
    kjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695482923;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uv/JBGnkBOFAaJkkS9haLMxd+xRgFL9sr1b/HqVpSoQ=;
    b=qu1uUWdpu8kIruEn5PXAmF06fCEV87y5I1BTMdO3VOi6tiVuxBHkudKy2JIkQMgREH
    /K2CYZlqjgHsaVk2LYN34UhHip2KRAy9fRSk6uabpHlR34CM9Jk1z6Sp2PXYBdopiTxB
    R/ll54ODSDHpcZ1uCNTn/+3rE/H5pI+zyPSCvwkuuhqD0KOfjIAZIVFvQtw+hJD6crHw
    LIpR1huO3MTNXzYgYrRt89cnWTeBgofcW9qSs7X7M4vumHLqrnFiTtddYGlLFef5hYRH
    XEeZsRTA2/4GMQs//8zA25Z96GYEbn1XbohET6lyNIkRdNhmeWLrttFaxBcIDzKIfLGs
    mpcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695482923;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uv/JBGnkBOFAaJkkS9haLMxd+xRgFL9sr1b/HqVpSoQ=;
    b=G7FQYODovgCOMIaJfBSDL9SweBXRD56BYPaaJMw8KE1m3Kd/K21B19c/dzAdg0dl0u
    emx5JkdzX7iidRlEAH28dlMydYvu6LrevqegFOMHXN+uvc/bUNW1gjITzTP/NlfKsArS
    l2BR+V6o68K4T5XabFdmK5Y2GJpxlQhbtP223kYzz/wTv1mT9jGIRb/qmMajxHRIz/NS
    wcQsOAejgege5dKUBOaQWuY+tXb0+S3kRE1rkYi62GdGfCxjPnw9iOoj2sOnWZxzoIAH
    ywSTsjmbDdIz5u0tp0xH5QpZ6ye69smRl6ZfgpaRt6uYv4evI0U182XTyeDj5bxpCEgQ
    g+xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695482923;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uv/JBGnkBOFAaJkkS9haLMxd+xRgFL9sr1b/HqVpSoQ=;
    b=x/scTKo8FoAmYQaFzcmTDx6GgZ31CBaaz7nrEbuamTUwAjGBqQlu+oH76h77IZW9MO
    DYH/ZLa1+tR12PF1mZCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8NFShWPZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 23 Sep 2023 17:28:43 +0200 (CEST)
Date:   Sat, 23 Sep 2023 17:28:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: msm8916/39: Fix-ups for dynamic
 reserved mem patches
Message-ID: <ZQ8EJIakfFw_cNJm@gerhold.net>
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
 <bda0d75e-1af3-4247-a363-48998c21c8a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda0d75e-1af3-4247-a363-48998c21c8a3@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:12:25PM +0100, Bryan O'Donoghue wrote:
> On 21/09/2023 19:56, Stephan Gerhold wrote:
> > Enable GPU/WCNSS properly in some MSM8916/MSM8939 boards that were
> > changed after I sent the patches for the dynamic reserved memory
> > allocation.
> > 
> > I have magic scripts that make the necessary changes automatically so
> > I'm quite sure that I caught all new instances that need adjustment. :-)
> > 
> > Since my scripts only work properly on board DTs with sorted nodes
> > I also included a bonus patch to fix that in some of the MSM8916 DTs.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Stephan Gerhold (3):
> >        arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
> >        arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
> >        arm64: dts: qcom: msm8916-*: Fix alphabetic node order
> > 
> >   .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  8 ++---
> >   .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 10 +++---
> >   .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 38 +++++++++++-----------
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  4 +++
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  4 +++
> >   arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  8 ++---
> >   arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  |  8 ++---
> >   .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |  8 ++---
> >   .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  4 +++
> >   9 files changed, 52 insertions(+), 40 deletions(-)
> > ---
> > base-commit: a35461d47fe3e555602912b905f1bae7045256eb
> > change-id: 20230921-msm8916-rmem-fixups-46ec18b9ba5d
> > 
> 
> Do these Fixes shas exist ? I can't seem to find them.
> 

Yes, fetch for-next from
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git

It did not end up in linux-next yet because the ARM32 build in the
qcom tree is broken currently [1].

[1]: https://lore.kernel.org/linux-next/20230921084252.3c5ab501@canb.auug.org.au/
