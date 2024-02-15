Return-Path: <linux-kernel+bounces-66633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7F855F46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FA11F2330F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3C129A73;
	Thu, 15 Feb 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsNTaPXr"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D01292E1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993140; cv=none; b=DNm3tveLBky0cMEZ8DspWiSlJ4bGsjjA0tdj/qWjlsK0Pxd9JyiGkRWT52JNw0G+ui9Hu1y/eId9pFPZafVA6X7dZEuhPcZtJvHmbRpPV9IaQJptML9/1w5eIhYNFqQzM6+n4nfKlUueSM0V5DzeAYM2z3v97zE2h+moTO7/Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993140; c=relaxed/simple;
	bh=cONun6TngeRrkk4IMltlDOWagNPI0xWvUxmkNTiDM40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AboL8xo7fNkTJlIWi90tXOU8A4hSL1XZ3wSx64fhv2wKFckaOcxyBCe6dg3ECKSyyD9ftmnpqMTcuTy637SBcvTJgM0Jn/4i6LmMpc6MwV+OpEwqUrHkNHzAE6QXJ1JeIEPUVmQPLjJ7YbMNIEw5r/3YBPWsDbfpNTEGcOjDkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WsNTaPXr; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58e256505f7so509609eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707993138; x=1708597938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnSnP54cWq3RDS6TzZYCLsOok3bG0dcYaLglmFl6H+k=;
        b=WsNTaPXrEu/023Pykc3vHgraElj4QzxyBWRMKnJGrFV8iAJ6W30Dqijk3kxoOBFM/I
         Br6ayjWlTja2Tnm8yLsKrXhpeYfWh1H1jht9MW3rguQnt4gdSmuMx41ZrjO8jVGYhuKc
         jZuzjxmijwXg51oMkYNMoNhHUf6NPwH2VoNSkTVB52QtO2yF6ChnzmYCnZfes5Rxz3yT
         Q3njCGShnQOERmsauf6+Xl733oMjmwPbTEFxouanKkOKKtUSw9i0pSPDzgS0nc2SjjLg
         VBfiLbp7SetN/QesKludKP8dv8pwbYqe+0Xm+45F8Y2qFghg3U6Q7ciyiVjSsWr/N7rf
         fOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993138; x=1708597938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnSnP54cWq3RDS6TzZYCLsOok3bG0dcYaLglmFl6H+k=;
        b=kJrZ64OHNn6sf7TINBI8xwytkqaJYWT9TcKGw/Ctk8G6hQ8IsxeaL9BjJ1nGn29biM
         AFt8y2oLUs7aLoIvIrLAqVj8rdeZbwA4P3csP5LguUX20Q5VbienLb95QbEARepAkVI8
         MPbyvJjR226PuaVAu/LaBoJEBunLe+l/8yvErlnLsdZd6KvJHEqaAGDnxQD6fGx6yynX
         of+E87Qp5T/9OltaXadSPwP2fYgBzC6dMRcV9fhMjCYYKtDjqgDQj+G8yKJJMbhiAeoE
         waK5pOlvlHP3a7NT5rK4FVbXZj2hxmZWQaj8B7aSrUu3X9OrrYGlVW/oUjiG4sxi7LgO
         LnOg==
X-Forwarded-Encrypted: i=1; AJvYcCUKmMNoARpE3BLU3wNoMQZQgWUwzry26s1D3Rlz0PRZzFIGRrpNqspimH40RlxywF0+LplsB8/S0zyhBjODRGCPn4HZdL5yS2SOjUw6
X-Gm-Message-State: AOJu0YznFhQh5hELDVt6nbRvCBoQ88semf/ibQnY7w75g7rWIV7KJquw
	rxDZiIEvOTxutHC4LcB1fPLpuETje0qiGZ9j6Ls2CPfVvj7J6C3dcdUILEysfw8pG/OkOwbDLDj
	Es/pNVevU06f9H81gzeuirJV5ZbpnUygNnuiRDw==
X-Google-Smtp-Source: AGHT+IEDZl0jC7JHpc3qKLwfiY44WZzrpOsYhTkKATayJtv93hEMXdcWmrqZG5pYDXKUMkeXBqFkh+j2mFsHa2Vvcl8=
X-Received: by 2002:a4a:d2d2:0:b0:59d:f09:352b with SMTP id
 j18-20020a4ad2d2000000b0059d0f09352bmr1191490oos.9.1707993137914; Thu, 15 Feb
 2024 02:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213145239.379875-1-balint.dobszay@arm.com>
 <20240213145239.379875-3-balint.dobszay@arm.com> <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
