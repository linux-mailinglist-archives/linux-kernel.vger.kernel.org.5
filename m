Return-Path: <linux-kernel+bounces-19348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DB826BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56415282460
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8F1427A;
	Mon,  8 Jan 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PatjNdlD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87513FFF;
	Mon,  8 Jan 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4670a58b118so205907137.2;
        Mon, 08 Jan 2024 02:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704710737; x=1705315537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHSm3N014AyUGE60z5Ba7SfqhipC/Xvk589IxwExjzc=;
        b=PatjNdlDDvHaLZTsLdoP4MJ/vPWcx9LKuPjU80IICnC3QpWUHDGUv/ag5ZktqSumee
         t0t9n8IIzGJVCEF6fTSJ/rnGLIMUXT0nLdOYHoH+NGqjNgho/TZ8IUiNBWCcs0OCuF+7
         zFFZPQTWx0K5vr0Tv/vfMQ6MUfggWpqytIsGhyeSS9MZnRgyucWV3O0KHrRgNdW3SCWq
         XF2RaMvVXuX+U5w/GOznz1nBJeuJW8+iv0MsbuEz/E3uEssV9ZdY0c57lj6GlqbayOgc
         cW1qIKSZT3Zw8owFp5Dt6hHrgkK5XgtlkmQQvbiCrutK+MCRvsgrpUt3RKs2ZAgAqMId
         rNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710737; x=1705315537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHSm3N014AyUGE60z5Ba7SfqhipC/Xvk589IxwExjzc=;
        b=OINKrycrugS8dHYkELerbryd8D9hAzCLaG0t9WR4jFJjuem4j1XeUA3q34bEkU/4hm
         d8Zv3YVEsXcwpK9XbyOdfOoKZWQz7/bU+oooZ2cO+h7ZwYbcHLm3FUGE79oS81HyQHlF
         CfOFqZaKVIeLKVdrjhvHSUFZ7BNUQ6uy95Z5epQ9nrFTa4stngWrqkh2bXnxkVYOAd7r
         F4pYAPkcSutjXizpvAFssf0VmNwzvQ5jFeyE2RIo4WwygkEa+g0avS2DjYW0KgjBzXk8
         D8OMDL6tsMlOVxLiOQ5Iut177NJDqu0JHpnlPAulyo8/jGO8jEtstjBcgsqHUSKNUkYG
         /1cA==
X-Gm-Message-State: AOJu0Yxdz59OEvNL0X/SJgs0un2GC9RjfNGY9O7KczAi7RWGHm6FqHid
	io3ms3mnAwq+ySmm8zAfAx295bboY7Umv9rH9T8=
X-Google-Smtp-Source: AGHT+IFJAE8HmDrjS1ZHO1g8sP3OJ5Gr8T2WbYQk0149HFHlzuTn7euukEPd6oRHbT8wa9VpxY6xD3LaM92I7GvfH94=
X-Received: by 2002:a05:6102:6690:b0:467:d91f:83a6 with SMTP id
 gw16-20020a056102669000b00467d91f83a6mr428619vsb.0.1704710736957; Mon, 08 Jan
 2024 02:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117113149.9069-1-victorshihgli@gmail.com>
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 8 Jan 2024 18:45:25 +0800
Message-ID: <CAK00qKDw7aZ+sB4afUfwQmQamTZ0km+e5zgVRpJbQLCf8o_Zmw@mail.gmail.com>
Subject: Re: [PATCH V13 00/21] Add support UHS-II for GL9755
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf

Excuse me, may I know about your opinion on this series of patches?
If you already have a closer look at a paragraph in the series,
could you let me know your comments first, let me check it first.

I look forward to your reply.

Thanks, Victor Shih


