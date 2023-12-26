Return-Path: <linux-kernel+bounces-11433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E3281E635
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033B31C21DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71034CE14;
	Tue, 26 Dec 2023 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeE+81tO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEF4CE09
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so1534703a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703581987; x=1704186787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD5iK0F1iadCeZ+DhemgQrO1IM36iKgwfZ0udGFoLoc=;
        b=IeE+81tOJAXZQhTdPWzk++po3nJuGIam5/eeImhtyxclYsrs7NOj2tSm5vNOB6wh0b
         WV/BPPvboHICjgIDQ6D4r+ldET+9D6tBeim/ArX7GvKksHIxKjAGWB3YzlzmhzsOmz+y
         OsHA9NOCAXSp+zB/lYd4gP5yHVU9m1D9823Qj5kJ2NN4BYhmQUCkgplYYMAoixE2lk8M
         SPKEDGyQPrlptroaEMZPBobOlE5DyrxBmtBmgUW+lu7XMuKJ3FaUfF3LV4OpPmfLH2Wl
         H467u03H9M5KB0CshYu95mYYOn8xBu8q6pb/ciYXB2MSLqgj+YZdSVbX1o1uXMw1F9dL
         DQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581987; x=1704186787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD5iK0F1iadCeZ+DhemgQrO1IM36iKgwfZ0udGFoLoc=;
        b=bshO24K4mgqPy9qJsUVneUVza6nQUJRPCBbioHrKSwSYBkkMeAwfv5FHD2l9VVOd/I
         wyxKni9yWrJVWyvIS/bQ2Fipxod5AVIj3zlz5kal5cuoQ8drdthRmZWuKUGYoyM6VZ64
         gGKlQFjeEB045poNibBGNQYYeUXdi5wF21aW/GJRhWbPmSmfZiz4WY5Pz4oanjFNDJrP
         AeqEq3za+E7ML5KsgBehkXkOC1bqRKHnBqbK+JSLMxAsLFXzphuQ/nKYqhYvlV44Hlfz
         EE08AOBIw0tRa9sUnssPwVE14VGecSSPw+GwO+X5zKF3oNaDH1/tzZa7FzaBcrvh0MgV
         /xgA==
X-Gm-Message-State: AOJu0Yz2y1mPGB+6My9yB81UWl51tkxi9qf40iB+edo/LGywmVvelgSi
	WtuJ8AVG/bBcI/W4punhRZRzx80R3FINYVreAfuMIQtb
X-Google-Smtp-Source: AGHT+IHE5Nu1aJXsQOkL5IJUN/bUPiypBm80WjKb7XaFbAVTm3N6VCJ+mOf+NYGs25kqAiU+aSbPnlmU7JNgW+sQIwQ=
X-Received: by 2002:a17:90b:2388:b0:28c:687c:299 with SMTP id
 mr8-20020a17090b238800b0028c687c0299mr257230pjb.71.1703581987271; Tue, 26 Dec
 2023 01:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220072529.1036099-1-tj@kernel.org> <20231220072529.1036099-5-tj@kernel.org>
In-Reply-To: <20231220072529.1036099-5-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 26 Dec 2023 17:12:55 +0800
Message-ID: <CAJhGHyC4Qj7t=Emd65556r_g0fUbf9LWEA-1OKuwaDFTz8O50g@mail.gmail.com>
Subject: Re: [PATCH 04/10] workqueue: Move nr_active handling into helpers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:

> +static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
>  {
> -       struct work_struct *work =3D list_first_entry(&pwq->inactive_work=
s,
> -                                                   struct work_struct, e=
ntry);
> +       struct workqueue_struct *wq =3D pwq->wq;
> +       struct worker_pool *pool =3D pwq->pool;
> +       bool obtained;
>
> -       pwq_activate_work(pwq, work);
> +       lockdep_assert_held(&pool->lock);
> +
> +       obtained =3D pwq->nr_active < wq->max_active;

It is better to use READ_ONCE(wq->max_active) here in case
the compiler issues code to calculate "obtained" multi-time.

Theoretically, READ_ONCE(wq->max_active) is recommended
from the patch1 in pwq_dec_nr_in_flight() and __queue_work()
since there is no wq->mutex for them.


> +
> +       if (obtained)
> +               pwq->nr_active++;
> +       return obtained;
> +}
> +

