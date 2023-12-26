Return-Path: <linux-kernel+bounces-11435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB681E639
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56494B218D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7804D10F;
	Tue, 26 Dec 2023 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8FZaENN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C24D109
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so2110772b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703582069; x=1704186869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqdNpUYpWfyG41yoNqreJFCO9R22bzGQt+dCXZqFMSE=;
        b=d8FZaENNstOG/1yOK9cPPf0Q0WWiEooVIkcuWS0Jyc68vqYdPufhKKnYpPNdoKA/WW
         fznjMgHmDVoVg5GfXynsk63n7HdyieFQ7IHDpC55du1zr+DnLhW1SZw8vYk5AEY2f3Vz
         bkjY7bXAYa2AKv+6vcBctN2MMQ4hSMukUdk4OBcLEvzeCe7Px0OQmvy2URYtzrH4YSzF
         UXwI4tzVcYSrH/w1sQVdTy4ti82geXICNHlPTaLiLr0smKDUdgQvskPDe9Rco2ClW2Mp
         Q2J7NjHi+3e4CEk5wcg9FXFsmbEoj8CV/SYNe3s3jKLrhl6RZcd98SOTFuhKO24/h821
         YfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703582069; x=1704186869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqdNpUYpWfyG41yoNqreJFCO9R22bzGQt+dCXZqFMSE=;
        b=qf1i0I0o/hrrkQIPY1xGhxhhdBDSjOEW6FS0ZlNlAtVfeXY7nDUUi5AzoZM1bIOvL+
         +fxpNYXTxoI0mkzn2+agj2KDf9DMj69kcb2xZ+lue0XVKXMV18Z+rUOiaOYCkd9x6Jdi
         xHtJyVTSrsMVEx8zkfm4k/xXcxnHmejvB+j6Z6x33rm2zCScBUa+NApn4wetk0jCD2v7
         hGDTV3wkzcJQXxunneg+r+5/l/hB3I7ytCFXlxddb/wXoPdQM0XKWl4Pirlq5t9b1Dyl
         3MSXdThJUFpWccsdgN6p/zFWSY2NTDmjbaL7Vp6jSKdX4Kupi+dANG1CFgskLKCRObCP
         OZmA==
X-Gm-Message-State: AOJu0YzQPHNC0emSXw7PMtJqG69vEq9CaNpTfoSz+EWMthl71K+WSNUb
	xoU7nV8Lu5uA47iOvO4IEKfjgj/c+TBrQUX3evg=
X-Google-Smtp-Source: AGHT+IEVz4PUi+nalNDwcuPNoKbvgCp/JlvgutfRWGeBiEc0K+ijPr9LaqpFDCSQ62reZZ7cAxaRmv5XNLciBXVstec=
X-Received: by 2002:a62:b41a:0:b0:6d9:c090:f836 with SMTP id
 h26-20020a62b41a000000b006d9c090f836mr1896458pfn.50.1703582069590; Tue, 26
 Dec 2023 01:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220072529.1036099-1-tj@kernel.org> <20231220072529.1036099-9-tj@kernel.org>
In-Reply-To: <20231220072529.1036099-9-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 26 Dec 2023 17:14:18 +0800
Message-ID: <CAJhGHyC_9JemZdv4Gp4XG7BqLc72bS1uM8xv9vpQtSsyhefZvQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] workqueue: Introduce struct wq_node_nr_active
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:26=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:

> @@ -1498,12 +1539,21 @@ static bool pwq_tryinc_nr_active(struct pool_work=
queue *pwq)
>  {
>         struct workqueue_struct *wq =3D pwq->wq;
>         struct worker_pool *pool =3D pwq->pool;
> -       bool obtained;
> +       struct wq_node_nr_active *nna =3D wq_node_nr_active(wq, pool->nod=
e);
> +       bool obtained =3D false;
>
>         lockdep_assert_held(&pool->lock);
>
> -       obtained =3D pwq->nr_active < wq->max_active;
> +       if (!nna) {
> +               /* per-cpu workqueue, pwq->nr_active is sufficient */
> +               obtained =3D pwq->nr_active < wq->max_active;
> +               goto out;
> +       }

For unbound workqueue, it is not checked against wq->max_active anymore
and it is increased unconditionally.  Is it by design?


> +
> +       atomic_inc(&nna->count);
> +       obtained =3D true;
>
> +out:
>         if (obtained)
>                 pwq->nr_active++;
>         return obtained;

