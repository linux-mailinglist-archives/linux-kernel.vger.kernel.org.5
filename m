Return-Path: <linux-kernel+bounces-166276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A876F8B9860
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A23F287017
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427E5788E;
	Thu,  2 May 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRvn94sq"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593027E78B;
	Thu,  2 May 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644016; cv=none; b=TNSyRL5UyB4RXEdMO0OrI7bNCri8f1mxjA61tZPENOfF5uvvR9CUHcSpL881VvSdh7uuGjfm1YjwJhorGOdyk0kg64O0o6/d4WQsUpjaoT2E1stghos6DEyxxIpSLDJVkUW0/o4lEtnLetzW1F2jeLDukxCjWWMaHLrFAeWAd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644016; c=relaxed/simple;
	bh=fJvZHbOPkBkkNJqfU75CqmF54s9MzQdiRJ33DhOwPoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7fpAmcZNjFg5DAvZpdFH1E9iTGwwgQyPvbxU7x2FkUCDJdKZgMEQ9jYhODoQxFCrrtdAiN5JjnlY2qvpRVGmcnvjVTGwsqLzzlcwc8/tRVBMXvw2jxf15oo51wY0STNRCF27JGKcHbtfE15mbcqE/IiVTuCNMfaGGHFPfkyGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRvn94sq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso2833068a91.0;
        Thu, 02 May 2024 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714644015; x=1715248815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jlTYG9vHv+Kk/nSExLseCcWYaSQ+I1BuCKbKEGymUY=;
        b=YRvn94sq1U1eGSKGcY0/8d0sdBTrjf4LU4MoCHKDb7Ytyio6I8ZlhvmGLKqcEcvRwW
         9NvIpXNcFF5qTnD4rqTfHz3EdIxb6OyPKgihpvJ79wMmTVZkl05Sm3jL36M7ZC4gQ+d6
         /5Aul9fWCv1SkvHBFfxxib/XoMP0ZAJ5fzK0PDfN0SiDGDuUYdagEB49oRTqomDw0GrA
         DWUOJpcqoFkYMp/qvmUG5HpFWl7RtnRvuAUPCdG2pHqf9zG6pfMe3Ms3H1Jl3zrDEiqn
         temYLCrrpAbx8DVPRztWHYxEjDX723kJ92k+CqBqNCpvBJpS/s/IVX2Mq/JJPuVtOFx/
         yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714644015; x=1715248815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jlTYG9vHv+Kk/nSExLseCcWYaSQ+I1BuCKbKEGymUY=;
        b=IcqsdWHHvxB8sPWY3ZQOejgsb8GyQikTgPt+NCSnTkeK1W23mqHuk2uFQkmVbVVUCZ
         KizuLngm8Xvm+qin2402lWbU/8B1j5JdY47DAIIrE5AyyD4Z7k41DZUcnRnWnxoLFSXk
         n3DmtQ5KxFELXS7m5n4f1e17iOXnQ30/XUGAaByC8DzdvpL48FbNl67mwPKnvJHL+wg9
         s0EvJagcK+MfYu/VBKDtkly6CPx+vsRakfRcykM6kg8JJwHa3ZGbHbkMmW2HTagmw/hH
         0otYXp93ZiskfaW3vS/6gqusmkaDgOTbAUBo2EOVYoIexMnWHD9dFY9/6vo9CtepVj8Q
         dssQ==
X-Forwarded-Encrypted: i=1; AJvYcCXazAeTLGOGHUjpujFi+tCJkPVdj0Q9SpX8QncKXTKHYkjiVcT8deckCjlL5K4D6Lg9tQ6MfdQLD7XkloNgku3ewW7cLYt0O9XTrjzSqRrqboQOAg3LjbrNoaSMmI5kqxAqQmG5GSMkOzw=
X-Gm-Message-State: AOJu0YwfURdwibVUkpyCmGAqMq7lkk8vqArCTHinVhxHYUuZ/E3S+IPa
	mHdv6PRpjYqiI8RECc/2HzKyX8cBbq+6AZ60NTVJqbhKFbsZjw++Hj0Gh9HpUilp255vk/O6uC0
	M7EhBAU6tMzm3VnfBLKc7mNLDV4E=
X-Google-Smtp-Source: AGHT+IEUUsxz2FqNCRKrlLd3iOcD1MJqsQo+2bTELDCjLfSEv9td5Hp7tE+SN0ytUqa2A4nCjVwOC5GVl19cUORFy9s=
X-Received: by 2002:a17:90b:3d6:b0:2a6:c503:95f2 with SMTP id
 go22-20020a17090b03d600b002a6c50395f2mr4930182pjb.16.1714644013879; Thu, 02
 May 2024 03:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502063621.65687-2-shresthprasad7@gmail.com> <20240502093623.GJ5338@google.com>
In-Reply-To: <20240502093623.GJ5338@google.com>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Thu, 2 May 2024 15:30:02 +0530
Message-ID: <CAE8VWiLP-QR_KaHBPYjA=UVJ8SShpKseB5Xp9Hpkd1RMcvt-qw@mail.gmail.com>
Subject: Re: [PATCH v3][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
To: Lee Jones <lee@kernel.org>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:06=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 02 May 2024, Shresth Prasad wrote:
>
> > `dev->of_node` already has a reference to the device_node and calling
> > of_node_get on it is unnecessary. All conresponding calls to
> > of_node_put are also removed.
> >
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > ---
> > Changes in v3:
> >     - Remove unnecessary braces
> >
> >  drivers/video/backlight/sky81452-backlight.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
>
> No idea what you're talking about.
>
> This patch/version doesn't exist in either my inbox or LORE:
>
>   https://lore.kernel.org/all/?q=3D%22%5BPATCH+v3%5D%5Bnext%5D+backlight%=
3A+sky81452-backlight%3A+Remove+unnecessary+call+to+of_node_get%22
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

I'm not sure what you mean.
The patches show up just fine:
https://lore.kernel.org/all/?q=3Dbacklight%3A+sky81452-backlight%3A+Remove+=
unnecessary+call+to+of_node_get

If you mean that the first version doesn't show up, it's because the
commit message
was changed to better reflect changes.

Regards,
Shresth

