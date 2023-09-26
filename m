Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33007AF4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjIZUEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjIZUEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:04:45 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E13F3;
        Tue, 26 Sep 2023 13:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695758674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r+WWJI+jl5GfKGFF79X2EsutQoKgldzw+IusOidIXLVafS6lXL8YqaC7yKGJpvhXjn
    Mzz1uICicSv5+3C5lpvNwQ2NdqyFXHLQ4Ru4F/koXMbCwIR3KUGGYoZxhlKyrg4NIEOK
    QbPObOC9BL5x3IjZimLvM3Hby28FcL1+UMQSu8Z52xwi21AO1ZQTsLnpDSD9D10zDmAB
    xckijrozjl+Kymi/xxrtuHhozg/lYLVdpTEpbJ23PpQcvHXdm+azXQ0bt4MzUphOi3dR
    l26DAu3rpFaymxojsW232nHRAWZBdqHCGSyfw6XUSytA7p073L8Hdr8RcpmyG8tUbXA5
    i7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695758674;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=deYkNb8E6XQB7PgsykUdZifQDt67hpeEYiVZoakgNQQ=;
    b=aacuSJDn0IHtQQVJ/R6SZlDix4tSeDNJJbez5TaUdbmo/6ml6gIr9PZlv0/D9yeeNO
    ugY0kDw1LJ6JI6LA6xoSUuPiCLZTEISp1/B+uTq6A67yRsTZ+2BuZ9M0gUZdGA31jOZf
    YoqZB/Sh5LEEhOlYFCn4qI9feGHAQLseD9KeO+PGZJurFwLQo7HI1S6kkgKO0nBRNuwv
    F9I9gcQDWl5BvAVVNjhG9XTIM2/+nexOlfNdF7mGjo6/dyIeNaqV/mWxn4fWg3tLo8s4
    6Qgy7On2uhQNI6SBKsP4GAq2F4VeJ5YNHoo764r/WF9yjxikANRcIWqqrGV3lgFf/+DT
    dbsw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695758674;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=deYkNb8E6XQB7PgsykUdZifQDt67hpeEYiVZoakgNQQ=;
    b=Sf+ugozyH7nI87MHy0ItpUd9QdlOYoSh9fHKz4iE2a8sUXHm613RWh9lH4Gbo/3TbT
    E38AFx/X7/kRtvHvxtnaqAXo8hAbuKAVeMJ+Qd7LB20Csh4es9aRnSUkVk7dq2AR5AJV
    zgjI+d32MhxiDeioRC3js14bdo556jYFGCtX3O7qfuHEj59nM+AxPbYrzA88C+LLLnC1
    LnVSpI6LrYbYy/xgbQGkXMrUIaYJkohZwsTjwc4yIEKK04RJtjBRW1nYQwh9h7krDeE5
    TAJFk1bdM3v3CK+xZVQuzNbOh69uXcT7bmt2JBlBPFhfZ/Yl89E13d5xYlUzUbfGhCiF
    qYyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695758674;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=deYkNb8E6XQB7PgsykUdZifQDt67hpeEYiVZoakgNQQ=;
    b=u1NQWrfkE6hFfFa4NCABFIl05VBn7IYTzAOJo3CcbI+pMbwKjSaCmmzeQu06T6zTCc
    aPx9UKmNlIZGOScq7/DQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QK4YgQk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 22:04:34 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:04:27 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 05/13] arm64: dts: qcom: msm8916-samsung-serranove: Add
 sound and modem
Message-ID: <ZRM5SyXf55WKY4_m@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-5-398eec74bac9@gerhold.net>
 <64f030ca-27e5-47c8-b0d4-5fd0d4fce9d9@linaro.org>
 <ZRMxDjVKu-kGIs5f@gerhold.net>
 <449f8299-3694-49e9-ba18-38cb52b5f196@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449f8299-3694-49e9-ba18-38cb52b5f196@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:57:51PM +0200, Konrad Dybcio wrote:
> [...]
> 
> >>>  
> >>> +&sound {
> >>> +	status = "okay";
> >>> +	audio-routing =
> >>> +		"AMIC1", "MIC BIAS External1",
> >>> +		"AMIC2", "MIC BIAS Internal2",
> >>> +		"AMIC3", "MIC BIAS External1";
> >>> +};
> >> I *think* we should be able to harmlessly enable &audio globally?
> >>
> > 
> > What about boards that do not have/use audio at all? (see
> > msm8916-ufi.dtsi). We don't even want to load the kernel modules on
> > those.
> Is it really an issue other than losing a few kb of memory?
> 

Well, the msm8916-ufi.dtsi boards (basically USB modem/WiFi sticks)
have 512 MiB of RAM, with 85 MiB reserved for modem firmware, plus more
for TZ, HYP etc etc. That's not too much :D

> > 
> > IMO the SoC dtsi should always be minimal by default. This also
> > guarantees that you don't run into trouble because of half- or
> > incorrectly configured components during early bring-up, especially if
> > you don't have serial and are hoping to get the device booting far
> > enough to debug it.
> Generally I'd agree, but if the audio machine driver cannot NOP
> successfully without a topology configuration, that's a problem.
> 

I think it will effectively fail to probe because there are no DAI links
and no "model". I guess you could consider this to be a NOP but it's
confusing and takes away the attention from the actual errors in dmesg.

I would say it's disabled by default for the same reason that WiFi,
SDHCI, UFS etc etc are disabled by default. They simply don't do
anything useful without additional configuration & hardware support.

Thanks,
Stephan
