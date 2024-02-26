Return-Path: <linux-kernel+bounces-81822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63920867A76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F028DF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE812BE9F;
	Mon, 26 Feb 2024 15:40:56 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923612B159;
	Mon, 26 Feb 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962055; cv=none; b=d6vVdKeLG9439B4sBDHH98oxj+CbIHlDco8L3SJ9pRhQkdi9E3GSZ13lfupp2vfjbHCURWCIOjxNrOuJaB1aDvhW+8ErtqHH271hM0bO3IQAGuWfgY04ymOJxLPix8lK33zrzCY6AcZ39h89aMhmNHQJvT/Jx5GzA7aRk6eWg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962055; c=relaxed/simple;
	bh=JvGqVtPMzjCWMpjEKF/jb89vLcg20ScqtVMRggNfqfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeOrF7zvWuXhOI6fkuIsfSlPNUZdBXmQ0LwNJs3rBoVLBk882oklrlgRyQBMQjWjzIbAjC/+e3BTizhEk0n74/vuBIuyH3F6pYy5nijySA8uj0nDpJ57v5jufFLmnI8mL7XVhWkwShpk8sqex0xHM+CJPcn+ZPJl+dJaVAyHUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60822b444c9so20073037b3.2;
        Mon, 26 Feb 2024 07:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962053; x=1709566853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtU3gBiSlF+zY1t4TZQha65DndWfF2kOq1bgpFzA6E0=;
        b=GYRQ+SOxJq+9gbNMTAHgHaCRIU4EXo9LY4SqKsJ81VzSaOgBjCsfVmtrGUM8FopB82
         3K822OgMPXz/euo0aB3Fm/QahCcdDy+4WBrW4VQRu8O3NakccN5hY4ALDG6rnGETHUTb
         upPTKtanVi+m7lON2ngVRiLukGboz2PbJc1DBzkRpVDWLBjO2Oge7PFrHSKgr2P4+yDZ
         009SvzDa+i3QW2O0lxd1hTJoJDBXnrXu3TSTim3AHKtGwvwCKwYeq4Fn3fLi2fhDa+4H
         d2pXXkLMX8NdjzhUHvitI1ESD5iXe4pi/pItPdfWEftvZYCduIzh5wfVsB6bSYg1m09o
         lfhw==
X-Forwarded-Encrypted: i=1; AJvYcCVknfQ2TZ/O+jldSQox71Vp+o4YRh0jqjVnbt3dZrSXSQXdr8GexY9US7ndHUAzThc0wwmxdxTPptF0xrOC9k/HtZdS9TFrYPyn3MwlfzlZorXxGGgUGyrRdDzN2hnJZqFlGhDsV/3Gfw==
X-Gm-Message-State: AOJu0Yyy2xk9Sp9LaPQeseA9IOjDGmegJ+ulCEK5/T+uwxIDI8BFByVR
	5+HulIxog/gpdZpfJdzjK5uTHdY0FE8inTFoFSO1+5ub7Z5hTJAY8UxKmNdumC8=
X-Google-Smtp-Source: AGHT+IFEfCOkQ1T8BKL6ipSFMTFi4GzxkTFlbcihhfK8vKLGglPSH3UA3YdgS0yk7shnY+J+wemyfg==
X-Received: by 2002:a05:690c:fc6:b0:608:bec5:f27d with SMTP id dg6-20020a05690c0fc600b00608bec5f27dmr7444033ywb.41.1708962053130;
        Mon, 26 Feb 2024 07:40:53 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l37-20020a81ad25000000b00608d55efe59sm1192421ywh.112.2024.02.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:40:52 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso3217906276.3;
        Mon, 26 Feb 2024 07:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR8Au/rELoLXN1T2MJNVK5z+vjcbKptYByRgDA5qozXTpDbmOT4CkuXKO6rlC9E8bUekoP9uvo2XUKs4SXke5W93ooFVQKsB7oMxecNtbKSprT6Pd0Xdb8GWx3XkHeCMImZ4vslTINIA==
X-Received: by 2002:a25:5f4e:0:b0:dc6:ebca:c2e8 with SMTP id
 h14-20020a255f4e000000b00dc6ebcac2e8mr4934465ybm.5.1708962052506; Mon, 26 Feb
 2024 07:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-6-andriy.shevchenko@linux.intel.com> <ZdTp5LQOTpL5ke96@smile.fi.intel.com>
In-Reply-To: <ZdTp5LQOTpL5ke96@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:40:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYy1-TeofX9NnQ0anbJDz8N3Y_uSnR94Bz=VJ+H2yRWQ@mail.gmail.com>
Message-ID: <CAMuHMdWYy1-TeofX9NnQ0anbJDz8N3Y_uSnR94Bz=VJ+H2yRWQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] auxdisplay: ht16k33: Define a few helper macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 19, 2024 at 06:58:04PM +0200, Andy Shevchenko wrote:
> > Define a few helper macros =E2=80=94 wrappers on contaoner_of)() =E2=80=
=94 for easier
>
> I have fixed 'container_of()' above locally.

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

