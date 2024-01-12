Return-Path: <linux-kernel+bounces-24381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC5E82BBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255D51F225E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE045D72A;
	Fri, 12 Jan 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY3Lh7uO"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F03D7C;
	Fri, 12 Jan 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-680f48ce344so12108636d6.0;
        Thu, 11 Jan 2024 23:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705044679; x=1705649479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzmJYQifp0tT8HMYxNeNkEtPO1O5pS2d3JZ6MMXiyEw=;
        b=IY3Lh7uOc/dMZEhAufI1uVfI7QxieDfcnJ3P9P5ksWIDqVvU7NBx33+VTolRoebLH3
         AhXUlm42txQtnznibN+00oQlsyqMHo/tw1+yvPtRRbZy72GQJ1wlQuYx1VmhDzv5ZWo6
         tTTRvRTqxt4c8av/aXEYWJkMR6xfei0v+ZoDLEvOyo3BwwAx+v8notIxKdxGPjjqTTKb
         IDLk876L8d7xjDfx0zixISJQoeN027SuiYeXUB+eaJ9pEM78a7jcdpxu5xbDCYFQqGtr
         iXqlf/BH9RGKKmp2aGVYdqS6hR3cyDD4Mid55Aj9Fz+Gx5zwWNLf0lPiW8N5KCXAJRiw
         8bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705044679; x=1705649479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzmJYQifp0tT8HMYxNeNkEtPO1O5pS2d3JZ6MMXiyEw=;
        b=gToEMxDNFW00bHt1uiQmCfIeFNjAi/BAVXQw6BAe4+IbgntZm+P7D+0/USU6ImZPa4
         qhGz5I2MHSpLwNaPopg8rr0icplzLRzCqDFp3YiEs38dXmNNiG2VFrmGqDhfOuab/cST
         RXbt7oUKz1Aa7wg4ZW0J889c6/D6Ln6Yui8yrrALox5gbPkKhGIgG60IAjfKT3JN7M19
         etlDlw/iyTeTvCwFA08zjqMFXfn4m83zBHvgZBgN1kdIi5JQlEhm/WS2JYiI2Hcw6zBp
         0vS7XTvrjuS3uyEMdgRqcWleAHbxOxgNIVHBANXqCbsmsic+gXkVXmCas7S4n9lxq/gE
         hCnw==
X-Gm-Message-State: AOJu0Yyy63Z37EAPBy7KdCrD1jmFqXGP5EmhInPW9PmImCn0Tx5e53x3
	fNsfEmPg5QCE6j6oaIyvR53fwRqdzuaheqvqBmY=
X-Google-Smtp-Source: AGHT+IEZYRtJV23LfZzikBGgRvQiIaymJwe9noiRvbJ1Sx4KzU7o8kxXfZX9iTngfrbE6cTAG+IAm1U3b2+OEdeyVak=
X-Received: by 2002:a05:6214:246d:b0:681:16ec:25e2 with SMTP id
 im13-20020a056214246d00b0068116ec25e2mr822887qvb.6.1705044678915; Thu, 11 Jan
 2024 23:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com>
 <efcb591e162ff0b04a9878f7250ab6ee6907f4a4.camel@mediatek.com>
In-Reply-To: <efcb591e162ff0b04a9878f7250ab6ee6907f4a4.camel@mediatek.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 12 Jan 2024 12:31:07 +0500
Message-ID: <CABXGCsPF6MbSOpfUBbT77Hnfc450kutsc8Fzr1O_O9bgtQ5PAw@mail.gmail.com>
Subject: Re: [BUG] Unloading mt7921e module cause use-after-free
To: =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:34=E2=80=AFAM Deren Wu (=E6=AD=A6=E5=BE=B7=E4=BB=
=81) <Deren.Wu@mediatek.com> wrote:
>
> Hi Mikhail,
>
> I can reproduce a similar problem when CONFI_DEBUG_SHIRQ is enabled.
>
> Pleaese try this patch in mainline kernel (6.7+)
> ---
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -387,6 +387,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
>         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev,
> mt76);
>
>         mt7921e_unregister_device(dev);
> +       set_bit(MT76_REMOVED, &mdev->phy.state);
>         devm_free_irq(&pdev->dev, pdev->irq, dev);
>         mt76_free_device(&dev->mt76);
>         pci_free_irq_vectors(pdev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> index 488326ce5ed4..3893dbe866fe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> @@ -12,6 +12,8 @@ irqreturn_t mt792x_irq_handler(int irq, void
> *dev_instance)
>  {
>         struct mt792x_dev *dev =3D dev_instance;
>
> +       if (test_bit(MT76_REMOVED, &dev->mt76.phy.state))
> +               return IRQ_NONE;
>         mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
>
>         if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
>
>

Thanks, this patch looks good to me.
Demonstration: https://youtu.be/nKnA2ftVoXw

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

