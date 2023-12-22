Return-Path: <linux-kernel+bounces-9390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB481C4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3084F1C238C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D208484;
	Fri, 22 Dec 2023 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgZYAi6/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6E9447;
	Fri, 22 Dec 2023 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28be1240414so1217337a91.3;
        Thu, 21 Dec 2023 22:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703225643; x=1703830443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enoBXf4tcUrXpMZvG4dDEisAshfULeCKxGo8vnP8oh0=;
        b=fgZYAi6/34MD5yIXIR7YZMMwm+mwPPb6GGiw5xwSH/KMN+o1BA/kXzFoeA0KKVFx0O
         aeDeY+kexYDBoAQeEtuwYSsXFDSU9v78ou9Die5IheNGYnhSy30Yz8DROClHGCMPXTfr
         hB4TuQjZY3RJIimnOAVIHro8Gt8+0gKvafgC65qcU4NUY4TIQL85CHIO2QWM6iIlLd2C
         RbONwHSX/n0a+35ocU2Be18mSMH0+PrePusGrrGvngQIdxVHOTz7sl5s4fvIVW3lLNje
         SLiGovXzQU5Vd+QCLiAx+WiBzIrgnpgg2dPWy1/z8MuaYR5QNKo1FW/dv9oXP3/INV4E
         ZGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703225643; x=1703830443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enoBXf4tcUrXpMZvG4dDEisAshfULeCKxGo8vnP8oh0=;
        b=YLxqD8HqiBliNf+rSj6b3M+4Pvegl7Z/t7EEP7KLRkYcD9mqEOKOAriNSvaFNvVfR9
         O1UPLwQBpswSdptxnao3PXQC+5ohoQHtOWflt6gDcN+hopIZy8CepccePP/3zhwjtfK+
         JlivV2taWjpsLyyFRz3jZYUxpjx5ef28PSgTyPaC5sZIV3ZTVDJeop9AiCPJsDQSxhoi
         VsJ6MH9+eoRgobpor3joiQ+EbrseTYjIUiZXdHHc1T/llPWu5j0hhYaki/dd7wABkniw
         22L3CssAvyFZtqRkEecTU+oIl9733gHIvj8ljuaEhqDSzDjdiWk1DalK1T7+7aW4auRN
         tozg==
X-Gm-Message-State: AOJu0YxP2PvEqHkdAsrfIrW7jVXOp8cJmcVVQ2hU3X3zhJwuLdDoKiIN
	mlLHqs6LCivYtEq0uO2lz+WBuO2DuoqDleaHOAA=
X-Google-Smtp-Source: AGHT+IHA7+Mlub/8ZuwEIHn8/cuhxPvhuDb+1SriZNxcO6XSp8ADsoyGx4twEpiDOpYyKPlPOqHRfLYxsXG2JvIQo+k=
X-Received: by 2002:a17:90b:108f:b0:286:9d14:65c with SMTP id
 gj15-20020a17090b108f00b002869d14065cmr684005pjb.63.1703225643274; Thu, 21
 Dec 2023 22:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221104034.4851-1-2045gemini@gmail.com> <2023122140-mobile-barrel-5db2@gregkh>
In-Reply-To: <2023122140-mobile-barrel-5db2@gregkh>
From: 20 39 <2045gemini@gmail.com>
Date: Fri, 22 Dec 2023 14:13:28 +0800
Message-ID: <CAOPYjvZ8mCACSjfs8v-B57N9uD+f5n2kOsfzOt5QzVcz2EZSFw@mail.gmail.com>
Subject: Re: [PATCH] usb: mon: Fix atomicity violation in mon_bin_vma_fault
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ivan.orlov0322@gmail.com, surenb@google.com, 42.hyeyoo@gmail.com, 
	Liam.Howlett@oracle.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com, 
	BassCheck <bass@buaa.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

In the patch v2, we've added some information of the static analysis
tool used, as per the researcher guidelines. Also, we've added a cc in
the signed-off-by area, according to the stable-kernel-rules.
Thank you for helpful advice.

Thanks,
Han

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8821=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 21, 2023 at 06:40:34PM +0800, Gui-Dong Han wrote:
> > Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
> > Reported-by: BassCheck <bass@buaa.edu.cn>
>
> You need to document this tool as per the researcher guidelines in the
> kernel documentation, right?
>
> thanks,
>
> greg k-h

