Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A4780943
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359591AbjHRJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359564AbjHRJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:58:49 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80AD358B;
        Fri, 18 Aug 2023 02:58:26 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4871e5dbe0cso1129056e0c.1;
        Fri, 18 Aug 2023 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352701; x=1692957501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNoxATOaxWeBScP/ikkMfxNA0EfZgTay9gzhYEX8t+o=;
        b=KBvwTEdb4u9FpAy9sKP6wNpk8lZcNoCBH3XwcdMACtN6VX//lFuPi7lT+uZ2nyPYfm
         w6YyinOVJ+ItFEC7c0hLoj8QvA6QwVJeEmqg0iuLnf2ghRB37MEWRvAQFhSWy3VH5Fnm
         zlQfhiIQCt5RG0iEymktlhSgVfyM/hVLCjGgu4t86ST0RXEQdQwnjHcAdtT86mINCn8d
         igRy8VvbVtRp4gLsS+2vFUNDWfJMLhRbC5D/C4cp99gMHVOjyGTfxfdEg1g6AwQ/95Ec
         iN6E4jcr8H5MWIAyVBVF/4bHIZTMewhgcu5zrU/QVrNlX5iUeLfWauyAUjtN6vdTMNhY
         1yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352701; x=1692957501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNoxATOaxWeBScP/ikkMfxNA0EfZgTay9gzhYEX8t+o=;
        b=f8fOdCtA+9/iI9YwMB7u7ERfSwKDqWrQrE+Eex0IYASrkEI31Uuv5IVBTz0M9mueqv
         W0usi4a3M4JW68FXL5/zVLrbfq2lt538LkTpEHtsRJ82ddC419gy+LO0roby93FFfFVL
         YQ+VlbhiEzoRlLOjdFXUHkijzETztimojSSLhXe6XM4b2ywzDpf99MzUBJZP0eOXzqyK
         gifovWP5i53cBhsbFVCDFTx5i1KYJMdokFFVwTLmKGYYDjvtY11LWfjC5ax4mobQHf+W
         dnOFlqv+h79/N6daVAkQrQsO1J3yv43XC/kuPaRXQYQAVo6YLi4l9FmpjN72jtEzDB84
         OrRQ==
X-Gm-Message-State: AOJu0YxcZQfiTWJ7cT1Zm1TQaJvPGqfLPpGlxD9+KVmdg7zIso85jKkw
        eMu2KppbxG8D+8Kt528dXjXHB4q4gUHoHwdi9xY=
X-Google-Smtp-Source: AGHT+IHAtqsS0qWBH3caoHp/dOvENIaguHbzMfLS9QsDT89R3bbVNBtLcMNQKl15EsdxY3Dq3g1io9cmiTfPQy8JAvc=
X-Received: by 2002:a67:e911:0:b0:44a:c90a:cedd with SMTP id
 c17-20020a67e911000000b0044ac90aceddmr2196815vso.14.1692352700829; Fri, 18
 Aug 2023 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <e5d23a32-1ac5-d6a8-c9a4-15dfdd96ace8@intel.com> <CAK00qKA5_kKny0KpEO6w42fUvtG0_YpO5V_-5E4ZQZBT83v+Gg@mail.gmail.com>
