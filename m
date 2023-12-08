Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9B80A58B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573975AbjLHOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573968AbjLHOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:33:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65C1712;
        Fri,  8 Dec 2023 06:33:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702045994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ifPekkHiXm+lcwtuf5lbbYNKF0qvQaOPaFCAVY6Z3g=;
        b=v9/gjCb5yzOa/MONNnVonsIQDXSguuXkH6dOQXz1HZQnwcireIC9FcfuhQAiVx1BzFbNwk
        tJv2phQFVrHSaw7Dkzi1yU2JEL4P7E7Y63i5IYfTOXyJX5a1SmwYz7Ludayt6yCTremiSi
        8+13LSJoMNwgznljoHKKeHY1tsyAJ4fX5m0TSpP64E3lYouhrVMhG67yBo5ghxr29pCOD8
        7ExhXhQ8KfNxPKNGnLjI2zlhPmJqXLeApI0Cl7WPxSS1JkVFZv7vw/RW9Lwb+hJ6EWXdkA
        ZGpcr7zV8VqaaTZL+p549o4Ed8khn9o4NnXZm168z7pvEVy4dvu916MGnUoMfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702045994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ifPekkHiXm+lcwtuf5lbbYNKF0qvQaOPaFCAVY6Z3g=;
        b=7KgWsTdQrZJiDvbEvccaBFpNsVcf/LlEosW+NC3hpa9G7kMBm+bf9ksp/OmQSoU6EpCoU+
        W+nlmI1tJxHN8lDQ==
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v7 0/2] Resolve MPM register space situation
In-Reply-To: <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org>
Date:   Fri, 08 Dec 2023 15:33:13 +0100
Message-ID: <87il58sr12.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad!

On Mon, Nov 27 2023 at 16:52, Konrad Dybcio wrote:

This list of version changes is useful, but seriously not on top of the
cover letter. It makes me scroll down 60 lines to find the real meat.

<SNIP>

> Depends on resolution of https://github.com/devicetree-org/dt-schema/issues/104

Is this resolved? I can't figure out from this non-format whether this
belongs to V1 or to the actual cover letter...

> The MPM (and some other things, irrelevant to this patchset) resides
> (as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
> that's a portion of the RPM (low-power management core)'s RAM, known
> as the RPM Message RAM. Representing this relation in the Device Tree
> creates some challenges, as one would either have to treat a memory
> region as a bus, map nodes in a way such that their reg-s would be
> overlapping, or supply the nodes with a slice of that region.
>
> This series implements the third option, by adding a qcom,rpm-msg-ram
> property, which has been used for some drivers poking into this region
> before. Bindings ABI compatibility is preserved through keeping the
> "normal" (a.k.a read the reg property and map that region) way of
> passing the register space.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Signed-off-by on the cover letter is completely meaningless.

Thanks,

        tglx
