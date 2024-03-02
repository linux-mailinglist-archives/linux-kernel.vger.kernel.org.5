Return-Path: <linux-kernel+bounces-89432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2486F047
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA52284CFC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2417548;
	Sat,  2 Mar 2024 11:42:27 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8CF376;
	Sat,  2 Mar 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379747; cv=none; b=J+DfQcJ3/srqAtB5JDAC0fYLo+UKHPG9Wtl0YkTI7B4/gCG9m4YaROMtHKiLMxrSatAB/9cdUWRSu8vpeh9lsHSlHnppfzWRw9IGA45fm6QsI4+lwcOpD7AkwBAdLvH9sidgSrzZrbtLk9JmiVyelqT/M3eNLoGW7OclYrvT1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379747; c=relaxed/simple;
	bh=8T1xxnqxA4Cn7ZALmW7k2vXmJDpc3Ja/SWJ6xwaLSSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb8e5h/71CWHatm/BPRZIgTGXjZapWA82aUwk73829pAi14yN1TFhoMNMa4b2+uM26EfyQsQt/tPKP5AEhmS5Yw6hV0tUBYhFaYtljQwcflWi5o8DIw+t+NAXCnLGWsw/pPeCbaoOy+gklrxlmX53PdYazxi0V056jNCRyd5msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-364f794f237so16020815ab.1;
        Sat, 02 Mar 2024 03:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709379744; x=1709984544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8T1xxnqxA4Cn7ZALmW7k2vXmJDpc3Ja/SWJ6xwaLSSU=;
        b=GYfBSgJyOUG5dIrxsx7F7ngSAdY0uR67Kr4S2ArzeptoF1DnE5doFfGuBiNxkAGc5C
         NQjmk8tvSl7BtMWwVfeBVVnhNGI8/qXtIbIOplfFqqfX2gKL/RH03KTdMgMjWmINYbI0
         UWXx2lZkPB6T1Rrrvnjt4M+91kdWU9nrwd47xFn6fCpetZSZl5OyCvjezUcValhi94MS
         FdP2MtEXCvp9RgZSqESKBXtj7+LqznIpkX56zGUlFxHA4vjQHLAJarOrUnvSxg//jg8U
         FIhs546Ok8RSy7BmJHYK+7M8nbYtHRHCFkXE+3K1py35pOFFvmayzyNAtRGKoye3RAPy
         g+0w==
X-Forwarded-Encrypted: i=1; AJvYcCVu2W28iIQHc0gbW4l69djqD8RFLYgaxM/AgdRiSwQCjRG1RLhMYE78tI3hntHshS7A6dSV3MQ0GnjU4+WRfl3WNN57I07U06DnUD2WR6Z9PyXmI1uWIHRmUnfARzIVZtnQ/FSj8i7k
X-Gm-Message-State: AOJu0YzvANwD1eX52s60ok8o010RR+uFhGcK8YO+GCSvayCT/aKSeL4q
	EaHWAoPprdmDvlcZqpJj0tpo4iGl5QQvPB+pZhZ4rKPcUZyxHymLW5iGZ4kMCsg=
X-Google-Smtp-Source: AGHT+IFs99ciz34AgjU6tYTk8CBGIC0GwTWWtLgku/rr7RbRwZVEX4po93RZ7o6KdJhKXMJF9GaRxg==
X-Received: by 2002:a05:6e02:144c:b0:363:d9eb:c2e0 with SMTP id p12-20020a056e02144c00b00363d9ebc2e0mr5361535ilo.28.1709379744409;
        Sat, 02 Mar 2024 03:42:24 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id fh8-20020a056a00390800b006e4e600d15esm4374906pfb.160.2024.03.02.03.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 03:42:24 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2630985b3a.2;
        Sat, 02 Mar 2024 03:42:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsQBV9jd5jNQGYjVjM4ZoJ6XgRr/hQCEyxco9yrnDkHB7M4UgS9lyTuGDCiCwMD8RcOZDVFwYzBxQbvyxfW2z2meahrLDl5rutxeYwQpOGl+ObYV5lMp7ZvAs5ekidl+NoUwiy4mkM
X-Received: by 2002:a05:6a20:8e01:b0:1a1:e75:477c with SMTP id
 y1-20020a056a208e0100b001a10e75477cmr5238403pzj.9.1709379743994; Sat, 02 Mar
 2024 03:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013181712.2128037-1-jernej.skrabec@gmail.com>
In-Reply-To: <20231013181712.2128037-1-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 2 Mar 2024 19:42:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v651T28yrkaAbX3ckV8gEsYXdGgHMgCb3Jdmbej2OnNyLQ@mail.gmail.com>
Message-ID: <CAGb2v651T28yrkaAbX3ckV8gEsYXdGgHMgCb3Jdmbej2OnNyLQ@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: samuel@sholland.org, sboyd@kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Chad Wagner <wagnerch42@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 2:17=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> While PLL CPUX clock rate change when CPU is running from it works in
> vast majority of cases, now and then it causes instability. This leads
> to system crashes and other undefined behaviour. After a lot of testing
> (30+ hours) while also doing a lot of frequency switches, we can't
> observe any instability issues anymore when doing reparenting to stable
> clock like 24 MHz oscillator.
>
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU=
")
> Reported-by: Chad Wagner <wagnerch42@gmail.com>
> Link: https://forum.libreelec.tv/thread/27295-orange-pi-3-lts-freezes/
> Tested-by: Chad Wagner <wagnerch42@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

