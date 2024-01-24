Return-Path: <linux-kernel+bounces-37613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C393383B292
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05FCB23229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F01133414;
	Wed, 24 Jan 2024 19:53:03 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C67A721;
	Wed, 24 Jan 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125983; cv=none; b=ZzL5W25qHMk0g5RtbIxs5gWEEw9VtiwjY1CpW+AIC2jcLaqE/cJPxzs3PHOXV+eJv82rb+M0emqpLzw3HNXbHdXtQqfhKd0JP4UOm44dtam6eqa8z/L11Y4FmQv2DRruKXsWQLwxm1cESVeTZn0bUkeh9D3KTXSvH83NSCE5sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125983; c=relaxed/simple;
	bh=aadZZEOGkkUEm30g9/XpD6S08ZVXC+3z9qo9Z7Hqwto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enJ8HoVDqijQI5+9ll5LXcX/QZGzSgJ23W8U9Z+G+P5LGVSZG0CG12j3PO/uA6OTey5N0BBoDsNv+o7FCBZxPjbkXEXSktlMlR/51ZQNpYSt0ors1huGwHxBMNk1njIhlfHGOrNchfNaKukn6Xk5LH//3Pix57eTTE1xj4fMzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-598afd970e4so722621eaf.0;
        Wed, 24 Jan 2024 11:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125980; x=1706730780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRoNhJ3/05j9Tlj5YG8Cl0Gw7tHLoeZYDuNeT2OREZs=;
        b=aLrr+1xEmEqBHfqxKwqo0yoWF3iw+7hRphaAzLB74OM1iGb26A6NAoAvz4NEYK8hHm
         NczXyOUJ5WRdGyXbnf9YjEj8gryX1F1zz1wcbMIO4r/cXuyWAq4VortZD+b9FEuuPN7n
         +rntXiZpd83WMmyLcy9nKGN7JFL801J7swOEgGj/J+iqfHoNARtVRLskCbIPJyec8oyL
         OXt4hlj3iRWEtmnsgcX2sCfGJjH9UjmqM1EhNGHgw2p+4UPWbB/lkmg32yPmVOA+BTQr
         2lsutLcL8jQwNdf3HeyURgc/SaSvy4CGBi96lzmqb+ls3mHFF2Kwn4gD1hkgSwbh8Hqj
         emUA==
X-Gm-Message-State: AOJu0Yxu1kD7SbgvOwbgdr+Ov5yjrGRVBbPoj38MIomNA5pQtVDrIymj
	qfo/v/39TA6jiXaaOZXkhr+0EASKcgP80nXAeVL4WrgemOzXajGNo2ZW1H3NTqDx2c7H27p5TZF
	D/CoK1Kw7H0Tai6VGH5WnC+tZQ6g=
X-Google-Smtp-Source: AGHT+IHkHJAffORh/fW3JTP82vIu6+jz/+0vhRELYfwxdDzNLlmrBuVUB//vF1C2NY1AK6LLpbrHXW9egpFdPauocUA=
X-Received: by 2002:a4a:bd89:0:b0:599:2b86:993 with SMTP id
 k9-20020a4abd89000000b005992b860993mr3258671oop.0.1706125980540; Wed, 24 Jan
 2024 11:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-35-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-35-keescook@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jan 2024 20:52:48 +0100
Message-ID: <CAJZ5v0gLr69vzLr_+yhP4z96nzFZjDfaPR-sTdkiv08vHbBe7w@mail.gmail.com>
Subject: Re: [PATCH 35/82] ACPI: custom_method: Refactor intentional
 wrap-around test
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:03=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow()=
.
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/acpi/custom_method.c | 2 +-

I may attempt to drop custom_method.c in this cycle, is there a
problem if I take this into my tree for now?

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index d39a9b474727..0789317f4a1a 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -54,7 +54,7 @@ static ssize_t cm_write(struct file *file, const char _=
_user *user_buf,
>
>         if ((*ppos > max_size) ||
>             (*ppos + count > max_size) ||
> -           (*ppos + count < count) ||
> +           (add_would_overflow(count, *ppos)) ||
>             (count > uncopied_bytes)) {
>                 kfree(buf);
>                 buf =3D NULL;
> --
> 2.34.1
>

