Return-Path: <linux-kernel+bounces-44835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0728427FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DB1F23F17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6082D85;
	Tue, 30 Jan 2024 15:24:09 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3B82D74;
	Tue, 30 Jan 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628249; cv=none; b=dKfRjvyr174Ufxoyy2qzFR1HH0DUDL187yo7M3wodA+FSInQQXb59dXK0V6JBRCODgl+e08qdUH04AXCaBIDSKOafZnC+iAeO/cBI17GNT1HuFXp1a3pOr0t2at83tO/IlJ1Yy9RFx7eutuYFLR0RAq1SC+5zoQsUNPEBYiM9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628249; c=relaxed/simple;
	bh=Ny9HZL1SDTcltS/mUIdLF+8OiysGYa6Smfj5/K0Yv1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9puLVOJXfAlhC+JrjYcyi3c8GShxZYKJGyo1JHJifz9ipUPkk8cjfr3KHKATer/UUBm942x/Jm8yB+IrDd5TmiMs0DU8XuLgFFNLlvGEp3gWDe3fyTv9pXIz628VHBt7YsGI6El+hGZ0W0EXJmqjQIQ0mWLVeM1ROiB/Pjvo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd5c4cffefso4531553b6e.1;
        Tue, 30 Jan 2024 07:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628246; x=1707233046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RELObW5QZ1dvNno3G4HntaRf4pHbics9wcgti0hEbiw=;
        b=UhNXlMatFyGKNpnWTfoXOokVgePR5pU21KOw0OCQb/eAKha2K+vZfenrYB/DwlLoiC
         Sv0y08Nmci/aatXeYA/eJaItJSEfQg58p1AO8vonbCjqN/PBi+ZzSavvQX3bYws4k6RE
         /tZZ2+inip7Y2XRetb0LD9gntFOVPkb4NbzICNgek8Vd0i4KpnXJqPl0Dsf0YS+pLRNp
         yZCfK2aOINPgbGEvgJv4+3buo/NOfkL53w4aFC+4J2qHPn1kn2fP6QOxH1ySvd2NGjTz
         LcZGZHoVxt2bjTo+iSwAokzML9xhl+FZXDNImvLSxegsq1XmmjgIAc+g310GoFL75JU3
         MTwg==
X-Gm-Message-State: AOJu0Yz6Dnhu9GhoObwxrHCwyTJBSXk63MzNpz3XDgKY0fmxTqTtmn8V
	w7/MkgnCW9mUyAVL0PhXCLH5SmUEVm86VHDr5Dh/3WrI9nPtmVOaOXt9Efo5J1A=
X-Google-Smtp-Source: AGHT+IFLmt5xjaeuCroDmGoARQAO9s6zSNwP1Fzzu2EGK/W7+7Uj4ipIqGLabcOoEmOb3Q51rWJdVw==
X-Received: by 2002:a05:6808:601:b0:3bd:62ac:cd3d with SMTP id y1-20020a056808060100b003bd62accd3dmr8462472oih.47.1706628246098;
        Tue, 30 Jan 2024 07:24:06 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id l13-20020aca190d000000b003be487f552esm935258oii.19.2024.01.30.07.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 07:24:05 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3be48947186so1231178b6e.3;
        Tue, 30 Jan 2024 07:24:05 -0800 (PST)
X-Received: by 2002:a05:6808:3c8e:b0:3bd:dfba:f9b3 with SMTP id
 gs14-20020a0568083c8e00b003bddfbaf9b3mr11731834oib.49.1706628245574; Tue, 30
 Jan 2024 07:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 16:23:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOZ-825GB0hBiqf_z_5p2_KDmKgwJ+E5AEo0T_rJPQ3A@mail.gmail.com>
Message-ID: <CAMuHMdXOZ-825GB0hBiqf_z_5p2_KDmKgwJ+E5AEo0T_rJPQ3A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sh: rz-ssi: Fix error message print
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The devm_request_irq() call is done for "dma_rt" interrupt but the error
> message printed "dma_tx" interrupt on failure, fix this by updating
> dma_tx -> dma_rt in dev_err_probe() message. While at it aligned the code=
.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fixes: 38c042b59af0248a ("ASoC: sh: rz-ssi: Update interrupt handling
for half duplex channels")
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

