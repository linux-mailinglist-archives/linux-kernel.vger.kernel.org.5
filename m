Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A07529FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjGMRjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGMRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:39:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C942702
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:39:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so1777437e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rockhopper.net; s=google; t=1689269940; x=1691861940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlnIv1GsZFbVP3Mz1BXr5g6tvtlYrqCrnxeQatJWL5o=;
        b=dgiY+HvO1FpJhCIGvHgXS0mUDVS3PxJF9No5QY2NVBT1Tj3CHHds3pcUK70WI7fiY8
         Or+/PGk3KywJbVt5OtcINVfueInl1X1emfZGvye1yRtQgSmz8vyr2AOTbdTG6j/ORNSS
         CVyxWZn2mYd/tI1arM+gVepPEVCghGikwGkIYO+D2jtyGfT7JHmuxO9IIZ4XqiF1LZ7h
         eim6um7RqfDTccpdOrk1fjkdGbwxyLaRKebX92aur6uiFT3EMPB40rP8z3GVTr1ZB3Vp
         IW9iSnSRx1GK533xqWZLhYe3FGAqHRIkUe15uwrVXNOveMN6hJz/aT1V2Ae2Sw3e7sgL
         medQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269940; x=1691861940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlnIv1GsZFbVP3Mz1BXr5g6tvtlYrqCrnxeQatJWL5o=;
        b=EzK2awg6Ob4wTzkmbEX45EN4davFDx13RCNGJdfd+tIx0fpDQRaN72/Ae7zkzj4mZI
         OQSJFYoOhXPnGJz3G410hhyn/rVOTXusA+fKWr6FFktAykfGhGpYj9kQa37JvKxwXX6v
         CHtuMLEqQRzxGJIrcqzPt2F+CynjDCoGK4QPJ9jX/Y450clgTngoHbTL+2bOyXXF12LY
         kESw71P9UOVcqMDVUqjGdhlDJQl8u/PsOr448WXxigmJpiy+wrx/OY/LRuaCDg3LVHIi
         2PbfZgxTNZYiL0AfuTWJYS2vz/+ncOMImp60LdtraQ3nhHgXqy7bVKNZ/8Snz1JU83B9
         Uptw==
X-Gm-Message-State: ABy/qLYD/i75uSSJLp+qlrrsPpxbMtWnb0YbrOGj6+g1iLLEFaqDzIrE
        QMNifBXO9BHNiat2P5lWcH4PHYVaXGvPl8N2yXQtPw==
X-Google-Smtp-Source: APBJJlGX/JqfBDiTkKnXSfw8Jeta2jGHb+I9n/u/xraUGH8HRL532zdH+oRvB6XAeXbc5bOvnH8Jj87VgxutH3Y3jsc=
X-Received: by 2002:a05:6512:b85:b0:4f8:442c:de25 with SMTP id
 b5-20020a0565120b8500b004f8442cde25mr1974614lfv.5.1689269939161; Thu, 13 Jul
 2023 10:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHqEdrPuH4ayMiiq5FixaNjM=r44VJOw-v3iQ0mek55FTUWpsw@mail.gmail.com>
 <CAHqEdrPD_EX=V0RnvvycN1MyXs0e+jkCcQ-nfHwOmyZR2LecfA@mail.gmail.com> <20230706084511.gp4iuvekkw7lwhdl@bogus>
In-Reply-To: <20230706084511.gp4iuvekkw7lwhdl@bogus>
From:   Avram Lubkin <avram@rockhopper.net>
Date:   Thu, 13 Jul 2023 13:38:48 -0400
Message-ID: <CAHqEdrMmwHzDFUeMWxmXrpM273-yw9-rz-HFnQK+Br0rcf0m1w@mail.gmail.com>
Subject: Re: Bug introduced in 724ba67 (ARM: dts: Move .dts files to vendor sub-directories)
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     robh@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, liviu.dudau@arm.com,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for submitting a patch. I saw it was acked. Will that get
merged soon? It shouldn't need to for the next merge window since it's
fixing an issue, right?
Just wondering if I need to work around this or not.

Thanks,
Avram

On Thu, Jul 6, 2023 at 4:45=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 10:16:19AM -0400, Avram Lubkin wrote:
> > Resending in plain text mode
> >
> > SImple bug introduced in 724ba6751532055db75992fc6ae21c3e322e94a7.
> >
> > The file
> >   arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> > was moved to
> >   arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
> >
> > However,
> >   arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
> > is a symlink and still points to the old location
> >   ../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi
> >
>
> It doesn't break any compilation as it is taken care. I will submit a pat=
ch
> to remove the symlink soon. Thanks for the report.
>
>
> --
> Regards,
> Sudeep
