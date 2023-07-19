Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67127591ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGSJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGSJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:47:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D15106;
        Wed, 19 Jul 2023 02:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689760022; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=s/cqr7BUGAtP03C6t/ywoM2f4bBpLmQhEsBEcHmWpfsdbnLgNbgRJQBXG1q7GxmJCc
    7WPBdQPpZecsw9vXD+wWNLdtZTBUx1qvN8gIcQf+yTV6sgvhlpJYogBjr0zQmNnE7mj4
    0H86hTj/CqwUokzPN3YXW9hcIiqh1EVMIujgzqhxt0KPAd5UqSbM/0PRxXny03JpA+RC
    LDhXGI/ssDGfAtWtqqAgVKZoVDFo7L1WSn+rnXP8WwTMEnKsHUAFfBOlXyUg5hDygrRI
    fLr4PQ7r25FYPFmpVCPFUoBLaol149vLnrcK1TU4Gusy7jimPEECUMJMt8XWijUP2D6M
    9Xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689760022;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aWulUSFQPQrk0YhE9gD9h7Gdx/P5m2vYoLnnOUcgX0w=;
    b=T5DmUr1xamW7aiO+hYDZA8Ht5LrJxqgZ2xIF3YZqpjr7L6hr0LJqptFdH9e0xwF3qS
    QL9jhkM5pJN0bKGTSq4h5h86Gmk4GCsiyKlI0vu/ZtXv3kHP1YlIE1ZaNroKr3+oBRIl
    JqB/njDN0Afl6wJid5bp98hm4ooD7w0Uu+dVc9oo41xK5ZSy3A5Bq+SgGz+lUyoAlaRh
    pKCe2kavPxhb7522a7ENILrnAu4rIKEJ7oY4oUt0dSXuEWSxzVBN3Wqw1XowepakRVbw
    qE/IcKpP8SzhVjEpa58oLbEuTxaR8wE0awWSdcRmcgPkxjriH1J+Bln2t/oteMsQo0Ua
    59yg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689760022;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aWulUSFQPQrk0YhE9gD9h7Gdx/P5m2vYoLnnOUcgX0w=;
    b=e36bOiV+5ZsnVxzbeB73ByEV038LTxirBS1x+1xmffIbaNad/0UmSCiLvlkTaPPRS7
    2IV6CNpRGRmEfraapqBB8hC1gG1UJg1NkLG4fiqwDypuYzvkg4xPoorgsAR/u4IKlU9A
    ci/n3W0WtlurhZavggmLRG20lmFTv+wKgOLj/IujRx0qErAH0U09foRyA5cDlS3EfsZq
    LEoQHldIlzNRhfp51Ygbm2Fr4SWQIt1d9L2PleTxpnbJboJXx3CayylBBq0QAtFdtHlS
    xrScPXBT1HheQ0m3N3UEqrGMJBm+XfAm/qmHFPDBWYjcfGFJIbSJZF9DKccTkP97peD8
    lfMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689760022;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aWulUSFQPQrk0YhE9gD9h7Gdx/P5m2vYoLnnOUcgX0w=;
    b=1MbLBtiTo2xVLZq0VKKyVWAXc0DKKoJ6orJXJD9axsLXwsxroKHAszeeqii2oEOz7h
    5nCQlYTAOcLD11xtnTCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.4 DYNA|AUTH)
    with ESMTPSA id Qa2b39z6J9l12Ww
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 19 Jul 2023 11:47:01 +0200 (CEST)
Date:   Wed, 19 Jul 2023 11:46:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: remove refs to nonexistent
 clocks
Message-ID: <ZLexD5tdjYGhTCR9@gerhold.net>
References: <20230719073520.2644966-1-alexeymin@postmarketos.org>
 <9e38d2f5-6da4-089e-1c70-a89069708909@linaro.org>
 <b8cc0229-d663-3527-b320-51a48b4af5b5@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cc0229-d663-3527-b320-51a48b4af5b5@postmarketos.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:36:46AM +0300, Alexey Minnekhanov wrote:
> On 19.07.2023 10:39, Krzysztof Kozlowski wrote:
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check`
> > 
> 
> If DT schema for interconnect requires bus clocks to be specified, I don't
> even know what to put there now. Can we change schema?
> 

I think I mentioned the DT schema updates during the review of Konrad's
interconnect changes and he mentioned he would like to clean those up
after getting the series in. (Which would be sometime soon now I guess)

For now, having the &rpmcc "bus"/"bus_a"/"ipa" clocks specified on the
interconnect@... nodes is still valid. At runtime they will just be
ignored. Feel free to just keep them there for this initial fix.

For the other two usages (iommu@, usb@) these votes with minimal
frequency look a bit related to the "keep_alive" stuff Konrad added. [1]
Maybe that could be used here instead of bypassing interconnect with the
clock votes?

Thanks,
Stephan

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b979049c38e170286158e97290c892957c836903