On Fri, Nov 17, 2023 at 7:31=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#7:  for core
> patch#8-#20: for sdhci
> patch#21:    for GL9755
>
> Changes in v13 (November. 17, 2023)
> * rebased to the linux-kernel-v6.7.0-rc1 in Ulf Hansson next branch.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> * according to the comments provided by Ulf Hansson to modify the
>   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> * Add new patch#6 to re-factoring the code.
> * Patch#7: Separate __mmc_go_idle() into one patch for re-factorring the =
code.
>            Move mmc_decode_scr declaration to sd.h.
>            Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
>            Drop unnecessary comment.
> * Patch#11: Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS=
2 mode.
> * Patch#12: Drop use vmmc2.
>             Modify comment message.
> * Patch#13: Modify comment message.
> * Patch#14: Add judgment condition for power mode in the __sdhci_uhs2_set=
_ios().
>             Modify comment message.
> * Patch#15: Merge Patch#15, Patch#16 and Patch#17 of v12 version into Pat=
ch#15 in v13 version.
>             Use definitions to simplify code.
>             Modify comment message.
> * Patch#16: Re-order function to avoid declaration.
>             Remove unnecessary function.
> * Patch#17: Re-order function to avoid declaration.
>             Remove unnecessary definitions.
> * Patch#18: Re-order function to avoid declaration.
>             Use vqmmc2 to stead vmmc2.
> * Patch#21: Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230915094351.1=
1120-1-victorshihgli@gmail.com/
>
> ----------------- original cover letter from v12 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v12 (September. 15, 2023)
> * rebased to the linux-kernel-v6.6.0-rc1 in Ulf Hansson next branch.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> * according to the comments provided by Ulf Hansson to modify the
>   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> * Patch#5: Remove unused max_current_180_vdd2.
> * Patch#6: Use mmc_op_multi() to check DCMD which supports multi
>            read/write in mmc_uhs2_prepare_cmd().
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230908095330.1=
2075-1-victorshihgli@gmail.com/
>
> ----------------- original cover letter from v11 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v11 (September. 08, 2023)
> * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next branch.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V10 00/23] Add support UHS-II for GL9755.
> * Patch#18: Drop the check mmc_card_uhs2_hd_mode(host->mmc)
>             in sdhci_uhs2_set_transfer_mode().
> * Patch#20: Remove unused ocr_avail_uhs2.
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721101349.1=
2387-1-victorshihgli@gmail.com/
>
> ----------------- original cover letter from v10 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v10 (August. 18, 2023)
> * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next branch.
> * according to the comments provided by Ulf Hansson to modify the
>   patches base on the [V9 00/23] Add support UHS-II for GL9755.
> * Patch#2: Drop unnecessary definitions and code.
> * Patch#3: Modify the commit message.
> * Patch#4: Modify the commit message.
> * Patch#5: Drop unnecessary definitions.
> * Patch#6: Move some definitions of PatchV9[02/23] to PatchV10[06/23].
>            Move some definitions of PatchV9[05/23] to PatchV10[06/23].
>            Drop do_multi in the mmc_blk_rw_rq_prep().
>            Use tmode_half_duplex to instead of uhs2_tmode0_flag.
>            Move entire control of the tmode into mmc_uhs2_prepare_cmd().
> * Patch#11: Move some definitions of PatchV9[05/23] to PatchV10[11/23].
> * Patch#18: Use tmode_half_duplex to instead of uhs2_tmode0_flag
>             in sdhci_uhs2_set_transfer_mode().
> * Patch#20: Move some definitions of PatchV9[05/23] to PatchV10[20/23].
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721101349.1=
2387-1-victorshihgli@gmail.com/
>
> ----------------- original cover letter from v9 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v9 (July. 21, 2023)
> * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next branch.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move uhs2_control definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags MMC_UHS2_SUPPORT definition of
>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags MMC_UHS2_SD_TRAN definition of
>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation errors.
> * Patch#7: Modify the commit message.
> * Patch#8: Modify the commit message.
> * Patch#11: Modify annotations in sdhci_get_vdd_value().
> * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> * Patch#18: Modify the annotations in __sdhci_uhs2_send_command().
> * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_init(=
).
>             Rename gl9755_uhs2_reset_sd_tran() to
>             sdhci_gli_uhs2_reset_sd_tran().
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230621100151.6=
329-1-victorshihgli@gmail.com/
>
> ----------------- original cover letter from v8 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v8 (June. 21, 2023)
> * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> * fix most of checkpatch warnings/errors.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>            Modify return value in sd_uhs2_attach().
> * Patch#7: Use tabs instead of spaces.
> * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> * Patch#10: Adjust the position of matching brackets.
> * Patch#11: Adjust the position of matching brackets.
>             Add the initial value of the pwr in sdhci_uhs2_set_power().
> * Patch#13: Initialization be combined with declaration and realigned
>             in sdhci_calc_timeout_uhs2().
>             Forward declare struct mmc_command in sdhci_uhs2.h.
> * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>             __sdhci_uhs2_set_ios().
>             Add the switch case for MMC_TIMING_SPEED_A_HD,
>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>             sdhci_get_preset_value().
>             mmc_opt_regulator_set_ocr() to instead of
>             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> * Patch#15: usleep_range() to instead of udelay() in
>             sdhci_uhs2_interface_detect().
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_interface_detect().
>             Modify return value in sdhci_uhs2_do_detect_init().
> * Patch#16: Remove unnecessary include file.
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_enable_clk().
>             Put the comment on the end and put the lines in descending
>             line length in sdhci_uhs2_enable_clk().
>             Modify return value in sdhci_uhs2_enable_clk().
> * Patch#17: Reorder the definitions and lose the parentheses in
>             sdhci_uhs2_set_config().
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_check_dormant().
> * Patch#18: Adjust the position of matching brackets in
>             sdhci_uhs2_send_command_retry().
>             Modify CameCase definition in __sdhci_uhs2_finish_command().
>             Modify error message in __sdhci_uhs2_finish_command().
>             sdhci_uhs2_send_command_retry() to instead of
>             sdhci_uhs2_send_command() in sdhci_uhs2_request().
>             Use sdhci_uhs2_mode() to simplify code in
>             sdhci_uhs2_request_atomic().
>             Add forward declaration for sdhci_send_command().
> * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
>             Remove forward declaration of sdhci_send_command().
>             Use mmc_dev() to simplify code in sdhci_request_done_dma().
> * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4().
>             Remove unused variables in __sdhci_uhs2_add_host_v4().
> * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> * Patch#23: Use sdhci_get_vdd_value() to simplify code in
>             gl9755_set_power().
>             Use read_poll_timeout_atomic() to simplify code in
>             sdhci_wait_clock_stable().
>             Use read_poll_timeout_atomic() to simplify code in
>             sdhci_gl9755_reset().
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331105546.1=
3607-1-victor.shih@genesyslogic.com.tw/
>
> ----------------- original cover letter from v7 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequ=
ence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2=
]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include S=
ection
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Reg=
ister
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Pac=
ket
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
>
> Changes in v7 (Mar. 31, 2023)
> * rebased to the linux-kernel-v6.3.0-rc3 in Ulf Hansson next branch.
> * according to the guidance and overall architecture provided
>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
>   UHS-2 Core function based on the patches of the [V4,0/6]
>   Preparations to support SD UHS-II cards[5].
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
>   the UHS-2 Host function based on the patches of the
>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> * implement the necessary function to let the UHS-2 Core/Host
>   work properly.
> * fix most of checkpatch warnings/errors.
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang to implement the UHS-2
>   Host function based on the patches of the
>   [V5,00/26] Add support UHS-II for GL9755[6].
> * according to the guidance and comments provided by
>   Ulf Hanssion, Adrian Hunter, Ben Chuang to implement the UHS-2
>   Host function based on the patches of the
>   [V6,00/24] Add support UHS-II for GL9755[7].
> * The uhs2_post_attach_sd() function is no longer needed so drop
>   the V6 version of the Patch#22.
> * Modifies the usage of the flags used by the sdhci host for
>   MMC_UHS2_INITIALIZED.
> * Patch#1: Drop unnecessary bracket.
> * Patch#2: Drop sd_uhs2_set_ios function.
>            Used ->uhs2_control() callback for uhs2_set_ios
>            in sd_uhs2_power_up().
>            Used ->uhs2_control() callback for uhs2_set_ios
>            in sd_uhs2_power_off().
>            Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
>            Modify sd_uhs2_legacy_init to avoid the
>            sd_uhs2_reinit cycle issue.
> * Patch#5: Drop unnecessary definitions.
> * Patch#6: Drop unnecessary function.
>            Drop uhs2_state in favor of ios->timing.
> * Patch#7: Reorder values and positions of definitions.
> * Patch#9: Used sdhci_uhs2_mode function to simplify.
> * Patch#11: Drop pwr variable in sdhci_uhs2_set_power function.
> * Patch#14: Modify some descriptions.
>             Drop unnecessary function.
> * Patch#15: Drop using uhs2_reset ops and use sdhci_uhs2_reset function
>             in the sdhci_do_detect_init function.
> * Patch#17: Drop unnecessary function.
> * Patch#18: Drop unnecessary whitespace changes.
>             Cancel the export state of some functions.
> * Patch#19: Drop unnecessary function.
>             Used sdhci_uhs2_mode function to simplify.
>             Modify some descriptions.
>             Cancel the export state of some functions.
> * Patch#20: Drop using __sdhci_uhs2_host function and use
>             __sdhci_add_host function in sdhci_uhs2_add_host function.
>             Cancel the export state of some functions.
> * Patch#23: Drop using uhs2_post_attach_sd function.
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.1=
9831-1-takahiro.akashi@linaro.org/
> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.1=
0738-1-jasonlai.genesyslogic@gmail.com/
> [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647.1=
1076-1-victor.shih@genesyslogic.com.tw/
> [7] https://patchwork.kernel.org/project/linux-mmc/cover/20221213090047.3=
805-1-victor.shih@genesyslogic.com.tw/
>
> ----------------- original cover letter from v6 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequ=
ence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2=
]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include S=
ection
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Reg=
ister
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Pac=
ket
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#23: for sdhci
> patch#24:    for GL9755
>
> Changes in v6 (Dec. 12, 2022)
> * rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next branch.
> * according to the guidance and overall architecture provided
>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
>   UHS-2 Core function based on the patches of the [V4,0/6]
>   Preparations to support SD UHS-II cards[5].
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
>   the UHS-2 Host function based on the patches of the
>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> * implement the necessary function to let the UHS-2 Core/Host
>   work properly.
> * fix most of checkpatch warnings/errors.
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang to implement the UHS-2
>   Host function based on the patches of the
>   [V5,00/26] Add support UHS-II for GL9755[6].
> * The uhs2_post_attach_sd() has implemented in Patch#6 and
>   Patch#17 so drop the V5 version of the Patch#23.
> * Modifies the usage of the flags used by the sdhci host for
>   MMC_UHS2_INITIALIZED.
> * Patch#5: Drop unused definitions and functions.
> * Patch#7: Rename definitions.
>            Use BIT() GENMASK() in some cases.
> * Patch#8: Merge V5 version of Patch[7] and Patch[9] into
>            V6 version of Patch[8].
> * Patch#9: Drop unnecessary function.
>            Rename used definitions.
> * Patch#10: Drop unnecessary function and simplify some code.
> * Patch#11: Drop unnecessary function.
>             Add new mmc_opt_regulator_set_ocr function.
> * Patch#13: Drop unnecessary function.
>             Use GENMASK() and FIELD_PREP() in some cases.
> * Patch#14: Drop unnecessary function.
>             Modify return value in some function.
>             Use GENMASK() and FIELD_PREP() in some cases.
> * Patch#15: Drop unnecessary function.
>             Rename used definitions.
>             Use GENMASK() and FIELD_GET() in some cases.
>             Wrap at 100 columns in some functions.
> * Patch#16: Drop unnecessary function.
> * Patch#17: Drop unnecessary function.
>             Drop the unnecessary parameter when call the DBG()
>             function.
>             Rename used definitions.
>             Cancel the export state of some functions.
>             Use GENMASK() and FIELD_PREP() in some cases.
> * Patch#18: Drop unnecessary function.
>             Add uhs2_dev_cmd function to simplify some functions.
>             Rename used definitions.
>             Cancel the export state of some functions.
>             Use GENMASK() and FIELD_PREP() in some cases.
> * Patch#19: Drop unnecessary function.
>             Add sdhci_uhs2_mode() in some functions.
>             Rename used definitions.
>             Cancel the export state of some functions.
> * Patch#20: Add new complete_work_fn/thread_irq_fn variables in
>             struct sdhci_host.
>             Use complete_work_fn/thread_irq_fn variables in
>             sdhci_alloc_host()/sdhci_uhs2_add_host().
>             Rename used definitions.
> * Patch[24]: Rename used definitions.
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.1=
9831-1-takahiro.akashi@linaro.org/
> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.1=
0738-1-jasonlai.genesyslogic@gmail.com/
> [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647.1=
1076-1-victor.shih@genesyslogic.com.tw/
>
> ----------------- original cover letter from v5 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequ=
ence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2=
]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include S=
ection
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Reg=
ister
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Pac=
ket
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#6:  for core
> patch#7-#25: for sdhci
> patch#26:    for GL9755
>
> Changes in v5 (Oct. 19, 2022)
> * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
> * according to the guidance and overall architecture provided
>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
>   UHS-2 Core function based on the patches of the [V4,0/6]
>   Preparations to support SD UHS-II cards[5].
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
>   the UHS-2 Host function based on the patches of the
>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> * implement the necessary function to let the UHS-2 Core/Host
>   work properly.
> * fix most of checkpatch warnings/errors
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.1=
9831-1-takahiro.akashi@linaro.org/
> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.1=
0738-1-jasonlai.genesyslogic@gmail.com/
>
> ----------------- original cover letter from v3.1 -----------------
> This is an interim snapshot of our next version, v4, for enabling
> UHS-II on MMC/SD.
>
> It is focused on 'sdhci' side to address Adrian's comments regarding
> "modularising" sdhci-uhs2.c.
> The whole aim of this version is to get early feedback from Adrian (and
> others) on this issue. Without any consensus about the code structure,
> it would make little sense to go further ahead on sdhci side.
> (Actually, Adrian has made no comments other than "modularising" so far.)
>
> I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> set to meet what I believe Adrian expects; no UHS-II related code in
> Legacy (UHS-I) code or sdhci.c.
>
> Nevertheless, almost of all changes I made are trivial and straightforwar=
d
> in this direction, and I believe that there is no logic changed since v3
> except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-II
> command sequences in addition to UHS-II errors. So I added extra handling=
s.
>
> I admit that there is plenty of room for improvements (for example,
> handling host->flags), but again the focal point here is how sdhci-uhs2.c
> should be built as a module.
>
> Please review this series (particularly Patch#8-#26 and #27) from this
> viewpoint in the first place.
> (Ben is working on 'host' side but there is no change on 'host' side
> in this submission except a minor tweak.)
>
> Thanks,
> -Takahiro Akashi
>
> ------ original cover letter from v3 ------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequ=
ence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2=
]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include S=
ection
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Reg=
ister
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legac=
y SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Pac=
ket
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1-#7: for core
> patch#8-#17: for sdhci
> patch#18-#21: for GL9755
>
> Tests
> =3D=3D=3D=3D=3D
> Ran 'dd' command to evaluate the performance:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> UHS-II enabled         :  206MB/s   80MB/s
>
> TODO
> =3D=3D=3D=3D
> - replace some define with BIT macro
>
> Reference
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
>
> Changes in v3 (Jul. 10, 2020)
> * rebased to v5.8-rc4
> * add copyright notice
> * reorganize the patch set and split some commits into smaller ones
> * separate uhs-2 headers from others
> * correct wrong spellings
> * fix most of checkpatch warnings/errors
> * remove all k[cz]alloc() from the code
> * guard sdhci-uhs2 specific code with
>       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> * make sdhci-uhs2.c as a module
> * trivial changes, including
>   - rename back sdhci-core.c to sdhci.c
>   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
>       in __sdhci_add_host()
>   - merge uhs2_power_up() into mmc_power_up()
>   - remove flag_uhs2 from mmc_attach_sd()
>   - add function descriptions to EXPORT'ed functions
>   - other minor code optimization
>
> Changes in v2 (Jan. 9, 2020)
> * rebased to v5.5-rc5
>
> Ben Chuang (1):
>   mmc: sdhci-uhs2: add pre-detect_init hook
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
> Victor Shih (16):
>   mmc: core: Add definitions for SD UHS-II cards
>   mmc: core: Add New function to re-factoring the code
>   mmc: core: Support UHS-II card control and access
>   mmc: sdhci: add UHS-II related definitions in headers
>   mmc: sdhci: add UHS-II module and add a kernel configuration
>   mmc: sdhci-uhs2: dump UHS-II registers
>   mmc: sdhci-uhs2: add reset function and uhs2_mode function
>   mmc: sdhci-uhs2: add set_power() to support vdd2
>   mmc: sdhci-uhs2: add set_timeout()
>   mmc: sdhci-uhs2: add set_ios()
>   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
>   mmc: sdhci-uhs2: add request() and others
>   mmc: sdhci-uhs2: add irq() and others
>   mmc: sdhci-uhs2: add add_host() and others to set up the driver
>   mmc: sdhci-pci: add UHS-II support framework
>   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
>
>  drivers/mmc/core/Makefile         |    2 +-
>  drivers/mmc/core/bus.c            |   38 +-
>  drivers/mmc/core/core.c           |   27 +-
>  drivers/mmc/core/core.h           |    1 +
>  drivers/mmc/core/host.h           |    7 +
>  drivers/mmc/core/mmc_ops.c        |   24 +-
>  drivers/mmc/core/mmc_ops.h        |    1 +
>  drivers/mmc/core/regulator.c      |   34 +
>  drivers/mmc/core/sd.c             |   10 +-
>  drivers/mmc/core/sd.h             |    5 +
>  drivers/mmc/core/sd_ops.c         |    9 +
>  drivers/mmc/core/sd_ops.h         |   17 +
>  drivers/mmc/core/sd_uhs2.c        | 1341 +++++++++++++++++++++++++++++
>  drivers/mmc/host/Kconfig          |   10 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/sdhci-pci-core.c |   16 +-
>  drivers/mmc/host/sdhci-pci-gli.c  |  233 ++++-
>  drivers/mmc/host/sdhci-pci.h      |    3 +
>  drivers/mmc/host/sdhci-uhs2.c     | 1257 +++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h     |  190 ++++
>  drivers/mmc/host/sdhci.c          |  274 +++---
>  drivers/mmc/host/sdhci.h          |   74 +-
>  include/linux/mmc/card.h          |   36 +
>  include/linux/mmc/core.h          |   13 +
>  include/linux/mmc/host.h          |   72 ++
>  include/linux/mmc/sd_uhs2.h       |  240 ++++++
>  26 files changed, 3789 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
>  create mode 100644 include/linux/mmc/sd_uhs2.h
>
> --
> 2.25.1
>

