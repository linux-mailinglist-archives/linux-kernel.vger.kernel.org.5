Return-Path: <linux-kernel+bounces-161247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B58B4982
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4FD1C20B07
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D433D72;
	Sun, 28 Apr 2024 03:48:37 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80720ED
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276117; cv=none; b=eppiTahuIT3rOrR9Xheah1zz7z+F3y8FUTf/5roygFnZ2270Ic6yFrQwkVuOuwUJoByHPUz9a43eaJyycrVQnXMZZbcwUD5zXZSDsGcFBq8N9IvJGccNDsC5Sb3Ogk2Gfdku2JtuDlWRcF1pb0Pe9DVvEzwm6pTD/Xv9/pq4rRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276117; c=relaxed/simple;
	bh=T9aAS6gjprJFrjRsVKMX+gzE3b6ZZkshttqPSxfH9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=NQm8e6QJlo4OiMua8IJHc5TN4gp1Mf5F2m+/c3mI14xDdzEoP9PzzJaMfmpXVBBM7eln+6RUhPPAHa8QEIs0UnsTCPd4ogAb8wuidwiUDcnnMi655wxRBgr9Ub76GXG+aUeUBXwKdQ1wR2PiLE3w6mMPvlM5wLekVM/kljVLbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so41123681fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714276113; x=1714880913;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYPrh4DHdmH+zyt0A/i+XtVcAopST5l2VEcQ5Ak5hpQ=;
        b=Kikqw3wnElP+SHFgNhVeH6hG0QyxeBB0MbP9YXp7UupihkeJc4XwPJ//Ff62+O+za1
         atUP8SjPtXex9iII4UO3PGhXTxglmNHxvyGgwMXPtH2Bo37fGQOb1U2lU/vl4gdvJ57i
         7n8RN6J7JQ/oSQL/i+x6SOJDc+LwMycTuZ/4NlrgRgf1AI+/PBeuB8T4NBVkfhU8b3Ts
         tdbW7x1DH7wqeH74JKJXwzgIub6m8y7cXAMNcB1l80iQe6aDV7a1ywyH+G6EObY6qbmE
         w0u+EsKXgWuvNFHOEziVs4hxcuOn4fOhnzInWttfG0v6CeNWeLIl9SsV+tTH0hMOblzz
         9VnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQi4MGEAQ6KQ+mTN/Kg/Jc3kpLd2NY4kAERnVrU2kMF3n6P6S3OZ+FaR9Xlt7MXQ0myE1GRVDWHpqDEj7TGxMEpfVLnQ1EJkvHXe9M
X-Gm-Message-State: AOJu0YxkmAmbn+8dtcG4y5XuvPKRC6x7mWwoXexdeFqMg2fzTOfIilVl
	i8NX+yWrvBCuRaxrejBOsSWl8A97uOZxi6fRB5yDSATyTqCAftW+5/qSHGdQkp4=
X-Google-Smtp-Source: AGHT+IHQkeOcpvaKlCk9u++eaYx6mUXKIYvCfsI1CmlCgowO0+DVW4+4aUz6yScgaBDnjqQFtv+NuQ==
X-Received: by 2002:a2e:bc03:0:b0:2df:b8f5:2e66 with SMTP id b3-20020a2ebc03000000b002dfb8f52e66mr2348302ljf.15.1714276113054;
        Sat, 27 Apr 2024 20:48:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n8-20020a2e86c8000000b002e007c2d831sm162574ljj.9.2024.04.27.20.48.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:48:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51c077cfc09so3954702e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcvyrvllftk/ZN6z2sSK4vj6zYTAdi3NeQ+An3tHmPXD6TPiQ/uKf18DjxYrL2RFx5O+lKf76O/KW2GLU5UT7uoB+/eKU1icpsCR3Q
X-Received: by 2002:a19:7708:0:b0:51b:d3a2:9d85 with SMTP id
 s8-20020a197708000000b0051bd3a29d85mt3212758lfc.9.1714276112649; Sat, 27 Apr
 2024 20:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427051934.879051-1-iam@sung-woo.kim>
In-Reply-To: <20240427051934.879051-1-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sat, 27 Apr 2024 23:47:53 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJjRoJNUY25MrsAhxdsCVZJVu2AXcstO_t31_xtLWFGJw@mail.gmail.com>
Message-ID: <CAJNyHpJjRoJNUY25MrsAhxdsCVZJVu2AXcstO_t31_xtLWFGJw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Could you not apply this? I found an error.

On Sat, Apr 27, 2024 at 1:19=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> +
> +static struct msft_data *msft_data_hold_unless_zero(struct msft_data *ms=
ft)
> +{
> +       BT_DBG("msft %p orig refcnt %u", msft, kref_read(&msft->kref));

Here, msft could be NULL. &msft->kref causes a null-ptr-deref error.
I already sent a v2 patch fixing this.

> +
> +       if (!msft)
> +               return NULL;
> +
> +       if (!kref_get_unless_zero(&msft->kref))
> +               return NULL;
> +
> +       return msft;
> +}
> +

Thanks,
Sungwoo.

