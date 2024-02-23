Return-Path: <linux-kernel+bounces-78298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15AA861189
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687A028730D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56E7A725;
	Fri, 23 Feb 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDXWAAMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C747399;
	Fri, 23 Feb 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691663; cv=none; b=c4hU4PZRDdl2irXS1IMZuB8ajkYCAq8itkLipqhZY+CiRrDGdWyzru5bnMt4yIZUWSmoEseYdcRw8CMbzgmtVBRMGu1LWMNIe68sPp8zTkIQcTuhda7/IScCLZSAZwqsAifbeUSwislsiEPwDWFWQ4lJYDJhIuAg8gYX/T5TL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691663; c=relaxed/simple;
	bh=wIZnEe3KcxS7XCDNqgIeFfvp323Etd87hBcWJTeE5ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW94FPKs8/5UMOZ6pBPs90rPUEmC8cwBG9AmNrx4gtOmQell25DMyfLCOZIoPzDnlDhKciKLvlqZ93Vrt4WkAOPxErbxlnQw1WUi25URIlSd99+4NUlUevdedkX1W1XrlaqdYfhD1l7kDAGI+S/1NHulwALttul4CIywI6qULGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDXWAAMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A30C433F1;
	Fri, 23 Feb 2024 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708691662;
	bh=wIZnEe3KcxS7XCDNqgIeFfvp323Etd87hBcWJTeE5ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GDXWAAMl+ykSPK+Opn0rYxjm7hV3YszXdo6b2qhiqkAe54lerkkqG0LKUPNdPvvvi
	 uDp/5QgFCstfO+3rmnLFdhAfq2WVjfUlU2Du/ga5EJbgjf0s+/PGQoLGIneE4CyJ4O
	 4zjkgLLJcXqY0awnGlCZYFXIyZVoNX1UO8st+ud4AjKJtKWdCmNwZkq+6ur3K/vr+6
	 aaHtS00yW6JOIjMUzeKQbn1G5vMZYt2X1TFmnBB9tfNtwoyzhwT4OWL0fbzvKiZsbR
	 EL2PBaNn/wTCAwpZ4PTkGcqMNrN8bP41x4x0hXeuG9+fRFckbYtLtsDLQDumqyTPGQ
	 xSiY3lgzunS5g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so3630011fa.3;
        Fri, 23 Feb 2024 04:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVujYsoS5uXK8VeNW4T/pYGmn9tGB53NlJ48XomWK/drFD5WAvIHSpIyIwc50tgaFxFPx1EA69qCpPW/v1UTCk+17x9JJOLwwYaBMicC7s+K+TguCOAH7L5qQtzUrAri7Lx8KKHlv6OIPIo
X-Gm-Message-State: AOJu0Yz7CNkQFZOeP1TiHN4ZYt00uT73HOsGvw6hy7tzs0lD+z0K/pYa
	keLjIavA5JZ4N58H7eoFPuAYTBknUetnb+Co6mf/kgKzeQfzkPY/in0mEpI1U8WtLMMPX2OO/qe
	oTMXEGtUXZCItjHMAi8/hzHzyIlU=
X-Google-Smtp-Source: AGHT+IHR/4n5aojj89CoD1dJ3LedRSlNN5a1x4hWtJYB0U8DAoIdMlL+5Lh77qZDBSm8EDFoIxbw93BIk/PvYJqXr1Y=
X-Received: by 2002:a2e:a7cf:0:b0:2d2:3c9b:ab70 with SMTP id
 x15-20020a2ea7cf000000b002d23c9bab70mr1199422ljp.21.1708691661154; Fri, 23
 Feb 2024 04:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221202655.2423854-1-jannh@google.com>
In-Reply-To: <20240221202655.2423854-1-jannh@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 23 Feb 2024 21:33:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBrc=JvGr-TA9BDB7KOeOycKVBoWJUkSEgQbdhpUk+ew@mail.gmail.com>
Message-ID: <CAK7LNARBrc=JvGr-TA9BDB7KOeOycKVBoWJUkSEgQbdhpUk+ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: get rid of code for absolute kallsyms
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> To compile code for absolute kallsyms, you had to turn off
> KALLSYMS_BASE_RELATIVE. I think based on the way it was declared in
> Kconfig (without a string after "bool"), it wasn't even possible to
> select it.
>
> Get rid of this config option, as preparation for some kallsyms
> optimizations that would otherwise be infeasible.
>
> Signed-off-by: Jann Horn <jannh@google.com>


The code is correct.
Based on Arnd's feedback, could you rephrase the commit description?

When 2213e9a66bb87d83 was applied, IA64 and (TILE && 64BIT)
opted out of KALLSYMS_BASE_RELATIVE.
Now, both architectures are gone.





In the commit description, for instance, you can say:

  Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
  removed the last use for the combination of KALLSYMS=3Dy and
  KALLSYMS_BASE_RELATIVE=3Dn.






--
Best Regards
Masahiro Yamada

