Return-Path: <linux-kernel+bounces-166598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97918B9CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129BD1C22E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033615533A;
	Thu,  2 May 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyLRx1uQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30015530B;
	Thu,  2 May 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661310; cv=none; b=HXkYM3Fb1EnbdkjMkrv4hkD+NjjHYyInTr8JhlHdW+b5bGV65PFY0D/3y8cCxAyDGgzc+a4FDiFVlnaY67wr4im3ZxmOlC7W3mwuUXqXc4Lmjzmj1qFRyXVIVU4VCCJYmzjcpppLbrQ6TUmKZ94D7ZLssGZitGWEb+tJ7hLTjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661310; c=relaxed/simple;
	bh=WuCgS0uaAm6OhtaFz1/h+RBpaEGJPr7XNl603FLh+Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3zFGKJAQ/b31diAADXV2s229b2TqNjE0NARTkyfzgGZ4PXiZfKgC/7gkCVlDkBD+z1l+n876YivC7aJEP/J3hO5KWXa/mB6afo382gi724xrjdJFScwKlEvevDJg/vILv7XXg77DwUp42U2908ysvRB1uZSzt7nOla4Df+agx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyLRx1uQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db101c11beso95769471fa.0;
        Thu, 02 May 2024 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714661306; x=1715266106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRjQPMEh9WYGuv2fVT2hmCP4q9X4vdYRgmB1ohryHYo=;
        b=SyLRx1uQd7eY20cD8qV1uY2992vTzMZZV/U1vYJl7nObpfEwtU3+rZ6rYHPWv5wOzr
         mNZfsPoo2pGKzBTXDetB0jDLfpUsqXVU1U8xq8WZyrjLShXyAmArcijlfsX2gaz3uEVN
         ayxauIJbyD1kubv8AUyq5K0TTbMNjFfAEhRTM34LOJNBEue7Qx1XwQ4bSC7JyVKMdczg
         a5dODbl66F5QUKBVG1SFCNC2R43iHQcoqzMgJbDCJpAdcEY2eIrDsYQUj4gF6l39mh9T
         VDkGs5XlecOBchtuLNR2CYls46qtnwuiPbXhOAPUfOceUeL0klTNxyTFDDuVQsouVU2f
         nfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661306; x=1715266106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRjQPMEh9WYGuv2fVT2hmCP4q9X4vdYRgmB1ohryHYo=;
        b=ogDWdMqKpoAcceOt2ySeuAwoBBMIPvL9SPYzGKedaZd918XSKMyAV1+bjyKcM0Jq4G
         np2w8Hm/CuQOcCo0QB9oq8jnZfbbSDk2dlfAQjSwnrs//wYX1d+mXhhm6kpWx12fUPLV
         /4CpgEyTTGvX3vcBHrVlmg10A+hyAnWZUlzii+jinsFtTa/7eJW929cdfNGglOcEzzn6
         EYCgeFiJvXwkXSUn51jUxGxf7c/LZxcvY+ShZb4/Hzkw3nFnKkFhrYHoQxfsDprBcyXT
         ilTpAUqAOwyNqAgVAcHOmfyTOxi419ripUUaCmW1WeV8TFI/uf6gQ+FEGnigRfYyCN84
         NAWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6CxGyevpD7qHoC+yPz4FMdBkKzNV6nSnJIsiH0cPzC4Ag+igp2MuWrNKTRyxe+HiH28Oyw10Wv3q1qFdQWrWUXmZTamj8sHr+fOGhKWUZ9JL8zqwFg52Zjk3BHUJVXUU7Sg0YbKOMLl3jo8Ad
X-Gm-Message-State: AOJu0Yz0bAFWKGPBiLToiAPlhaT0rEbxqnZwDpvNRjFJbhkxLvXlpmwF
	VDw6sLTqC98Y9Ic4nV/YJ5bpq2P4Rim5ruQ2Voh8HYP3T68m/rU+/ik/ie5zeokdeCDkP4aOqBT
	l2N5HcOO63CviBHlGx2H5wF/K1Zo=
X-Google-Smtp-Source: AGHT+IHu2QZ1yiLfYZodwW0GkWrjqAImhZMRUrIKw9IQfzDfzrdFM0MfsLMCBX10rXhUUNA/YgOG7wqWK1uhCcns7+g=
X-Received: by 2002:a05:651c:235:b0:2d8:59cb:89ef with SMTP id
 z21-20020a05651c023500b002d859cb89efmr3213273ljn.24.1714661306186; Thu, 02
 May 2024 07:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502021709.141220-1-iam@sung-woo.kim>
In-Reply-To: <20240502021709.141220-1-iam@sung-woo.kim>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 May 2024 10:48:13 -0400
Message-ID: <CABBYNZLcfQ-sQ8+=5hebVsXC9qZp+Akq-V4SY0hL4FukfwEaQw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Fix potential null-ptr-deref
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Wed, May 1, 2024 at 10:22=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> Dear all,

Not sure if you are following what I actually enter as patch
description, that normally doesn't include things like Dear all, etc.

> hci_le_big_sync_established_evt() has a potential null-ptr-deref bug.
>
> hci_le_big_sync_established_evt()
>   bis =3D hci_conn_hash_lookup_handle(hdev, handle);
>   if (!bis)
>     bis =3D hci_conn_add() <- could fail
>   /* ... */
>   bis =3D hci_conn_hash_lookup_handle(hdev, handle);
>   set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags); <- null-ptr-deref
>
> There is a missing check after hci_conn_hash_lookup_handle(), which can
> return NULL. Especially, if a prior hci_conn_add() fails than
> hci_conn_hash_lookup_handle() will return NULL.
>
> This patch fixes this by adding a check.

Nor the one below.

> Thanks,
> Sungwoo.

And by now I'd expect you to start adding the Fixes tag as well.

> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/hci_event.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4a27e4a17..d72d238c1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7037,6 +7037,8 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>                         u16 handle =3D le16_to_cpu(ev->bis[i]);
>
>                         bis =3D hci_conn_hash_lookup_handle(hdev, handle)=
;
> +                       if (!bis)
> +                               continue;
>
>                         set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
>                         hci_connect_cfm(bis, ev->status);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

