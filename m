Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD87CBD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJQIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjJQIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:30:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3328F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:30:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d84c24a810dso6344014276.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697531409; x=1698136209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxbU8VQAzmkVOhUJ/7DgKFkqpOThGFGr8nSN0CTJbY4=;
        b=TNyr1Hx+F5j9cLPaG6bn+3DVVhVq/UEiFAQqjxVCPzBz4bf+Dn1se1pjvP+t7tj+2S
         Nt1vcupJfwKDJublCzpgplvBTviw8z+se1acuBgyoDX0Od0RQd+MvBl+DobffGY/wDS8
         GT5WxCMYuFFpnrvZTQ6c7l0UlvaY1Ft8jvOb2KXzdnslXjd7S4JiYKvEsPkNOhnBrJIQ
         cY9ZXbI46Pb3dh+XICjsta8L7l7HqM/EJnxlJagC2CJSc3AL54pJirgOHp4f8uB8CkAD
         l+TF8wtMFQndWlKSiShGzZDkE8hzvbpn3KW/B3lKV3vAOiSFfxTw/RNng5/J6mG1HSxt
         SOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531409; x=1698136209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxbU8VQAzmkVOhUJ/7DgKFkqpOThGFGr8nSN0CTJbY4=;
        b=DU0uEL74oDvQEMhV48HvVvLbcy2B2mrQbryIdSGJJs9wmxRdtP/II8BCGXnirkGrVS
         xngkDsddfcApQytrLwyDQdR2eUAx1lp7BfW6/oBUQF1UBw+Ytxcbznim5Ht/W7in+gGZ
         2kgTKUG74QCdEpEg7FLN6sqkSus1DuPbwAtQIqJW6OKajhuQZfWR88O+1Vnu/i2wjExd
         1C1v035ygmpabg1/5RD8Y5TUY3ZuvKZQXF050TmY389dLQpiUYIPsVlIS7Jq94djCV6M
         dygdeMTVPmE3gDij7GjApsOPWQjP3P4x+0PIaf8FCmeBByQFtEfPbUkd03EyCFUmaBe2
         SbCw==
X-Gm-Message-State: AOJu0YyY/0B2bRPB8/y7mHbdUHSPBbIfozdBXNeeFMq8Y5vUNbaZenWx
        /VrDAcoP26nnqX/97/cElYs4y21mFoBGfoo9KgfcqQ==
X-Google-Smtp-Source: AGHT+IEhYw5vI8pIZ4Y+FmCEilr+oOi7vQDFhZ/yqPSm9KF5E2p07D7Nyqk7el4fXcpUTBJRXNslGLpwa9JQAvj97Fo=
X-Received: by 2002:a25:8a92:0:b0:d9a:bbe1:1b7a with SMTP id
 h18-20020a258a92000000b00d9abbe11b7amr1291030ybl.50.1697531409028; Tue, 17
 Oct 2023 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-4-bartosz.golaszewski@linaro.org> <f12cb246-e7fb-44c4-a17e-0b395a146325@quicinc.com>
In-Reply-To: <f12cb246-e7fb-44c4-a17e-0b395a146325@quicinc.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 17 Oct 2023 10:29:58 +0200
Message-ID: <CACMJSet5df8_edRyhLdOhFGJ0arcq+XsQ+Jz_xa3O+eL+r6_pw@mail.gmail.com>
Subject: Re: [PATCH 03/11] firmware: qcom-scm: atomically assign and read the
 global __scm pointer
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 10:25, Om Prakash Singh
<quic_omprsing@quicinc.com> wrote:
>
>
>
> On 8/29/2023 12:54 AM, Bartosz Golaszewski wrote:
> > Checking for the availability of SCM bridge can happen from any context.
> > It's only by chance that we haven't run into concurrency issues but with
> > the upcoming SHM Bridge driver that will be initiated at the same
> > initcall level, we need to assure the assignment and readback of the
> > __scm pointer is atomic.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/firmware/qcom_scm.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 980fcfa20b9f..422de70faff8 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -1331,7 +1331,7 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
> >    */
> >   bool qcom_scm_is_available(void)
> >   {
> > -     return !!__scm;
> > +     return !!READ_ONCE(__scm);
> >   }
> >   EXPORT_SYMBOL(qcom_scm_is_available);
> >
> > @@ -1477,8 +1477,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >       if (ret)
> >               return ret;
> >
> > -     __scm = scm;
> > -     __scm->dev = &pdev->dev;
> > +     scm->dev = &pdev->dev;
> > +     WRITE_ONCE(__scm, scm);
>
> In my opinion "__scm = scm;" assignment should be done at the end of
> probe function success so that qcom_scm_is_available() return true only
> when probe is completed.
>
> Other changes may not be needed.
>

Om, this is v1. We're at v4 (soon v5).

I agree with the comment but it's outside the scope of this series. I
may address it later.

It has been like this for a long time. Typically this module is
built-in and initialized before all other drivers so it has never
caused problems.

Bart

> >       init_completion(&__scm->waitq_comp);
> >
