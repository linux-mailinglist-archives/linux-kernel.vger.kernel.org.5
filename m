Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3377F10A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348414AbjHQHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbjHQHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:15:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707B272D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:15:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76cded293e8so483519385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692256513; x=1692861313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZxONYRYUA2SIICDRecfca1lVWlX5qvboAgMcTP29Gk=;
        b=dsvxmPdzfrxDI3p/zUDrAPmQkNNBGN69/EAEF4WFUrBWuvF7ZA52OZECbyFkdnZzpY
         cH0r/ziXL1FU+FyOhwFo416k0I+1JZMsyqpd9//MLy0JiqPFJQ8NN9LhYgGrUtOZNUrc
         45N/+Q+FYyFUhqL+U0g6gXfXPf1vM7I+XVhSM6LJlbqcxR+bZShI0yEcjYt6UFBxH7pK
         ycfz/zbsESGtumvi8Cqm2oQ9dgMDn+18YiROzH3k8Znsy7HCddtqXT00EwpnQC/fmX+Q
         /05aTm8LyNeC+nlCJeQCZOYqeQ2d9AndA28ITWggTg24jtyi6SDpel6VmxIDwdq6OEHd
         XNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692256513; x=1692861313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZxONYRYUA2SIICDRecfca1lVWlX5qvboAgMcTP29Gk=;
        b=aP7scvs2sX90ZcjyEwK2mckNxFoyyakA6oSosnCP0/yatuX4qmhV4k0HhDNxon2vSc
         Gresk6ab1lIroeDcVujDelT42v+FwivVAp+j93qr4tKRNI3WCsu+cgSW2dE9gGb7hkCF
         txi98I8A+/TQM0OpK7uEpUsjRDzAEfKAesMPBbAhX8xhU8v/LBggr0RGd00Np+4QeO0c
         FFXxLzJwvH3Or//97TQh373hCg0oHxIS6IpX+wZac1XFUDLjet8KkWVWXt5f4Zvfgvmv
         b0p6yeFOelGoN42PeOfpjcK4cJ9Bc5/+hMdAw1eM2mVyQrogAXg5KVo5lrPrkCLKD8n6
         RCiw==
X-Gm-Message-State: AOJu0Yx3OniwODeHkjjtthSxutXOt5iv2a2PAflOSxw8nB2VpPQk+NIv
        /GISZMOCfuE7XnMMVqdc5toVo7hPdYU9qP6VMkhuCMaPbncoM3RjcLk=
X-Google-Smtp-Source: AGHT+IEcxHUtvwqTlfg/2NwjU0sKrHqqk3qgeXLdbA6/VHS9Ia+zSyyV3Ft8nF/ULFeIITB27MmsFCtWcll2+giOMpg=
X-Received: by 2002:a05:620a:2944:b0:76c:b0aa:cfd1 with SMTP id
 n4-20020a05620a294400b0076cb0aacfd1mr5620731qkp.37.1692256512993; Thu, 17 Aug
 2023 00:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230816034009.2614866-1-nick.hu@sifive.com> <20230816-mural-portion-5b22d90e83fd@wendy>
In-Reply-To: <20230816-mural-portion-5b22d90e83fd@wendy>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Thu, 17 Aug 2023 15:15:02 +0800
Message-ID: <CAKddAkCawPAAcwKr58YJ-Yiw49946GUniJGMDumsPFXaKLDm=Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: suspend: Add syscore ops for suspend
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        mason.huo@starfivetech.com, jeeheng.sia@starfivetech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor

On Wed, Aug 16, 2023 at 8:34=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Wed, Aug 16, 2023 at 11:40:09AM +0800, Nick Hu wrote:
> > Save and restore the FPU and vector states when system suspend. If a
> > task is the one who performs the suspend flow and it also do some
> > floating or vector operations before the suspend, we should save and
> > restore the FPU states and vector states for this task.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>
> What was Andy's contribution to the patch?
> Are you missing a co-developed-by tag?
>
He fixed something related to vector.
I'll add co-developed-by in the next version.

> Also, I'm a bit confused by the commit message due to a lack of
> knowledge here - is this a fix or a new feature?
> It reads as if things are not being saved/restored correctly, but
> there's no "fix" related keywords in the commit message nor a Fixes:
> tag.
>
> Thanks,
> Conor.
I'll rephrase the commit message.
Thanks for the feedback.

Thanks,
Nick
