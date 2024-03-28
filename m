Return-Path: <linux-kernel+bounces-123487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DF890956
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081BA1F23041
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A6137934;
	Thu, 28 Mar 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oij9zdN5"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25201EA6E;
	Thu, 28 Mar 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654678; cv=none; b=mTdqi9ZVw4/JtsKHrQeJq5Tj2A4oYYzDtGYjKasLbST8IUyiBfTGmpKGhc5wE9VNoQHCpYKZ1d8xiIgMypVovNJe9C0gZHE+B4IFaVzCY8YIid2Iv79p788GEdUCahbkLj2v35oLbNLdsQX5ajml93YtS++g0M4ztzVUCpoHrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654678; c=relaxed/simple;
	bh=y/b4xYUnvZR2AqHFoYx6ytBmSp6Erv+XATgcP3Dubbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFtRnbCPGOrRJBFVSoD2MJly7kKxEJEEN7fKvQiwxdN4jnFeLYWwU9T8aXWig0E+s4ls5QsaYeVKxeXxuhEoBpsmgXyIMQLyBrY6hspbj4ubc4eu1SvvvDgJZjlJb3uY173MT9DmrwNxQOdl/X5WBimQKr6s32FmVjC4Lz6yD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oij9zdN5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6963c0c507eso13297866d6.1;
        Thu, 28 Mar 2024 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654676; x=1712259476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/b4xYUnvZR2AqHFoYx6ytBmSp6Erv+XATgcP3Dubbk=;
        b=Oij9zdN5FHSoT/F/7ndrJSf0ROO9T3otue/dYecf9XLnVw7Y6vRxFfU0phviwwqMrl
         TCkm9iLDFFz6oEd16RBjhFw2y5bCFYmOa4JcQSiMPkTE2ZKCSgpDN8oI0PchhGvfSA6v
         Ljt2oRB11IA06+qiNw3k8zm+Tont81StR9qFy8gDePz/Ug+aCKVAEY656ep9EMeBS502
         jo0k2SPIAMlsutuenDjppuWF0C9OeKEsUoTmkPytMg2wuJdtTX2m9Y298eWokla54p8r
         n16Nn/2giFLnurpfbRZo8qijdB3Wj0spr68QTzGHM8Ve9iCWLZgqYIM/hfgsCVk48uLR
         89Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654676; x=1712259476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/b4xYUnvZR2AqHFoYx6ytBmSp6Erv+XATgcP3Dubbk=;
        b=g0nuh3H345PnAIcEj/gm3TiHy4SXgi32ONMstmdFKvsCjzjScktMwz4duwMKCLhobV
         h/GtZLzxzuIHFzugQ187FIz8TWpOZTsIehWrh7TJ3poiqxNuEhG2uhzsziWkygUZXkZT
         MmT4UA41AhBEvSGYNx09FLfK5tf2GvnRqPSYRGXPohYr8r8tn+IcrNNjNOHkV9BLi+Ns
         r94Wz4pUEDtTR0yzIGg1WvB/xJphsQUh0/zexryKIDmD8s+rw754GcuqQI+jKJ5oYTdo
         /VhIapqoQs2ea5/vMtIFfpitVVZsCjqWeCotNZZgnFmPva1wOvGGnA5I7RCU2fJRT/Gx
         9mQw==
X-Forwarded-Encrypted: i=1; AJvYcCWX59Hg7SaCItJuRUo9YA6BzwsuG4ij1U5y4pg0dYHfS9CPxdHj6dF8XtRIn33R+MaLfIvUT723fidRfUC45g2uNftAp5O26XzfCx4DK3lcc/nCiGqlb6zlWJt3HQgcJVav+sRq5dvOWA==
X-Gm-Message-State: AOJu0YxuXSOGe9l5mQwim/5EzBm/k5u2eCuI7kWrheqpjYT9wjdzG0VO
	hGlMsfBHqn1GiJM9ESJfm+u5o1slKCGz0I9GgmkkN87TyawA6toEYeXvUz42lKrFCMtxVSi38rv
	32psaAK8lPQv2SdO0vQXmuWwQ3f8=
X-Google-Smtp-Source: AGHT+IGVM5PXHNySYzAHCaoUocLXKnVjvFp7o+JfhXyoWthzaOLZx2m6VnOdX6eZRyUKh9LSRB66s8lF2s9NDUErMgA=
X-Received: by 2002:a05:6214:1551:b0:696:a330:ce5 with SMTP id
 t17-20020a056214155100b00696a3300ce5mr847432qvw.20.1711654675710; Thu, 28 Mar
 2024 12:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCHtYiSYat771sfx-Pdv59GDUBH_TzqkxUM+BMf0Q7Z0KEC9A@mail.gmail.com>
 <5C54919E-EBD5-4A16-821F-5146659CCD1D@beagleboard.org>
In-Reply-To: <5C54919E-EBD5-4A16-821F-5146659CCD1D@beagleboard.org>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 28 Mar 2024 14:37:28 -0500
Message-ID: <CAOCHtYgy9UzNALjvhKo2uNGO8xW=V-3=3a_AmQ6oJMP1tDrFVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-j722s-beagley-ai
To: Jason Kridner <jkridner@beagleboard.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Deepak Khatri <lorforlinux@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:26=E2=80=AFPM Jason Kridner <jkridner@beagleboard=
org> wrote:
>
>
>
> > On Mar 28, 2024, at 9:16=E2=80=AFAM, Robert Nelson <robertcnelson@gmail=
com> wrote:
> >
> > =EF=BB=BFOn Thu, Mar 28, 2024 at 2:12=E2=80=AFPM Robert Nelson <robertc=
nelson@gmail.com> wrote:
> >>
> >> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> >> hardware single board computer based on the Texas Instruments AM67A,
> >> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> >> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA)=
,
> >> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> >> cores for low-power, low-latency GPIO control.
> >>
> >> https://beagley-ai.org/
> >> https://openbeagle.org/beagley-ai/beagley-ai
> >
> > @Jason Kridner we need this to become public when you are ready ^ ;)
> >
>
> Did I mess up? Should already be public. We should make a github.com mirr=
or though for up-time/visibility/bandwidth.

Thanks Jason, it seems to work in incognito mode now, so we are good!

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

