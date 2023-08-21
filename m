Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD9783133
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHUTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHUTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:35:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2ACB1;
        Mon, 21 Aug 2023 12:35:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3e271491so1200722b3a.0;
        Mon, 21 Aug 2023 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692646553; x=1693251353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qI34iJAcIg1OI4XvfXRAUhrMBaz6bUYHgyLqCszYbKs=;
        b=ROw/wzG7gRC5XxhpaHUu6WpcvcbnzgzJUE8MwCWLvoaInQBI+gmt1+OcvINQTlGaVy
         vZmY+DMlpccjjGkQCh9/1QZNKTBvZaTEtMH3wgHqfqibUMCSDhZt9ehNDl6xhC4J9vwa
         uYetQqBen4Rutv2vl2JXHBPZmOuV/79usnZqFT83SRvZGY26YsPtZd9DJ/h/ogGrpcLS
         x/FJRrZE84D1cNwf+sMq3CM9BLUzzFbxgCuolXRxMY0zXXJSamcR8n/ot7SpiMdPU5W+
         w7slnvPJv3X9fw1/OejoOtI+axdzBiMJJqrfhMVNNnAPJMsfktlQBxTYiC2M1etP28dj
         JMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692646553; x=1693251353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI34iJAcIg1OI4XvfXRAUhrMBaz6bUYHgyLqCszYbKs=;
        b=czw/MgpMwNF/xO1bJz/PLJ5eDCiNc/QmH/rN8pqak5USW1aXMrj7hQsuOw3pCGik6F
         XYkom+L8iCclTGS5Slw8y75LbC5tWuwkejfYELqdd0bnYB+u+dnQ9gNKj3PeXD5fPLU1
         /Sko599XnvtKNKBQZRadozY3cg95qLHP7kuMSUa55dzr0BqTsrmT8LOQKmjmU2EY48lM
         QZ/PlDajrg2BZ7xhBvBBz75yC/StGYwJmPkUihMiVqkCux+3+A+ZtYcconQGIzVxsNqw
         lSvUvjsVCM1zivDNi/xmMwalVqcPK2w49PcKpZo6xRHhVtP4VMOo3adCk6Ut2wUYim7s
         UF0A==
X-Gm-Message-State: AOJu0YwCpaKlKOCivjQd0n5G5P+TqzMd1/7x0p/TcbVMhfGTUGC6FONC
        c2sWhpIdREKfXy4i72AAUFLi0eQos4044D1ioJdT+ShCMwM=
X-Google-Smtp-Source: AGHT+IEu8u0Q6NeR+gSjQ1y/lfxy9rhzl9b8bC+fviPnNAXiuHAxq/Q4WzYGlsFAUQBtGDdkfceCH5zTv0g9aZxfPkA=
X-Received: by 2002:a05:6a00:b44:b0:68a:3bb9:7e86 with SMTP id
 p4-20020a056a000b4400b0068a3bb97e86mr4687197pfo.0.1692646553146; Mon, 21 Aug
 2023 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230815140030.1068590-1-robimarko@gmail.com> <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
 <20230821193152.GA2157670-robh@kernel.org>
In-Reply-To: <20230821193152.GA2157670-robh@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 21 Aug 2023 21:35:42 +0200
Message-ID: <CAOX2RU6be+eeTPT7HbC8_-C7d7oVhspsXWOmwtgg6s=QMe6QEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI disable
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        computersforpeace@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 21:31, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 16, 2023 at 08:15:54AM +0200, Krzysztof Kozlowski wrote:
> > On 15/08/2023 15:59, Robert Marko wrote:
> > > IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> > > means that WDT being asserted or just trying to reboot will hang the board
> > > in the debug mode and only pulling the power and repowering will help.
> > > Some IPQ4019 boards like Google WiFI have it enabled as well.
> > >
> > > So, lets add a boolean property to indicate that SDI should be disabled.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > index 4233ea839bfc..bf753192498a 100644
> > > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > @@ -89,6 +89,14 @@ properties:
> > >        protocol to handle sleeping SCM calls.
> > >      maxItems: 1
> > >
> > > +  qcom,sdi-disable:
> >
> > The property should describe rather current hardware/firmware state,
> > instead of expressing your intention for OS what to do. Therefore rather:
> > qcom,sdi-enabled
> > or
> > qcom,secure-debug-image
>
> Why can't you just disable SDI unconditionally when going into debug
> mode? Is doing that when not enabled going to crash the system or
> something?

Because if not disabled you will enter the Secure Debug mode even on a
regular reboot and then you have to pull the power in order to boot again.
Even according to QCA docs they intended for the Linux to disable SDI as
TZ/QSEE will always enable it as part of booting.

Regards,
Robert
>
> Rob
>
