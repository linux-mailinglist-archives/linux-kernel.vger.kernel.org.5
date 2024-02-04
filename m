Return-Path: <linux-kernel+bounces-51546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC9848C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AC4B219E1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF6A16419;
	Sun,  4 Feb 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPYx/lEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7016415;
	Sun,  4 Feb 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037823; cv=none; b=LyfwXMsY90oqAkeGca2hGYNrmzgNkOLqnfIo6XuN5X0VtEm4QNq4R18J3WyPcNo/BiAg1+8UNVr2fp47KYePlFCNb3+Iy17L3nZSpSe1v03p3GNs2JfFfkIPicgFHOv0Rgg14l/4xl3iLqNf6g2DjV2a70BJU9LbtlOEWMgK4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037823; c=relaxed/simple;
	bh=X/udvI6Rmnt/kC0Ww4EhN5BGOFGKdHNsI7wBdV/ueoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZyTgaUr9/MJE6ZxqLlVhxatyj1NKdOEwlcfRw0yOEc9nCXZGHL6s5VAtfF6lJe9wc0v1uHUP8KWu54PwW5dyPUU2iL6O4Adg988ArhBCLm+31T9DiEF7KXY6ohCeKzAqP97XlYKkfrbe4f/45iGpDM+xN/uLpIW2PLMybBg/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPYx/lEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0546C43399;
	Sun,  4 Feb 2024 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707037822;
	bh=X/udvI6Rmnt/kC0Ww4EhN5BGOFGKdHNsI7wBdV/ueoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HPYx/lEXsAF9VOvxd0H4xQR2UxxA4rq0K/+kSXthc5L1U+giTB/Mnuj6AeuAWRdyp
	 +7xMgmgXRPHb1coIp9cDeOGAimaLMCyMyQnv4UkCf/AkErVvoXi/H9onfFuK/gnbTj
	 awUs/KuVopc6SFAVnNRZH/jwebWUMHDv3nGqFtN15z9P32727lhuQNCjqTRtVM8kY1
	 Om91KSyVFIrG2ytD1pxLaOGPsMZfBK0ytS94A00KyzTVgEvO4mST/uXo9FONXQiXzG
	 JPZAYz+3sgRg7KlNm+HTEtyq4xxiyT6eMO5JTJYJEWuNsP2raAaoY1i7DP6QFx+dYB
	 oC3wCfgmgwYWg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511396ec8c7so3195423e87.0;
        Sun, 04 Feb 2024 01:10:22 -0800 (PST)
X-Gm-Message-State: AOJu0YwYFvKFjXxk9QY4N4lzhpCyutd7E/Nzz20Z2GcfkwbR7BjghW9K
	0SYj6pVQtrSVWSQaO5LfWs7SGVOX2eHTpoDiBGrnbFOvrxK9EcsYopYBRo8DbYt94KJO0UKoGtO
	qYzQV4Ji1cUD1065qXqo9zLEkmrs=
X-Google-Smtp-Source: AGHT+IG4nI7h2Z9atmNu1/7EStI7ed/Lt7iPmeG8uYoJ4hjwswTxeXR8+wocGb1aaBZfiyfd/FR7Xr8pJh5oSN+oJ/M=
X-Received: by 2002:a19:6758:0:b0:511:4cb1:ea00 with SMTP id
 e24-20020a196758000000b005114cb1ea00mr575217lfj.62.1707037821263; Sun, 04 Feb
 2024 01:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204090223.37621-1-masahiroy@kernel.org> <CAK7LNAQExdrSmucgzj8UHcgvXjKjdLqkiww+cuUN6EBzkJAy3w@mail.gmail.com>
 <87a5ogbnqr.wl-tiwai@suse.de>
In-Reply-To: <87a5ogbnqr.wl-tiwai@suse.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 4 Feb 2024 18:09:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATb1xxCRsdMJONWvT0-h8+H-wxm9h-eXH_SUSVYQPEJMQ@mail.gmail.com>
Message-ID: <CAK7LNATb1xxCRsdMJONWvT0-h8+H-wxm9h-eXH_SUSVYQPEJMQ@mail.gmail.com>
Subject: Re: [PATCH] sound: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:08=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 04 Feb 2024 10:04:32 +0100,
> Masahiro Yamada wrote:
> >
> > Maybe, the patch subject "ASoC: pxa:" might be better than "sound:"
> > so it matches the change history in this directory.
>
> Yes, care to resubmit with that prefix?
>


Sure.


--=20
Best Regards
Masahiro Yamada

