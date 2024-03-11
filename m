Return-Path: <linux-kernel+bounces-98859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6C87805E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0159B20EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F23D3BC;
	Mon, 11 Mar 2024 13:19:20 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA53D0C6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163159; cv=none; b=WE/qSGh6U4qGmz/oF+MrKmLNhs/oI5heukFvsQrMCcXtq+eVPDKhrFxWSNUux9w6q+wQWVPRVBrnxPV9Dj1I9RJgJSrNiDE7JMMWqKUjual6HHOb8bd4kuKIr+uRNfoTMs9+pDAg8ZxCh7yVpPjX7PYLe4zCHmO2UpEmUe1efEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163159; c=relaxed/simple;
	bh=TrQVnMFqRdKxy+Ab7zL92BC7pRmGTjw3QeWTZWzAMBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkiE/gRVQMRhpGP0zqjkg1vL/vH+vxzgqo8zV9+tIJOmC3MnVD/GtY+Dcdvslr6fslAlcsSbT08d6IKFZaLQPI6w65lwLJ3pz1fnF8KTq0qm4aVPofA3fewGvlAhesA60cBb31BPc5I+R33MNnDY0JzF44Ke2P+gXXdSeYwyAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609eb2cbeccso22927957b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163156; x=1710767956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7ylCimAbNAWM7sZ5YD/p6CSqTzWJSR4W2A/mtEmsJ0=;
        b=uB46OUCdS4FgKNIRfkDh2H6Q6CZMhldkA3aGfuxgyOlNC6+za8MwFq8yQEDPDX4Iqq
         yCNpxMmUJvi0M5vtpErbn6LQClAfTmBrzen/0hpsoHQ0YkAgqicUph85HJJdHZiHZnNU
         WVgMU/VUIjnCjlkt3XLABBoWfID11wOKVWPHD2YUX8kPW3eguiLMEPodzZktcrwSEkCl
         2rvXBGF48pWzjNeQYyouzkfhdDdiy6i9wYhN34GEWZ3lJVEGwaSF/Gm51otVGiOOXabE
         thQNYARsxnhl529f+CzndumoofipKyapdiZx4DMKW/FyKjPKH3BC1vjlgnnFRA9kvpDM
         XRcA==
X-Forwarded-Encrypted: i=1; AJvYcCVkrp6uTdS1MQ8IkO/oXTwnVqCcjdiQEuEZtV4FJD1f64BuKRZ14YCgUk4mLjH3S08sj1fLjOGFlpuaf7NGg1+EjGxUvHyg25cRbasu
X-Gm-Message-State: AOJu0YzEUMe8RagT1aB3LaWTkeSKQMK3qoMPZl0jP8de/hnyYlVXkPqN
	GuEh/80HA48R/KnTFUsPtEpPR4i2AY7VVg0cIG/LBcwLRJTpnDlE09al254Jy2E=
X-Google-Smtp-Source: AGHT+IH+C+Z7HRlIQlptDVlJdVJ4RXNzH5TvHQa+XECFVSualLR3ctBmQ/xN0tWBPmH1oIDHUjxxqg==
X-Received: by 2002:a81:c24d:0:b0:609:ff22:1a88 with SMTP id t13-20020a81c24d000000b00609ff221a88mr4454991ywg.44.1710163156056;
        Mon, 11 Mar 2024 06:19:16 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id dg20-20020a05690c0fd400b00607c3904416sm1293053ywb.40.2024.03.11.06.19.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 06:19:15 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609ed7ca444so29958907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQcs3+uNpe0nt0KLQK0y+XA2L3g+OXAPM1wiQMRentlRBhNi2W24n+wW6WfUs80Z9sicIkXFUtvlPY+g2r8OsMd9xW7mh7b6OErE55
X-Received: by 2002:a25:ae56:0:b0:dc2:3113:8700 with SMTP id
 g22-20020a25ae56000000b00dc231138700mr3507486ybe.24.1710163155413; Mon, 11
 Mar 2024 06:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304085455.125063-1-dawei.li@shingroup.cn>
In-Reply-To: <20240304085455.125063-1-dawei.li@shingroup.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 14:19:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUW1gXjzHiczHKe=O7fv+qPn29g5UYN41v_-3W1qSax_g@mail.gmail.com>
Message-ID: <CAMuHMdUW1gXjzHiczHKe=O7fv+qPn29g5UYN41v_-3W1qSax_g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Calculate THREAD_SIZE from THREAD_SIZE_ORDER
To: Dawei Li <dawei.li@shingroup.cn>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:55=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> wro=
te:
> Current THREAD_SIZE_OERDER implementatin is not generic for common case.
>
> Improve it by:
> - Define THREAD_SIZE_ORDER by specific platform configs.
> - Calculate THREAD_SIZE by THREAD_SIZE_ORDER.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>
> V1 -> V2:
> - Remove ilog2().
> - Calculate THREAD_SIZE by THREAD_SIZE_ORDER.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.10.

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

