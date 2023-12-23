Return-Path: <linux-kernel+bounces-10456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84AE81D49D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F531F22257
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF138BE0;
	Sat, 23 Dec 2023 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZaOphlf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88EDDA1;
	Sat, 23 Dec 2023 14:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D301AC433CB;
	Sat, 23 Dec 2023 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703341930;
	bh=6m61JpTZjnKdKPs2Vty0hWObL3BZUXWxLpruC6L0fe8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HZaOphlf8JzU9fX3XZq08h81rf+jd1cVNWLSJI5Qt4MKI1Fv1Ie63TFFVwNubIqHO
	 L+P0ruslrfjCCnfb5edu1YTJex+4w0fHq0qpfAeopnoBrwGGVJiSlSByaqtgSI3+GT
	 HEbMv9RrblMdDeVduATb1Op/dOxZQQbuB0Jyjpggj81vwTxWlKwFfeLyprTiUHKDpB
	 pkWlZonqTik0GrzXqoRbLf6re0D3SUEToeF8KfSszotMoIJ/OnigVJU+CfcchzYOmA
	 SEDkhwT+7r8Plk0vU8NbCKxk+yXZdcL6paPHBLlbcM7IDHvPFBZArahQkAfs6pjlq6
	 gArEYVoZIgq4g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-203fed05a31so1910777fac.0;
        Sat, 23 Dec 2023 06:32:10 -0800 (PST)
X-Gm-Message-State: AOJu0YyKtmNmH9Ffgf+XUyL7iR2ZzaujfPSpW/otGMTsQjNbV0AmXAH3
	J3ar4bIEQbPxJOm5d4fcgBETRzcQsS2cdkA+8F4=
X-Google-Smtp-Source: AGHT+IEan/Ho8zcqnOAfg2j0o0flsZ4/8XhlU8vwe1/cM3dKJacpjyk18/nf6FSpVEIvZxZBpOgALID/ZQtRvLNspTg=
X-Received: by 2002:a05:6870:51cb:b0:1fa:1c89:c656 with SMTP id
 b11-20020a05687051cb00b001fa1c89c656mr3587157oaj.56.1703341930140; Sat, 23
 Dec 2023 06:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219154049.1095323-1-masahiroy@kernel.org> <CA+icZUXKMfzecJgrSzw7smNm8kN6V28VouNLT0H0-qtedB4ZGw@mail.gmail.com>
In-Reply-To: <CA+icZUXKMfzecJgrSzw7smNm8kN6V28VouNLT0H0-qtedB4ZGw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 23:31:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQq7wWppmE=tujaBF_RkS98Zt4LMs0FRQ+MVBB0XEtfQ@mail.gmail.com>
Message-ID: <CAK7LNAQQq7wWppmE=tujaBF_RkS98Zt4LMs0FRQ+MVBB0XEtfQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright
To: sedat.dilek@gmail.com
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:51=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
>
>
> Masahiro Yamada <masahiroy@kernel.org> schrieb am Di., 19. Dez. 2023, 16:=
41:
>>
>> Copy debian/copyright instead of generating it by the 'cat' command.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>  scripts/package/debian/copyright | 16 ++++++++++++++++
>>  scripts/package/mkdebian         | 21 +--------------------
>>  2 files changed, 17 insertions(+), 20 deletions(-)
>>  create mode 100644 scripts/package/debian/copyright
>>
>> diff --git a/scripts/package/debian/copyright b/scripts/package/debian/c=
opyright
>> new file mode 100644
>> index 000000000000..388a204b0b2b
>> --- /dev/null
>> +++ b/scripts/package/debian/copyright
>> @@ -0,0 +1,16 @@
>> +This is a packaged upstream version of the Linux kernel.
>> +
>> +The sources may be found at most Linux archive sites, including:
>> +https://www.kernel.org/pub/linux/kernel
>> +
>> +Copyright: 1991 - 2018 Linus Torvalds and others.
>> +
>> +The git repository for mainline kernel development is at:
>> +git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> +
>> +    This program is free software; you can redistribute it and/or modif=
y
>> +    it under the terms of the GNU General Public License as published b=
y
>> +    the Free Software Foundation; version 2 dated June, 1991.
>> +
>> +On Debian GNU/Linux systems, the complete text of the GNU General Publi=
c
>> +License version 2 can be found in `/usr/share/common-licenses/GPL-2'.
>> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
>> index c1a36da85e84..91f0e09600b1 100755
>> --- a/scripts/package/mkdebian
>> +++ b/scripts/package/mkdebian
>> @@ -188,26 +188,6 @@ $sourcename ($packageversion) $distribution; urgenc=
y=3Dlow
>>   -- $maintainer  $(date -R)
>>  EOF
>>
>> -# Generate copyright file
>> -cat <<EOF > debian/copyright
>> -This is a packaged upstream version of the Linux kernel.
>> -
>> -The sources may be found at most Linux archive sites, including:
>> -https://www.kernel.org/pub/linux/kernel
>> -
>> -Copyright: 1991 - 2018 Linus Torvalds and others.
>> -
>
>
> Can you update to 2023 while at it?
> Thanks.


OK, I will do so.

Thanks.






--=20
Best Regards
Masahiro Yamada

