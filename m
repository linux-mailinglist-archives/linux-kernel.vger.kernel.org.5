Return-Path: <linux-kernel+bounces-137178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB389DE21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF6294D17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADC13BAC5;
	Tue,  9 Apr 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCn2zHwP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADB131E3C;
	Tue,  9 Apr 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675128; cv=none; b=E+5Z0oF7LDb5rnd6FRQ6Fa/NdB/6RPfPiKGvuj398IMcizrSWDAf+6MdO6y5h5fOS/lGf1rs/ZPZdafc0KcczOkP+J1uWN076xmuccB6oIvSy6qEWIvs0bADf+BffreY2M3OPkwztH6wg06ceOaa3KRV0zy0y5SVAuNAE9XES+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675128; c=relaxed/simple;
	bh=mJt7v6CLSOYzx1gtAyi5VoQyh9G4Ztq0Q2FlAeZxZmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1aqm2m+l4Gkkh2D2ipZD/X4Jfdl/+VZEj9G80D11DeK4yuzNGIrpVtkiWF09QWSgLCOEYb2eExLYQFXXfs6BMufTK72TaO3o8FhtGdeX6GtJ2gP2sZH1bdbu0kOC3qWAGohvbTkvBFG1RKSuozlS+rKuYJvO/BPk18QYaKoaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCn2zHwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D441C43394;
	Tue,  9 Apr 2024 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675128;
	bh=mJt7v6CLSOYzx1gtAyi5VoQyh9G4Ztq0Q2FlAeZxZmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fCn2zHwPhopHz3aJMqQuvT0XcsT7uQACdH7RpIfWCKsUDLkk3gf5FGDw4zWpYrgvD
	 uHsoSSt5qLptwNNbfqus0tnv+lz8+j1GLA7xNJuWdgoxedmWIxOy1qpgIkLedk9xDZ
	 Tk/2gjwceeSc1HSDRiACiU5Lt1elWa15BD6BnZoSUoi2ONmiPBp5pZJ4PFLwkkq164
	 yQAbCmUhBIsj30JKInNCV4w8feoC9IBwwj2hTtDSdwUhcdDk808VmE/4jVrvoWs8eH
	 2mdyLkcgR2mZGl6rkNdcwmbWQYw5RmNuI3DaQ9sgQ+yZZNlJVIt3ARO7x5S0Mba2We
	 Bx23czV4vYapQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22ec8db3803so401636fac.1;
        Tue, 09 Apr 2024 08:05:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1ZpLlplzyjSp+xywErsTXtkV+AFugDo9gIIux1ycBbSUIjzE3xViy7vCqYCjcreUuhgkXrog87BDsc7Yo0TtOfiKeV1iKm8X0hVJg/NiV6Lq2bvqtz2+l07rS18EfVl2cMmQjokreUAxXEr28sehtG+V4wb+MlOSp/TFENIYxDVyjoAemHNj5twUWhrNdDmdllpklEqFtzJnRKLQ/cFY47+qbc8eXY1Iv
X-Gm-Message-State: AOJu0YxrwQXJcPZA9b4blDwM01TCYyX+6S7pznTfEdQ9VBFDQU7+qe7U
	ew8hrKnpC98nOiJb9vYwchZMbANWwJhLD4tboQ79vwkrGMZCyw49grLn0IdKM4nbIen6xJPJDO8
	q3jPzUFH+pMZ9PPDCdPDOSY+pVho=
X-Google-Smtp-Source: AGHT+IGDUO0rZ4GKVyVieaHSmKzYKqNHjEuMKn4kB8H+BP9iyv6DlSuHKVlwMC/rIyJebF0i0bhH71zkmEuwl5+N0cA=
X-Received: by 2002:a05:6870:f727:b0:222:81cc:ac9c with SMTP id
 ej39-20020a056870f72700b0022281ccac9cmr12216666oab.5.1712675127270; Tue, 09
 Apr 2024 08:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409140059.3806717-1-arnd@kernel.org> <20240409140059.3806717-3-arnd@kernel.org>
In-Reply-To: <20240409140059.3806717-3-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Apr 2024 17:05:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7XEV__S4pvQJt54Ab832z6PZFTNTRspfLF507MNo9Og@mail.gmail.com>
Message-ID: <CAJZ5v0h7XEV__S4pvQJt54Ab832z6PZFTNTRspfLF507MNo9Og@mail.gmail.com>
Subject: Re: [PATCH 2/5] [v2] acpi: disable -Wstringop-truncation
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lin Ming <ming.m.lin@intel.com>, 
	Alexey Starikovskiy <astarikovskiy@suse.de>, linux-ntfs-dev@lists.sourceforge.net, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc -Wstringop-truncation warns about copying a string that results in a
> missing nul termination:
>
> drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equ=
als destination size [-Werror=3Dstringop-truncation]
>    60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equ=
als destination size [-Werror=3Dstringop-truncation]
>    61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE=
_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>
> The code works as intended, and the warning could be addressed by using
> a memcpy(), but turning the warning off for this file works equally well
> and may be easir to merge.

"easier" (fixed up).

Tricky that, but OK.let's get the warning off the table.

Applied as 6.10 material, thanks!

> Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
> Link: https://lore.kernel.org/lkml/CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFN=
LTBqCZMUxT50Q@mail.gmail.com/#t
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/acpica/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 30f3fc13c29d..8d18af396de9 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -5,6 +5,7 @@
>
>  ccflags-y                      :=3D -D_LINUX -DBUILDING_ACPICA
>  ccflags-$(CONFIG_ACPI_DEBUG)   +=3D -DACPI_DEBUG_OUTPUT
> +CFLAGS_tbfind.o                +=3D $(call cc-disable-warning, stringop-=
truncation)
>
>  # use acpi.o to put all files here into acpi.o modparam namespace
>  obj-y  +=3D acpi.o
> --
> 2.39.2
>
>

