Return-Path: <linux-kernel+bounces-128453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D8895B06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C39C2819BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75315AADD;
	Tue,  2 Apr 2024 17:46:05 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CD159910;
	Tue,  2 Apr 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079965; cv=none; b=haqs8ZSXLYmJqmS48c/w9ovTKUf5K+D0F9yPImD4CsvKVEkjwe+9Lwya7XPGaDEcMk9qKYpBGgHPXONUBvAb8fzhWnyePkEGJQ6vPD+d3Cll9CHDokF3RO6/C8uGFVa+MB76djUi4gDTI0dBD7ngFv6LRooLE/Ejk40FzIWNUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079965; c=relaxed/simple;
	bh=y93SZIbrnH2U1PRuoMZgbJFzq72nN3iSwDY/ntn2yG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4MhYki6EqtD3XOY2bCm7m4pLUsq7DZZzCYnfD29PehkUiPLVFC85hE88YeL0Mui3ismoHF5yqhynf2yLcXBsMdenykK0drrRhiYO+puMdGhIvdRNFv/IMCEKEbSIKChhmA9Z0VImfGPXlGrfUwj9+bKTJ5c77K370KZ7+CbKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22e82734a13so340260fac.2;
        Tue, 02 Apr 2024 10:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079962; x=1712684762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uQrT4OPUnJJ7qwQbuOJ3w/i96EgMem11ZKbGpAMb2I=;
        b=aFFTkTSB8K5BO/G7LsPLPxGWr+JEEIXSYsAFAYbp+XilZztyq87tJ3IpcYWGB4EcLq
         6a/DhiyV47XRICYWOUi8qzH40IouOTqNgIMOsbiFBULMJubxWWaIu+RkQ24qm17nwQCN
         QiJtAo2tT9gs/trxNiXfP0vAEXBsDmpVgTJl/fKAiw8wLOOMQFVi8+SzWrgCGRq1NCsh
         TB8n4e0r1fFdl/5V7NJ2KHEdZw61+1FD6/iiDZA6aM8y8kVGGk+PNam217/xc61PGMhV
         MqU4lhhinEI3/9xiDDb+SpVoEaFGD1uLoZEqqqhe3wXwovWi1kdnOs0I4koH7dDHvD+c
         vLsg==
X-Forwarded-Encrypted: i=1; AJvYcCX2UGh81Ai+h0ylBCJDvhF2DKdynhJguRjrz6zR7Tw/HjEKmstA3vE14V0cKyxrggtwM175u5rLs5H+10OSycVFPWCkDvXpDXsPSIdn
X-Gm-Message-State: AOJu0YyC1xzLwdsfErStwyhSwvt4jleJQlKB/v5OyH6p7550UVgamkFb
	JS+Ingvwo3wEEEvmiISd15qzJbEQ/Ijpjb/WcfS7afEJ2Bq9rlwUmNVSgKvKwNy1GJF1yM4Ca7t
	miTvdHD6raEgMS5vr26KcWqLAvO0=
X-Google-Smtp-Source: AGHT+IEOYGMciwLTpZJjgcMmo8Nro7C40F0fC2Llkhv4PjwwByG4OqSEXbHrQAStqnaR9XL0e+4gk0wcFr6hOxWRBOY=
X-Received: by 2002:a05:6871:7a2:b0:222:a91a:63cd with SMTP id
 o34-20020a05687107a200b00222a91a63cdmr12864139oap.45.1712079962239; Tue, 02
 Apr 2024 10:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308204957.2007212-1-justin.ernst@hpe.com>
In-Reply-To: <20240308204957.2007212-1-justin.ernst@hpe.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 2 Apr 2024 13:45:50 -0400
Message-ID: <CAJvTdK=R+XQZ4Vov8iXGiMADShgrwSoDL8-Jqfhii7YruRLDsg@mail.gmail.com>
Subject: Re: [PATCH] tools/power/turbostat: Fix uncore frequency file string
To: Justin Ernst <justin.ernst@hpe.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch, Justin,

Looks like the probe part of this was already fixed in my git tree, so
I lopped off that hunk and kept your 1st hunk.

Let me know if it works, or if I screwed it up.

latest is in this tree:
https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git/

thanks,
-Len

On Fri, Mar 8, 2024 at 3:50=E2=80=AFPM Justin Ernst <justin.ernst@hpe.com> =
wrote:
>
> Running turbostat on a 16 socket HPE Scale-up Compute 3200 (SapphireRapid=
s) fails with:
> turbostat: /sys/devices/system/cpu/intel_uncore_frequency/package_010_die=
_00/current_freq_khz: open failed: No such file or directory
>
> We observe the sysfs uncore frequency directories named:
> ...
> package_09_die_00/
> package_10_die_00/
> package_11_die_00/
> ...
> package_15_die_00/
>
> The culprit is an incorrect sprintf format string "package_0%d_die_0%d" u=
sed
> with each instance of reading uncore frequency files. uncore-frequency-co=
mmon.c
> creates the sysfs directory with the format "package_%02d_die_%02d". Once=
 the
> package value reaches double digits, the formats diverge.
>
> Change each instance of "package_0%d_die_0%d" to "package_%02d_die_%02d".
>
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 7a334377f92b..2a15a23cb726 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2599,7 +2599,7 @@ unsigned long long get_uncore_mhz(int package, int =
die)
>  {
>         char path[128];
>
> -       sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/pac=
kage_0%d_die_0%d/current_freq_khz", package,
> +       sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/pac=
kage_%02d_die_%02d/current_freq_khz", package,
>                 die);
>
>         return (snapshot_sysfs_counter(path) / 1000);
> @@ -4589,20 +4589,20 @@ static void probe_intel_uncore_frequency(void)
>                 for (j =3D 0; j < topo.num_die; ++j) {
>                         int k, l;
>
> -                       sprintf(path, "/sys/devices/system/cpu/intel_unco=
re_frequency/package_0%d_die_0%d/min_freq_khz",
> +                       sprintf(path, "/sys/devices/system/cpu/intel_unco=
re_frequency/package_%02d_die_%02d/min_freq_khz",
>                                 i, j);
>                         k =3D read_sysfs_int(path);
> -                       sprintf(path, "/sys/devices/system/cpu/intel_unco=
re_frequency/package_0%d_die_0%d/max_freq_khz",
> +                       sprintf(path, "/sys/devices/system/cpu/intel_unco=
re_frequency/package_%02d_die_%02d/max_freq_khz",
>                                 i, j);
>                         l =3D read_sysfs_int(path);
>                         fprintf(outf, "Uncore Frequency pkg%d die%d: %d -=
 %d MHz ", i, j, k / 1000, l / 1000);
>
>                         sprintf(path,
> -                               "/sys/devices/system/cpu/intel_uncore_fre=
quency/package_0%d_die_0%d/initial_min_freq_khz",
> +                               "/sys/devices/system/cpu/intel_uncore_fre=
quency/package_%02d_die_%02d/initial_min_freq_khz",
>                                 i, j);
>                         k =3D read_sysfs_int(path);
>                         sprintf(path,
> -                               "/sys/devices/system/cpu/intel_uncore_fre=
quency/package_0%d_die_0%d/initial_max_freq_khz",
> +                               "/sys/devices/system/cpu/intel_uncore_fre=
quency/package_%02d_die_%02d/initial_max_freq_khz",
>                                 i, j);
>                         l =3D read_sysfs_int(path);
>                         fprintf(outf, "(%d - %d MHz)\n", k / 1000, l / 10=
00);
> --
> 2.26.2
>


--=20
Len Brown, Intel

