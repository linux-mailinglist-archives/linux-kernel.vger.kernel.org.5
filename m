Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1EC7ABABA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIVU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjIVU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:58:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0CCA;
        Fri, 22 Sep 2023 13:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695416319; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DM/h0Ssk0CSA9pBKpoZS8kdda7elTUspMXJEKVezdP4+6VL2SQyG/MWM6ynsZWhRn4
    4XPLQwCXCZ75FwZ1OkdjZnAGPokgALuigmtutunaUUi1PGXkqhKVyT9kzjpz1iOEoy7G
    oRtCuUb+joCKolPmNK6stMCosYadegI3vZgthJMZsoMB5dyLLQ8oq0fe7c9AIAENnBjP
    P/XRpWItZsjuBGdz19CfVFApMrAtmVSl4RylrX1h/TkwEeignyNZpZ2YkK2ad/TjSdb0
    x2TJapPf0uUWWVd18jJl8PtYwe8zz1GFQUkR9fXAxBbhzdkiRP9kBZnJdFlcpTmUZSDo
    ep2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695416319;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8tC0I6qpuuVb1JXq7RbaHdrmQDpUMmS81IG277Uq2N0=;
    b=jvnqkqGH2Fs3yEBV4q27JdZ+3s2khgVp8QxjWfXsyqVH02bJvXxjklLRCOU91pgO4a
    xmI1cGT4flHzQvN6Dg1yLkk8zz+uqcVmP8MGFx19CDkPBUGkvb3HB8HYTu1jYgBxMtfx
    HrXHczkB7Xme2ffyqPesXeGiT48gqraO3Rk9fgPWCUpCQBRs5HYJk4AtS2pJOrtLdrPT
    A91POIsH3CFHXSQ1uCQXmQifrLTTYIYUKcOyL3yONEW7L1g3qjgtAV7XLcHeXRbp2VKG
    k4nXzMas0Pjxrlh6U313R6xGVz2Uec7qDZQ5k9xSo85Sd13LwCzozoMVSm8v4CpRgAdK
    a30A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695416319;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8tC0I6qpuuVb1JXq7RbaHdrmQDpUMmS81IG277Uq2N0=;
    b=DYf1JNT65qQUFMsZ3QOoEtAk7L2p9XblVEHUl8wb6Cbjx7WcIs+AVCgDLD5CL56naA
    TOjnpHHM42Y3fXgne9CjZL6nKE0xrmfbandZjAmd5tUBRqjlWASACKMXOR/9RZ4R0PQy
    9Twece7okBc/HoTQ1fN3Lb5pn+peTuX3zBhVjr80HLUhCkpBt+MEWGk8J500+9H9x/uv
    SbwlS36J95ZOxNaYAsQ4XVWWIA4zdoxDF+FoVpruqTjPGNZSSdcugScYmW6QWvy2eFgV
    CF+diwNzXAgB76iZ1HSx6UmPZEF2dPLzzDOhzwxEpXfBIJ5FRg5crbiiRvWx/LsGG2lC
    BhJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695416319;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8tC0I6qpuuVb1JXq7RbaHdrmQDpUMmS81IG277Uq2N0=;
    b=fYiHF2mPW1t2pD2tOWsZDlhu76pYSkEdvl1g26zOO2D3X1uK81wZQzvl+Rf+m/9kGe
    xqQP/W8Zelefhj9MTpAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8MKwcV4V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 22:58:38 +0200 (CEST)
Date:   Fri, 22 Sep 2023 22:58:26 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to
 DT overlay
Message-ID: <ZQ3_8njijHqat5eV@gerhold.net>
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
 <c835c404-33f3-4f5b-8a8a-819d4019e74b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c835c404-33f3-4f5b-8a8a-819d4019e74b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:47:07PM +0100, Bryan O'Donoghue wrote:
> On 22/09/2023 16:11, Stephan Gerhold wrote:
> > Follow the example of the recently added apq8016-sbc-usb-host.dtso and
> > convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be
> > applied on top of the apq8016-sbc.dtb. This makes it more clear that
> > this is not a special type of DB410c but just an addon board that can
> > be added on top.
> > 
> > I also prepended a patch that cleans up the node names a bit.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Stephan Gerhold (2):
> >        arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
> >        arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay
> > 
> >   arch/arm64/boot/dts/qcom/Makefile                    |  5 +++--
> >   ...nine.dts => apq8016-sbc-d3-camera-mezzanine.dtso} | 20 ++++++++++++++------
> >   2 files changed, 17 insertions(+), 8 deletions(-)
> > ---
> > base-commit: 7236e86ce5c8198b01c30933c2334d07d877cf48
> > change-id: 20230922-apq8016-sbc-camera-dtso-f247bea40f99
> > 
> > Best regards,
> 
> db410c doesn't ship with a bootloader that is capable of applying a dtbo
> though, so this conversion mandates an updated or chainloaded bootloader or
> out-of-tree kernel patch to support.
> 
> __adding__ is fine but, converting implies imposes a new requirement on the
> bootchain.
> 
> Perhaps a middle road solution is to
> 
> - Add, not convert a standalone dtbo or
> - Add a dtbo that includes the mezzanine dts but amends it
> 
> Option 2 for preference but, I'm not sure the dts syntax can be meaningfully
> made to do that.
> 

With these patches the apq8016-sbc-d3-camera-mezzanine.dtb is still
magically built, by running fdtoverlay on apq8016-sbc.dtb and applying
the dtbo. It's applied during the build process so you don't need a
bootloader that supports DTBOs.

There is literally *no change* for you in terms of usage. :-)

Thanks,
Stephan
