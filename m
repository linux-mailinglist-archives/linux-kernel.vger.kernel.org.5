Return-Path: <linux-kernel+bounces-164948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A588B8558
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83C51F235D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ACC481DA;
	Wed,  1 May 2024 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL+jrcV8"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57154AEC3;
	Wed,  1 May 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541558; cv=none; b=lNMSlyueHEZOGejVAaw1BmOqWuFlf7vm01G+ZXvDTF6HZM28bFMJXufR3K+ELnpgl8lmIkRHkgdWrIeMRVocKDZ7iMTNIRZiaTjbaw2x+oO+XYBoM4Ir2jbrbFbS7tDyc6SZ3DU4hWXRmhbhH8wOFppme+BIJiWzB/iAO/oufFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541558; c=relaxed/simple;
	bh=LhUQypmCj6FihMXMgHiHgd8f2gMkEN6+/WGmjHLMtsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHuNivvu+zRBTipRQ5G6U/MW6e7acs0QYCo3FGI13QUZMNJ5DHksaLP2A7WrRLKbN1SnOxScrno8nz71q6CXZtYTIhJi0XtT9XXEYgcCOZAseE+oxUIra2O9TbkKMWdfkwaJJQobH7wO/Rw2WsV1dxnHATkgYbsBce4vAOrH4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL+jrcV8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b24dbd1bb6so1519849a91.3;
        Tue, 30 Apr 2024 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714541556; x=1715146356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhUQypmCj6FihMXMgHiHgd8f2gMkEN6+/WGmjHLMtsQ=;
        b=nL+jrcV8t5U4Jcd2F37YY16zv3eK1n59hzUYBDqWA0Rmz/G87Ga0r+GfA7Yaw+n3MW
         OKteE7rbAPRdo0L4LyZeLU/8C5MfrLW5qJhrhyX6mhMXWJ2aUlO0S/OPB2RMRH9QIxKv
         RJaOOXWl5tftT71JGMwtmQ6OnPf1EL+/jDCF4rVcnticGSQjMFOwK1V0fhv86CmgkLQh
         h8bZAfEi4mNDcaEWwOq+uErB8vYPWlKDr12T1OtKxpVZ3wNYV9YGyyTzeZiNp6WxN9nT
         e48IMnEGHtGUh/bb1wgNlBKtLCzcC3YBK8WYHbzjj8lR1NIeJKVhC+2BadTxRmIczivW
         tRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714541556; x=1715146356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhUQypmCj6FihMXMgHiHgd8f2gMkEN6+/WGmjHLMtsQ=;
        b=W0TTgxYi4uS6blFDxGyODT9o0aE0mZiRQXnpfBGVpR3JYNSWxxauncprKjC0zGR3ur
         1EganiLDjpUlN1PsVTetMpzDmWz7D8JGWG7Zd2yFRp1aZoTE9uM/+VYGobToeGsfqChW
         EFY7GTmPa4k5914+WpJBZbTH1A2J10pKPflZnf8FuMSthbfVIF8BHBDC36gZiQqu2P2E
         NIFGPmLmd11VW+PXjgofAZjlig283XzVEq7jhGAbZroVLIa3EJrGdfHZg/Vuj20QhhmZ
         EOAJEJmzunAXnCg+ykufG+RPlpG0ObE/Afr16+QzkLfBaiT5PhVJAbsoFrkic4ZJ/FOV
         79yg==
X-Forwarded-Encrypted: i=1; AJvYcCUs4izYCWTjaASX27iNcltrFJ9LEHDI3otswQvM5EdEhvNXTaf8dbBkX24jqzIxE8igEnicKPWO9Un50GGL/CYOcrs7tkriB82/H7fbpE97t8UVxia+zTsBPxmzoEKfnw4EIQ6AvR20fGNCx27czfyHbfn+MhaNktQieDYI89qSCsw6VzlMpA==
X-Gm-Message-State: AOJu0Ywy3RdZcNql0hTo7KhNu7ZDTreucXZqoQQ8mjcm7FFDHrw+puj+
	eJ9Y8s75K317WAgtoctzj9pp2P/99lx30NXnPyPhHPD1uPUV1bDovuMthmXTg4OkPZTLhhbG+p8
	siUGIenaMaCBi074RJ0/Jh4pSUGM=
X-Google-Smtp-Source: AGHT+IHiMOGLd/+67g95LqIkRpVDEp1zqfi64FrDgiZ4JUy/3e1V8BHvssHdIkCZW6yhQ4K5LDcsY6QZXtCz416hve0=
X-Received: by 2002:a17:90a:714a:b0:2af:b977:363a with SMTP id
 g10-20020a17090a714a00b002afb977363amr1483032pjs.43.1714541556119; Tue, 30
 Apr 2024 22:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>
 <2024050119-pediatric-prankish-64b9@gregkh> <CAE8VWiKqrPge_OaeCXXAER6ofFLULLPrPK8StCMV9DPM+WHuHw@mail.gmail.com>
 <2024050149-blob-afoot-af04@gregkh>
In-Reply-To: <2024050149-blob-afoot-af04@gregkh>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 1 May 2024 11:02:24 +0530
Message-ID: <CAE8VWiKZSGM_JXnvsbp3jo+A80puYGA58FoLY3+ZQar5tFAyCg@mail.gmail.com>
Subject: Re: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using __free
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Shuah Khan <skhan@linuxfoundation.org>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Yes, but you did not include it in your response at all, so how were we
> to see it?

Oh, really sorry about that.
I thought I was replying to the thread with the patch.

> Great, please say so in your changelog text.

Right, I'll do that. My bad.
I'll resubmit the patch.

Regards,
Shresth

On Wed, May 1, 2024 at 10:33=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, May 01, 2024 at 10:28:35AM +0530, Shresth Prasad wrote:
> > > I don't see anything here, sorry.
> > I'm sorry but is this patch not visible?
> > https://lore.kernel.org/all/20240425060303.8045-2-shresthprasad7@gmail.=
com/
>
> Yes, but you did not include it in your response at all, so how were we
> to see it?
>
> > > Also, how was this tested?
> > I tested it using a qemu x86_64 virtual machine
>
> Great, please say so in your changelog text.
>
> thanks,
>
> greg k-h

