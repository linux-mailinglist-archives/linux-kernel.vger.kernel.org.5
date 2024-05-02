Return-Path: <linux-kernel+bounces-165965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C98B93EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB6CB228F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BBE1CA82;
	Thu,  2 May 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nsiYtqnN"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8931CA9E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624781; cv=none; b=poEjkYZsDqZKGElvzoa3W4FVDpWYh/SJxxChh3i3S/ZoiLBv8KHrzdvHmT13XMC4/dwVjNJsb6ceffsNQL4TMh5LNsj3G9bF5pCQzHewLa35Ln6o3E+0CCPSseFE53lbJVkKxsP950kLKu7uceKcy6aShe89zJxxdBNZuz5Lo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624781; c=relaxed/simple;
	bh=NKq8vrxCem9objWV3C+MOFnpbo85KhNs4PiXk/R07Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqRi0Lwk9yC7wxnuxxPbSyrS81T7qo9ZZACxvRNHPOpCALChhjee/84G/yN6agWgj5BskVshO9KsRtnIny936CUMBfrCVVugXAlDGVl3Xh0B5lCGvAAurboNImp+ElmpVSGLn+wvLbSbLhO7JCWvuLeNCtSp8JeVldZ59AxqH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nsiYtqnN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so5917413a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714624779; x=1715229579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYwMNtU5ISKi/pHw0Eotzjxo72T7kdIEeid7s5bFFZU=;
        b=nsiYtqnNmzgzAqSTXGk6VDMjRRLsqcUCg9LTnZT/wuJKQg6uDDzrtYpvzYR2FNnIEo
         bigW51SfSeuEq9okrjtryEUtK7XtjSCynQTSi8EqFjMGbss7RxX+x95d9MGS9nYXXPqR
         QYbUmWGWZivJ7aj90JZ0YjteOSQ9qIwsCB/22L4eXa5Nr89i7eBpoLRIK/BYtX6viOlg
         9vFiGz3aR+JXMw+Hd+KcP2orE/elFOWRhQ18MWs6/hLtTnP1rk72T9e5hQZUbsV7fkXK
         rkyp9hVsQP2A9yIwP8UqWsWRziD587Aiu0AOPnj1xFUboSIZ61kD5XvHWHOT26qu/dZz
         2wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714624779; x=1715229579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYwMNtU5ISKi/pHw0Eotzjxo72T7kdIEeid7s5bFFZU=;
        b=U9jzwnCDR06+L0A0nalVoERM6NgU/ihJC0LRSGSEv+sdDyBAra/56E16Awj7vjORdC
         pCcO2CRtx4qRV+qLf/L+9gz8SS1nEHmy2ePD21danh0G/2M4SCdrX9hLoq8ddbszwFKT
         VeZZIXZml9FCWZtxnR4XZTQWcbfEt+UDCsIsaqzTNBoXlkrRBczmX8YjosTwFvhTSwHx
         yWSQSG1aE18SLvt9OiPHshy8vIREe7kBZlTtKoz3coXNGwC1Zn3mb3jpQE3w9l7CNUDi
         VKE0nVzx/PwhvK8C7MEsO9RFDRMb+uxsDKdwpKaY9xJVKOlFZy2ExJsnZ5KYk7g6FwMO
         DEuA==
X-Forwarded-Encrypted: i=1; AJvYcCVKs5pawPSn3VcHGEqESPYjWh6TEcfDC57beHnPIc1j3y2cWsu/3hhngsYvghXzD0FoMh95FY8+N6zVFxABqgnj6HDAxrDPD3qGG7wA
X-Gm-Message-State: AOJu0Yw1lSOW1nuYL754ZAwpz2OMZ+FsCGW3jLLAC1uFkji2jyuA3tTx
	H2eFiAui/oHMMJJF5EWBgpmUppGpakFtPX4VxmUqqFchnrbp1BsSJRvXdjUcvQDPxef8Ogxbjtj
	oRd4CSHkqDipVwTUc/HXWOaeLX6lZ+GdvCB2NCQ==
X-Google-Smtp-Source: AGHT+IFGOZPSbOG+7q08BpoKEAwkSMY5N4r9BG/M6xWabJ6xt9Bfuyl68UiysrvQmviAyEuWdMP6+zF6WYqEShpC7Aw=
X-Received: by 2002:a05:6a21:150b:b0:1a9:a31a:1b67 with SMTP id
 nq11-20020a056a21150b00b001a9a31a1b67mr1221119pzb.47.1714624779299; Wed, 01
 May 2024 21:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <7c3fc511-6a3b-44d8-94fa-e4fff54f93b9@linux.intel.com>
In-Reply-To: <7c3fc511-6a3b-44d8-94fa-e4fff54f93b9@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 1 May 2024 21:39:28 -0700
Message-ID: <CAH2o1u6Vh55E=jn7ytp7s6VSQaZ+BqKLY1adz2AA0=OsLm21dw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 8:52=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> > +/*
> > + * Send IOTLB.INVAL for whole address space for ranges larger than 2MB=
.
> > + * This limit will be replaced with range invalidations, if supported =
by
> > + * the hardware, when RISC-V IOMMU architecture specification update f=
or
> > + * range invalidations update will be available.
> > + */
> > +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT        (2 << 20)
> > +
> > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > +                                 unsigned long start, unsigned long en=
d)
> > +{
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_device *iommu, *prev;
> > +     struct riscv_iommu_command cmd;
> > +     unsigned long len =3D end - start + 1;
> > +     unsigned long iova;
> > +
> > +     rcu_read_lock();
> > +
> > +     prev =3D NULL;
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +
> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +             if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > +                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > +                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +                             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                     }
> > +             } else {
> > +                     riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             }
> > +
> > +             /*
> > +              * IOTLB invalidation request can be safely omitted if al=
ready sent
> > +              * to the IOMMU for the same PSCID, and with domain->bond=
s list
> > +              * arranged based on the device's IOMMU, it's sufficient =
to check
> > +              * last device the invalidation was sent to.
> > +              */
> > +             if (iommu =3D=3D prev)
> > +                     continue;
> > +
> > +             prev =3D iommu;
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +     }
>
> I don't quite follow why not moving "if (iommu =3D=3D prev)" check to the
> top and removing the last riscv_iommu_cmd_send(). My understanding is
> that we could make it simply like below:
>
>         prev =3D NULL;
>         list_for_each_entry_rcu(bond, &domain->bonds, list) {
>                 iommu =3D dev_to_iommu(bond->dev);
>                 if (iommu =3D=3D prev)
>                         continue;
>
>                 /*
>                  * Send an invalidation request to the request queue
>                  * without wait.
>                  */
>                 ... ...
>
>                 prev =3D iommu;
>         }
>

Oh. Thanks for spotting that.
Code section reordered very likely during rebasing patches...

> > +
> > +     prev =3D NULL;
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +             if (iommu =3D=3D prev)
> > +                     continue;
> > +
> > +             prev =3D iommu;
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
> > +     }
> > +     rcu_read_unlock();
> > +}
>
> Best regards,
> baolu

Best regards,
- Tomasz

