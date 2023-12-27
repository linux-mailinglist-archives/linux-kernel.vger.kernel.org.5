Return-Path: <linux-kernel+bounces-11889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E781ECFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBCB28363F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533D5691;
	Wed, 27 Dec 2023 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz27OA9T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B655666;
	Wed, 27 Dec 2023 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5942259ca62so3098821eaf.3;
        Tue, 26 Dec 2023 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703662635; x=1704267435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kklWMCPiCjz55uM2MffAqdRZNJANsABPXaQBeXkYorE=;
        b=Uz27OA9TWh9AEHpXuH+AGu3Zux1QCa+WBInF3E1iZh57re8a+FPx0c+pf2EJ5VHo57
         xFSSveKBokBcn3iRYhFG4BZ47BP4+8//x+n1qRKSDtLZuCJY0DYGibSeT7xco9/S/m5y
         Bhr27j2+2WlXjB3RLoqee6FJrj9lMGa7dtV79gUtyQzQH/1EiYy0RM4zdplfr3UZ+Vxy
         HcebWjXK1hlhil8nnNnwljJfMOM6XZKq0Sw4lSFdO4lV5pyDiLyHKUWrulRnUUovnCZH
         Fm7OQPf9xWns50pDjIjY5dC9QYU7xZtqxpO8Bqj7J4dXnFn839LdscdA8TU/iLEar6A+
         DW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703662635; x=1704267435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kklWMCPiCjz55uM2MffAqdRZNJANsABPXaQBeXkYorE=;
        b=w1eQQ/W5k1Jc7j6t2hDBwIMCo5wiYcnLuIJFmUKVQKCOGDLz1LA/DatGlYsOcDTSGf
         VeRvFtu3sF62mB2PiLpN/6qScVBfnP5lvIqLJnPE/0WZEFkFbkcg7/FQJPChnvIrp/Ib
         TZE/F4zB9/RfpkQa6FLzxVMAu7XdrrWc/QYyS/DJbvKZ1+ExV4AMWnxyIzMRz/0K7ZHU
         T9sSOX0n8HWIfbdsUJQ4NuG+BTQnnroYsjBpva0cZDN4V5LRPdASixxundI2ZC4wnPP7
         Um5gTxP+kzmcd/SHFqUJUgTrQpAcnXkIf0VlHqUncTObBZ9Af1582ViLTPxa4nFjfDdz
         DbUw==
X-Gm-Message-State: AOJu0Ywf1zuqYK7VzQCCtr0hWWogOUSqWVQmcLq8JxlJ5vnu2ji2mxom
	UsFUACZ8Vh25irqLmewPHlruOC9SGGHas5qW44E=
X-Google-Smtp-Source: AGHT+IH3xbafbVk7YiN7HdyJAcdsTr6vQBR8C+tF6OYHJPrQpKQSfVnhyixiQQ8Kw/mtVlc5RkuFqyM0UCVt/M7Na+4=
X-Received: by 2002:a4a:58d1:0:b0:594:51f9:bbf2 with SMTP id
 f200-20020a4a58d1000000b0059451f9bbf2mr3488707oob.19.1703662634765; Tue, 26
 Dec 2023 23:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-2-qiujingbao.dlmu@gmail.com> <86481a49-40ec-487f-8cec-6f2f64cf0f12@linaro.org>
In-Reply-To: <86481a49-40ec-487f-8cec-6f2f64cf0f12@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 27 Dec 2023 15:37:03 +0800
Message-ID: <CAJRtX8SN62_7FsALpjPSAKtfVQPBnEmrxZiCDwSuqcevEedEAQ@mail.gmail.com>
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

On Tue, Dec 26, 2023 at 8:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/12/2023 11:04, Jingbao Qiu wrote:
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > +
> > +    syscon@5025000 {
>
> This example and DTS suggest this is system-controller, so use that
> name. Assuming this is system-controller, because I am still not sure.
>

Thanks,I will carefully consider how to name him.

> Best regards,
> Krzysztof
>

