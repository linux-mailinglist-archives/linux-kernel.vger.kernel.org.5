Return-Path: <linux-kernel+bounces-6370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC88197BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49128417D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6B210F3;
	Wed, 20 Dec 2023 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYs7ox2Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94246210E1;
	Wed, 20 Dec 2023 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67aa9a99915so41166216d6.3;
        Tue, 19 Dec 2023 20:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046240; x=1703651040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+eJ8GCNdPeoI4L8SnnmNHM4OsYtuGuRi23NMEvZEH0=;
        b=XYs7ox2QPonlGlVkk+yry6IlBw+l0pqP+/pRuqP3I/4KQqXxBfvbxEpBBFnTYIGAQz
         uYDk5zMqvxcpGPSMncU1EKX/x98KxlexLomYVzwcBrpwHFUbDDQ6jSz8bPbru75M2+xw
         NhgPXHqCaTl8DIWbnA3WyizbnynazGMm/usAaJ2PCs3owlDYBIyHmYSkIoyxpCn7eAbS
         eXr2rucNH/VFcAfUv2yNgu8ydQvxwf8J/r85Gdn7F9XDHINgb0BCKs95Kvx0MmmMPWa9
         3xV44ORS6zfc6nHUpo5Hy2PZjZI3TjvoRUi6x/zeRuzVeOez0kvzYx+8EmFSPRwLv6JC
         SWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046240; x=1703651040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+eJ8GCNdPeoI4L8SnnmNHM4OsYtuGuRi23NMEvZEH0=;
        b=jpch4OsJdrlEuF8+GyikOwa8J+xZYjhvoj4tmaShNFTf0TFitknTP3e0o++0DNrHcr
         Ivp1J3ySykHtGwM8ky125BuE0PXpTwbCkqTmfbHQoUg7k9IkRJLPK6DAPP22FTN23S/b
         2Rx8Qq9qnpLb67ywRTrQKGmSRJPPnGCY5iCVpbat7q7p0RnT5K/p1SzYvR4XjnCoVsb4
         yOBs+J6KvctfM8Z5RC8GoIN8aSYOVKEN97fIdHsacWA40x8BcOtmfHV/Nep1SouH+fbw
         S7HbXPCPfyzE01+B9qBFaP6aW8uzqbVQeKuNQRSU4xL3N1dZZGewuJhs/TVfTGFS/KtL
         Xw4Q==
X-Gm-Message-State: AOJu0Yz1fpvgYAx7b261GRj43rrM3+q2do3Yne8W5xOBSviDsQ5Gura4
	WdCiP/pKzKsi4oxRh2XlAwQtA7CMB53iWR0Fc9SSElRgMdM=
X-Google-Smtp-Source: AGHT+IGsshzgoWnH/DuEgm6oNicXeUsHwPLWsGkkHmeEzkr9wchEn6s/RXAZaQjMOg5TBFh8pmhof2mBhDLqHJ9nCTU=
X-Received: by 2002:a05:6214:ca3:b0:67f:262c:14e4 with SMTP id
 s3-20020a0562140ca300b0067f262c14e4mr12331448qvs.68.1703046240452; Tue, 19
 Dec 2023 20:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219175206.12342-1-zohar@linux.ibm.com> <20231219175206.12342-3-zohar@linux.ibm.com>
 <ddff6449a57ef38e503fcaef759fa37ed391d134.camel@linux.ibm.com>
In-Reply-To: <ddff6449a57ef38e503fcaef759fa37ed391d134.camel@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Dec 2023 06:23:49 +0200
Message-ID: <CAOQ4uxgn3X5Py9XE6wmafPpUBSXDzygUpgDSVct9AfzH+0kvXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] evm: add support to disable EVM on unsupported filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:10=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Tue, 2023-12-19 at 12:52 -0500, Mimi Zohar wrote:
>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..db9350a734ef 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
> >  #define SB_I_USERNS_VISIBLE          0x00000010 /* fstype already moun=
ted */
> >  #define SB_I_IMA_UNVERIFIABLE_SIGNATURE      0x00000020
> >  #define SB_I_UNTRUSTED_MOUNTER               0x00000040
> > +#define SB_I_EVM_UNSUPPORTED         0x00000050
>
> This needs to be fixed.
>

With this fixed, you may add:

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

