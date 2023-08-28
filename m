Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2427D78A92C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjH1Jqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjH1Jq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:46:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF511D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:46:21 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d746d030a86so2868152276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693215981; x=1693820781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvT9VWI6p3Ng55UqfBAOs6yV7v1162iVaAMYT0ayf9U=;
        b=NgWaOMtT/FLer5pXj4cGDoTI3jI20a1CMVaE4V++rZjgmGKzkznOE6FFopIjhHOpSB
         2fCGwXIwct8Xgdvyq4JGVYiQ98IC3zYytGl3H+5c11vpyK+qATZI5zuToKGTPMq31BnA
         pii5NnkLf8KzhLmAOw2Lc9X/NVY8/eTc7cRhw9dHi52tlhM2oPENPWiHtFAFUfXz/jwK
         zWwxsHm4atPCmY5t3Vxi04Xa10TuW4zlyd8MYpRy8SHbUhpQ4/QuL4SH4kD9n5huB4rA
         NLX2B05TFTEdzvHHL4TOsPLWFIw4BN8AZ0XnZfL9PgtwJunfchfVjMRGCKawGqJOz72u
         Sl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693215981; x=1693820781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvT9VWI6p3Ng55UqfBAOs6yV7v1162iVaAMYT0ayf9U=;
        b=IzHURNvapQTTA4ebPTJ1xdE7DAwLqRJ1byQc1Fc9j+qKrOttWcQ0XPEwb2TOwrS3kJ
         7NYPXJnsc+R/uUp3lnvHdNFXa8Aeq1pQT10EocnT3LKY9zrRHIly0ZToZofLakN7CoIL
         J0/Y5IFlr/aEP4j3xKbcjbCSpcAc0P5Jek8xGbJ46Wa9P16C8mvKQQA9pHqSHZ/zSiT3
         rFkbvGyK1Ok88DmmU640bDSg9lMIhBnNE3gKILPLIkq0NNpLkkCwOPtvf22cBBD4008d
         823/l1UHpZvh9q+9hvPOD52EVHQxsVpksO4SI3WebMlV66zrgSy0+ul3r39mDuX1UCOk
         iRdg==
X-Gm-Message-State: AOJu0Yw17IA8Jm74yzBjo6v5mYRcJ1KqHBiMwMiod0vDyjjXVLFeQMAY
        n/XjDRdAVWVHinf85DEnFc2QpsLy3SOn+hevRjz+YQ==
X-Google-Smtp-Source: AGHT+IG9jOpT5iaXhq/lIA24iDxL7B2I6Lfh1TLJkPahp/zduR/YCqSxDNMlBj1AEPgZB5JRSy/K8lPtU99VcyjGmnc=
X-Received: by 2002:a5b:8ca:0:b0:d11:2a52:3f35 with SMTP id
 w10-20020a5b08ca000000b00d112a523f35mr23225760ybq.20.1693215981044; Mon, 28
 Aug 2023 02:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org> <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
In-Reply-To: <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 28 Aug 2023 12:46:10 +0300
Message-ID: <CAA8EJppmn5hM5=zdkQoaGAYghw822vP8YoW0wQsNmAZY0v7dtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
To:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 12:36, Maulik Shah (mkshah)
<quic_mkshah@quicinc.com> wrote:
>
> Hi Dmitry,
>
> This patch may be useful if there was a case where some PDCs don't have
> version register populated/available,
> In all PDC versions, version register is always available but due to reg
> size not good enough in device tree for SM8150 it failed to read.
>
> reg size in device node must be expanded if its too small to access all
> registers and i think
> additional check in driver to check if size is good enough would not be
> of much use.

Unfortunately, it doesn't work this way. DT files are ABI. Even if we
change the DT, the kernel should continue working with the older
version.
Thus, we have to add such bandaid code, which will keep the kernel
from crashing if old DT was used.

P.S. Can I please bring to your attention that top-posting is a
frowned upon practice.

>
> Thanks,
> Maulik
>
> On 8/26/2023 3:05 AM, Dmitry Baryshkov wrote:
>
> > On Qualcomm SM8150 the PDC resource has size 0x400. When PDC driver
> > tries to read the version register (0x1000), it reads past the end of
> > this resource, causing kernel crash.
> >
> > Check the size of PDC resource before reading the PDC_VERSION register.
> >
> > Fixes: bc82cc42644b ("irqchip/qcom-pdc: Add support for v3.2 HW")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >



-- 
With best wishes
Dmitry
