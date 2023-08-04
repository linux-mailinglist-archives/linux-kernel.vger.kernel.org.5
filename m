Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAA76FE2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHDKKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:10:45 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F82118;
        Fri,  4 Aug 2023 03:10:43 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44757af136cso851673137.3;
        Fri, 04 Aug 2023 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691143842; x=1691748642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJhW0ZjzOpMD8nvVAK/+sCT8UCoqJbIL0iy1V+dPWgw=;
        b=GVkvWuW5knKrx/ezgHcD5CUwrpjUaaB9Zd1kFsegumqvIsxNATr5LsPT+nB2kA0tAh
         aAo48KepB43S/m/3ZUh9k5H93l5zvUjaJMfrVQ1XFHarikWL0Y7MdCgw3mAqGN68Bg3p
         1VlMYbevlSgISSoRYbsSFSImO+p8aBNTtTC+MFXu6/43f1ryFClB4N2TqlzuQzx1Doez
         SraYg2YGg9ABr2uoOAQQx/GYkmfcwFfzGL1borFk7T+Nj9m1842sy876O9R/lwQ4e5rU
         u3NMQnVlRB7YwbM+rylyQcQ5SrMxs3kw2UKM+3jtWvg4OEANrj6wiCPoNq7J72twT8QO
         khpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143842; x=1691748642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJhW0ZjzOpMD8nvVAK/+sCT8UCoqJbIL0iy1V+dPWgw=;
        b=bBx+PxbgYBRvtE7gOGo7IwWFJeZ3lJviwsasakmEc5AO60Qq9emEIL6PUA4bU1F5Na
         eRRWqQOieUu8/EjKfmTQwVpbEWj/oH2+gNlyXLYlwRWqEerUJSq7B7sgP8ehmL/xLiJI
         6wMOetg6fMgrc+k3seGoEiEhDzhYuMe4xKhypn38e6RHfLtVskPQNjgdLZN1W6DK72ez
         9bDrFdn/vtPPJ8YI0nzF9L99m5OlkB5u49qNirAOME5MoKFgIIieY7ftVke7+dzXanT7
         jn+BmY5GLvXwX+WyfZxxevaH/7MQ0qCXL9ua129Zwi/IlfJgtUjKmRx+/Qzei57atQ9A
         qdAQ==
X-Gm-Message-State: AOJu0YxIrPOltKE3M79SisqUgz1Iq1/S5Hvh9Oiem/cVzZFVUQfr3AAL
        GzBAZVizzA7dPHaK6CpcPp1nHJ6XP8IdRLuC1go6ze9SvwQ=
X-Google-Smtp-Source: AGHT+IF2kRKRL4V5TQsu+iVEjPpOfDw0ui/eOrQ/JFQQbMqmSthGCdhGjQDdmJyE/OVXrd+LZEwUT4Nz6HukX/eOnr8=
X-Received: by 2002:a67:f4ce:0:b0:447:6ba8:9a21 with SMTP id
 s14-20020a67f4ce000000b004476ba89a21mr724817vsn.27.1691143842187; Fri, 04 Aug
 2023 03:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <e5d23a32-1ac5-d6a8-c9a4-15dfdd96ace8@intel.com>
In-Reply-To: <e5d23a32-1ac5-d6a8-c9a4-15dfdd96ace8@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 4 Aug 2023 18:10:30 +0800
Message-ID: <CAK00qKA5_kKny0KpEO6w42fUvtG0_YpO5V_-5E4ZQZBT83v+Gg@mail.gmail.com>
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

Hi, Ulf

Excuse me, may I know the patch's status?

If you already have a closer look at a paragraph in the series,
could you let me know your comments first, let me check it first.

I look forward to your reply.

Thanks, Victor Shih

On Mon, Jul 31, 2023 at 11:29=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/07/23 13:13, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v9 (July. 21, 2023)
> > * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> > * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move uhs2_control definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move mmc_host flags definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move mmc_host flags MMC_UHS2_SUPPORT definition of
> >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation error=
s.
> >            move mmc_host flags MMC_UHS2_SD_TRAN definition of
> >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation error=
s.
> > * Patch#7: Modify the commit message.
> > * Patch#8: Modify the commit message.
> > * Patch#11: Modify annotations in sdhci_get_vdd_value().
> > * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> > * Patch#18: Modify the annotations in __sdhci_uhs2_send_command().
> > * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> > * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_ini=
t().
> >             Rename gl9755_uhs2_reset_sd_tran() to
> >             sdhci_gli_uhs2_reset_sd_tran().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230621100151=
.6329-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v8 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v8 (June. 21, 2023)
> > * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> > * fix most of checkpatch warnings/errors.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> > * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >            Modify return value in sd_uhs2_attach().
> > * Patch#7: Use tabs instead of spaces.
> > * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> > * Patch#10: Adjust the position of matching brackets.
> > * Patch#11: Adjust the position of matching brackets.
> >             Add the initial value of the pwr in sdhci_uhs2_set_power().
> > * Patch#13: Initialization be combined with declaration and realigned
> >             in sdhci_calc_timeout_uhs2().
> >             Forward declare struct mmc_command in sdhci_uhs2.h.
> > * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             __sdhci_uhs2_set_ios().
> >             Add the switch case for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             sdhci_get_preset_value().
> >             mmc_opt_regulator_set_ocr() to instead of
> >             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> > * Patch#15: usleep_range() to instead of udelay() in
> >             sdhci_uhs2_interface_detect().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_interface_detect().
> >             Modify return value in sdhci_uhs2_do_detect_init().
> > * Patch#16: Remove unnecessary include file.
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_enable_clk().
> >             Put the comment on the end and put the lines in descending
> >             line length in sdhci_uhs2_enable_clk().
> >             Modify return value in sdhci_uhs2_enable_clk().
> > * Patch#17: Reorder the definitions and lose the parentheses in
> >             sdhci_uhs2_set_config().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_check_dormant().
> > * Patch#18: Adjust the position of matching brackets in
> >             sdhci_uhs2_send_command_retry().
> >             Modify CameCase definition in __sdhci_uhs2_finish_command()=
.
> >             Modify error message in __sdhci_uhs2_finish_command().
> >             sdhci_uhs2_send_command_retry() to instead of
> >             sdhci_uhs2_send_command() in sdhci_uhs2_request().
> >             Use sdhci_uhs2_mode() to simplify code in
> >             sdhci_uhs2_request_atomic().
> >             Add forward declaration for sdhci_send_command().
> > * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
> >             Remove forward declaration of sdhci_send_command().
> >             Use mmc_dev() to simplify code in sdhci_request_done_dma().
> > * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4().
> >             Remove unused variables in __sdhci_uhs2_add_host_v4().
> > * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> > * Patch#23: Use sdhci_get_vdd_value() to simplify code in
> >             gl9755_set_power().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_wait_clock_stable().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_gl9755_reset().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331105546=
.13607-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v7 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
>
> For patches 7 - 23:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
