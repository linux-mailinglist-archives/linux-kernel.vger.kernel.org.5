Return-Path: <linux-kernel+bounces-7518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4681A935
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0130D28355C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4963EA95;
	Wed, 20 Dec 2023 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04E/z68F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D41DA3F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-466912ccda7so35332137.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703111457; x=1703716257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBf507AsS5lYdqWe3RS8FgMvqptcaacgolmtRhCKBmM=;
        b=04E/z68FhnZfEADzNddsQp7HbVI46gwRieURE6R2MlcRZrWi5EjDF1nfDZKeDlvvOG
         KgyyyMpV1vZpleaEeRIfHogkpz63LFpMqIsyYooRm8xF1SbMZmQd2CwqdIsaNG9uBxYi
         rXK7+fSpTiuQqKCgmrLB42gkFQn3nK79TKJfKzXL+VmFAqsKAJs+vK9FjgeMzL4wQhI5
         rFkEl6ogcZNw0D68eCCY3ggR7AD9LR4Z+eCkURDH6AIneMComrXIO4V6UQI2oPddF8w6
         D6/KgoCJcjbdQhl8NS2rdhHfUnjTDGN26fUt6P3S/RD5ptCB8k0RsR4JuVebpNJ7Qg55
         Y5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111457; x=1703716257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBf507AsS5lYdqWe3RS8FgMvqptcaacgolmtRhCKBmM=;
        b=N83emNFSySMlCLlqyusoVTjwWP8RGIkpH74BqYmHo8acTuxDPimteAuIHPrpKMeHRk
         BWwUISg1/9dnldqt31y9wAGKNRELtTDDx/MIeBNI4N+Fwmtjisk7meTPfL4aB4wGBmy5
         WZzgPHXR9jYZkfqqnibaJQ+0+XfxfEMCzlpd0UvuZYdz7EpAUqleNq1q05SS55tjWqy0
         vmlYFXo1oCvcYvxHj4VvxsSyv22qfc6ypX4nQfWgKlYWIYrlJTaEnrMfWY/rV7Vfl6Xc
         dWy1lxImuFYk1Hx9Ys82N6sIMTO1H7YAsS7aocKvViUrZS8Bb8nqsyMR+bJHWzGLdbb8
         uLXA==
X-Gm-Message-State: AOJu0YxMsXeOMnTn9qwEbYlkdV/EjC4EDI1d10V+tkw7XxLn2qDeVc6V
	3NPWUsze/ITsAbM4h65MQAorDIKLrMGx5k2YqRVZOg==
X-Google-Smtp-Source: AGHT+IHlHuy110RUmpGR8wgTDBvpH4cFi+hQ6U4ubcT4eMunNXWGC8b8GH/CA/DKLC79jXDFRT91hG0HOQpsbB3bnsM=
X-Received: by 2002:a05:6102:54a6:b0:464:4443:f1aa with SMTP id
 bk38-20020a05610254a600b004644443f1aamr348465vsb.12.1703111456874; Wed, 20
 Dec 2023 14:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220220843.73586-1-mike.kravetz@oracle.com>
In-Reply-To: <20231220220843.73586-1-mike.kravetz@oracle.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 20 Dec 2023 14:30:45 -0800
Message-ID: <CAPTztWb5hyqXDZfR1fXWb019DXFg7qzqaU3r7Ufu6YkzyMOf=A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for all your work, Mike!

On Wed, Dec 20, 2023 at 2:09=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> I am stepping away from my role as hugetlb maintainer.  There should be
> no gap in coverage as Muchun Song is also a hugetlb maintainer.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..b487aaa206e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9762,7 +9762,6 @@ F:        Documentation/networking/device_drivers/e=
thernet/huawei/hinic.rst
>  F:     drivers/net/ethernet/huawei/hinic/
>
>  HUGETLB SUBSYSTEM
> -M:     Mike Kravetz <mike.kravetz@oracle.com>
>  M:     Muchun Song <muchun.song@linux.dev>
>  L:     linux-mm@kvack.org
>  S:     Maintained
> --
> 2.43.0
>
>

