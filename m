Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A5C78EFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbjHaOtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:49:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2231B1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:49:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so9364945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693493379; x=1694098179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYzNNWTbXx2Ehv1Xqnr5+Jyg1rByrT48Wq+qGpaaLU8=;
        b=NvzE768TPm6/QPR3b3zsQUpY3v7UuaFSIQfsffcpSqXAz12o1ZaxEYrT4Eo+yxdm9Q
         a6wE1LfOqKi17Wj3ZzW/YPlEv2JAhnU10uPNpRzRxuXc0siG9hhSWYO+xjf2F3AuITVG
         gKma5uWK6MRW/mbwX69FPD5+br+69ikAs5KlIcg0uhcacrKbKyg5rVkGCFcTSqtgIHlb
         oFImjI3wW4FPtmAy7hXAuou5oFoE1AVHc3ruN+1Vib0NsX45cobzZHR4OFM9rSR06ZO7
         40JWudGea41hAFjcB1PUIv2IOdOQUEsn3IvYBWgxH/Pqwemh36MwPzkjrN5gblfsndI7
         br2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493379; x=1694098179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYzNNWTbXx2Ehv1Xqnr5+Jyg1rByrT48Wq+qGpaaLU8=;
        b=J57znmVQVaVLQW0zkerzxGLum6JfoHqMjauZagw8KzYlmK1WmuALo3iuoLviZbRsn7
         iuyeicf4750olGi8z5EDDudqpRjIxyF++I8K4e9E5UMP7yUzHgYncX+LiyFEL4/P09M0
         s8X1GVaFyE+Zwublun3SEZ3krGQX3sLLv08KXbT/APRw0rl7LoP2fF4rFWt8yN7Odu12
         RzEmNUhVkFc8ej8YH+GxJIAWjJ1ZuW4kSx43gkbQVB0iu2MPRn0C4zn3B5c+W7Bigglh
         xfIUKDYXFfT9oC2eDzWFemDE5uDiF32p4oi3RyDn9+3Us0mCSiDU5sWYeOCh30q782oZ
         tR7Q==
X-Gm-Message-State: AOJu0Yx46TRENZGcqLF8Hh+YK5fJEoLSiXL8ABUFSVLdAleH2fjQzoqo
        jIcKtiRlYdyQPzj6xxdb9ho5O3M7ayyX9t5ug7c=
X-Google-Smtp-Source: AGHT+IFjTC8nbArwDx+ol6fGY7cYqbVM5nzbgV0lIucPfXPRItanMflTJwp6bLIQdCN2aAPRDDlantYHSAtBtw8N28Q=
X-Received: by 2002:a05:6000:10a:b0:314:5f4a:5a63 with SMTP id
 o10-20020a056000010a00b003145f4a5a63mr4389888wrx.54.1693493378300; Thu, 31
 Aug 2023 07:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
 <20230830093902.duvvjimgwddh7qbt@bogus> <F59FC6AB-40E6-4BBA-A0BD-C7221160854B@gmail.com>
 <20230831123412.wetnqqb7owqfyqov@bogus>
In-Reply-To: <20230831123412.wetnqqb7owqfyqov@bogus>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Thu, 31 Aug 2023 22:49:26 +0800
Message-ID: <CAJRQjof3UtmL=mGOQ54E-a6hM-NOG_g0aD8Peta5Xp=wm7wSRg@mail.gmail.com>
Subject: Re: [PATCH v1] firmware: arm_scmi: Fix NULL pointer dereference in mailbox_clear_channel
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 8:34=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 09:23:58PM +0800, Qiujun Huang wrote:
> >
> >
> > > 2023=E5=B9=B48=E6=9C=8830=E6=97=A5 =E4=B8=8B=E5=8D=885:39=EF=BC=8CSud=
eep Holla <sudeep.holla@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Aug 30, 2023 at 01:07:47AM +0800, Qiujun Huang wrote:
> > >> There is a race between the failure of probe and rx_callback (due to=
 a
> > >> delayed response).
> > >>
> > >> scmi_probe
> > >> scmi_acquire_protocal
> > >> do_xfer
> > >> timeout
> > >> mailbox_chan_free
> > >>                                                    <--- delay respon=
se
> > >>                                                           rx_callbac=
k
> > >> mbox_free_channel
> > >> cinfo->transport_info =3D NULL
> > >>                                                          mailbox_cle=
ar_channel
> > >>                                                         dereference =
cinfo->transport_info
> > >
> > > It is always good to provide the kernel stacktrace which you get when=
 a
