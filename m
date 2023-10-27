Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514A77D92CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbjJ0IzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjJ0Iyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:54:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3026AD5F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:54:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778a47bc09aso136158085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698396886; x=1699001686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdaenGl9X0PEqjSYbPqn12MNPqtdvNAV8Oju3UsrrJ0=;
        b=jPXDVdwOZWiByTXtns5MQe3jfkq3+LXPNufNTO1vQAUqaeDOYmtPlXlOgarrTtfLMV
         M2CIsdzRrbDx2e/dbgtc1HL589v6No7k5n/8idt5+kKkMEN7ljGspvIYBt8wIs8LJyF/
         lGle5OFT5TeQNoP+wcvR+U/VZZUj3qNNHfx1brIlHFUFG8h18uU185y4fpVCYleWGnXg
         dcvxG8+FGoDhdXZ00WFa5EW7Ap1lSFkPyWQaf8qBR2jJSOnjLS2Y5B2qQAA8elRN5akv
         sEILGqFzy6ldoqZ92xuT7byvPKgHHwbYs6O8mNkKqdXeSQr1JDtzhTq0enz7nCt/SVqs
         vZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396886; x=1699001686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdaenGl9X0PEqjSYbPqn12MNPqtdvNAV8Oju3UsrrJ0=;
        b=bkvDKyzrkP5EAoSfzmDwd9egrcHrTipYXezbPXyudKJ7M5Ld7kBo+ZKmnVRCPSXCLv
         9zlfsBpa7ZfZAGuMM9BUd5ugGAga86edxP/qj1Xh0Yhdmpl8/CvK2DzSh63BJ0qOhtwH
         c9HnlcvV+FPyBMPIuL73HeqsAS1el6HEW70mHyQ6Veq19ytXQMeVPyXjT0HZ7Kz44fh/
         f9d3qoarNNhqjMjCG3UubSQlUDvWW5FiOwpY+agbSk5+IBzm0VPcpTFhj560dy78lxNW
         TPZoXAQiws6KH1tpEuD7bD4s0HibYBcPkXaKCL6jO+lCPaUFPMgitvojLGCMD/gGkyEv
         i+cg==
X-Gm-Message-State: AOJu0Yx+L/orBj/sjvrgZxWnImpCn7FE2/tMFKr57aiOfFloO9r3utwR
        LPWMejJh0yBnJ9PrS11qMZUXzhYVsxb9ordDuFSuQjKScdYJCHyh/Ok=
X-Google-Smtp-Source: AGHT+IEeCm4aK9bpRM+LcIhgy8a9j/Ju0WiTVSP3A9XTCbcW3Gefp3T6ONYgGWcMpDzNEJEHYxXa/UkgFynZJD761IY=
X-Received: by 2002:ae9:c114:0:b0:777:2792:4a2d with SMTP id
 z20-20020ae9c114000000b0077727924a2dmr1687510qki.65.1698396886165; Fri, 27
 Oct 2023 01:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231024101902.6689-1-nylon.chen@sifive.com> <20231024101902.6689-2-nylon.chen@sifive.com>
 <20231024-yin-coliseum-11f5e06fec14@spud> <CAHh=Yk_h_1r7ZG+yLK=SoK9AgPkestuQDH-CK621mz=X-PA+cQ@mail.gmail.com>
 <20231025-utmost-enforcer-eda125f636ac@spud>
In-Reply-To: <20231025-utmost-enforcer-eda125f636ac@spud>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 27 Oct 2023 16:54:35 +0800
Message-ID: <CAHh=Yk_MfFowjzUypgZ7DEc2nNN2Pd7MAFCk6W=5P4Asd20T_A@mail.gmail.com>
Subject: Re: [v5 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> =E6=96=BC 2023=E5=B9=B410=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Oct 25, 2023 at 05:32:21PM +0800, Nylon Chen wrote:
> > Hi Conor,
> >
> > Conor Dooley <conor@kernel.org> =E6=96=BC 2023=E5=B9=B410=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hey,
> > >
> > > On Tue, Oct 24, 2023 at 06:19:01PM +0800, Nylon Chen wrote:
> > > > This removes the active-low properties of the PWM-controlled LEDs i=
n
> > > > the HiFive Unmatched device tree.
> > > >
> > > > The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-s=
chematics-v3.pdf[1].
> > > >
> > > > Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-=
7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> > > > Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-=
e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]
> > >
> > > >
> > >
> > > This blank line should be removed if there is a follow-up.
> > thanks, I got it.
> > >
> > > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > >
> > > What did Vincent contribute to this patch? Are you missing a
> > > co-developed-by tag, perhaps?
> > Yes, Vincent was the first person to find the PWM driver problem, and
>
> That sounds like s/Signed-off-by/Reported-by/ then.
Thanks, I got it.
>
> Cheers,
> Conor.
