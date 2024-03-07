Return-Path: <linux-kernel+bounces-95063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8468748CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2519B22DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B76310D;
	Thu,  7 Mar 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYQKIiDO"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D64A31;
	Thu,  7 Mar 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796992; cv=none; b=JyOLoWIphfhxtnh7VFbwPtwCr5U+sWXXiVQEJITQ4uWbHqeIwYGSmuIVKXTM7kwzTi/CPiUM5L545h2aEBfuRW1p4UhJ8tyyB+TG3JX6DU0ylMX66brJUBn2wE0E772iZ+/jt4r4GoPLaAc++2AB9sO+u5cQUv1Hi8dmVLe9A3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796992; c=relaxed/simple;
	bh=CfiPOgIw5CqjfHlPnyULJPM6C7OUXGgJs9wSJUmOooQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdJXogLE2hVjN4dqlbdznv5BIqGaPa2GsJ3XIwjIXS63tRhKxBfJPEy87Qmv8UYV7A4zlWgsXEQbsAv+610gStZ1kJo4B9P+vffA1XGTXOflUZYM7xq9F2MXtsIi9bwSAzBEL7u29L6s9rSUNU6O5n6nmVRNlWDmHdo2cP4oJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYQKIiDO; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c87474f4d7so17092439f.1;
        Wed, 06 Mar 2024 23:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709796989; x=1710401789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx8njYwzC6hGWbKta7FmPx/KT/8cp/eNI08VENesbJg=;
        b=hYQKIiDONfiuIzv41XzXsvGS44Ts/vGuxPPjQ7PaUaK8+sdiEeo9wa04wf0cVQWiGa
         BOYNaxGmbyNYUE88/TSKoHtJ+ua2e80gkuxJU9HLEKFTB/X3mIdJNoaUTQNwyxj9O6ab
         z250MZwJrip+c0oG+tsniOyaA0kSPdQ2BCdYCYhqToyKsowOPBx/mMWep7oTUJFdlzoy
         siQTnwi632QcAuVv60PMavX6ldE+BUd2gmmr4iOj/fWH7sk+AP0AK8xXdpPH6QRT8qRr
         p55ei9TFcrxIlDLMU3xN5Z2ULQ32vWZikJvIGuyXtimDt+q1uEmgjkYicklpYMa4hgJQ
         uGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709796989; x=1710401789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx8njYwzC6hGWbKta7FmPx/KT/8cp/eNI08VENesbJg=;
        b=SmWWv4dx4EWs8nObjvP5E2HD9B1foTPqXOk77ocBJNyLelHVNCSpR+Gzecu1PrRoAE
         YebTaI366zBeZ3rYisEHYyDH1b6D+dB62fbKNEEqnNDQVbFvMnCRNTeHo+1Iq1tynG/T
         3KxAUr44jKZ7bLlNY/UtHhbKNHTmtsoJYvIWfqGZ8+8E1jpak/XfPOjl673m6R2bDjRw
         mqZ6NQkXiUp2XzSoobQNnvMf34NQZSxbIQxmvXCLYToNkySxMx+eX+9MbfHUjlPKKLGw
         e3pWTRHNtUqEqhoi1h5x1I4mtt5BkRJy8SY/2tosp/W4R3F3foIEttJXmrpTLlSC2wgY
         idgA==
X-Forwarded-Encrypted: i=1; AJvYcCWLNiOaFeimd34MF8BRixV81qm1dI8en87FSBBp1Q8XbUdmR60s7KL15EcI3ofESThD/5lA7av4KSIkAbhsqkdMH9x2UKn6wD8klVfKpmiMNioAwy9/NvXBZ1eLRCBrk4FZDTzFwiqjo916sOVgAySUMFJ0KmIQO8BCbkcrnUTSP70aLICqVuH0SBG8DiL7exSdBovDoNCwXjwx9Y8pTlYR
X-Gm-Message-State: AOJu0YyW11MLQhO/xwpQcPUSvB9If6vwIT2ym7ET2eSAUx5H35KkkUra
	jG3UJOTct3sMx8IUHC0aXps/TcAQqB09QPNxKx0ReRqYqZwIEhcRtyZLKy1tYVCgIXEsBP0jKrT
	ZTok+0PS5vqey5rrl/LVOzPY7Z9Q=
X-Google-Smtp-Source: AGHT+IEWCigYTV+saptQ4gGC4reoPMGeVcdmhGVWHJ86cLwUCk4dX5rt3k+tEVetuW7boDKccRowap5dbDW36xA7qMQ=
X-Received: by 2002:a05:6602:8cc:b0:7c8:60c5:cb14 with SMTP id
 h12-20020a05660208cc00b007c860c5cb14mr9300580ioz.13.1709796989544; Wed, 06
 Mar 2024 23:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net> <cffada5e-0f7a-415f-9c4b-7c46fac5cd3a@hatter.bewilderbeest.net>
In-Reply-To: <cffada5e-0f7a-415f-9c4b-7c46fac5cd3a@hatter.bewilderbeest.net>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 7 Mar 2024 15:36:16 +0800
Message-ID: <CALz278ad+c6=BCrmHW9GfC3WkkOyhyvoR0xYxmi=_awUmjhdqw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
To: Zev Weiss <zev@bewilderbeest.net>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zev,

On Tue, Mar 5, 2024 at 8:28=E2=80=AFAM Zev Weiss <zev@bewilderbeest.net> wr=
ote:
>
> On Sat, Mar 02, 2024 at 12:19:07AM PST, Zev Weiss wrote:
> >On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
>
> <snip>
>
> >
> >>+
> >>+     fanin_cnt =3D of_property_count_u8_elems(child, "tach-ch");
> >>+     if (fanin_cnt < 1)
> >
> >fanin_cnt < 1 || fanin_cnt >=3D NCT7363_PWM_COUNT
> >
>
> Er, off by one -- just '>' rather than '>=3D' there I realize now.

ok, fix in v5

Thanks,
Ban

>
>
> Zev
>

