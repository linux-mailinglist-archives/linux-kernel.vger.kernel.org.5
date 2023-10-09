Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB757BEB8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbjJIUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:21:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D6CA6;
        Mon,  9 Oct 2023 13:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696882901; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nT+Vcpu8SyloiQlxcAVM6vBsKZLVjh2Zp2aJYx0TWYjDzutP9G2/rWQDATJWQVVejv
    e1XGvTUtViFauiyevE3KhaccJjocY9l2oqlWxr3JgVYKK74Pwn/uYqhUguNU94V2lDp2
    MIccLlELJHSlKXuCKiYdRW0NA4bSrqYTMYEeu1XjzSM2M9IASm9G7vpizBdSVWCcGU2V
    s6qDbvDiP9ypRRReCaDxpt0T2u4IZCqLnzadMIHRayhV15wbsHiFi+VRModWNiPjFlmR
    Kv0CzkmX7Xrc5RdQgiYHRVJnLlzllHwilNATXPbRjNbZRiUWJu5ezziauKQOI3rCAWt3
    iM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696882901;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xBltSPAwMjp8kb/BKjFM21OEWMVJqmboaggz5sCx6kQ=;
    b=q0k/rfkiOqWXhqaeLRpzfBn9GTxjfKxsFoUteCd7IQpxqSrmwLlxteahx5Wwr+FYIa
    Jl/uClJ4nZiZTTMZazMC+BufyI+1UWDK+TDI5+lcaoueondo/NBRXYXbgApq553T6icV
    fIRQJEC/P3sLz4myFNYqrqNsfkDqZvDO9mh4L7WzU8SbfcKK4oQi0bbDkf0N4kOZ48Kx
    hZ8U9WkUPi3ifNZOwo+mY5a1U4iYoV3mh6AZy9X4dIEdTgNsEsuzFwpNQF6SKJTqgZVU
    QEfAVHDHysNoGsql1f/MlllInp6etJAnSVyYdLQP3Yxa11+VEeCFnrE9+S6uUsC28lQl
    mjfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696882901;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xBltSPAwMjp8kb/BKjFM21OEWMVJqmboaggz5sCx6kQ=;
    b=bFKXZtAQAEbkJ8IcSvEsHy+fkeXfZYkP8kqNXXCfpp3Hr007OEiGvQ6cSg65z5y58k
    GR976AL+AMj7JABsWSg24AwezId7uAK+TDKeXPzCcId1zVVUYKS8Y07gx4oHAk8taKvS
    jDIFB0OH+tjKB6Bs0jk65zBas3NApPibQxQxc0lMfZg0NmBa7QJkWNArSwPKDz+lY+pO
    DT9HRJ2gRpSxyIu5SXZrx/rKJrrSttYvo/v+hHRrLgTIU8ykQFtlq0XWA+/SWiodnjmv
    y/vFqpelyEio7MspUbg/Vg/y++JdPQJ4PZFVr38QOTqq7KTWOgvvn5UuzSg2FeCxnV0p
    L/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696882901;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xBltSPAwMjp8kb/BKjFM21OEWMVJqmboaggz5sCx6kQ=;
    b=lWNSri158fYNHNjvzRSDJ78+5BbpcxnEf0C37hEMkEFP8RfjKNJaGU9Z1Qt1JCZm7E
    cazWeK010zZIX8HNvvDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z99KLfQC0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 9 Oct 2023 22:21:41 +0200 (CEST)
Date:   Mon, 9 Oct 2023 22:21:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <ZSRg1H772gMTl-d3@gerhold.net>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <9b78cab5-d72f-469a-816d-6b3f86aecada@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b78cab5-d72f-469a-816d-6b3f86aecada@linaro.org>
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

On Fri, Oct 06, 2023 at 11:11:48PM +0200, Konrad Dybcio wrote:
> On 4.10.2023 16:17, Stephan Gerhold wrote:
> > Some regulator drivers do not provide a way to check if the regulator is
> > currently enabled or not. That does not necessarily mean that the
> > regulator is always-on. For example, the regulators managed by the RPM
> > firmware on Qualcomm platforms can be either on or off during boot but
> > the initial state is not known. To sync the state the regulator should
> > get either explicitly enabled or explicitly disabled.
> > 
> > Enabling all regulators unconditionally is not safe, because we might
> > not know which voltages are safe. The devices supplied by those
> > regulators might also require a special power-up sequence where the
> > regulators are turned on in a certain order or with specific delay.
> > 
> > Disabling all unused regulators is safer. If the regulator is already
> > off it will just stay that way. If the regulator is on, disabling it
> > explicitly allows the firmware to turn it off for reduced power
> > consumption.
> > 
> > The regulator core already has functionality for disabling unused
> > regulators. However, at the moment it assumes that all regulators where
> > the .is_enabled() callback fails are actually off. There is no way to
> > return a special value for the "unknown" state to explicitly ask for
> > disabling those regulators.
> > 
> > Some drivers (e.g. qcom-rpmh-regulator.c) return -EINVAL for the case
> > where the initial status is unknown. Use that return code to assume the
> > initial status is unknown and try to explicitly disable the regulator
> > in that case.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> > Instead of -EINVAL we could also use a different return code to indicate
> > the initial status is unknown. Or maybe there is some other option that
> > would be easier? This is working for me but I'm sending it as RFC to get
> > more feedback. :)
>
> -EOPNOTSUPP for "doesn't support getting is_enabled state"?
> 

The way it is implemented right now the Qualcomm SMD RPM regulator does
actually support getting the .is_enabled() state. It is only unable to
determine the initial state during boot. Once the regulator has been
enabled by some consumer for the first time the .is_enabled() callback
starts returning the expected results.

Typically -EOPNOTSUPP is used when the driver callback (or similar) is
not implemented at all. I'm not sure if using -EOPNOTSUPP for the
"temporarily unable to determine state" purpose would be misleading.

Thanks,
Stephan
