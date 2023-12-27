Return-Path: <linux-kernel+bounces-11994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3581EE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B0C2837C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF34446BE;
	Wed, 27 Dec 2023 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxe1xUqR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64418446AF;
	Wed, 27 Dec 2023 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6da4894a8d6so3257797a34.2;
        Wed, 27 Dec 2023 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703677327; x=1704282127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb7lpldq2Tx1QNQ+H2Dim+WKnJgqfdJmzYnoXpB8qbM=;
        b=Qxe1xUqRsrCXLFwwVci/d/oZ9hyC5apqYfi98eY0XYcJOI8KLrsb/2WkWfLDCn401+
         C+v1+76GLBYaQwHoqNYXvmwjGzhEfaUjFhUhM0NIkhIli0/JINHLx+PJXBnSV7tUbj6q
         D4eR3wVZY8HTNn41s4t/XdknJo/NOSn3Q1nGb+AW26IVMvkL82853Ln2lznxbr47AG5R
         ALfzohXDM5LwaqQngoBXicuZEhg0G71XtuljhhQTKuuvVbNz3sgpTchJ4NmWXI+MDA/c
         SfiCIhXAbXejfVUucHCDs9PuPPawZ7K3TySVOqErRuOi1AfPYGKuUwQQIqv+PfKXDoR5
         SfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703677327; x=1704282127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb7lpldq2Tx1QNQ+H2Dim+WKnJgqfdJmzYnoXpB8qbM=;
        b=c33y2KZv6PPgtepxNPz1ebOe/ZvMim2GMn7ofaZIAmi4WaT1fzTQnuPMszmy4miKfw
         0WfooMYDLvv7sMYPLqhGJ0I8Q/9nneZfU04B9fGXJg7W6ibrbQ7+n1pXueaKXsjZIlS+
         bu0UMVl9CgzMz17AnUBxJIv5ZOVHMkH+Z/mRA+eUZXTiay3p6vIqRets6dzr2D2lwzNt
         /m3PiQz3VlQ0VC/ApwHH1w3tP1ZFw3sJ+/KPJosGaPR1ran51M35JUHX6RWkaxDslQdv
         v3yhkGxDs4PFZylLEiYnqvJjh+8HFUMaPHDWvkcbS2Vr1G10PZeIoPc1PJ2oMj0pXWkG
         IB/g==
X-Gm-Message-State: AOJu0YwTCRVeZHI3ffc9KUr9G1wbKdaQzY6SUK85QZ6wGmXaFGz3mlvm
	EXGr4+r6alRF3pBAkf7hLH00Vw47m9UJdxNRFh0=
X-Google-Smtp-Source: AGHT+IG9HREmck3pKgGMOlqJlBXLHQ/lrJdeT/aJclJBNwnuos6qFhPCGAVQVIJrd4I1BFD7ScK4mlSLbvHZfjCNaeU=
X-Received: by 2002:a9d:6a44:0:b0:6db:ab71:9e56 with SMTP id
 h4-20020a9d6a44000000b006dbab719e56mr3957749otn.68.1703677327094; Wed, 27 Dec
 2023 03:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-2-qiujingbao.dlmu@gmail.com> <8f5e5cc7-9795-4e17-8bb9-73448e960c3d@linaro.org>
 <CAJRtX8R=K6R0o-43cHfL2iKizEJYH+fGFtVj7tWFBuFN1cSsig@mail.gmail.com> <8cadec0b-8bf4-409d-b56e-28c8bae5f567@linaro.org>
In-Reply-To: <8cadec0b-8bf4-409d-b56e-28c8bae5f567@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 27 Dec 2023 19:41:56 +0800
Message-ID: <CAJRtX8RBER6eit11dEwqMHwaQQwk=0cK12Z7vRArUME3rJ_s6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: sophgo: add MFD subsys support
 for Sophgo CV1800 series SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org, 
	inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/12/2023 08:35, Jingbao Qiu wrote:
> >>
> >> I do not see any resources in MFD block, so why having it as separate
> >> node? What other devices you did not describe here? You mentioned
> >> restart and 8051, so where are they? Which driver implements them?
> >>
> >
> > I'am sorry for that other drivers have not been implemented yet. I
> > will implement it
> > after rtc. They have the same address range, so I use mfd to describe t=
hem.
>
> Bindings should be complete even if your driver is not ready. After
> looking at such device node, I say you do not need that rtc child. If
> you sent complete bindings, then of course discussion would be
> different, but...

Thank you for your patient explanation. I will supplement it completely
in the next version

Best regards,
Jingbao Qiu

>
> Best regards,
> Krzysztof
>

