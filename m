Return-Path: <linux-kernel+bounces-91510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEB871273
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F9A1C22513
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFF17C96;
	Tue,  5 Mar 2024 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHytnR/S"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE695CBD;
	Tue,  5 Mar 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603205; cv=none; b=qEPSQqJ/LGyPQ7Dx+726zqEer1GgTaYAMx2hHq/KuMrvZMSu7d2eBNTpI18AZecIaWV44ysTj7y6aTWkFFtgLdVkW7h+NWFS1YauEesvy9iwTxjJsW/Ndf+CSzPE0VxZnCk5xtKOsnyc/Z3Xj+JqVg7rHj++8SbEbz4nzI0pMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603205; c=relaxed/simple;
	bh=1p7Y20rG3es8GL/mNZQxWlYBE8AuqWodXoKq37e4R88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moKJhC98KqR0d8s0XBtcNaEgNwS6an88ApMIilDTUJykwt6ovnn64Lx1O0GKszAWDseTvzKg/BThrlcQ4OGE99S/JX36FiZNuG0nW9zAtrU0HjxiJXYS//8Ai+tktOyxxVwFvYG8EQwhmqCO3hUX4WxP3/+A0iR0qAomc7oCgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHytnR/S; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4e9f8539bso599722a34.2;
        Mon, 04 Mar 2024 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709603203; x=1710208003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q8XfC8X0sSBGJM5X8fKplgHHh/I1jIORCkIdpaZ79U=;
        b=YHytnR/SATwwbLrCgD+T1w4cdTWUdHimeqTJb0KZVYTLeHfuxw/2kWdmDVn1V3qgDa
         pRSddGSL7D8t6iRpnTizxTx6TYGDVaOsO6M7WihJ8gsiG6JkvmHdlUYj+s6LRulL4vfL
         svVwEcaCIwPPTICYyjTaWQdZU/egH7qpd6OZ0SFNk0tEhtRpW6YEEXH1905UHvMkxx5a
         MHWGzqWWBSDCFpg2BfJ70lMSQZxfjvnNgRvTSOBfsyIPMOKrXeTYhztnB54BcxljvNYt
         YCaJbctjisuJLwFx9Jgh/SKNv2kcNJ1t64T2nbbptHNsPow8Y1EUoUbUxBniG1MDl9Qx
         VqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709603203; x=1710208003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q8XfC8X0sSBGJM5X8fKplgHHh/I1jIORCkIdpaZ79U=;
        b=kPjtB8/yR4/oZbD22FBbXkBOz3uWuqUg+E8SjqxekADtg5OTK+h+tV/xFqXRU5mu2H
         nptkJd8/PDIWre0Ip1ryUkqWJAfgbklkU8rdSSMrAGRW9SZpTW01J49hPGSzoQFR/Lxy
         W5TXh6JwOpqI2umbyTnXrh4Xt+Xqya6JsCXJAi/EGAxlQpItSi29/ymkcuKAzKU5+Srg
         m1t7OgbfqW2t1uLM49rpuscq+AA03DVvTvwt5SJp9q3VxMShu+Rpl8T6OicFYQtU9UEm
         9QPZ+raPFY3NZEgGDaQgDpGgtdKUmsnJIvngdz3Urh7kRG2mlhImPhr34ouaUJd4gHP6
         Fodg==
X-Forwarded-Encrypted: i=1; AJvYcCW1lP0/rVwiBGi2+aNzNRKKvGuNQXGFQQTMb5kOx0v7unF0dC76E1Ks7YkNwYz0jK24FFihzC/CAKmDYXpU9XnVTl4qnHavZdJGTdVxBbvZK8c/RvdwxXApKk0zjhwTjE1iLfKI/ZNwsItD7whcVMhEOb8zgpLE0Wt9U0zMTiqjoOHaGQ==
X-Gm-Message-State: AOJu0Yx+3jANnG/VZmUrQYK6SzzpBLN1bqpB89NKxHgRM91KCyG/68r2
	wWAcl1ytRUXp9YT99n+0yDJzMjgIu1DtZaiYb55RxF6QO0bK3co3yL4gCAHcSmXgCK9+mFmy/8A
	EcIMGdjuXn6ENxkPgwDHvZVuwR4U=
X-Google-Smtp-Source: AGHT+IFTj1MPlCHGWTdjZLDUdn/iWQfX/NaKINyMcQIMj2NwGyAsVchqCPjJu8IIopxsRzD2KEj4wTNPbDXiBH20iu8=
X-Received: by 2002:a05:6871:5b28:b0:220:a23c:6786 with SMTP id
 op40-20020a0568715b2800b00220a23c6786mr475843oac.11.1709603203177; Mon, 04
 Mar 2024 17:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com> <91f0a339-ac0e-49df-bd26-dbfe1485308f@linaro.org>
 <CAJRtX8TPz_jTvPmuBW8t=mC+BR1kWmu=GS9K1k6ys7U9u0ENFw@mail.gmail.com> <0c957a95-9f82-41c2-8e2c-0b5bf4b061a4@linaro.org>
In-Reply-To: <0c957a95-9f82-41c2-8e2c-0b5bf4b061a4@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 5 Mar 2024 09:46:32 +0800
Message-ID: <CAJRtX8R-j6BfJC6We0Xh1e0sYe6_CyUjbznf7e-kNmcF0=Bcjw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:02=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/03/2024 14:40, Jingbao Qiu wrote:
> > On Mon, Mar 4, 2024 at 6:15=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 04/03/2024 10:02, Jingbao Qiu wrote:
> >>> Implement the PWM driver for CV1800.
> >>>
> >>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>
> >> ...
> >>
> >>> +
> >>> +     ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_excl=
usive_put,
> >>> +                                    priv->clk);
> >>> +     if (ret) {
> >>> +             clk_rate_exclusive_put(priv->clk);
> >>> +             return ret;
> >>
> >> Please test this path - you have double put.
> >>
> >
> > Thank you for your reply. You're right. If the
> > devm_add_action_or_reset()  function
> > fails to add an action, it will call the action.
> >
> > By the way, if I need to resend the patch, should I wait for the
> > maintainer to review it, or
> > should I immediately correct this error and resend it.
>
> I recommend one patchset per day.
>

Thank you for your suggestion.

Best regards,
Jingbao Qiu

