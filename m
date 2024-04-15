Return-Path: <linux-kernel+bounces-145594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB208A5847
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA511C21114
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93665824BD;
	Mon, 15 Apr 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB9Kcq9O"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774060EF9;
	Mon, 15 Apr 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200124; cv=none; b=PnB/NPXH6MYOrOZIHPA8yk2kssFUeyozf3oTNrVcm2+03qpExJsxK3GevEUIqkXnekqtUonyvYDpg99cJ82J5Suq30SpIgheIj4aA2VJiScMCYM6uD6oi6MYF5X6apNE1K4UnIscd0xK0EMticI1+ldd7wtVZuzaUXJn6jNp3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200124; c=relaxed/simple;
	bh=be7oRZUQ/S2JdRwQpojUowfgGOLGjxhk1XnzAepAj+Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WKL+2zwgeDz3VdqpBqtOXoQKFp/f8rWpKqAD5imKA53CIrRGnPegWLbV33R5BKbzaamKOzbSSjScckpldYBcmmh5mejw+UGJ7Zl+Ww5kWV5A+oy9vi7FztTCCpT7ZEgfbGKqrc/29r17ZkBaZR4hMMk6rtcy2u9QLEqaUyYkKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB9Kcq9O; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2343ae31a9bso1267307fac.1;
        Mon, 15 Apr 2024 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200122; x=1713804922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdGYstXTWazjEUKLUsBnEYFaautc2holTmAavrds7D8=;
        b=lB9Kcq9OMwPiA4li0uAv0r9aU9AgM8ma/n/XRoEODbLkCpwgw6ar5kxcoHj2Co3zXS
         CbeTuOgw7vDh97HlMm7+eshaIoJyV8IOw3quOd+aOCQSJ6QlC9HdenDaqc5WzbCcLRvK
         VYEN3r89M+4AjawNxjVvQIx8SnX2ZIPINc2YdYnXbB+hiPN0ZvYbd+PRf8+7yzOim2rU
         xcmlQ8U8vCtcXp5RQOiDmoaMlp3Yj6YK1mwUirgtJKwLeUpepf3dYWZ2agKguZELaEDp
         Xc64JYk6bGICtBYLTLg5x6gdL1qxQk5gpYfc2durs4cZGzVGVTXAF+FFU5uMBQPedbJQ
         FsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200122; x=1713804922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdGYstXTWazjEUKLUsBnEYFaautc2holTmAavrds7D8=;
        b=L7cFO80vzXlLLNTXJsep8bnyPKeG5WluXIHcu85YOwH93M1iijviqCyUMdicCiTsEs
         Kqww9smQZPad3fTaVV/nUqaksWtEeYs2rMWPPSWdlRJWx/4oVLmApJpr09Stc/V5jrAd
         v5DsWHnzSyctw4NNGXdaf5eiNPIiFLrLTZucyS2xITuSzzK4nnr/r2yOv8ymWEyJkTAb
         U80dOQOwmC5Cxrc7cbv8qLHJUnJRDKpLBEqrEOLBOkltCdbpjB8WRjUsufVX8zz/Spwf
         Wjoaf1jk9y01hBqwTsjCXAQlSEylNwfY0yGR2JYEXKuQ2ShqAqkOmzXXduOci9vntPjj
         f8TA==
X-Forwarded-Encrypted: i=1; AJvYcCXRkjH8Ytt+chxV618Grk24VYC40OneJzS1hc4Jdj7iJVSf1XkMMqKslJ2PINYH55lUNzTWua9lvjpzjueI0xTqDKe2Sl1GYbvymyp8JxpedUo2TD5sKw/drjBXpoGDSL/4Wtb7ziVnvP8Z
X-Gm-Message-State: AOJu0YyFGBBQcBRRLzSjW2+UzmQ37TZNL3NUtRPMH3WPTsK+p21CB9UK
	767OPjbAM1wqeZEXHcHuxVmEBB0qTDnDO4X4X0sTzvjIR8/hk3XcOAHbiL1cpwbLQKQjtLGpzDL
	67Miephj9ELI9JSi3QQo+zFI6mzg=
X-Google-Smtp-Source: AGHT+IGjX7KYAV9eE37M28bewt12iuGzeq8YwJK8fQBwnQEX1Wettngrgbu04fOvzpTUF3ZgrV3yW8ss3XJMUbm/Y0o=
X-Received: by 2002:a05:6870:b619:b0:22b:a8f3:36b7 with SMTP id
 cm25-20020a056870b61900b0022ba8f336b7mr12841925oab.55.1713200122720; Mon, 15
 Apr 2024 09:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Date: Mon, 15 Apr 2024 09:55:11 -0700
Message-ID: <CAN1+aZxiJVdMUd8q5w+Xo9EmHc9hhFzRyzEmgJ7eb5eNi+PD=g@mail.gmail.com>
Subject: Re: [PATCH 3/6] [v3] kbuild: turn on -Wrestrict by default
To: arnd@kernel.org
Cc: akpm@linux-foundation.org, arnd@arndb.de, 
	Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, nicolas@fjasle.eu
Content-Type: text/plain; charset="UTF-8"

> All known -Wrestrict warnings are addressed now, so don't disable the warning
> any more.

I've done some testing of a similar patch with gcc versions 8 to 13 and clang
versions 12 to 15 for x86_64 allmodconfig builds and found no issues building.

Tested-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8b3f5b62b837..95466a04d51b 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -98,7 +98,6 @@ else
>  # Suppress them by using -Wno... except for W=1.
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
> --
> 2.39.2
>

--
Gatlin Newhouse

