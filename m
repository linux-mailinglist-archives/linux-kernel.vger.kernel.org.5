Return-Path: <linux-kernel+bounces-20902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516C82872B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288011C2445F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B138FA8;
	Tue,  9 Jan 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiGfYHlC"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3C39863
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f68e2e1749so24531607b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704807208; x=1705412008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHZ0iBApQGJ/aySFQyXRT8jhOYwAfsQIE1adBR/kDRU=;
        b=RiGfYHlCEvWU51wHpuTWT17IQEeJR36/Nu7eYNExP5ns0gHsTYpTGdiFj1BIfE4+M+
         E3XsAFtHFLGXT+PdCVtdDJtEt7Xn2lUXOipoDX02bgQPHSsFy9fZnQGdr5CioxSUXFsW
         adjUWno+D7tpJ6Wz7PR+TixGpXobsZoU0m+Q8zHtJduxZerShcHDF6R5YPROIw1cJaVa
         HyL1jGnTwkklOvZ6u6jMFZj8bSAMfO1FlqHHsBfbC5C39hTNm1m45FkM3B5JXoK0NLJQ
         5wQBOi7tVWJI30C9IeSfYvnaSaqfuJCuPiyJ5tw2+lLNFGHFJkeeaXUiMgsZWuXveZQL
         pQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807208; x=1705412008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHZ0iBApQGJ/aySFQyXRT8jhOYwAfsQIE1adBR/kDRU=;
        b=YAiGvU+xZdDdEIqAoaoihnY+1XA2iS9Wzczb6wrY6xIUNomCWF4oUKOn/FXZyJgCuK
         oapo6JCG6sPSLwklajPKRGUsAYo0oWphOzebAghtVcpvDJKGgQoSAVqVpUw2q+3P2/ci
         ZZsh9TSM5+rIhKHD0q0arrEJcXz9lAFvuQqonBjxT9BEdzakICPBlmllQeG29YFYwOdU
         NJFQA/YhnQudSFoV080JezohvYBNH2YPk4fO9tfVNunGWgBQFLz0844/qVlfd5jziVcZ
         t9c5mQbKkHytXVPNqqA8bgdBe4Npufl8qth3gKG2mmI9Kcp48fSHrDwLIYsBwxSAKocD
         DCoQ==
X-Gm-Message-State: AOJu0YzWfSzf3XJSJCU0GegW2qW1y5xTA0Ra1WlL62RCU8hJYzvDCDSQ
	L9WgIFSnROv3SWqNaozm/wznBOaOurEIaEN/AdkoKIm81mKDsumjpPD//qEL7ok=
X-Google-Smtp-Source: AGHT+IF2kvCXH2qy10+fhnJEciTnWzgvRxRXt0CVFSiA4DlAEM3TuXGAlBq6gQ/t6xHZ8wfyN3WJqEYr3DY+lcBaGHE=
X-Received: by 2002:a81:5292:0:b0:5e8:c5a1:dec6 with SMTP id
 g140-20020a815292000000b005e8c5a1dec6mr2914526ywb.103.1704807207854; Tue, 09
 Jan 2024 05:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com> <3a17f36a-04bf-04f2-7a22-82b76977b325@quicinc.com>
In-Reply-To: <3a17f36a-04bf-04f2-7a22-82b76977b325@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 14:34:10 +0100
Message-ID: <CACRpkdbnj3W3k=snTx3iadHWU+RNv9GY4B3O4K0hu8TY+DrK=Q@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write function
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 2:24=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com>=
 wrote:
> On 1/9/2024 6:44 PM, Linus Walleij wrote:
> > On Mon, Jan 8, 2024 at 4:28=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.=
com> wrote:
> >
> >> It was realized by Srinivas K. that there is a need of
> >> read-modify-write scm exported function so that it can
> >> be used by multiple clients.
> >>
> >> Let's introduce qcom_scm_io_rmw() which masks out the bits
> >> and write the passed value to that bit-offset.
> > (...)
> >> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int=
 val)
> >> +{
> >> +       unsigned int old, new;
> >> +       int ret;
> >> +
> >> +       if (!__scm)
> >> +               return -EINVAL;
> >> +
> >> +       spin_lock(&__scm->lock);
> >> +       ret =3D qcom_scm_io_readl(addr, &old);
> >> +       if (ret)
> >> +               goto unlock;
> >> +
> >> +       new =3D (old & ~mask) | (val & mask);
> >> +
> >> +       ret =3D qcom_scm_io_writel(addr, new);
> >> +unlock:
> >> +       spin_unlock(&__scm->lock);
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> >
> > This looks a lot like you are starting to re-invent regmaps
> > regmap_update_bits().
> >
> > If you are starting to realize you need more and more of
> > regmap, why not use regmap and its functions?
>
> I think, this discussion has happened already ..
>
> https://lore.kernel.org/lkml/CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJ=
eC9SDQA@mail.gmail.com/

That discussion ended with:

[Bjorn]
> We'd still need qcom_scm_io_readl() and qcom_scm_io_writel() exported to
> implement the new custom regmap implementation - and the struct
> regmap_config needed in just pinctrl-msm alone would be larger than the
> one function it replaces.

When you add more and more accessors the premise starts to
change, and it becomes more and more of a reimplementation.

It may be time to actually fix this.

Yours,
Linus Walleij

