Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114F4757B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGRMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjGRMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:08:50 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891B173C;
        Tue, 18 Jul 2023 05:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689682034; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b/CMNJeyAeLl/HC9J1VRNQaC+TB+jg+tJoy8snaTw5L4kXOCIJnFQppCP6BcphvPPM
    OJGLPs27qZRyl5y6Kg5C/4ch+kuhp+v89/mgOf5whSeFiy1I9Sqk7QeD53DJsiIQDkHT
    ZsuAgjiXzSZb/D6508vVCjoxkjx4wevP5iZU7eA+kY14p/SJjAyeEP8VxOC6FNuzBd4T
    OMtD21Qp74h5gF9+HQx30V3RlVWp8sKXX40kCo0DGtIS2gbyzi7OY82mjDjRjGAOWb7y
    tOFnLzo0eeZgpisvLwLoIru9jjhx2dYA+LxgNEICzyC55rhY3CsSLMd08ByEUMsPhT67
    Fp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689682034;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/wALjgnG3v6FP3wfvq2OkKhkeF/CVtHeLiXFqKzD+gU=;
    b=EVK32gLErsDWBeuTmCHN4s/oSXIIeIjtMmHRMaQNytuRkqz3OlkdnMhfFQcQ2h9VnG
    o4yztwUo+kqGBpx8oODH5iibLBkKfxZHecYi9rcxAk0fnNWjdCNLf06vdwl9NWfaN0IW
    tuZthXUKj/068AMYPCMwBHAazRy6qI4MrotizIJ0o5mFWzf5dsYgK4OHMnWoB0isl4Jn
    FIaQn9B3izk2mofgOezfXNndx61JqUbZoeInmtxn2xirxkHq25/YaMVs7B0t7nLLRqpW
    kqeGMGUzO6qFcjdsPrG/U5dsbRrGISToHfAUro2ADEXuu2fzVbdfFwB64vPejOomtNy/
    Lbug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689682034;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/wALjgnG3v6FP3wfvq2OkKhkeF/CVtHeLiXFqKzD+gU=;
    b=Aw0TqYuoyQJ//fuMce6zxtMOOO5rF51oITMW5z2HBdvey0hurOBNbJ+vS71ZlcDLn+
    YNB+O0VnKCPszV8jX3Ts9GG2ouXlO1aLh8E0jR5O8tz76FbJcDqcGljTeVMFMTPxVMRe
    ERFZinHoJM/lZd4QCLEEBcxNrfCe4W3X0GXKK8de0GcXnr+H7xKoZT7d3yIxFPAxtz8/
    VGiA0z6BgRHH9BBa9yzTRaooqRjqX7B7iPZIQg0Wjd21D92VryJ5IFxV2wGOpW4Mvrne
    ljk4dyJBQgH+N0htzUYtRQ+wFNctzYhSaRxRWQWt/SMjMlbzdayfNn3DhilZ1zMK6f/v
    Csqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689682034;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/wALjgnG3v6FP3wfvq2OkKhkeF/CVtHeLiXFqKzD+gU=;
    b=vifbpKo/7n5doiokhWJRUe4B97SZVfEmDI4dj3V7lHR/r5EVVgSk1e4P1RTxbbCZX2
    JJL58Kpa4JLvGq9nCIAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IC7Dbwu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 14:07:13 +0200 (CEST)
Date:   Tue, 18 Jul 2023 14:07:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <ZLaAcELnsldc98Uk@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
 <ZLVru50N2ukdXnsW@gerhold.net>
 <pv7pcn5xc7xdjigefrwzvbjvp5lmgfziywfpvxn2nl7hjnvyre@kukniawnm5rm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pv7pcn5xc7xdjigefrwzvbjvp5lmgfziywfpvxn2nl7hjnvyre@kukniawnm5rm>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:02:29PM -0700, Bjorn Andersson wrote:
> On Mon, Jul 17, 2023 at 06:26:35PM +0200, Stephan Gerhold wrote:
> > On Mon, Jul 17, 2023 at 05:19:11PM +0200, Konrad Dybcio wrote:
> > > The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> > > that it's enabled to prevent unwanted power collapse.
> > > 
> > > Enable runtime PM to keep the power flowing only when necessary.
> > > 
> > 
> > Are you sure this is necessary? If VDD_CX was really possible to fully
> > "power collapse" then I would expect that you lose all register
> > settings. This is not something we want or can even handle for GCC.
> > You would need to restore all frequency settings, branch bits etc etc.
> > 
> 
> This differ between platforms, some allow us to completely power down CX
> while keeping registers state using MX, others require that CX stays in
> retention at least.
> 
> So, CX isn't the only rail powering GCC. For the most part though, we
> have a relationship between frequencies votes for by clients and the
> corner of CX, and hence I think the current description is ok...
> 

This patch is just about sending enable/disable votes for the power
domains though, based on runtime PM which triggers when all the clocks
are disabled.

It's unrelated to voting for CX corners required by certain clock
frequencies (we handle those in the OPP tables of the consumers).
And it's also unrelated to ensuring rentention of register contents
since we actually release all votes when the clocks are idle.

So while adding runtime PM to all the clock drivers sounds nice, I'm
a bit confused what problem we're actually solving with this patch. :)

Thanks,
Stephan
