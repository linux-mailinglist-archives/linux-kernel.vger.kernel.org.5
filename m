Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4127A9D08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjIUT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIUT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B3A4ABF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:58:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59bc97d7b3dso34234747b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319119; x=1695923919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRNYzNiImJujTu3gVe0e/F1xgNn+hpxzq5LY7wQeMXA=;
        b=WriGPSX9pADR1QXrjEoyMVwaZQZXGKbYRDO8os1ufIkuFNXUMkbPzw2gfmjIKfXcXy
         599iP5o4G3M6mDVUxL+/dBgZ8VTWq+ZwZvItoR3H5xbpGOfWOBGsa5VPDIlrr6dcrt2z
         PaHS4VcDU12FjyEhO+h0wRCoCRiERpsAT6RNoGEdoi2KOwTPnfxTSgKiK+1BoV2BYch2
         N0SF09xhQ/X2RA+NCHYQ3RDVgevmvR+GfBIHDwMLKlWR3KRr389K6j+hpeB4+bgtb38G
         yHfw/dx15lYbz+phk+O3FcAZTvbBdfIkQTypOstXMD2AhTDYC9Z+hMDTQrhVf4Xc9XHP
         8llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319119; x=1695923919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRNYzNiImJujTu3gVe0e/F1xgNn+hpxzq5LY7wQeMXA=;
        b=X94R72tyAverN8KqiPiF63tPdZ371g3wIKqfV4ITpH77+rVVUWj70661uNCYc/49l1
         nJ/Jmq946hEWltRqhR2dcDT0bj0ygdm94A/Hz+xhcPryK0t+dLIF1pIvlwUcLFGaUEzE
         uQIJWZBY7NwCemq3LfCmSxAWVwfEHwhU+RfOFX4BUYY6nKatvudPaKLcvHrj9wXKKoGM
         pYktrK09M8LITFNxNAfgPM9ZXpu0PZ2fe98oSdgrCSOPPQEk0VGvJCSww93tfurCiKNu
         yv1QYIe368wsLOUpno7pzrqJdSJBwjhZvwomYJQZUh3VPbuhognKNBOdHYR0T7m47fMK
         1Lvg==
X-Gm-Message-State: AOJu0YwTWC1AzhhEJM1ofNKojn3MOOkF7OmTCSg24gDtnQqZaU5yMgRD
        HMB4viKs3kq/atPZcixAV0seIFDXWj4oAYWTfR4+v6SbXu8=
X-Google-Smtp-Source: AGHT+IHDnNytitrj7g9Wmajhoe6mCmu7lVKXRZ191256VG1PXDsUDEvnSpWs3jvPhcDX3RKb1qYinf71cmk84zYAogw=
X-Received: by 2002:a05:6870:e2cb:b0:1b0:3f7f:673a with SMTP id
 w11-20020a056870e2cb00b001b03f7f673amr3513899oad.25.1695297933746; Thu, 21
 Sep 2023 05:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <170e8577-42c9-b72f-60c7-80141f379ec4@arm.com> <20230921021350.28283-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20230921021350.28283-1-mark-pk.tsai@mediatek.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 21 Sep 2023 20:05:22 +0800
Message-ID: <CAB8ipk8cn893vTg_TZwBq4G7CtLdjCPtJ5Bt0OKbO9VxXg6rfQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: vfp: Add vudot opcode to VFP undef hook
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     robin.murphy@arm.com, amit.kachhap@arm.com,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux@armlinux.org.uk,
        matthias.bgg@gmail.com, yj.chiang@mediatek.com,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        "aijun.sun@unisoc.com" <aijun.sun@unisoc.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK, Robin

We also meets the scene, and has the following stack:

