Return-Path: <linux-kernel+bounces-65484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694BC854DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210CF28C549
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F25FF0D;
	Wed, 14 Feb 2024 16:05:57 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB05FDDE;
	Wed, 14 Feb 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926756; cv=none; b=tqwP7DGvIUH5eQLbdC+sxTgMD3NrowJef5z1RGVUILHcMgmy7UoBuX6JJInOeTkaPHpyvDu9xvNc99DhiBnS9FffdldZ7wdK8DK2izi39jiiithPb1aH7iCciwBB5bRNpKLkPZrizKBFwFrfBVP6aObGh4/V3uhySAERLJTF/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926756; c=relaxed/simple;
	bh=2rPdZu7j7a65QckXuLVe7Tw9x0DknKBAnl3TOA/vyEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYc9HqC9MYN1g++ZJQyejEMuslOAt40NxS85hLa4lONRLbu+wLpP86g/STqi8YhXgHTmov3GMR7RyXlJvEcKw9lGX6zzJrGV83ptqLWdsNlEsunytS0C/RBNEF+DN7+Av1QKr4dEeUdpaUhLWiO5njRm//ALiFD/JsYh8qLnBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60777be1a1bso26494257b3.1;
        Wed, 14 Feb 2024 08:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926754; x=1708531554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CabsuXF5OsJBAOKe4fS3bqwNItwV3UGEGIvYWeFLkY=;
        b=pvAlbqRnSRmwZvpE1cRfwjaw6v2OL4lHB3OYG1G+CKgKshI02nI/pbN0rZ2PEgmhpE
         KYIEO9z7LY2ZfpOJN3qo7Y9RWTrjQW8zo9RnhyGyipBmZGYMaEG5lcXvhTp5TlXouWGl
         J9VRULcXd5rosd2Hkqz+9jH8ABiGbGGlv8IBKrwDBe5MRLJ/jZTu+PfHtdsUAmKozmlo
         zo6fd8/LIvYtUeaSGBjMHgGRArgXG3EKC6YXLz4WLXnuMLFYm9MeGDv2suJQxVY9Mv8I
         mKLzsqpsUNXPjz2IKBfX08PT4Uv4K+Q7YSrIVKDJ1ImiD3KqHJ2AtpgFNC1EA+l+RbNF
         +bGg==
X-Forwarded-Encrypted: i=1; AJvYcCVK5i38L5yVfH1y2YWR0QVqytaZQyXUGnSv48bgCrUoj6+cZW8QM6xyG5R2YaMafEH40xjn3eEyPLkaQ4i+gK9vBB70X22p4bjKMeJL
X-Gm-Message-State: AOJu0YwPKak3bqt9pUq5LBvL1fRI43lNfiwEM9yRJdIFOGzIKbFFnNN1
	OKZIyNwFtKD1yK1dxldykRD5iCZqMx7olvP6XI5dtW9u98X6wdaA8F8uyI7PeQ0=
X-Google-Smtp-Source: AGHT+IF/A380KUzwUdhbgQ+XbHwKHgR/JtswBXQnw2vkqHauImf7Jsyj2nae5D0/0ptVMs+YZr42wQ==
X-Received: by 2002:a0d:e254:0:b0:607:8393:384f with SMTP id l81-20020a0de254000000b006078393384fmr2569343ywe.29.1707926752323;
        Wed, 14 Feb 2024 08:05:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUK3/AG7DyBlJeZdgw9XY7XJ/ymoQ0f2KeRF/RBrDANbg/xEqTC7H+D20ff7fuayeTpj2+vddL8kilab28Ly6XidZz6ljdAAMLPnaPi
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o9-20020a81de49000000b00607c2ab443dsm25247ywl.130.2024.02.14.08.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:05:51 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso3010750276.2;
        Wed, 14 Feb 2024 08:05:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURxGVOc7vDUxwUw8FcP5Bzyd4KgLF1syfuw43vOj8vWUSLWQVYeJgfyIQ8XyVf5VfbGky6i08+nWF7+0Ws+GKUIFbAs9AqsYdtJ0vY
X-Received: by 2002:a25:ad94:0:b0:dc6:7247:5d94 with SMTP id
 z20-20020a25ad94000000b00dc672475d94mr2218889ybi.55.1707926751399; Wed, 14
 Feb 2024 08:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-9-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:05:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUmz47Kaj9U_VWeT_LR8LM=qgqcRecx9aEAQxcTeCK4qQ@mail.gmail.com>
Message-ID: <CAMuHMdUmz47Kaj9U_VWeT_LR8LM=qgqcRecx9aEAQxcTeCK4qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mfd: tmio: Remove obsolete platform_data
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> With commit 8971bb812e3c ("mfd: remove toshiba tmio drivers"), all users
> of platform data for NAND and framebuffers are gone. So, remove
> definitions from the header, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Lee Jones <lee@kernel.org>

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

