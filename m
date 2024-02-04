Return-Path: <linux-kernel+bounces-51889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9B849070
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244C81C21780
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768BC2869B;
	Sun,  4 Feb 2024 20:45:18 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4925565;
	Sun,  4 Feb 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079518; cv=none; b=t7Qy92lmHhgAoPBmFbio124KRIoTdtYqTQbHAE1kiTlYpg8vhKxSeMoUNP/Vc1AdL+J6WLOaKse1zap1Tpfs3A6PkF6sO2NjqmjQ3X17zAz7J9J+eztBOSYiCGVFIENjZDZZBdJhvmc+z3yQoiUlDMhDgT8Wn2nJwtBY0Oci1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079518; c=relaxed/simple;
	bh=JV+Wd7Im5aUUnZOUfc6fuLxpDqIGzgX3N5TERiynJ3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4Lq47or0nA+sRy8iVnbHafbqjfpPFmPZUuy9JtNh1htb+9vxKVRJ6CXFyugufTbg1YMs0j7CYwd0XGhRSX2KAj0tjb9nig+KyfuMjk9bWw5oKNpDT05S5nu/iIdeyCv7qyQa0N/gQ2mNK5QCpp+DkhvrzUpFi0ZkaynWZm8mkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604059403e9so37321557b3.3;
        Sun, 04 Feb 2024 12:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079515; x=1707684315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETqMOhIHhZm5B+JmMLekbYgg8mbEjlb7o4YBTagCBfE=;
        b=OcPwCOgChJwcu82Xx9b3cgDJJ08DSmZHW6WW+3Fasw+CHDJaT8rxFJHzPxXOZr5h0a
         vAB9ATmd/C2BG6im6g6Cqjd2md5KzY9SRvZ/tedvtGIhbUViIBqvfGR7xAAkxwLwRPaU
         se0ici8mn5qEdtdJmN1Ykk+E5/ZQaj6ziuRyjR2IRrA9Ajjab8zEXUB7cl4w5JInQGY1
         HV7ui0gkKBz4hs2e+fimF6bdZOWaPNpEZlxSEN23CIHke7SXghtwJ0d6R2hvCrLrzdQn
         XG1GVMP7w+IX9EybBVv9NzHVPdrmC+M9HJ+SOcCEimISoAA4NWz/q/lsdOa3Yl6YbiWf
         8zwg==
X-Gm-Message-State: AOJu0YwzZqHihLyn2ipUXEK9A7Fwk4FQdedj6iJyKYawcn8Wqxf8fSHl
	APNzvKx/Y4gOff/gMTYBRXDTpb6X3waYUVj5h0gUfKCyE4ViDqYUmVg7wWFOHLc=
X-Google-Smtp-Source: AGHT+IGptP2xJ/CGR7KW169i938wFOVfzJSBn22spRyWblkLTpa2/khfPuDw6vmXJ7BO09sNM21E5w==
X-Received: by 2002:a0d:cb91:0:b0:5eb:de3c:fbff with SMTP id n139-20020a0dcb91000000b005ebde3cfbffmr11332633ywd.27.1707079514969;
        Sun, 04 Feb 2024 12:45:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVCQnqNf6lDYtSGelqcFT3SgQ7Wmp1lYmP7uAKNyVEnXxIqvCY1wkgBDqHAs929j1egLrhxorvrMiy3tKgHq8NCh01AzzS0Ja7oTCHlHBNJjJlU4JGYBFPhsD2B+xy1Pm0HIjpRHA=
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y194-20020a0dd6cb000000b0060418fc78eesm1620673ywd.80.2024.02.04.12.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 12:45:14 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6045db1b5a1so2333747b3.2;
        Sun, 04 Feb 2024 12:45:14 -0800 (PST)
X-Received: by 2002:a81:4422:0:b0:5ff:91d8:42b0 with SMTP id
 r34-20020a814422000000b005ff91d842b0mr10970588ywa.46.1707079514424; Sun, 04
 Feb 2024 12:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
In-Reply-To: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 4 Feb 2024 21:45:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHtUVM9ACXQUPJeGt6e6GgJgbN89Qj0HDc0HzetzNjUw@mail.gmail.com>
Message-ID: <CAMuHMdXHtUVM9ACXQUPJeGt6e6GgJgbN89Qj0HDc0HzetzNjUw@mail.gmail.com>
Subject: Re: [PATCH] dma: dma-sysfs: make dma_subsys const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 4:14=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dma_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