Thread-2 (5361): undefined instruction: pc=3Dd05ae08c
CPU: 5 PID: 5361 Comm: Thread-2 Tainted: G        W  O
5.4.210-android12-9-04458-g56c7c43d3298-ab000045 #98
Hardware name: Generic DT based system
PC is at 0x7d1aa068
LR is at 0x7c22ae50
pc : [<7d1aa068>]    lr : [<7c22ae50>]    psr: 800b0010
sp : 7c78ee20  ip : 7c22ae40  fp : 7c78eea0
r10: 7c22ae60  r9 : 7c22ae70  r8 : 00000008
r7 : 7c0fee80  r6 : 7c0fee70  r5 : 7c0fee60  r4 : 00000010
r3 : 7c0fee50  r2 : 00000000  r1 : 00000010  r0 : a698aee0
Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
Control: 10c5383d  Table: 8649c06a  DAC: 00000055
Code: edddcb1e fe22edd4 f4600a0d fc67cd98 (fe20edf4) <<<

So, we also need add the 0xfe000000:

Could you please help add the following patch into the patch-v2?

Thanks!

---
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 7e8773a2d99d..1078c0f169d2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -788,6 +788,18 @@ static struct undef_hook neon_support_hook[] =3D {{
        .cpsr_mask      =3D PSR_T_BIT,
        .cpsr_val       =3D 0,
        .fn             =3D vfp_support_entry,
+}, {
+       .instr_mask     =3D 0xfc000000,
+       .instr_val      =3D 0xfc000000,
+       .cpsr_mask      =3D PSR_T_BIT,
+       .cpsr_val       =3D 0,
+       .fn             =3D vfp_support_entry,
+}, {
+       .instr_mask     =3D 0xfe000000,
+       .instr_val      =3D 0xfe000000,
+       .cpsr_mask      =3D PSR_T_BIT,
+       .cpsr_val       =3D 0,
+       .fn             =3D vfp_support_entry,
 }, {
        .instr_mask     =3D 0xef000000,
        .instr_val      =3D 0xef000000,
@@ -800,6 +812,18 @@ static struct undef_hook neon_support_hook[] =3D {{
        .cpsr_mask      =3D PSR_T_BIT,
        .cpsr_val       =3D PSR_T_BIT,
        .fn             =3D vfp_support_entry,
+}, {
+       .instr_mask     =3D 0xfc000000,
+       .instr_val      =3D 0xfc000000,
+       .cpsr_mask      =3D PSR_T_BIT,
+       .cpsr_val       =3D PSR_T_BIT,
+       .fn             =3D vfp_support_entry,
+}, {
+       .instr_mask     =3D 0xfe000000,
+       .instr_val      =3D 0xfe000000,
+       .cpsr_mask      =3D PSR_T_BIT,
+       .cpsr_val       =3D PSR_T_BIT,
+       .fn             =3D vfp_support_entry,
 }};

 static struct undef_hook vfp_support_hook =3D {

On Thu, Sep 21, 2023 at 12:40=E2=80=AFPM Mark-PK Tsai <mark-pk.tsai@mediate=
k.com> wrote:
>
> > On 2023-09-20 09:39, Mark-PK Tsai wrote:
> > > Add vudot opcode to the VFP undef hook to fix the
> > > potentially undefined instruction error when the
> > > user space executes vudot instruction.
> >
> > Did the kernel expose a hwcap to say that the dot product extension is
> > supported? I'm pretty sure it didn't, so why would userspace expect thi=
s
> > to work? ;)
>
> The hwcap for dotprod has been exported since commit:
>
> 62ea0d873af3 ARM: 9269/1: vfp: Add hwcap for FEAT_DotProd
>
> >
> > IIRC Amit was looking at defining the hwcaps to align with arm64 compat=
,
> > but I believe that series faltered since most of them weren't actually
> > needed (and I think at that point it was still missing the VFP support
> > code parts). It would be nice if someone could pick up and combine both
>
> Were the mentioned series related to this commit?
>
> 62ea0d873af3 ARM: 9269/1: vfp: Add hwcap for FEAT_DotProd
>
> > efforts and get this done properly; fill in *all* the hwcaps and
> > relevant handling for extensions which Cortex-A55 supports (since
> > there's definitely more than just VUDOT), and then hopefully we're done
> > for good.
>
> Agree.
>
> >
> > > Before this commit, kernel didn't handle the undef exception
> > > caused by vudot and didn't enable VFP in lazy VFP context
> > > switch code like other NEON instructions.
> > > This led to the occurrence of the undefined instruction
> > > error as following:
> > >
> > > [  250.741238 ] 0904 (26902): undefined instruction: pc=3D004014ec
> > > ...
> > > [  250.741287 ] PC is at 0x4014ec
> > > [  250.741298 ] LR is at 0xb677874f
> > > [  250.741303 ] pc : [<004014ec>]    lr : [<b677874f>]    psr: 800700=
10
> > > [  250.741309 ] sp : beffedb0  ip : b67d7864  fp : beffee58
> > > [  250.741314 ] r10: 00000000  r9 : 00000000  r8 : 00000000
> > > [  250.741319 ] r7 : 00000001  r6 : 00000001  r5 : beffee90  r4 : 004=
01470
> > > [  250.741324 ] r3 : beffee20  r2 : beffee30  r1 : beffee40  r0 : 004=
003a8
> > > [  250.741331 ] Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM =
Segment user
> > > [  250.741339 ] Control: 10c5383d  Table: 32d0406a  DAC: 00000055
> > > [  250.741348 ] Code: f4434aef f4610aef f4622aef f4634aef (fc620df4)
> > >
> > > Below is the assembly of the user program:
> > >
> > > 0x4014dc <+108>: vst1.64 {d20, d21}, [r3:128]
> > > 0x4014e0 <+112>: vld1.64 {d16, d17}, [r1:128]
> > > 0x4014e4 <+116>: vld1.64 {d18, d19}, [r2:128]
> > > 0x4014e8 <+120>: vld1.64 {d20, d21}, [r3:128] --> switch out
> > > 0x4014ec <+124>: vudot.u8 q8, q9, q10         <-- switch in, and FPEX=
C.EN =3D 0
> > >                                                    SIGILL(illegal ins=
truction)
> > >
> > > Link: https://services.arm.com/support/s/case/5004L00000XsOjP
> >
> > Linking to your private support case is not useful to upstream. Even I
> > can't open that link.
>
> I thought that maybe someone in arm need this.
> But it seems a bit noisy so I will remove the link from v2.
>
> >
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >   arch/arm/vfp/vfpmodule.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > > index 7e8773a2d99d..7eab8d1019d2 100644
> > > --- a/arch/arm/vfp/vfpmodule.c
> > > +++ b/arch/arm/vfp/vfpmodule.c
> > > @@ -788,6 +788,12 @@ static struct undef_hook neon_support_hook[] =3D=
 {{
> > >     .cpsr_mask      =3D PSR_T_BIT,
> > >     .cpsr_val       =3D 0,
> > >     .fn             =3D vfp_support_entry,
> > > +}, {
> > > +   .instr_mask     =3D 0xffb00000,
> > > +   .instr_val      =3D 0xfc200000,
> > > +   .cpsr_mask      =3D PSR_T_BIT,
> > > +   .cpsr_val       =3D 0,
> > > +   .fn             =3D vfp_support_entry,
> > >   }, {
> > >     .instr_mask     =3D 0xef000000,
> > >     .instr_val      =3D 0xef000000,
> > > @@ -800,6 +806,12 @@ static struct undef_hook neon_support_hook[] =3D=
 {{
> > >     .cpsr_mask      =3D PSR_T_BIT,
> > >     .cpsr_val       =3D PSR_T_BIT,
> > >     .fn             =3D vfp_support_entry,
> > > +}, {
> > > +   .instr_mask     =3D 0xffb00000,
> > > +   .instr_val      =3D 0xfc200000,
> > > +   .cpsr_mask      =3D PSR_T_BIT,
> > > +   .cpsr_val       =3D PSR_T_BIT,
> > > +   .fn             =3D vfp_support_entry,
> >
> > Why have two entries conditional on each possible value of one bit for
> > otherwise identical encodings? Surely it suffices to set both cpsr_mask
> > and cpsr_val to 0?
>
> You're right.
> I will set both cpsr_mask and cpsr_val to 0 and use single entry,
> as you suggested, in the v2 patch.
>
> Thanks.
>
> >
> > Thanks,
> > Robin.
> >
> > >   }};
> > >
> > >   static struct undef_hook vfp_support_hook =3D {
