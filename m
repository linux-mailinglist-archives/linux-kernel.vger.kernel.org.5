Return-Path: <linux-kernel+bounces-60688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDE850877
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972531C2153D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76125917C;
	Sun, 11 Feb 2024 09:53:56 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196C59141;
	Sun, 11 Feb 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645236; cv=none; b=P5cq4U1l17xFVATWHRf9MM+5kvLq9FWeF0p3mbxkAQkWyRI/M6dp4YLi1ajZh3oEvWk1rt6rius5By8W6JtKRVuPORp6y+sZhG1JphMbSlAM099eecDV2nSRIfA2L8svuFZ8OsdWLl6dAl6WYCpB7lJVWMcmALRgvgqcll5MmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645236; c=relaxed/simple;
	bh=I7YZwRT/usHmRZRp/Ua6UZNQvDq03jokdgJSQkJx8ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NryFFYUpvQlNP3FL8216/xOnfE6J4jQ/+5Ci47/wL9PfYsDYXj/VKxPtzjbXdsRsuMS5MCKN9Y86GVsBvCLLr+qtFzO/nIvRJEEJ44PpGjmD/eSexs5WX6ud1th1Ru5EQeE/7cVOI1aSK7UuCmDTn3I48oAufybzlGfgi0+5L28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7857964f57aso95575185a.1;
        Sun, 11 Feb 2024 01:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707645233; x=1708250033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RvRmHt+r/0Yyk/VeH3rIf5h0w1G4j3Mo4jl/7Uv/FU=;
        b=vP6xso8WxFI1fhh3mhv5Ucr2PGx5O1ikiqLM4kTc0OYH/tmW2feRAXwRqPyRhYDnow
         jzy8Rm4+aJk41thc3z1F1VS1IA78INerx8wVHj2NktGTcSYHWaUyTQ9Xcsn+Genw57uu
         Kv1TGmJHBqWCO1xteyr0UW+W/vjUA9FG3LGT9DabzBDnX6f7zoAwtc8dFyte1pclIVQP
         ai4ra08uDz/jGDCW5AMBcMjCq1975JKgBv3CSEVH39v44Hlynrdd7FIoqtdckRuNPBGh
         y3AohsSv+XabUz4JKpspOm5rY1YLG/ZcTnEroJEg3bWQxQNl3M0SbDLxTN89b7VQUcJK
         VeJQ==
X-Gm-Message-State: AOJu0YzvRG5ojb3m+28Yzg/pb2Wp8BqYCzpaIsnanDF25wKAOxvMhZFl
	nUiIsoOTlslpjnDvGhD+laABIWPu8P3Nh3usJ/BlQ5gSWIq0h1dE9O8s14bjTmQ=
X-Google-Smtp-Source: AGHT+IFvOwg1zd0A4PC3nUVjxgaRSJa+7ErW7hQCfQXkbFz1cvwGS51Lf9w3PSjYhGsX6A4a5Cr3NA==
X-Received: by 2002:a05:620a:4153:b0:783:e9ba:7d4b with SMTP id k19-20020a05620a415300b00783e9ba7d4bmr5115622qko.49.1707645232544;
        Sun, 11 Feb 2024 01:53:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzBikxsSKV31rzOvWhNSuFsi7eqUndeY/GLXxXsXsnrGD4DaWMJrP5PiP8YmVAnc7zZqUH3ni4dzdMCnvVrtCXlsj1ebiD0cWMXO103Ggrnf5iYtfQ4Sba3yZNWnJAUZYPwi5c+iM=
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v19-20020a81a553000000b005fff0d150adsm670175ywg.122.2024.02.11.01.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 01:53:51 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74435c428so2194685276.2;
        Sun, 11 Feb 2024 01:53:51 -0800 (PST)
X-Received: by 2002:a25:9347:0:b0:dc7:32b1:b7ea with SMTP id
 g7-20020a259347000000b00dc732b1b7eamr2843172ybo.46.1707645231510; Sun, 11 Feb
 2024 01:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
 <aedf7b7f39f820de555f1c41b6a8d663738eb3a2.camel@physik.fu-berlin.de> <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
In-Reply-To: <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 11 Feb 2024 10:53:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVt1Ebjf0X6X=rvFsr4aOcGc2c=RBViWP3cbAodNQJ4tg@mail.gmail.com>
Message-ID: <CAMuHMdVt1Ebjf0X6X=rvFsr4aOcGc2c=RBViWP3cbAodNQJ4tg@mail.gmail.com>
Subject: Re: Problems with csum_partial with misaligned buffers on sh4 platform
To: Guenter Roeck <linux@roeck-us.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Sat, Feb 10, 2024 at 10:59=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> On 2/10/24 12:12, John Paul Adrian Glaubitz wrote:
> > I have not run these tests before. Can you tell me how these are run,
> > so I can verify these reproduce on real hardware?
>
> Enabling CONFIG_KUNIT and CONFIG_CHECKSUM_KUNIT on top of a working
> configuration should do the trick. Both can be built as module,
> so presumably one can build and load them separately. I have not tried
> that, though - I always build them into the kernel and boot the resulting
> image.

Yes, you can build and load them as modules separately; that's what
I do on m68k (and yes, the checksum test fails on m68k, as it is
big endian).

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

