Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF837D74D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjJYTwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJYTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:52:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A41B9;
        Wed, 25 Oct 2023 12:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698263518; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qFotAC/sZ8xeyiQnXw/h8arQQKnHmMEv5pjz23bttDHguZsF6rbpDJMJgWU/CXkBF+
    3D/BuYZG5SNn0mbhy22QVdEtaDu1jKRXUVF+/SykBqIHAb8C7ZkTNNltSJZoCuRv8Lto
    SAL8CuVdtiv/tg9VzHukONqzcYNmIGpcOALnvimZwkGf7frd+3dNnQEHPbeTCr4Ilhr7
    nnjlno1C8+3JJPrImFrVBnYl0NVdPEZGpRwpGVRInq9uRUGgPmfs6SU2jQbydmHk7XiZ
    Qeh7GbE8GzdZ1GDot1pYuBdaOI+BkjSbaMCw6yfN5i5iMSJi0Dg6IS92fvLrzt8arEmz
    joUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698263518;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=czqM0s6N9npxk72MyN1SMji468x1N+pLAgzuHcok88Y=;
    b=ihVET2XWaqf+1Y/CoMYybLySdBoD7USZaHBV7rdnu5Z9j5rqIR5OKMYF7ryFxgGh1D
    hucYqWI4fSEcCNjdmzZhZOMINTi2ePUq3N0p6FDo4ouWrDts9XF4pg7M/847gLhFVGVm
    58DhTvlNAj/sjSNc3RRk6WYFVtRC26hqJKEGA3Z2sbxzoIjPHiUzjHNxE/b9bmOxQ8t0
    9k2LPjkWLL6ZhF5QDxE6sWPhb59cRv2MudPqEDMPVR5A/0rimYnHLtKuEZXAfSRiJ6Xn
    1XoUmfUFDL4qdD0VRI+LzjWSrUfgU9RJm5YHdxheEYUTbyUPliwBtvrrpgszPxlIB7a6
    J99Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698263518;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=czqM0s6N9npxk72MyN1SMji468x1N+pLAgzuHcok88Y=;
    b=JnpckCfYiQKAOYTkHbDjKWdpC8wwz2pAq4BI2Fz3n6TFgAaOa6dbrH7A9yxBwAE3nu
    t8U3EE0IaEKQL2xwvozz4kbihA4NGymck3BqNmgGDAkt7MsYkY9bd4bARZ6O818PgDs+
    CIsNAXlh0/3dQgjdaJqpKysKx7OXTYpG6b2gHaiBRovIMIF5rmc4oFTC/z/niPZ7EzM7
    QXibYMoJhRag7vkUIlsJxT6YvI4XmQkaYRVRM/dkpB6WquSxZrfiVqqBcSyvndbeRe23
    hmo05NpwGHWZAQEKbO5Ipse+E/Ct5LWos3rxRAzQ++yKrz8kuMymQioGjIRCYtQTUq8w
    pvFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698263518;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=czqM0s6N9npxk72MyN1SMji468x1N+pLAgzuHcok88Y=;
    b=TJd1bYTtF6h85hrEMf+iAGigcuy2e1+jjmhg7JoGW3zZzaXZ6p003DPXVu1sj3JZ+z
    8Eq6CjFWs6+IOzR791AA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2z9PJpw10t
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Oct 2023 21:51:58 +0200 (CEST)
Date:   Wed, 25 Oct 2023 21:51:51 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <ZTlx13fBddvf4n0h@gerhold.net>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
 <ZTeHAqL5QB2w33RN@kernkonzept.com>
 <802e7f15-029c-4eb6-b0d8-53d16f7da37a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802e7f15-029c-4eb6-b0d8-53d16f7da37a@sirena.org.uk>
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

On Wed, Oct 25, 2023 at 06:49:47PM +0100, Mark Brown wrote:
> On Tue, Oct 24, 2023 at 10:57:38AM +0200, Stephan Gerhold wrote:
> 
> > I think it does not change much for this patch, though. Even when
> > implemented in the core we still need to represent this situation
> > somehow for regulator_is_enabled(). Simply returning 0 (disabled) or
> > 1 (enabled) would be wrong. Do you think returning -EBUSY would be
> > appropriate for that?
> 
> In these cases where we simply can't read the expectation is that we'll
> always be using the logical state - one way of thinking about it is that
> the operation is mostly a bootstrapping helper to figure out what the
> initial state is.  A quick survey of users suggest they'll pretty much
> all be buggy if we start returning errors, and I frankly even if all the
> current users were fixed I'd expect that to continue to be a common
> error.  I suppose that the effect of ignoring the possibility of error
> is like the current behaviour though.
> 

regulator_is_enabled() already returns error codes in various cases,
e.g. regulator_is_enabled_regmap() returns the original error code from
the regmap_read() call if that fails. So if users ignore that and
interpret the value as logical one they either don't care (which is
probably fine in some cases?) or already use it wrong. Or am I missing
something?

> > qcom_smd-regulator.c and qcom-rpmh-regulator.c use their reference
> > counter internally in other function (e.g. to decide if a voltage change
> > should be sent, see "vreg->enabled" checks). I think we would also need
> > to add some rdev_is_enabled() function that would expose the core
> > reference counter to the driver?
>
> > Tracking the enable state in the driver (the way it is right now) is not
> > that much code, so I'm not entirely sure if we might actually end up
> > with more code/complexity when moving this to the core.
>
> We have to do the reference count in the core anyway since it's a
> reference count not just a simple on/off so it doesn't really cost us
> anything to make it available to drivers.

I assume you're referring to "use_count" as the reference counter?

On a closer look I think it cannot be used as-is for my purpose:

 1. With "regulator-boot-on", set_machine_constraints() explicitly
    enables the regulator, but doesn't increase the use_count.
    In that case we should return true in ->is_enabled(). I'm not sure
    how we would know, just based on use_count = 0.

 2. To cleanup unused regulators that may or may not be enabled we need
    to know if the regulator was ever explicitly enabled/disabled before.
    It's pointless to send a disable request for a regulator that we
    already disabled explicitly before (after a enable -> disable cycle).
    use_count just tells us if there is currently a user, but not if
    there was one before.

I think I would literally need to move the existing "enabled" field from
the RPM regulator drivers to the core and manage it similarly there
based on ->enable() and ->disable() calls. Which would be a (slight)
overhead for all regulators rather than being isolated for the few RPM
regulator drivers.

Thanks,
Stephan
