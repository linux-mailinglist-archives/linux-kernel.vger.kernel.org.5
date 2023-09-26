Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0227AF35A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjIZSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIZSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:55:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBC11F;
        Tue, 26 Sep 2023 11:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695754488; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KeSvCaQmt6W0BfrKmoFz5VRKNN26HAqtb9mp9KQRApSFhAbPtQn3PJ5zo9dokCUuPM
    CFTmDylzZBm8TVz2661YnWN1+XbRsMpsy8QhEQuYOUi5L7EyipfMbRVI2qHYJN1aOb4o
    RakyxGWRbpaEOaVP1CbZVtK9gNMqt+l90f75IbbiOgkW3pMHZvGarSgJj6+NJ+BHoKy+
    ocyKoHh+0eiIocDNOX+mOnrZPbvP6Qu61YIvErOcDOo5KX86sN4k89Bh26XcF33hhx9Y
    wzt+iHaGlv3yeB/9bP+XdcUIPbKUQv82L8hPv3qE/uMEmYDSR+Yz/qZvZJ9Cjbi69rUs
    JBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695754488;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5ZEnW6G7+a9YdYJfcVUnOTQMyExo6rsjQv9ME3mU4z8=;
    b=MutN6n0vgICr5S8u9p0JZmF1uInePhG/Oj+pOjPEJyhw7Bznpro2lh2OCd/jul4RHb
    GgcmcKpfeRG8Tu7rBygig3M4IbvE9Ab1dUuvePY4fOqO9QpCX4ap0EPTalKewQVqgN+c
    DHHOWs+qY6zWtxPWvFrIxcT5fDFNTzxqhW7UHMV/fZ5u0Z8WhlPM+ZyL0o3fe1kMVhWy
    QJFoonZcRnKUnXBOCUhiK0Xv8PAuyhDt2fCdNH/ykZ6TZTclcw0vjuqlt/eznW/kQZOQ
    kqgu+kWatZJO8V1WC7w8YBjVv8y0SQb6eVI6eFDPKQkFrtk9W9wrk63c9r2y4oE680pA
    qtOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695754488;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5ZEnW6G7+a9YdYJfcVUnOTQMyExo6rsjQv9ME3mU4z8=;
    b=Ge66tFkQKFUjVpow2D/P0hzXuhJbSj9zHekafdQT6dIqHjGPKdIb5gRTpzs/IOapvm
    I4996INPvLUQ9OPvwGFD1FVQwpoa3yx5kgYAIr7WfM9QelrfTr/VHSLeH7rWQU/Y+nyf
    eJNuHPmTunSLTAwEEJ14SBI6oleAhL+NKWYmBzDeF7natcHEutYyupqOPFuT9O7hZArX
    O7wWeWLAwph043mIswZ+kuasa90ZEyYdfsb4yYaXJZ4i2AlUv8YfZB7eV9VgDD5zMyjT
    b5KduKcU4nmGA4Sg5Y/eaYAdl6DGGZNcT9sGbt9YrimXRZ53RVNOvIV7V+DV1C98JvI2
    Lcwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695754488;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5ZEnW6G7+a9YdYJfcVUnOTQMyExo6rsjQv9ME3mU4z8=;
    b=EqCvKOrKMrxjYaer3DHayQmv5+j/f+sOWFOq9jMJ5CRIWFJzuqA6y1wjU/7JAk2rSV
    FHoUO3SwG+As5FEadrCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QIsmgJR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 20:54:48 +0200 (CEST)
Date:   Tue, 26 Sep 2023 20:54:42 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 02/13] arm64: dts: qcom: msm8916/39: Add QDSP6
Message-ID: <ZRMo8oxIKJIY5WG8@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-2-398eec74bac9@gerhold.net>
 <698c8d60-e284-4267-8349-b327712c94cc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698c8d60-e284-4267-8349-b327712c94cc@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:46:36PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > MSM8916 and MSM8939 do not have a dedicated ADSP. Instead, the audio
> > services via APR are also implemented by the modem DSP. Audio can be
> > either routed via the modem DSP (necessary for voice call audio etc)
> > or directly sent to the LPASS hardware (currently used by DB410c).
> > Bypassing QDSP6 audio is only possible with special firmware
> > (on DB410c) or when the modem DSP is completely disabled.
> > 
> > Add the typical nodes for QDSP6 audio to msm8916.dtsi and msm8939.dtsi.
> > The apr node is disabled by default to avoid changing behavior for
> > devices like DB410c that use the bypassed audio path.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> I'm generally grumpy with regards to multi-soc changes that
> have no need to be multi-soc..
> 

Well it's 100% the same diff so reviewing it separately doesn't really
make sense IMHO. When I do "msm8916/39" patches these are generally the
changes where strictly speaking there is no need to duplicate at all.
It could go into a common include between both. We just haven't found
a good solution/agreement yet how sharing SoC components could work.

Thanks,
Stephan
