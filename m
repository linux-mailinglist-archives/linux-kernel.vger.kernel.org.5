Return-Path: <linux-kernel+bounces-93346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0F872E51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B2AB21854
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B407018032;
	Wed,  6 Mar 2024 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkIlz7z7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055A5381;
	Wed,  6 Mar 2024 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702874; cv=none; b=VGCz4/pVu7C+s6pQPJqtxhVeunqdtf6a0aDVery2RVo4o0znF98QI8JkVUuLBbgLqXWzBIZfPUWanWgP6oSCoAr52cpRm1JY8l8oBfhz9W5o705WHgLiqdYvGt6kAbaqltPIb9DBeDYq34moji2KaFgmkliYETW/DHxqhxyC2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702874; c=relaxed/simple;
	bh=wKnbumHw86NpSxlTFIsomzV9Cee/hsO0cJfbKBQ1Ltw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNJ0Sm65rXK7vi9DWkGB0G9qlxUu/0X9CBCKKMGvMJxDL1U6Xazv38smkaR1x+79KxnipHkBx/C5Zq/PbpWhy8D0MUlmXHHTIZ54nMtpqINDxoc6YxLrRSXruTpQBLKhk/9VnSfSJBfg5ehTRILqQhljWgwinIzfo5n8juPsRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkIlz7z7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5134f830488so2295997e87.0;
        Tue, 05 Mar 2024 21:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709702871; x=1710307671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6XANTBlf+Hs9bvtmVOEbSoR6w8IVhuP5PyAmad96gU=;
        b=nkIlz7z7+/TzMXCTrizfss9B9s7aOYq+cB9Hr1H1J/v+n44zMaRXevLvK3EOOB5jEQ
         GP3+PQAy0gbV6PSc0wO0xKzDHDm82J7Z4znTJGXDSTojTAPdoV6lvQ6O5g57zlupVLDU
         DdoQl9LAZviwBcozn0FeoI7hP3dnExq4kLoPAUWgVRMoC7KL+A/BDNvypJWtmpNPMFCk
         FZKD3Qsn97pkJ53IQyxoVO0rgJaNuE4PwhLKO+zb2cyJk170IfbtBNuUmOsHCa2JAUDR
         CRb3VMYTj/EVRX3JYbuU8n32RqHHWZ51j6im5j6pssrEwbbV6LqIBuw54QYq0e7mWlwH
         mONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702871; x=1710307671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6XANTBlf+Hs9bvtmVOEbSoR6w8IVhuP5PyAmad96gU=;
        b=fr6V+g0XvnirDDtl+V6+4lqMBupX38d5jDJ+OLWJPeErQfWICS8bjYZsdOPxnpektC
         1DPRsAqz1/bPAbzaz+1CsetKg+vHn/kTgASfg2rij0CGzce2OOOf6oaQNPWbdvB9Cb4z
         s7gpg2VnsGrGKclKqLzfR48/qOslT5FV68Dp1+werH02ocOzKu8SL+bmUcqbuI+o/Qmz
         B5Bfc4R6yG67lWUGr4XHP0k0MwH4Vh1yqy2XcGxc7gpnnBkUxIU3w2CBjZda1Rd37QB7
         JEuWQXtuh+pvtImsn8L9PWECV6403hTjEtTfzyngsEtUBTLJjEXvyEkR5lpaVj6t21i4
         45Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU2HsrU0K+Hoa5/YeUDReJbvo/EcvQvCatEUJO/Bjgn2G0R3dn5oZ/VcRllPlrI450XcZXf8vXpFy7rTo/3Kb1/SvZtfqwgZ+Vep9Vo2egdn6CxXDgKDL58OxFppO6NGrB3My5gzTLcaA==
