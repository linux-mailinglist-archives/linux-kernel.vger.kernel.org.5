Return-Path: <linux-kernel+bounces-54595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7584B155
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79180B22515
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC712D153;
	Tue,  6 Feb 2024 09:33:40 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F614265;
	Tue,  6 Feb 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212020; cv=none; b=nbdKNvlocdgTbwpTPMMvwtW9vtVXVNZHzH6exdx89gMdXbzXkLDOiEz5b7whW8E8MY/X16pM2aPJtzQRjzg3i8gTAe7ZAwbEeU/zyc/U5WfwS1O1vgvtJnAzIJhMKkq8ZohNUk/Hu75OK408D42avkAaKwhK0PgfV+4Bf2PlG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212020; c=relaxed/simple;
	bh=y4U2aG9cl6K5uex4m8VJTV+7Gi4knibICynFOHtZOew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6QeGNp5G7DDL9nshIpka7pI8mAIAzNqRJ2TGn3Ieyt4xf1+RtItWvHOj1zeGzXnqCAm3GJF+Q8+EjDdjbAQiUNr1eBSem/2FqJR3qQULRE0Vh0kyM+Rt+egufgQSLp8ok8WbNCXIekL3BgTfAj6AglXdoafBbTBV1jD+xoJnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604819d544cso1741857b3.1;
        Tue, 06 Feb 2024 01:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212015; x=1707816815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv8aVTQt1PkjH10jXoXAhUeu0btco/HHsLNCr4o/nTU=;
        b=KeHuUnuhowZEJT9PFUxPaq7vkT9ANwSBo4uebLA916NiRMIyTymND5Eo6qx/vIYRZy
         raam7A7EQOnpw8QecuqYiOM27KnMzFgUf4FmkhW6n6GcKehjxCdmqB0ONQVR/tuAEi9H
         iyqrd2adGer2MygINkNbSTv9d6AhNzMmfPeM93qgjPz55ftRd2u64kRB6c8nO85l/i7B
         cR948utZh3OFhKOJ2ZS7dcEAcOjUf2kuU/ta9DXj9BbUoVQZ5uQmbVgBWMK5X/eSRWh4
         l5WoHz8dHbtNCCkraIRJSw4oXYkq+2oxZa+6dYmmAX3Q5DNrxrIWo+iV1aKWpsj27JRt
         qVBQ==
X-Gm-Message-State: AOJu0YzwRFFPHdmn1MdX1562NYU6ALmU6t3CRrzPgnYgyJ2EcH16Bhz/
	BLvxuSRAc0w+MuuMY2Osikpahf9GDoXl03en/xCodRqSsQplQrEcwrem5YHUZcs=
X-Google-Smtp-Source: AGHT+IF54/JlBZSP73R4yrcPGhUfqqmzJ8NvUn+TkH8IeyGtsCu8JXleA7CQTRjuyY2PQi6FP9r+hg==
X-Received: by 2002:a81:a903:0:b0:5ff:4a64:a8ec with SMTP id g3-20020a81a903000000b005ff4a64a8ecmr1183223ywh.38.1707212015338;
        Tue, 06 Feb 2024 01:33:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUyf608w2uEOkg+wZvFVbYThN72lZEL4XyRb7ClIpr0bEieM2fU1gQEaJX6n4hdQxktzdJyAGuHXyOoOT42arQJEs/ByQcAIznkOq2OcFyeHzuPltXAlLf8PeuOY1F+iICOa/R6XdHoJMFjHy/AzfE=
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l145-20020a0de297000000b006040f433098sm405216ywe.94.2024.02.06.01.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:33:35 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5126533276.3;
        Tue, 06 Feb 2024 01:33:34 -0800 (PST)
X-Received: by 2002:a5b:711:0:b0:dc6:4c9e:9e4d with SMTP id
 g17-20020a5b0711000000b00dc64c9e9e4dmr1100023ybq.20.1707212014034; Tue, 06
 Feb 2024 01:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206071314.8721-1-liubo03@inspur.com>
In-Reply-To: <20240206071314.8721-1-liubo03@inspur.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 10:33:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
Message-ID: <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
To: Bo Liu <liubo03@inspur.com>
Cc: lee@kernel.org, wens@csie.org, marek.vasut+renesas@gmail.com, 
	support.opensource@diasemi.com, neil.armstrong@linaro.org, 
	ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com, 
	mazziesaccount@gmail.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo,

CC broonie

Thanks for your series!

On Tue, Feb 6, 2024 at 8:16=E2=80=AFAM Bo Liu <liubo03@inspur.com> wrote:
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably

probably?

> more appropriate for modern systems than those made by the rbtree cache.
>
> Bo Liu (18):
>   mfd: ac100: convert to use maple tree register cache
>   mfd: as3711: convert to use maple tree register cache
>   mfd: as3722: convert to use maple tree register cache
>   mfd: axp20x: convert to use maple tree register cache
>   mfd: bcm590xx: convert to use maple tree register cache
>   mfd: bd9571mwv: convert to use maple tree register cache
>   mfd: dialog: convert to use maple tree register cache
>   mfd: khadas-mcu: convert to use maple tree register cache
>   mfd: lochnagar-i2c: convert to use maple tree register cache
>   mfd: wolfson: convert to use maple tree register cache
>   mfd: rohm: convert to use maple tree register cache
>   mfd: rk8xx: convert to use maple tree register cache
>   mfd: rn5t618: convert to use maple tree register cache
>   mfd: rsmu_i2c: convert to use maple tree register cache
>   mfd: si476x: convert to use maple tree register cache
>   mfd: stmfx: convert to use maple tree register cache
>   mfd: stpmic1: convert to use maple tree register cache
>   mfd: rc5t583: convert to use maple tree register cache

If all of this is true, is there any reason to keep REGCACHE_RBTREE
around?  If not, perhaps REGCACHE_RBTREE should be treated as
REGCACHE_MAPLE in the regmap core code first, followed by a single
tree-wide patch to replace REGCACHE_RBTREE?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

