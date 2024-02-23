Return-Path: <linux-kernel+bounces-78521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F0861471
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55CE1C20C26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C005C60F;
	Fri, 23 Feb 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoHgQvPM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A51C680;
	Fri, 23 Feb 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699533; cv=none; b=mTr875HbdJMfyltAVPESFaCFCWcCGJA7NJ54BVlLHjHg9gNFyOQkT1TwZ9VTMWEVm1iFl5gGxXw+DXJfvvuaKeFBH/kREY8k+oW2H1dFvuGXk7hj6dWUSjRRN+kOwv6+1oWPuMZsxvRGZ1jf/iOlPUeiDxo1uGk4tbm3LRuOFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699533; c=relaxed/simple;
	bh=BfsdNiLPuAMy7kSkAtbNij4qj8LZNG1lsXLeWEKp+iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkfT0syQ67i5xe/JDbepEvCIn4Bc+Vr0nNAjuBuXHcpxVhu5uOVfYYgRjt8PliEJSyotqQ9jDJbm28HiIPsVGVPpJe4ZCNfmFpGqlm075PE0BPKZV6GnZAVuNQ/4ofAw14VLR34J6+eOfjs6xo/BPtJtWPiFvH0D6F9xCS4HK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoHgQvPM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e706f50beso117597866b.0;
        Fri, 23 Feb 2024 06:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699529; x=1709304329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfsdNiLPuAMy7kSkAtbNij4qj8LZNG1lsXLeWEKp+iQ=;
        b=VoHgQvPM4yt1NgNp0Aj5W/KgakPK8nqwI49QYLDSM2bi9TIsvzEq3Qw9t0pF4uWSVa
         zbKLzePd83hR1wGPpTbs0JjoK/wGPL+UcJuP9QRbSpl+tuAwVlAumS+H/6c40pHJGoyo
         DjJN0QJ4ZB2IZf0nIxQDz87enFRSCdM+XELDAjiyuxl4c119xYG3k4La2q7lrys9X45k
         GoBJUdBFZZHVs98hcexaDNUDRf/m/laGYy6Kfy7JE0iNAi8Rj6I5LLTUGyCTBem8h+/z
         KLc6aF6fbHEtpHy51USPrUnCT4Qdh7qNwRPBnwN1JCtgwTP6+ZlZMHniRSc265BnhoC2
         ge0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699529; x=1709304329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfsdNiLPuAMy7kSkAtbNij4qj8LZNG1lsXLeWEKp+iQ=;
        b=evM431ySroUilxzJcFguljHEs9NjFxP/hTP6qss51fwwdwsqNwReF4r2zxji+cF19W
         hgp9gL0sj/N/HarqCoJ2Hn4nz+7mk69jiS2rtMDxiEGcjskPl1uN0m8O0muQny0XuXgW
         SnHnc6ql8IwBxLV39PrPtHqvNPCyDKRaZCytbRwsmhh0+cKFWKTvnZg2lDBTr2Sq9h3W
         p08X1wO7b5eb8UcsrhaadFBnCEUqU9A0ElCrFU172BUfCiXdZIGtU5kZmCYJdMwTKeYr
         /3YPjlw/mE8MAv5YxelZ1gmDrdKHo1PzVYKGxXdC9KAb2dS6IlXjmOsszihSnH2l4tCV
         vv8g==
X-Forwarded-Encrypted: i=1; AJvYcCWDUVw213+j2OSAViKHswMm98OIFb6beN3aGct+dQNiSrenLM9/QGdlldti7TCIxMPprB7PZuR7x7DTQecdChZrtg6jVT5Xv5csuDCkKlOrbehZH20o/b30ZUKwvW1kIm822SBVTqcz+A==
X-Gm-Message-State: AOJu0YwhkhvXNCUtf67DZQAuu/qna2xBq94xXTR2e0AhrxtaghrNLw9W
	uBqe6ZQlnuLC46YjkMpo+J5UVkoHJNrbvaTPPyRpCNey74uE1YcKw4x/yKK0k6/mCFEbTt07ZSU
	hhqcc5GdN0eMotgWeIhoYLg7vUf4=
X-Google-Smtp-Source: AGHT+IHpGq+phVFLaZeC26ocGsL8AfkiYJNn4F/EeswUoJ7ZVLBk5ozgifLr7/gd+vx88ceM9Ug0BVMVZvD8ij7037Y=
X-Received: by 2002:a17:906:4e97:b0:a3f:d71d:d820 with SMTP id
 v23-20020a1709064e9700b00a3fd71dd820mr1204331eju.26.1708699529198; Fri, 23
 Feb 2024 06:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
 <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>
 <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com>
 <CAHp75Veyvw75jc4LFpW2EQQ=wSYmn_VdsPBWVG03b+P0QvyGaQ@mail.gmail.com> <CAMuHMdX0CYWGn8OSQ3sXGyZTSqjTK5n1aj2-BOudfEejp980Tg@mail.gmail.com>
In-Reply-To: <CAMuHMdX0CYWGn8OSQ3sXGyZTSqjTK5n1aj2-BOudfEejp980Tg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 16:44:53 +0200
Message-ID: <CAHp75VeGiAWOFgOVjpOCHj0-CGgUYAuGEYmLomn4ydnSVv=_yA@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:01=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Fri, Feb 23, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Feb 23, 2024 at 9:52=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > Note that most larger displays are not individual LEDs, but matrices
> > > of LEDs. Do we want to drive/scan them from software, using a
> > > gpio-7seg-matrix driver?
> >
> > LED matrices are the displays (like tinyDRM is for).
>
> TinyDRM is for rectangular matrices.
>
> Multiple 7-segment displays are usually multiplexed using a matrix,
> using 7 (or 8) lines shared by the corresponding segments of all
> displays, and one common line per display.
> https://embedded-lab.com/blog/wp-content/uploads/2011/03/Lab11_Circuit_Se=
venSegmentMultiplexing.jpg

Yes, that's what I call "dynamic" approach (in my translated
terminology, I dunno the proper English one). With this in mind, you
can read my message(s) above where I referred to it.

--
With Best Regards,
Andy Shevchenko

