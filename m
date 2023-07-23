Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A075E18C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGWLCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGWLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:02:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3197E79;
        Sun, 23 Jul 2023 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690110114; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=itBHUgVWw+1H1AyvmMuLnCjl6KYYeNbbu5HvJn+py+fJ8gVzGRImfhlWqQ48JggDFR
    WYJnzbAa0A9aYmBCgHDnFK3jfdFkZeggltkwTo8LK5ppuD59AC0NnYKQP1UwyZNEh7t2
    8ua7Nx61VvbWj9sEEN9p4FkTuNgpqdl5F6gVGDHZtReeG62CeZ/WqPQPrQ7JLIX402S2
    Qz7+jJLbvEGbfIezuefkZNNz0LICkId9/Ckf1lpeb/HjxFUlIMw2LKvkALdABNYmfeCS
    8DH22n/TEBfFUD1cojAeyMNUoxwlRj6r7+1b8YVR41wofK5kcmhr2Wap75xuzCSGuLHG
    o+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690110114;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMEA9P1xZg+7wXNCY5oLz3njvCClnHVxBBvE+kvx+fY=;
    b=nrqknRiAOMYBvr7pywL9h6lng3I2jyQs5yRa1Dm85YvWSPtqHF95GaofMdByQTBidl
    jFto/THDMp4v9bRIE3CPOowg3ivJu31vzau+mKuq82XE3I/NnLMbJpmTcIrZS4PAdD1G
    TmxAD1jjiD+iaqPpAxPEHnkVDF240IyZrtNViEf5t6GydDny4c27MCWpQULN2kT0caCh
    i9//rfcofZ47Wcax06UM9Mt3eXL/vUZzAfqSHEJGEPXO16vmEeO40hTHrs8kj2532cle
    XcfdrH6s5ZKWS+DDrFFs8RQmcbatN20kxf2xjNCEKd82GPTbyxZKtCC0uvikXyht3U7K
    CjZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690110114;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMEA9P1xZg+7wXNCY5oLz3njvCClnHVxBBvE+kvx+fY=;
    b=J0aWpBYiV3ufk3SEV4OOYGjMF1LVGbqn90t99Hr+axMSS6HZonax2DNo0O7vYDx33U
    SQRhLBQSKis/1WCsylY+MGUxg9+dwuoWs8OUyN3B/yb+RZcv3yUHpa/9fV0I6KH28G70
    y6FHExgSm4AE30Hyi0tgL+4I4kX+io/SuN1fomlRXChslmraiJrWWwEj+0f9jYwaPtl9
    e/xHn/zTN7oTAf+V898mLISuflWcBfuFcVKHtLH0F9pX3xLO0w6AwnNt+F+CV23GOaz2
    4bImC1oWmAZ0sAcaMqYHPNbKNk7L6GRsgEXR82gnOVDLcpyH/WCNG7KH6FAai4E9r31W
    95gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690110114;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMEA9P1xZg+7wXNCY5oLz3njvCClnHVxBBvE+kvx+fY=;
    b=3xZ3SUxyANjKWunm+nKULfxJ8zatT2UVBAFbFRWaTGD3ReyvxyYtAaMohsLk6V2WmQ
    Dbzf3+Py0Z3oselbvvBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.4 DYNA|AUTH)
    with ESMTPSA id V0b383z6NB1sCdu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 23 Jul 2023 13:01:54 +0200 (CEST)
Date:   Sun, 23 Jul 2023 13:01:48 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: qcm2290: Enable sync state
Message-ID: <ZL0InL6slLRNcVkI@gerhold.net>
References: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
 <20230720-topic-qcm2290_icc-v1-2-7f67f2e259c1@linaro.org>
 <ZLmQdjDgIbbhyTMJ@gerhold.net>
 <3e1d650d-7c5b-381c-464f-3c464c056a1b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1d650d-7c5b-381c-464f-3c464c056a1b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:03:16PM +0200, Konrad Dybcio wrote:
> On 20.07.2023 21:52, Stephan Gerhold wrote:
> > On Thu, Jul 20, 2023 at 08:24:01PM +0200, Konrad Dybcio wrote:
> >> Very surprisingly, qcm2290 does not seem to require any interface
> >> clocks.
> > 
> > What does this mean exactly? The interconnect .sync_state() is
> > responsible to drop the initial maximum bandwidth votes, with the
> > assumption that all active devices have voted for the bandwidth they
> > need. How does this relate to "requiring interface clocks"?
> If it required such clocks to be present, sync_state could not
> complete, as trying to access some nodes would crash the platform
> due to unclocked access.

You mean something like the IPA clock that must be active to do the QoS
writes?

Wouldn't it already crash before .sync_state() then, when the initial
max bandwidth votes are being made?

> 
> > 
> >> It's therefore safe to enable sync_state to park unused devices.
> >> Do so.
> > 
> > Doesn't this make everything painfully slow? There are no interconnect
> > consumers at all in qcm2290.dtsi. I would expect that all bandwidths
> > end up at minimum.
> There are no interconnect providers defined in qcm2290.dtsi.

Ack, so I guess you're going to add them together with the actual
consumers?

I think the patch itself is fine. Only the commit message is a bit
misleading. The actual change that is being done here is enabling the
bandwidth scaling (dropping the max bandwidth votes after
.sync_state()). Can you try to clarify the commit message a bit?

Thanks,
Stephan

