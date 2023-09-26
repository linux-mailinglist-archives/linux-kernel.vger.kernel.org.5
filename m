Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1197AF4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjIZUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjIZUJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:09:42 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E882F3;
        Tue, 26 Sep 2023 13:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695758965; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WS4x5rvdJI4EAJiDhdSIw2lnGrRPbo88z5YH2ex+jD/Z7VwMojhvLQEIvswFj2ba+Z
    Rm1LV1ucw8Vsqi6cR3dCPS7XQAGem7/jpAOOw9/LMqxCsPNxqysyMEhJ+gsAcqlwGVaB
    ezxdmiTZkvNtRkxUmIm4nQ307mu6HtX2DLDbuDzusgSRbYvh3UmeShxCUYN+D2Ik3P/m
    I8+AvdSWhrQrBHA4Wl8n3txxLXBqUWGd7vB9QwdAiOzmpyl6vh5sk6DMagao5vT9JXsG
    eoeksHVZoK/DGioqbwxJ2/ulMH3YCDAvxUegXGApPHwVlVCsevJAdk11dFQBxFDr2v1m
    jNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695758965;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YETXfSsUtaof3nncdDu3fY7ytFdEFMKv0AFZkw1Jcqk=;
    b=WBNa0DhNutK6mySOxWBwEmC7AzWQe2cpRYDLNEqEJ7MgCQZmxfOj7+V2V6198M46my
    o+g+yRTggBvdHUz6om35xlhiC0MZ6HNlrPje9MpIwwLS7fXxnPvanjtq674919WfecBZ
    LNb2XgIreDF4a8ct5oCAuK7NaEScOSVtMtvNgfcuhqghF68ACCGj+1KNWnVsvY2U8X/l
    zboK+sAHGZHpW7p9fLOnnK9CtmVEO+mW7DKAFD7jfksbt58I1v4/EJPNyEyr6a1eW9DX
    v6/3XIVwqGyVtlkdHWpWEw8eM+dUPRrY1Kzj0S3TbHMt0oIw5cRJHPZcV7t4qoLV80ZL
    xCkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695758965;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YETXfSsUtaof3nncdDu3fY7ytFdEFMKv0AFZkw1Jcqk=;
    b=SLNR1sTInafG0F33FzaJUaynQq1s4n15rnXa/uCo6g3+bE8Z8N6xSYjf6gC2NZ+bhY
    Sfl7z9waTLCEun2yxzZt5qWclJ8z3lerHrVOaDxTPlyi3yb8KvmHz9xpMji20rJCMLcu
    u0FYn1JsjH5oj+8RrtYCTogV5H7+4uodNjseACcLT81A/VCHiwBhmIBX5AMkwS+mxeqV
    g4tm1j7fEfMeWMPmbwx8WzI0/z4indO5eJcmFMBS1kRWo3fK8Tle08HXTSlvB8URAHKD
    GpxKZ1AmOxj3r7nnxjku4DBmk+2VHrDOIliksjgk/KS9iGTLXmRyqQGqoLOa00U8zZ4o
    h9pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695758965;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YETXfSsUtaof3nncdDu3fY7ytFdEFMKv0AFZkw1Jcqk=;
    b=h8a93bmqQe2gWd3zJX3LsPbssJWzJ9kEGICQrOLz3/j1eYZdv8FScXnhvukhKHxJ/e
    /+lk4cOdqbV2EsfaMVBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QK9PgRK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 22:09:25 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:09:24 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH 04/13] arm64: dts: qcom: msm8916-samsung-a2015: Add sound
 and modem
Message-ID: <ZRM6dJXNvx93jFrM@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
 <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
 <ZRMwdRo9hAm4BO5E@gerhold.net>
 <278ac134-992e-460a-b37a-60a746eab107@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278ac134-992e-460a-b37a-60a746eab107@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:56:12PM +0200, Konrad Dybcio wrote:
> [...]
> 
> >>> +
> >>>  &blsp_i2c2 {
> >>>  	status = "okay";
> >>>  
> >>> @@ -243,6 +258,13 @@ &gpu {
> >>>  	status = "okay";
> >>>  };
> >>>  
> >>> +&lpass {
> >>> +	dai-link@3 {
> >>> +		reg = <MI2S_QUATERNARY>;
> >>> +		qcom,playback-sd-lines = <1>;
> >>> +	};
> >>> +};
> >> Is that not status = reserved?
> >>
> > 
> > Correct. This is here to simplify switching to the modem-bypass audio
> > routing if someone does not need (or want) the modem. The direct audio
> > path with the LPASS drivers tends to be more reliable and configurable
> > (especially wrt bit formats, sampling rates, latency, channels etc).
> > I know that at some point this helped someone who tried to use an old
> > phone as some kind of portable musical instrument / synthesizer.
> > 
> > It's not too obvious that these definitions would be needed when making
> > those changes (because devices using the standard SD lines (i.e <0>) do
> > not need it). If you forget about this you get non-functional audio with
> > no error or any hint what could be wrong.
> > 
> > To simplify switching between the different audio routing options, the
> > lk2nd bootloader actually has an option to do this transformation in the
> > DTB automagically during boot. It's sort of like a DTB overlay that
> > disables the QDSP6 audio path and enables this node instead. The DAI
> > links are also adjusted where necessary.
> > 
> > Do you think a comment would help here?
> I'd say a comment would be necessary here :D
> 

No problem, I will try to add something simple.

> While I understand this use-case, I believe this is better suited
> for an actual DTBO or something entirely kept inside lk2nd.
> Otherwise this looks very confusing to an outside reader.
> 

Translating from the QDSP6 audio setup to the LPASS one is mostly simple
but not entirely trivial (especially the patching needed for the DAI
links). Main blocker for DTBOs is that you can only add or change, but
AFAIK there is no mechanism to _delete_ or fully recreate nodes.

I guess I could maybe derive this from the QDSP6 definitions using
custom magic code, but the code complexity for that is much higher than
adding these nodes here for completeness.

Let me try to add some comment first.

Thanks,
Stephan