In-Reply-To: <CAK00qKA5_kKny0KpEO6w42fUvtG0_YpO5V_-5E4ZQZBT83v+Gg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 18 Aug 2023 17:58:08 +0800
Message-ID: <CAK00qKBx8BS3EZYJcJZoCxLvQDGN_OUt=crwKvu1tCxk93PLaA@mail.gmail.com>
Subject: Re: [PATCH V9 00/23] Add support UHS-II for GL9755
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 6:10=E2=80=AFPM Victor Shih <victorshihgli@gmail.com=
> wrote:
>
> Hi, Ulf
>
> Excuse me, may I know the patch's status?
>
> If you already have a closer look at a paragraph in the series,
> could you let me know your comments first, let me check it first.
>
> I look forward to your reply.
>
> Thanks, Victor Shih
>
> On Mon, Jul 31, 2023 at 11:29=E2=80=AFPM Adrian Hunter <adrian.hunter@int=
el.com> wrote:
> >
> > On 21/07/23 13:13, Victor Shih wrote:
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> > >   Sequence[2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce
> > >   [2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de
> > >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> > >   Setting Register Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy
> > >   SD compatibility and preserve Legacy SD infrastructures (Section 7.=
1.1
> > >   Packet Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#6:  for core
> > > patch#7-#22: for sdhci
> > > patch#23:    for GL9755
> > >
> > > Changes in v9 (July. 21, 2023)
> > > * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next branch.
> > > * according to the comments provided by Adrian Hunter to modify the
> > >   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> > > * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
> > >            to PatchV9[02/23] for avoid compilation errors.
> > >            move uhs2_control definition of PatchV8[05/23]
> > >            to PatchV9[02/23] for avoid compilation errors.
> > >            move mmc_host flags definition of PatchV8[05/23]
> > >            to PatchV9[02/23] for avoid compilation errors.
> > >            move mmc_host flags MMC_UHS2_SUPPORT definition of
> > >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation err=
ors.
> > >            move mmc_host flags MMC_UHS2_SD_TRAN definition of
> > >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation err=
ors.
> > > * Patch#7: Modify the commit message.
> > > * Patch#8: Modify the commit message.
> > > * Patch#11: Modify annotations in sdhci_get_vdd_value().
> > > * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> > > * Patch#18: Modify the annotations in __sdhci_uhs2_send_command().
> > > * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> > > * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_i=
nit().
> > >             Rename gl9755_uhs2_reset_sd_tran() to
> > >             sdhci_gli_uhs2_reset_sd_tran().
> > >
> > > Reference
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > [2] SD Host Controller Simplified Specification 4.20
> > > [3] UHS-II Simplified Addendum 1.02
> > > [4] https://patchwork.kernel.org/project/linux-mmc/cover/202306211001=
51.6329-1-victorshihgli@gmail.com/
> > >
> > > ----------------- original cover letter from v8 -----------------
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> > >   Sequence[2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce
> > >   [2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de
> > >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> > >   Setting Register Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy
> > >   SD compatibility and preserve Legacy SD infrastructures (Section 7.=
1.1
> > >   Packet Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#6:  for core
> > > patch#7-#22: for sdhci
> > > patch#23:    for GL9755
> > >
> > > Changes in v8 (June. 21, 2023)
> > > * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> > > * fix most of checkpatch warnings/errors.
> > > * according to the comments provided by Adrian Hunter to modify the
> > >   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> > > * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> > >            Modify return value in sd_uhs2_attach().
> > > * Patch#7: Use tabs instead of spaces.
> > > * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> > > * Patch#10: Adjust the position of matching brackets.
> > > * Patch#11: Adjust the position of matching brackets.
> > >             Add the initial value of the pwr in sdhci_uhs2_set_power(=
).
> > > * Patch#13: Initialization be combined with declaration and realigned
> > >             in sdhci_calc_timeout_uhs2().
> > >             Forward declare struct mmc_command in sdhci_uhs2.h.
> > > * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> > >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> > >             __sdhci_uhs2_set_ios().
> > >             Add the switch case for MMC_TIMING_SPEED_A_HD,
> > >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> > >             sdhci_get_preset_value().
> > >             mmc_opt_regulator_set_ocr() to instead of
> > >             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> > > * Patch#15: usleep_range() to instead of udelay() in
> > >             sdhci_uhs2_interface_detect().
> > >             read_poll_timeout() to instead of read_poll_timeout_atomi=
c()
> > >             in sdhci_uhs2_interface_detect().
> > >             Modify return value in sdhci_uhs2_do_detect_init().
> > > * Patch#16: Remove unnecessary include file.
> > >             read_poll_timeout() to instead of read_poll_timeout_atomi=
c()
> > >             in sdhci_uhs2_enable_clk().
> > >             Put the comment on the end and put the lines in descendin=
g
> > >             line length in sdhci_uhs2_enable_clk().
> > >             Modify return value in sdhci_uhs2_enable_clk().
> > > * Patch#17: Reorder the definitions and lose the parentheses in
> > >             sdhci_uhs2_set_config().
> > >             read_poll_timeout() to instead of read_poll_timeout_atomi=
c()
> > >             in sdhci_uhs2_check_dormant().
> > > * Patch#18: Adjust the position of matching brackets in
> > >             sdhci_uhs2_send_command_retry().
> > >             Modify CameCase definition in __sdhci_uhs2_finish_command=
().
> > >             Modify error message in __sdhci_uhs2_finish_command().
> > >             sdhci_uhs2_send_command_retry() to instead of
> > >             sdhci_uhs2_send_command() in sdhci_uhs2_request().
> > >             Use sdhci_uhs2_mode() to simplify code in
> > >             sdhci_uhs2_request_atomic().
> > >             Add forward declaration for sdhci_send_command().
> > > * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
> > >             Remove forward declaration of sdhci_send_command().
> > >             Use mmc_dev() to simplify code in sdhci_request_done_dma(=
).
> > > * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4()=
.
> > >             Remove unused variables in __sdhci_uhs2_add_host_v4().
> > > * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> > > * Patch#23: Use sdhci_get_vdd_value() to simplify code in
> > >             gl9755_set_power().
> > >             Use read_poll_timeout_atomic() to simplify code in
> > >             sdhci_wait_clock_stable().
> > >             Use read_poll_timeout_atomic() to simplify code in
> > >             sdhci_gl9755_reset().
> > >
> > > Reference
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > [2] SD Host Controller Simplified Specification 4.20
> > > [3] UHS-II Simplified Addendum 1.02
> > > [4] https://patchwork.kernel.org/project/linux-mmc/cover/202303311055=
46.13607-1-victor.shih@genesyslogic.com.tw/
> > >
> > > ----------------- original cover letter from v7 -----------------
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup =
Sequence
> > >   [2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce[2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de Section
> > >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting=
 Register
> > >   Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy SD
> > >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1=
 Packet
> > >   Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#6:  for core
> > > patch#7-#22: for sdhci
> > > patch#23:    for GL9755
> >
> > For patches 7 - 23:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >

Hi, Adrian

     For some reason, I will slightly modify 3 patches in V10, please
help to review again.
     PatchV10[11/23]: Move some definitions of PatchV9[05/23] to PatchV10[1=
1/23]
     PatchV10[18/23]: Use tmode_half_duplex to instead of uhs2_tmode0_flag =
in
                                  sdhci_uhs2_set_transfer_mode().
     PatchV10[20/23]: Move some definitions of PatchV9[05/23] to PatchV10[2=
0/23]

Thanks, Victor Shih
