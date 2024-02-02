Return-Path: <linux-kernel+bounces-50093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCE847425
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F721F218EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161031474CE;
	Fri,  2 Feb 2024 16:05:10 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10491474AA;
	Fri,  2 Feb 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889909; cv=none; b=GcbH/Wb7C2gq5vnBZ9LZtRcSuQIFDJGb7F+HG0Ia6xEOnHmmNGdSaKma5q+DJJsGy83SkAwQvdPlUSdtPBmAG35rTV7ya6coPNDEt4V1UOlbp3kIVGyGpZpB7tvGyiUnWgHUoYMSydYugz+rskW92u6W+U3p1yL49/eSsm6+Jl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889909; c=relaxed/simple;
	bh=l8joaKMVVu94Gn+N3rz8Ln/DlxXxbBOGkRC5IzLqW3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIz71eDPs36kbnkf0k/kzGior9NBEUwNf8Og39BglmcC9u3k+x4ipdAgaBAIMzbe9qTinV9fHilivFmmFDqMAHV8vU1+eytD1Jrbcw93D0E3yjOi93ym7uwx7+/AQODK32F2wO0j/KMEKX1IU5J6ppphxNhvw6REOw2libt7PMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59584f41f1eso674790eaf.1;
        Fri, 02 Feb 2024 08:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889905; x=1707494705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44DDp+9sdekQWew+SL+SIN16R0d8VDB+yLicT1mrJmc=;
        b=b1R7YdFougVKIV11WzID+NLipql25rwl2q1GSijrjjKLDeTm3uaOC+kCaWdv15+Psj
         cIkN4RWGkixzkt4BAMevIbiRZxVAYgh4M7GMMp9h9hJ9DcJoQLjTjN4pmB0D0q1lTEq2
         paUOGbe8Te9EXqhjfOy6m+oN7lPHd8pNcIKaqs1cmO10vGeBqV9WdUrwrhqGek8qC0db
         UxSmgOSAGCj9eK4JaDLLnvo/lqhrxp3RRLCAfXG9EDUNQ/ShW2cNRYwpaZkTpK4LDE9U
         QDDcbs0PPcOeu0+oyn6qVzK2NSJWURR+GkeXAYcKETnCDU8zOW6nh603JRSieSOm9L9e
         0v9Q==
X-Forwarded-Encrypted: i=0; AJvYcCXFlxLRco4P2RevYRJKrzvBCbNJZ/CGWXNOIWozT4HTmifw5iZyciBRQhxawh9iQ9WawZOTPlpdeMpyJeSELVsV4XGEI97YCfDdcFw5Z7mzDwffM9n/omCChsLY1AmsOnTB0bYl+UXBkA==
X-Gm-Message-State: AOJu0YyYederUvyGwXYpP/dhto2o6iJbRm++l95/TgCUD/5BrjMxbzP1
	lu2hLEM4jj8E6/INSnDb3YO3sX/troDu8XYOiM6PDXQopC/qwkr1EletuQe9IQeRL5PlVwsMJXr
	RkkTEPQ+GMKTMjHdD9KA297BVOzew1O5U
X-Google-Smtp-Source: AGHT+IGCxiuaTIcNgjndNzOEbvIVYklyZFacA2m0gaZJaSfm+6/FZAPabx+BtGol3yyEnb3KUjoz+irs4Y6V7KOZE98=
X-Received: by 2002:a05:6820:1c96:b0:59a:bf5:a0da with SMTP id
 ct22-20020a0568201c9600b0059a0bf5a0damr7525643oob.0.1706889905114; Fri, 02
 Feb 2024 08:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 17:04:52 +0100
Message-ID: <CAJZ5v0jVq=xiZ8gY=LvRoB6RH3ud139-4BdsmkPkuaJaOS=Tkw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use swap() instead of open coding it
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
>
> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING opportunity for swap=
().

In order to modify the ACPICA code in the Linux kernel, you need to
submit a corresponding pull request to the upstream ACPICA project on
GitHub.  Once that pull request has been merged, please send the Linux
patch with a Link: tag pointing to the upstream ACPICA pull request
corresponding to it.

Thanks!

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8168
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 1bb7b71f07f1..ccd89a82a4e6 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
>                                     obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> +                               swap(elements[j], elements[j - 1]);
>                         }
>                 }
>         }
> --
> 2.20.1.7.g153144c
>
>

