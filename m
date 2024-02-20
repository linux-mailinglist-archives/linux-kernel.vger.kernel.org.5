Return-Path: <linux-kernel+bounces-72466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE185B3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C21B243F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A85B202;
	Tue, 20 Feb 2024 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH3b3Cjs"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F525B1F6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413846; cv=none; b=HF4pfan2LyN9sby0eGJ4e1ZPeaWe3ZTvvYUXHcKYP7Kgh6DvldW1Od9Imvmr990OIPrYBTZthVVzlHmMHYs+zKWS4X91yicB2CS2+OfxCpYIrjIxbPMhpFjhcaKjIjoe+ehq+EfIDxgw6h81dvs5W20a4KI4pRhJyvkboCyPTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413846; c=relaxed/simple;
	bh=qicImOJ+93+7ipaXfqBV3tHxv+ind/fFoWYhUjfLDqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCGYX90wxe7i3Mb71uuSfvqUXSeYncWR234njw88ajQgQ2bkuU2izhr/TuztaAXpWxsi9Z+PvRqV3YNlcOAWIvBgQfLjEFhFuGesdZD52ZFKld96/ar7qFrUmcWRuF/kDu8tnklN6P9fWe22bWUS1D78hdEhiTfCKGAoq7/5oBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH3b3Cjs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so3820287a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708413844; x=1709018644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg3AWDP/6gw5LIlouNG2JDqC4XWqXexOKTTcNONe2tQ=;
        b=bH3b3CjscXlDj99hWiYFqqlI6ix0iF88Rh1MBOQUnbSPJdjSoK4RdppWAPEay2cRjH
         Grzf9bmJhIgBD8MB/bnwJx0mbI0ppF8QkwEb4yAVsaPghq74EMyQqv7TxvEUw1yXPC3J
         +1Wjlxo+F+1ddLjU0k96uY5REGGgep/he2Zdhxu/FToF8UcHYwa0SphHxSpKIDf50X6v
         yNuTbD9hYGXyHBqrLGck5wYbm3+OJwBO/t98c/UfMyY8HP23wGxtVhn3xyxWFxilHIFY
         gaTBwcfL1q2Ax7GT/YFLWfbIJSnT/IlRVuZASqY+BelTGAAB6Id2DJiagSLdX0VCeK1x
         tgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413844; x=1709018644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg3AWDP/6gw5LIlouNG2JDqC4XWqXexOKTTcNONe2tQ=;
        b=ALfcuisxNbW8zxjHB8nOvOfPlSxzq9qoEtLtxprnkOL8ScoBmWaAB9stTfBFEWac75
         2+h0r5WzA7GJaFQxNOWbAU0L4oyPdyXDcNAeJxd0PaFj5a424ZmF5NxSiY/gmc2QK8JF
         hiDZdZgXgE7vYXb8TN0aFGnowAVlBR10Uh/iIu0CkyHQJxqKNeTDwn+pC08WuUfZh2MZ
         ajJDGcz6MqeU5+g7T5k16PqrzGknk/5aOYr50tVRa+4sHMLzba6otXljyi7zVxj968cV
         6ohvkS5FXZe8/9thHpaMrtr27ELESclhjtOgOMF3kwyzk+eM1Xz6AuSfLBgHywvFSsr5
         1ncw==
X-Forwarded-Encrypted: i=1; AJvYcCXybzC9Lp+gBPDyoHyPt4kQ34ynr1++AwQK45Da9cPu27MoBvtwjlC6xbJo3GKZbWdy3cfD8i/YzhR0tIVbESlKCCI+hx4mhX7RSl17
X-Gm-Message-State: AOJu0YzATRNvIQG9bsbQ3YpHf94inHesXVPD8YcSVNP8bGauex37QNkn
	LhnDWqHxNGDWEg4zVFcj+KkVe2hLubgFdcxu+YzO9dxGLNKHfFPUSjcTM5rP2pw79O/myvB0nmH
	OzO6L8JKiEpiGpIC7PYqUaVgqfAA=
X-Google-Smtp-Source: AGHT+IEO4pgfyv8sIu7hPQhpfArLrmFTOVJJVpBVrvJ6BikZC+2evWXAuQcp4Zoz8BXRnR7sMHU9Lo9GKhMD4WyJUbY=
X-Received: by 2002:a17:90a:ca84:b0:299:4f75:150e with SMTP id
 y4-20020a17090aca8400b002994f75150emr5296615pjt.47.1708413844674; Mon, 19 Feb
 2024 23:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <20240216180559.208276-14-tj@kernel.org>
In-Reply-To: <20240216180559.208276-14-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 20 Feb 2024 15:23:53 +0800
Message-ID: <CAJhGHyBHsu_o02eZ4HWHhuFVXtVUR-sH_W8gFXw7QbLOBm+k+g@mail.gmail.com>
Subject: Re: [PATCH 13/17] workqueue: Remove WORK_OFFQ_CANCELING
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Sat, Feb 17, 2024 at 2:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -2631,19 +2567,13 @@ bool mod_delayed_work_on(int cpu, struct workqueu=
e_struct *wq,
>                          struct delayed_work *dwork, unsigned long delay)
>  {
>         unsigned long irq_flags;
> -       int ret;
> +       bool ret;
>
> -       do {
> -               ret =3D try_to_grab_pending(&dwork->work, WORK_CANCEL_DEL=
AYED,
> -                                         &irq_flags);
> -       } while (unlikely(ret =3D=3D -EAGAIN));
> +       ret =3D work_grab_pending(&dwork->work, WORK_CANCEL_DELAYED, &irq=
_flags);
>
> -       if (likely(ret >=3D 0)) {
> -               __queue_delayed_work(cpu, wq, dwork, delay);
> -               local_irq_restore(irq_flags);
> -       }
> +       __queue_delayed_work(cpu, wq, dwork, delay);

The disable count has to be checked before queuing it.

Thanks
Lai

>
> -       /* -ENOENT from try_to_grab_pending() becomes %true */
> +       local_irq_restore(irq_flags);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(mod_delayed_work_on);