X-Gm-Message-State: AOJu0Yw/Iid+fVppU9NqjSfLg9udawGKtAzHdBtJA9P6rRoBHclvhWFN
	pDm0W3iQyP8ehuj8vv7ReLkc4g6z62VA29km9YbSYOr5eYQ/YomGWI2v3jNJM+WmJeQQ56AOvW4
	OpljL6Bfs7Zzz0D3C0ap7Qn0yvbWlVJBfDaPgEw==
X-Google-Smtp-Source: AGHT+IEV8/o3jo9E7Lp/Mc9+d1xZq5uwZjt002ECMmo5PNhaBpnQ1gL7QcMHHTkoZreIlmul4g1YHUkohgFH+8dhTbE=
X-Received: by 2002:a05:6512:3194:b0:513:5eb5:f7f4 with SMTP id
 i20-20020a056512319400b005135eb5f7f4mr369476lfe.55.1709702870587; Tue, 05 Mar
 2024 21:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 6 Mar 2024 10:57:38 +0530
Message-ID: <CAKfKVtErVuCM+pa1e7Lwt0DUU-t-U0eNRnZSw39pfsZ8gv8QZQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] EDAC/mc/synopsys: Various fixes and cleanups
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, 
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:52=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> This patchset is a first one in the series created in the framework of
> my Synopsys DW uMCTL2 DDRC-related work:
>
> [1: In-progress v5] EDAC/mc/synopsys: Various fixes and cleanups
> Link: ---you are looking at it---
> [2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapp=
ing
> Link: https://lore.kernel.org/linux-edac/20230920192806.29960-1-fancer.la=
ncer@gmail.com
> [3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub suppor=
t
> Link: https://lore.kernel.org/linux-edac/20230920195720.32047-1-fancer.la=
ncer@gmail.com
>
> Note the patchsets above must be merged in the same order as they are
> placed in the list in order to prevent conflicts. Nothing prevents them
> from being reviewed synchronously though. Any tests are very welcome.
> Thanks in advance.
>
> The main goal of the entire set of the changes provided in the mentioned
> patchsets is to as much as possible specialise the synopsys_edac.c driver
> to be working with the Synopsys DW uMCTL2 DDR controllers of various
> versions and synthesized parameters, and add useful error-detection
> features.
>
> Regarding this series content. It's an initial patchset which
> traditionally provides various fixes, cleanups and modifications required
> for the more comfortable further features development. The main goal of i=
t
> though is to detach the Xilinx Zynq A05 DDRC related code into the
> dedicated driver since first it has nothing to do with the Synopsys DW
> uMCTL2 DDR controller and second it will be a great deal obstacle on the
> way of extending the Synopsys-part functionality.
>
> The series starts with the fixes patches, which in short concern the next
> aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
> only, serializing an access to the ECCCLR/ECCCTL register, adding correct=
 memory
> devices type detection, setting a correct value to the
> mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing an=
d
> getting back a correct order of the ECC errors info detection procedure.
>
> Afterwards the patchset provides several cleanup patches required for the
> more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2
> DDRCs) so the provided modifications would be useful in both drivers.
> First the platform resource open-coded IO-space remapping is replaced wit=
h
> the devm_platform_ioremap_resource() method call for the sake of the code
> simplification. Secondly the next redundant entities are dropped: interna=
l
> CE/UE errors counters, local to_mci() macros definition, some redundant
> ecc_error_info structure fields and redundant info from the error message=
,
> duplicated dimm->nr_pages debug printout and spaces from the MEM_TYPE
> flags declarations. (The later two updates concern the MCI core part.)
> Thirdly before detaching the Zynq A05-related code an unique MC index
> allocation infrastructure is added to the MCI core. It's required since
> after splitting the driver up both supported types of memory devices coul=
d
> be correctly probed on the same platform. Note even though it's currently
> unsupported by the synsopsys_edac.c driver it's claimed to be possible by
> the original driver author (it was a reason of having two unrelated
> devices supported in a single driver). Finally the Xilinx Zynq A05 part o=
f
> the driver is moved out to a dedicated driver. After that the
> platform-specific setups API is removed from the Synopsys DW uMCTL2 DDRC
> driver since it's no longer required.
>
> Finally as the cherry on the cake a set of the local coding style
> cleanups are provided: unify the DW uMCTL2 DDRC driver entities naming an=
d
> replace the open-coded "shift/mask" pattern with the kernel helpers like
> BIT/GENMASK/FIELD_x in there. It shall significantly improve the code
> readability.
>

For the zynqmp

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Thanks,
> Changelog v2:
> - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch=
.
>   (@Krzysztof)
> - Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the ne=
w
>   DT-schema name.
> - Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
>   in several places. (@tbot)
> - Drop the no longer used "priv" pointer from the mc_init() function.
>   (@tbot)
> - Include "linux/bitfield.h" header file to get the FIELD_GET macro
>   definition. (@tbot)
> - Drop the already merged in patches:
> [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definiti=
on
> [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
>
> Changelog v3:
> - Drop the no longer used "priv" pointer from the mc_init() function.
>   (@tbot)
> - Drop the merged in patches:
> [PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller s=
upport
> [PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device n=
ame
>   (@Krzysztof)
>
> Changelog v4:
> - Remove Rob, Krzysztof and DT-mailing list from Cc since the respective
>   patches have already been merged in.
> - Add a new patch
>   [PATCH v4 6/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk fl=
ag
>   detached from the very first patch of the series.
> - Add a new patch
>   [PATCH v4 15/20] EDAC/mc: Re-use generic unique MC index allocation pro=
cedure
> - Add a new patch
>   [PATCH v4 18/20] EDAC/synopsys: Unify CSRs macro declarations
>   collecting the changes from various patches of the series.
> - Drop redundant empty lines left by mistake.
> - Drop private counters access from the check_errors() method too.
> - Rebase onto the kernel v6.6-rcX.
>
> Link: https://lore.kernel.org/linux-edac/20230920191059.28395-1-fancer.la=
ncer@gmail.com
> Changelog v5:
> - Fix function names in the zynq_edac.c kdoc.
> - Rebase onto the kernel 6.8-rc3.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Serge Semin (20):
>   EDAC/synopsys: Fix ECC status data and IRQ disable race condition
>   EDAC/synopsys: Fix generic device type detection procedure
>   EDAC/synopsys: Fix mci->scrub_cap field setting
>   EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
>   EDAC/synopsys: Fix reading errors count before ECC status
>   EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
>   EDAC/synopsys: Use platform device devm ioremap method
>   EDAC/synopsys: Drop internal CE and UE counters
>   EDAC/synopsys: Drop local to_mci() macro definition
>   EDAC/synopsys: Drop struct ecc_error_info.blknr field
>   EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
>   EDAC/synopsys: Drop redundant info from the error messages
>   EDAC/mc: Init DIMM labels in MC registration method
>   EDAC/mc: Add generic unique MC index allocation procedure
>   EDAC/mc: Re-use generic unique MC index allocation procedure
>   EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
>   EDAC/synopsys: Drop unused platform-specific setup API
>   EDAC/synopsys: Unify CSRs macro declarations
>   EDAC/synopsys: Unify struct/macro/function prefixes
>   EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
>
>  MAINTAINERS                  |   1 +
>  drivers/edac/Kconfig         |   9 +-
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/dmc520_edac.c   |   4 +-
>  drivers/edac/edac_mc.c       | 135 ++++-
>  drivers/edac/edac_mc.h       |   4 +
>  drivers/edac/pasemi_edac.c   |   5 +-
>  drivers/edac/ppc4xx_edac.c   |   5 +-
>  drivers/edac/synopsys_edac.c | 967 ++++++++++++-----------------------
>  drivers/edac/zynq_edac.c     | 501 ++++++++++++++++++
>  10 files changed, 963 insertions(+), 669 deletions(-)
>  create mode 100644 drivers/edac/zynq_edac.c
>
> --
> 2.43.0
>
>