In-Reply-To: <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 15 Feb 2024 11:32:07 +0100
Message-ID: <CAHUa44FUmXMCLvJEB8v2_H4j+yNzR+YMU0xSO6uaaqF0BHj_2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] tee: tstee: Add Trusted Services TEE driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Balint Dobszay <balint.dobszay@arm.com>, op-tee@lists.trustedfirmware.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, sumit.garg@linaro.org, corbet@lwn.net, 
	sudeep.holla@arm.com, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/02/2024 15:52, Balint Dobszay wrote:
> > The Trusted Services project provides a framework for developing and
> > deploying device Root of Trust services in FF-A Secure Partitions. The
> > FF-A SPs are accessible through the FF-A driver, but this doesn't
> > provide a user space interface. The goal of this TEE driver is to make
> > Trusted Services SPs accessible for user space clients.
> >
> > All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
> > by TS. A TS SP can host one or more services, a service is identified b=
y
> > its service UUID. The same type of service cannot be present twice in
> > the same SP. During SP boot each service in an SP is assigned an
> > interface ID, this is just a short ID to simplify message addressing.
> > There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TE=
E
> > device is registered for each TS SP. This is required since contrary to
> > the generic TEE design where memory is shared with the whole TEE
> > implementation, in case of FF-A, memory is shared with a specific SP. A
> > user space client has to be able to separately share memory with each S=
P
> > based on its endpoint ID.
> >
> > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > ---
>
>
> > +static int tstee_probe(struct ffa_device *ffa_dev)
> > +{
> > +     struct tstee *tstee;
> > +     int rc;
> > +
> > +     ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> > +
> > +     if (!tstee_check_rpc_compatible(ffa_dev))
> > +             return -EINVAL;
> > +
> > +     tstee =3D kzalloc(sizeof(*tstee), GFP_KERNEL);
> > +     if (!tstee)
> > +             return -ENOMEM;
> > +
> > +     tstee->ffa_dev =3D ffa_dev;
> > +
> > +     tstee->pool =3D tstee_create_shm_pool();
> > +     if (IS_ERR(tstee->pool)) {
> > +             rc =3D PTR_ERR(tstee->pool);
> > +             tstee->pool =3D NULL;
> > +             goto err;
>
> Is it logically correct to call here tee_device_unregister()?

It is harmless since it ignores null pointers, but you have a point.
It doesn't make sense to call tee_device_unregister() before
tee_device_register() has been called.

Thanks,
Jens

>
> > +     }
> > +
> > +     tstee->teedev =3D tee_device_alloc(&tstee_desc, NULL, tstee->pool=
, tstee);
> > +     if (IS_ERR(tstee->teedev)) {
> > +             rc =3D PTR_ERR(tstee->teedev);
> > +             tstee->teedev =3D NULL;
> > +             goto err;
> > +     }
> > +
> > +     rc =3D tee_device_register(tstee->teedev);
> > +     if (rc)
> > +             goto err;
> > +
> > +     ffa_dev_set_drvdata(ffa_dev, tstee);
> > +
> > +     pr_info("driver initialized for endpoint 0x%x\n", ffa_dev->vm_id)=
;
>
> Don't print simple probe success messages. Anyway all prints in device
> context should be dev_*.
>
> > +
> > +     return 0;
> > +
> > +err:
> > +     tstee_deinit_common(tstee);
> > +     return rc;
> > +}
> > +
> > +static void tstee_remove(struct ffa_device *ffa_dev)
> > +{
> > +     tstee_deinit_common(ffa_dev->dev.driver_data);
> > +}
> > +
> > +static const struct ffa_device_id tstee_device_ids[] =3D {
> > +     /* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
> > +     { TS_RPC_UUID },
> > +     {}
> > +};
> > +
> > +static struct ffa_driver tstee_driver =3D {
> > +     .name =3D "arm_tstee",
> > +     .probe =3D tstee_probe,
> > +     .remove =3D tstee_remove,
> > +     .id_table =3D tstee_device_ids,
> > +};
> > +
> > +static int __init mod_init(void)
> > +{
> > +     return ffa_register(&tstee_driver);
> > +}
> > +module_init(mod_init)
> > +
> > +static void __exit mod_exit(void)
> > +{
> > +     ffa_unregister(&tstee_driver);
> > +}
> > +module_exit(mod_exit)
> > +
> > +MODULE_ALIAS("arm-tstee");
>
> Why do you need this alias? I don't see MODULE_DEVICE_TABLE, so how this
> bus handles module loading?
>
>
> Best regards,
> Krzysztof
>

