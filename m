Return-Path: <linux-kernel+bounces-19189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D93826989
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596F31C21C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C1BA4B;
	Mon,  8 Jan 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoTsV4Dv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3CDDAA;
	Mon,  8 Jan 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7831be84f4eso113376885a.0;
        Mon, 08 Jan 2024 00:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704702771; x=1705307571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GwILI2ALIJNST8VPsffc3ahIHUwnzbrpdCcG6R7Vhc=;
        b=HoTsV4DvBMHGn6Gc01wMfSso7vRMCJLHPeOPGdmENBoNZTQDayk3+B8mmlnDfYVdHu
         VlY4HmqfAdRZwhm/Mo7mT0n55kk4xz1wFsNj8SYj9WUoz7qUO3E+ageDqnvOjnXzoYEH
         q10FApay7za4whrVaUDwi/sdLMeQjoxJWfqsMq6kF69mglZApuUnWxW4dVYCdy0Lj0XP
         C7lOZsk9AGAXgC++fEebscewmh4m6aUd9jSuUsSUQ7R/spVBRzX3fmhjNKzgyoC7oLEh
         ArK6vhacTW/YbwXE4jTKB5H3KNGAmCiOz4M/tK2nSejLq2PpZMGa7Njnwnf5GZ01vZWI
         w8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702771; x=1705307571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GwILI2ALIJNST8VPsffc3ahIHUwnzbrpdCcG6R7Vhc=;
        b=ToIBPaQ+rgY/aBWKOI+5mQTyB5s+hoSagnDGyM6Cy8lRYc7zYZHGyu3MKV5EAQ7k8z
         QlMqk1P10yN2ohK2B1+ni/ddsg3+W30/qP4eOUmtQFt1T/OlOajhtt8K6FjrnryXCEKX
         vLAwIMwfp82m75bmuhYxnjaHpuIitU2ZjIQOJjwa25+Jx6V4vOYnP604FD3zMLBl17PR
         uY3LQZyuJZ22lXmzLS6MYSNsIeB21RgoO21/4AfgvOgxTvcKqHjCfXNLpPFeLb4e19j3
         oYWMTGJ0ZI3Fz80RUfkjY6MirbsCaOIxiN5zk4QnfjgDMzWeM5CpalmNPPMUhpvuoQRr
         zicQ==
X-Gm-Message-State: AOJu0Yy9+NoMi2X7xAR/lhwkG8Nr5SomdBOU/7QQD32Hp8gjGw8IhaoZ
	WiM5hXkCD/lyZB7lTeV2kFAm/ZU+TEy/GCZ7SNNTh/JcOcE=
X-Google-Smtp-Source: AGHT+IG1hYBz6K5KACuHekMLwBrEkxXFHG+wjm3BDqSNoAayV1A15p4tlYfATgTjURZaXukYiBYGdCrKH8cKINUQZL8=
X-Received: by 2002:a05:6214:500a:b0:67f:998b:bfa6 with SMTP id
 jo10-20020a056214500a00b0067f998bbfa6mr4859226qvb.64.1704702770711; Mon, 08
 Jan 2024 00:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107203258.37e26d2b@gandalf.local.home>
In-Reply-To: <20240107203258.37e26d2b@gandalf.local.home>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jan 2024 10:32:14 +0200
Message-ID: <CAHp75VcsV8t2-6GB24Rz003B2JSAEOBjWD7B7FjEXuCQhkJ5pQ@mail.gmail.com>
Subject: Re: [PATCH] tracing histograms: Simplify parse_actions() function
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Shevchenko <andy@kernel.org>, 
	Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:31=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The parse_actions() function uses 'len =3D str_has_prefix()' to test whic=
h
> action is in the string being parsed. But then it goes and repeats the
> logic for each different action. This logic can be simplified and
> duplicate code can be removed as 'len' contains the length of the found
> prefix which should be used for all actions.

> Link: https://lore.kernel.org/all/20240107112044.6702cb66@gandalf.local.h=
ome/
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

If you want Link to be formally a tag, you should drop the following
blank line.


> +               if ((len =3D str_has_prefix(str, "onmatch(")))
> +                       hid =3D HANDLER_ONMATCH;
> +               else if ((len =3D str_has_prefix(str, "onmax(")))
> +                       hid =3D HANDLER_ONMAX;
> +               else if ((len =3D str_has_prefix(str, "onchange(")))
> +                       hid =3D HANDLER_ONCHANGE;

The repeating check for ( might be moved out as well after this like

  if (str[len] !=3D '(') {
    // not sure if you need data to be assigned here as well
    ret =3D -EINVAL;
    ...
  }

--=20
With Best Regards,
Andy Shevchenko

