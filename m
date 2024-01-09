Return-Path: <linux-kernel+bounces-20882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953C8286E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C341C242B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0B38F94;
	Tue,  9 Jan 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzk0/EZl"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BDE381DB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbed4b03b48so1916431276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704806051; x=1705410851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGNYUtkWCOHBwunZC8iFn5R0Y2IJiR1ajiXmbfXxPkQ=;
        b=Pzk0/EZlwGnNBSSrLAPlV8RiybYaAbwRR4MbrCzz4x0xtGy2qm+bELykfWMm5ZUWu7
         XhYqkdWrfi/LMdSvq/tlVdN6pGrtgqLCSGFMSiUmLOr1G9DVDKzY778bV56UIKt1lEpq
         AXz80OCO8JID4uGSoPgkcNQPcpvS6GoF93iQuTOa2f4YQuEvu2Yl09ZRB8X6VOagn2vh
         U9C8KPZWChyEVAhrVoQUdAjRshvVp9WIkYzuKWTB7mNSOfaQ7R8HrPVGQMQmvhgClfbY
         A8FSDHJ6IffILcUTYTtEJeg0Py+SpTxXOWXyFNWd8yKc/w2U1MZgxzFziGxZQSyc0JWF
         zPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806051; x=1705410851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGNYUtkWCOHBwunZC8iFn5R0Y2IJiR1ajiXmbfXxPkQ=;
        b=WqWMvozrDAeC6g1TmSwqlxw6Uf156SHaGyTcX6lc7O1jHXUYZbK091gkB/grp3D4Qo
         Kz5+bVCGIXTVFsrsRLQVgzzL9EwJUhQs8tpkxJhOJnmbZQ7H6QCvLYaD+moQ9cq5GVYD
         h5+yzNTZG/am43sd6PM9gqJ2tRScRhOG2RfnAsWZjpCoh49ugpow4xVUVWPgnZP7qz80
         i2k/SFl9ReWBpE3CZI3v7CFFWm/La71Qxdtqs/CZqcsPjU6Vk6w5q+jwK3ukBVK9y4Qy
         LVbOnr8PQxhE+oE6RW/SU2emBxe45AmcgKeC8lbmEAn5bWKLiybplNlFphQ/Scs9Xk/o
         do4w==
X-Gm-Message-State: AOJu0Yzx5ZLdFNJUwL0Dausu5vSATR536GW1daU25CPx0Enx3VAIHtYr
	XklGPPKQa/wzOBw88aUlEgTGp9+hzqFHaqhi2ia/5YE8JD9bvA==
X-Google-Smtp-Source: AGHT+IHsbVD35ExweMRy9H9/B4dnvvtmkdZS6RAn7knlf+5eytNoStpDHZb49dxcVSsZ5HWGfc2jk5p1T+bUQ5P/joY=
X-Received: by 2002:a5b:181:0:b0:dbc:afb0:5b0 with SMTP id r1-20020a5b0181000000b00dbcafb005b0mr2822352ybl.1.1704806051145;
 Tue, 09 Jan 2024 05:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com> <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 14:14:00 +0100
Message-ID: <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write function
To: Mukesh Ojha <quic_mojha@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:28=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com>=
 wrote:

> It was realized by Srinivas K. that there is a need of
> read-modify-write scm exported function so that it can
> be used by multiple clients.
>
> Let's introduce qcom_scm_io_rmw() which masks out the bits
> and write the passed value to that bit-offset.
(...)
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int va=
l)
> +{
> +       unsigned int old, new;
> +       int ret;
> +
> +       if (!__scm)
> +               return -EINVAL;
> +
> +       spin_lock(&__scm->lock);
> +       ret =3D qcom_scm_io_readl(addr, &old);
> +       if (ret)
> +               goto unlock;
> +
> +       new =3D (old & ~mask) | (val & mask);
> +
> +       ret =3D qcom_scm_io_writel(addr, new);
> +unlock:
> +       spin_unlock(&__scm->lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);

This looks a lot like you are starting to re-invent regmaps
regmap_update_bits().

If you are starting to realize you need more and more of
regmap, why not use regmap and its functions?

Yours,
Linus Walleij

