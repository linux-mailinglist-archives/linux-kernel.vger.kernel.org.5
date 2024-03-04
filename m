Return-Path: <linux-kernel+bounces-90671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED09870301
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE25C28A993
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EE3FB02;
	Mon,  4 Mar 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjvAJLQO"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3121EB2C;
	Mon,  4 Mar 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559665; cv=none; b=usMgvyog5+De3s9M7KqvXx4f5JhD7veNrsckU71UguD2UAl15VodnMk2qkLv0UdpC6EYEBWm0niL38dgzbhqahi5DRxy7YmTFPiQhNJhVVZUcYmOpxsVlW8TIo/jq+XIi0V1PZoeqPw2zar9pOlSv0ubhzGPJBz2Xq/xoLdOGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559665; c=relaxed/simple;
	bh=BQE9hFzI13IZRZo749AAQrUf4z+0QDBsfPu5T/4OTlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/99RKek9tk2KOAASfliFSNNr3ujohQ8C11ci74r7kHPagREc7gv0aoLZplncy4Drm83LZz8f2gyZgf53RBt0IYSaMUCN1rvEjzS4om7stPOXswx0Wh6AfcT2gUSc7Gn01v0Cm8kN17/0yO5Ka2S56Fp1HMXihb0VJoDu8Z44OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjvAJLQO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a128e202b6so831860eaf.2;
        Mon, 04 Mar 2024 05:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709559663; x=1710164463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/dHCpgDDmSuBOfKLpH4euKRiDvMD04w7x34y1sbbGY=;
        b=QjvAJLQOfdYN5YNyyJLVXsLMQIUBFGP8rfn0wUsSTTSneGSPT01RszcUqljGvwa0m9
         F1f3cfWF34w0xSU/KD4q5Uga+/Vt9W6lT5bhswikwSQytfV0BYc83AYzMFnxKHYUSX6I
         kiBlDcWT1kdRWRD628HSIIDFXBPv/4U7U6JSFQiLf8FEdC7ca6Ac5kefDWCboaXFIy4S
         mWhstasd9ElNjAWHEpLbmlqflgcE6FAQ65v48moGed2kZSwwozRqIYPkJ7nbMO94jrAb
         k1l7KHQE0e6NDoYCsvnd+YnxXFoBbSYk2sjE87yg4fJi/fZyeH2epjWNfecwb0CelN2/
         JcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559663; x=1710164463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/dHCpgDDmSuBOfKLpH4euKRiDvMD04w7x34y1sbbGY=;
        b=iB8bB2bCynPnq3I0lnt3tVsNsNtRut2Dha36GRJVNSyCnRrEhd5V4dqHhHK89Sjxn4
         A7u8zOJFGDUj8Bvg+C9A6DFkk0ysBmzow24R/AwbXMFthjwkLMmOcLE63IpOzYyycbHr
         8J9Jfw4YoIh9GhmrlhJrs7K3kL8F5zudfQqUtAQkzjjQW12TbcKIQKZwoIOvgIaCnzRe
         6P7RmyjroJxuPDShEG/n58YSjjeCJe+AycA/5t9Wf43g+j8O7B3nqp81PDtdYYLbWeKW
         aZyXwcvWzU1ZL9CnoMGU6p1+muKO/O4iylVvMNYlAdd0rEgmWmGVlxnWXuXAIZvcYfzc
         9Siw==
X-Forwarded-Encrypted: i=1; AJvYcCUo2RyTPFE9OMwEBCYMYM4ff3KGt6YiSIJTrsITVfC3bk3ZoJEtIZKsEYqvPLfg7/083suOmTOWZFED9m5An2+qNtRjjnEgby78TpisXg3Q8hdnwZFaS8AEQi+B/lc1xCJ91T+5WqljbPWt+m0Fx0DlpNVgABuOQ8qra/jk7miHWg0CGg==
X-Gm-Message-State: AOJu0YxxEZ/KPYJos06MzmluZFht1GHpccu8emUzucf68JSolRkFIr/7
	9O9DlkN72J3T6N1ut8AfNlXP6AB8mdYY8l17r/Pdur1PN4dZpxRBW4kIsoWZ/+HAHCuJtDkOA9e
	w9HhATh1O/9px7J+0U1Mk5D1F2cbdXziTR5vdYqJY
X-Google-Smtp-Source: AGHT+IGApFrYWTCxf7o+Xw3AU3j0mc3yLDQDYin1YtShfj5gmezRzs9SAsWTz6aEslad9W0wPmt7sBbXkXDMb2pSQo4=
X-Received: by 2002:a4a:2559:0:b0:5a1:15a2:114c with SMTP id
 v25-20020a4a2559000000b005a115a2114cmr4854461ooe.0.1709559663519; Mon, 04 Mar
 2024 05:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com> <91f0a339-ac0e-49df-bd26-dbfe1485308f@linaro.org>
In-Reply-To: <91f0a339-ac0e-49df-bd26-dbfe1485308f@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 4 Mar 2024 21:40:52 +0800
Message-ID: <CAJRtX8TPz_jTvPmuBW8t=mC+BR1kWmu=GS9K1k6ys7U9u0ENFw@mail.gmail.com>
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

On Mon, Mar 4, 2024 at 6:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/03/2024 10:02, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>
> ...
>
> > +
> > +     ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclus=
ive_put,
> > +                                    priv->clk);
> > +     if (ret) {
> > +             clk_rate_exclusive_put(priv->clk);
> > +             return ret;
>
> Please test this path - you have double put.
>

Thank you for your reply. You're right. If the
devm_add_action_or_reset()  function
fails to add an action, it will call the action.

By the way, if I need to resend the patch, should I wait for the
maintainer to review it, or
should I immediately correct this error and resend it.

Best regards,
Jingbao Qiu