> > > NULL pointer is dereference. It helps for review and also to document=
 it.
> > >
> > > --
> > > Regards,
> > > Sudeep
> >
> > Get it. Here is the splat.
> >
> > [    1.942240][    C0] Unable to handle kernel NULL pointer dereference=
 at virtual address 0000000000000048
> > [    1.942241][    C0] Mem abort info:
> > [    1.942243][    C0]   ESR =3D 0x96000005
> > [    1.944888][    T9] spmi spmi-1: PMIC arbiter version v7 (0x70000000=
)
> > [    1.950652][    C0]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    1.950653][    C0]   SET =3D 0, FnV =3D 0
> > [    1.950654][    C0]   EA =3D 0, S1PTW =3D 0
> > [    1.950656][    C0] Data abort info:
> > [    1.950657][    C0]   ISV =3D 0, ISS =3D 0x00000005
> > [    1.950658][    C0]   CM =3D 0, WnR =3D 0
> > [    1.950660][    C0] [0000000000000048] user address but active_mm is=
 swapper
> > [    1.950663][    C0] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> > [    2.338929][    C0] pc : mailbox_clear_channel+0x18/0x64
> > [    2.344384][    C0] lr : scmi_handle_response+0x17c/0x4f4
> > [    2.349923][    C0] sp : ffffffc010003db0
> > [    2.354045][    C0] x29: ffffffc010003dc0 x28: ffffffd85263f000
> > [    2.360216][    C0] x27: ffffffd851621068 x26: ffffffd84ec815c8
> > [    2.366386][    C0] x25: ffffffd85263bf80 x24: ffffffd85263d230
> > [    2.372556][    C0] x23: ffffff803cd70cc0 x22: 0000000000000008
> > [    2.378726][    C0] x21: ffffff8036cf0df8 x20: ffffffd85161bac8
> > [    2.384896][    C0] x19: ffffff8043ffa580 x18: ffffffc010005050
> > [    2.391065][    C0] x17: 0000000000000000 x16: 00000000000000d8
> > [    2.397234][    C0] x15: ffffffd8507965e8 x14: ffffffd84eaebdf0
> > [    2.403404][    C0] x13: 00000000000001ea x12: 0000000000007ffb
> > [    2.409574][    C0] x11: 000000000000ffff x10: ffffffd852c5a000
> > [    2.415744][    C0] x9 : d7be1a9b75f29500 x8 : 0000000000000000
> > [    2.421914][    C0] x7 : 382e31202020205b x6 : ffffffd852c57e7c
> > [    2.428084][    C0] x5 : ffffffffffffffff x4 : 0000000000000000
> > [    2.434254][    C0] x3 : ffffffd84eae6668 x2 : 0000000000000001
> > [    2.440424][    C0] x1 : 0000000000000000 x0 : ffffff8043ffa580
> > [    2.446594][    C0] Call trace:
> > [    2.449819][    C0]  mailbox_clear_channel+0x18/0x64
>
> Is this with latest kernel ? IIUC the mailbox_clear_channel should get ca=
lled
no, it's on 5.10-stable kernel
> only for delayed response and notification in this path(scmi_handle_respo=
nse).
> You are saying it happens as part of probe and again IIUC probe doesn't h=
ave
> any delayed response command. What am I missing ?
>
> Any additional changes in the tree ? My build has much smaller
> mailbox_clear_channel.
>
> > [    2.454916][    C0]  scmi_handle_response+0x17c/0x4f4
> > [    2.460100][    C0]  rx_callback+0x60/0xec
> > [    2.464311][    C0]  mbox_chan_received_data+0x44/0x94
> > [    2.469584][    C0]  qcom_rimps_rx_interrupt+0xc0/0x144 [qcom_rimps]
>
> This suggests out of tree driver, any pointers ?
>
> Also I vaguely remember discussing this in the past. Perhaps at [1] or
> somewhere else.
Get that. It looks painful
>
> --
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/linux-arm-kernel/cfa26ff3-c95a-1986-58fc-b49f=
c9be49d5@quicinc.com/
