Return-Path: <linux-kernel+bounces-66988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202285647F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50341C23B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF1130E40;
	Thu, 15 Feb 2024 13:33:00 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5B130AE1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003979; cv=none; b=qguJ/1EAk4NjMZksM/YRGKAumNO6V2hCvVwGv9wfi6QG+8rba3lcQGyJmvQplKxR8oPKEvFOF1nS9X2fye5m7kSxZ4gyv9stXjHIT/WRtfsiWEbG1G/0/gm3ybc8jAgLEgiygN6AioXhrxoIetwC4j63gqm9cpuGXmdKWF9CA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003979; c=relaxed/simple;
	bh=kiXg2Gu/c+D5S7ZBDY+MXrWjwqMWOKYkRWNmr4rKlV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLBy2qCXMcrgAK5jaQplYWKVnJHVu4UdrFjQg9nEDbH0ObHwXoruCUBZNvPnQcqECboiArCI3QN7G/Y+U6BIpduPCL4R0w8kJhuksMBR20xzbadZuxp82SnnvxOUDWo5b8fY9g44ZcZ0eAKFVui5Fx9RI0SApR3Gixhk82o9QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607dec82853so3629617b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003976; x=1708608776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4meeTJSurZIlL3gAPQaSHal0Sj5UIbFktENiFv8EMA=;
        b=oiNf9WHf+nvyv+bGCXsXZyVglF1y8sWh7xF0hVvPH4yjr5vgoJuxjR0bejJIKD99k9
         dkVNDjzN8iNhJZO1jWMJ6biHR8o5U7H5udqujV7UvmNaos4EiYll/tIQpb0VdUuVkLch
         KWA7ypZMHDIYx8ruqxiJeZ1vMJM8xQxlmWdB9RWOYGjiEj03/2RP6LdoMMOBJ3HBHOac
         2kPsEuQ/6J9lppNg0D2c5Nd2fcID2wKV9tn0DyyfWt/hIngMpM4Cr/QXqQBf9r+3lCkT
         sX2rK51s78ns//XX7senJwxo9AvYIzvIeFuaXIXzddSFckMmaPuAAEb49MqLFptrZvGa
         mE1A==
X-Forwarded-Encrypted: i=1; AJvYcCWh+S2f2MJ7D/wga5+J6DdUAmxUQueFreCAN9vEV6k3BNyloKvX3ZlPfvv73vlnRTCJliL8lLxxFjplCIm112I5MoW9TNJgw/uYLK+d
X-Gm-Message-State: AOJu0YxKQKIAkrWDuiKBbCbXBxkLtzwLyiEmjn0yh5vWxCHH4zh7k8oe
	7W59tSihyleVD6/pwyUQX1Lja9sYF1Tx2mBw/O+zFLQtAVr3d5cMNynRqwgu/1nnxw==
X-Google-Smtp-Source: AGHT+IEeza39mcuk74gdxff9+rxMrVltd9mYvqwRz5sB0zoT8TrogaIvYubT6ZSapjj441TlsR66HQ==
X-Received: by 2002:a05:6902:524:b0:dcc:3020:e68 with SMTP id y4-20020a056902052400b00dcc30200e68mr1452188ybs.64.1708003976084;
        Thu, 15 Feb 2024 05:32:56 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i9-20020a25be89000000b00dcd9e3d3fd0sm182042ybk.19.2024.02.15.05.32.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:32:55 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso869689276.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:32:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpCOXipwEqlMC562qku1qGV7xtdVVeOnWYwRpJGrh2bHVjtY+l1Abx/jl+41Zg4vk5NCjVAlKwA6gg5RzU+gF0fu9Dtn9eAkv4UIrI
X-Received: by 2002:a25:ae0c:0:b0:dcd:4cbd:2600 with SMTP id
 a12-20020a25ae0c000000b00dcd4cbd2600mr1774699ybj.55.1708003975710; Thu, 15
 Feb 2024 05:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
 <cfdc968e-f5e7-48e0-805b-8a5d745a7536@sirena.org.uk>
In-Reply-To: <cfdc968e-f5e7-48e0-805b-8a5d745a7536@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 14:32:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-V_Mg-r1T5a_0DjARu-mLJN2uV5fvv8vVzKhvz=6eLQ@mail.gmail.com>
Message-ID: <CAMuHMdV-V_Mg-r1T5a_0DjARu-mLJN2uV5fvv8vVzKhvz=6eLQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: lp873x: Use bitfield helpers
To: Mark Brown <broonie@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Feb 15, 2024 at 2:13=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Thu, Feb 15, 2024 at 02:09:18PM +0100, Geert Uytterhoeven wrote:
> > Use the FIELD_PREP() helper, instead open-coding the same operation.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Mark Brown <broonie@kernel.org>
>
> Presumably there's some dependency or something which means I would have
> acked this rather than applying it?

Not that I am aware of.

Looking at [1], presumably you were misguided by the bogus threading?
(due to an attempt of mine to send several patches with a single
 git-send-email command? I don't remember)

[1] https://lore.kernel.org/all/YZvGFHLWf3GM1jVl@sirena.org.uk

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

