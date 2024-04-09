Return-Path: <linux-kernel+bounces-136568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FB89D597
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56351C22F10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E987F7D5;
	Tue,  9 Apr 2024 09:29:23 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551221EB45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654962; cv=none; b=C1SBI6LzSCqo+lJiS4BF5fZnvhqMBM3ukaNKuhdF9UqElpoyXEa97x3mVOM7weF0m3DeER92BTxFBXIKWM69i302bv3TStqBkuta2K9r4y4IlgoqzrxrAa3ciDT5I9E1KmiMp8uhJE3eSp5/lF6k5flwbCLFOpuHl4HcitCM97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654962; c=relaxed/simple;
	bh=sZ8Bkg1aJ6GxpBeuOfjv4aBkEwnsqncZAR7MpKKsIic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeNudXL671DdJjYdNJTDEbbOcnJ8fval8l0aYzINjDGvF3a9wwg2+6rovic4DP0aSUKEvHPVFyBmEPl7FDW6uH1rqCHBtR6aJ04yaSIug+btBWeErFOQelhGOXhr7/1jNbB50pjtXEDRh2sZJ5XkL/zt6Iq/4ZDvHIeWHu1L954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-615053a5252so48525937b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654959; x=1713259759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm8YtYJJRFU3fWn5+mKdf/RAlSyWBzxMrz0Qaq95rKk=;
        b=AQb1v80FjH714wK0T+aqYvIhiIK8UN5gG3d5y0QShcSslEiUrqDzsW0MMacnX2sZp5
         H9N0vinJL+NEiYPiiqicnD96LnOiXZe9xnaRp479ipk6z3F4DW5i/Xqa/PxggtniDG9y
         bK0sHTqDEYxMsT+FRSK4UhVA93k64ofJ4+an9azamG7LasODUQ/u7+5eI7OrxrAUGiuc
         A5wnfb1WYvgL7dlMLxPvar6KoQG5aRbHsfL7ByxzQBss2RHSSw3egdr213/ZouAtrvae
         Cz6DiyJnmAPpECOXS37C4/FsOmNI4gc0a2bfBj46vBDQWKMF3/8Pchw1yKBTqYlyDtwN
         2Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJa0NW9UooxQJY+gD6SWoyq/hcEAD0SkvmZf2uKvRldGWEWGiwjbZ1SIzAdB3lWGtJzkB1cJqPuet4x3NHaSkGIZBuHf9aOPRNGtE
X-Gm-Message-State: AOJu0Yz5PaEvFqbjvgR4DwHp+i/lcWBsuPqm7DQ2i8sB0NZqKx0ZRWnM
	3vA8JCxu5jWpLHvemYzx3tRFPbO4pnTOp2La4WnTHH1lRE8R8lpFHMqwV2bk7DM=
X-Google-Smtp-Source: AGHT+IGlzlp6J1HKafEVKB8T+XM4CcIHgYMVOEezHz3o9WReC+8+vURAbJzy7UiuACg5bmWsDpb7Ww==
X-Received: by 2002:a81:c64a:0:b0:618:1eff:24e4 with SMTP id q10-20020a81c64a000000b006181eff24e4mr1277526ywj.15.1712654959524;
        Tue, 09 Apr 2024 02:29:19 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t20-20020a818314000000b006144c769e1asm2137588ywf.38.2024.04.09.02.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:29:19 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4646447276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2i/MdawRru3UOK/Q6bI3iUDRoMewCLT4DDZy6+YJQUfaITgL8K0jTF6/3L3YZ7X3ZTDIf8cI7sHywBzNHzrL34tqLjx+FOntxFkSc
X-Received: by 2002:a25:bcc6:0:b0:dc6:e545:68be with SMTP id
 l6-20020a25bcc6000000b00dc6e54568bemr1336134ybm.29.1712654958840; Tue, 09 Apr
 2024 02:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Apr 2024 11:29:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX9VxNsedQUfeYs3hgpVN=dt=z_VX34pZEzN82fcErp2w@mail.gmail.com>
Message-ID: <CAMuHMdX9VxNsedQUfeYs3hgpVN=dt=z_VX34pZEzN82fcErp2w@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: seg-led-gpio: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:03=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

