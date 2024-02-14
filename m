Return-Path: <linux-kernel+bounces-65490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00596854DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73113B24196
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558F5FDBA;
	Wed, 14 Feb 2024 16:10:00 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCB5B5DB;
	Wed, 14 Feb 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926999; cv=none; b=VS7SxrZkloeq2eJ0qF+0rmZJ4gnGa0KdQZWUryV3tkJZAn9yqjtWpPaxW6Iq5eYfcOptpNYFr65e1//RDYTEFH9g97zB/p9tG5Ec8zHVZzkXMQbp5pMr6/Iwlf5VeMP3dCYyHZ1MmXhzAeVvZ5UXne3anJEo6wGVXC1u5JeDn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926999; c=relaxed/simple;
	bh=eczxNSPiw4p4CNj/PUhSH5mu4tDa6Gr1OgSTglWh40s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQOnBARK+YsB67KXnmGmkFo2lwxL5vkOxLq1sjoBOu4uXQfXRu/FdG5malk0eOa77cLO5WmhdF6Db/yqt/k0FsxhaFC5CzvU+4I5MU2dIAU7Onw7nnZpo1FZ6Vb0bmYDj/DBsgQbEsYP3Q7Dl0jlaEK5VjXPI5MkXqdlQmYecJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607aafb2cb4so6542197b3.0;
        Wed, 14 Feb 2024 08:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926995; x=1708531795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noAyHXMAvZWAemJey+xdD/xMfux7ZkmXm4kG5pidNbg=;
        b=PbVWtHz5JW2NGZPUwbImWVqaHe+v3aVwA6VrRbd1vHPwN8EQu71tOdkQmu9UCIyHNc
         GR+ce8q8Ho1rH23ADT53PLmh4rkVIS8XiB3QS3kmkbJ5y5OQ9KllPQ4Rw+TZgZbzeZK8
         IvOyiP0TNVkd84BtW+8f66/F9QrBzOJmqTJzHTmwBmijXDpE0N9kozFOEZje4KCgaWbK
         3AJEuv0vn4GH1REeXQhLpFd24uew6avrRXAN8WArLHOfPYOsN0I7VXtnpo4FwtaqzHeS
         xQ6IvQm3aw0ELlq9LXPKIDhBb738z2K/bZhBsKPUsq1puonfIMtycE4GjDGdXk8UN1N8
         9qMg==
X-Forwarded-Encrypted: i=1; AJvYcCVqu8hTuj/qbYoHH3jeBMEW5cIRTsoBg7jliSdgPwsxKLThMwMQBed6OBKVHx3fd/8ZsExBo5q6WQCy1H7+Hso1uSiczfKvw9X6s2tZjKNiZdmaQ3zr/arytRsz3D2VXbJUegyNUfG7
X-Gm-Message-State: AOJu0Yw/75RKE7sKTt8AvGwYuwEzjwxhFYNUxQoXudrU9NDsJEPmsbcw
	sLJVI4CwN/9pQJp2QySL0VUkH3yV+pGDt9l658mBUYSR34zC5vIR3olEV4hKU/M=
X-Google-Smtp-Source: AGHT+IFs8zig0grnwbTuSMfWqswTPyRG9TUyNTKNGiPtpDwGkKWY7Eu2rzsS+FmEf0BXCyUl9ezuEw==
X-Received: by 2002:a81:a214:0:b0:607:83c3:c138 with SMTP id w20-20020a81a214000000b0060783c3c138mr2987900ywg.34.1707926994725;
        Wed, 14 Feb 2024 08:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw8aA9D9K+3ZqmF1I2oMpGOuI1ZYDxa4Y3vuBx/b1vYgGttm9o0VuX5yQYoVxSeqQKJ03jQdrrdKY4J6hdLjXniWgw0MZ8lxtZIITFtAPWGf5u9AqeNwSyz9BiAaF4dZu9VzV4jnq7
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j75-20020a81924e000000b0060790d60113sm679957ywg.89.2024.02.14.08.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:09:54 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso2007633276.0;
        Wed, 14 Feb 2024 08:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe8OlnfGacwSbapcX/rPAXBrOe6C1CJFadf/AmNI2yZOIgGGyk6lUyFvRNpNd+ZFKTgcNhlnAXv8C6olnCweLLqULeCUvEw+Kv66NK4gwWEVQ6/4/wuUKIHyKn9m/DQ5JXlNQ2jgi3
X-Received: by 2002:a25:8251:0:b0:dc6:d6f6:cc13 with SMTP id
 d17-20020a258251000000b00dc6d6f6cc13mr2893886ybn.20.1707926993726; Wed, 14
 Feb 2024 08:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-11-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:09:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVk3VL=E-DqZFuxSzXsGAeQGo0VHZXGtMiq2wi7oo05Q@mail.gmail.com>
Message-ID: <CAMuHMdWVk3VL=E-DqZFuxSzXsGAeQGo0VHZXGtMiq2wi7oo05Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mmc: tmio/sdhi: Fix includes
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	kernel test robot <lkp@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:18=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> TMIO uses an of_* function, and SDHI uses pm_runtime functions. Add the
> includes directly, so we can clean up another header properly. Sort the
> pagemap include while we are here.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402070323.JpYfFtkQ-lkp@i=
ntel.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

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

