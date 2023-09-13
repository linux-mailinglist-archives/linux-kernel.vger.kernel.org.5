Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB679DD92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjIMBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjIMBa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:30:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3172171B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:30:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so8059246a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694568623; x=1695173423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS8SEj+1zaeA13vnr/L8JD68DOc4KH8YhBKHOXjjHQI=;
        b=0CKsJXsxQ8TswVwNwUNdDH7eLV67PcFnQSsd6nrwoVNNT/T5txHT+CSsm5tFWRHcaI
         vei6NMkoP25iFoBCh23Rv5/tnX0iZsy7eI2ZOnq7lMVA+vqeowkFUhpVohO1rrwPmRng
         vpb5jmF9eH/RqDAn6IfJYFBbAdjL2SLMEfNeTxEqVy3iLJ1X1o80qP+5N+q1uJ5Gz1oX
         YOkx0BdbtO9Q+hwnOc+/lP1UlYejo2pCEob92QWEfFsZ+MozWpS2d7iRp+VyXKSQkNnn
         tG3S9KEmddNSRVgYJIoo/naXGPQ9l0ztchsQLRwrt0xyDzjTM0yqMNwNqbhgv9+ZqwL6
         DkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694568623; x=1695173423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS8SEj+1zaeA13vnr/L8JD68DOc4KH8YhBKHOXjjHQI=;
        b=e14vb76q1wwJGLEdqlisuN0H4oA5mDQX5qKHZW4TnsY5Y5phzdQsNJuRCmCey2g7yj
         Zt2n3hX485Zt2dJ8rt8cePM4GaRemPNC7GCHVOIQuvQeYETZjhiYXRv6Kt2MPB/gT8S4
         d43qUPkxOr01NMVUFcTN8dQLQrHFHH040ViM/kf/3J4/4Xlo98z97m8YtOLLp6Z6SoiN
         +Cf/1FJmd4d4bKWvc2MDRrnAuurWT/cq/p3E71+o1YJAtRUTqx4bmYMmSLy9foUqWKZM
         M36KldSlTu5D+2quBYijj6DRrIItvEbHlLDtggumfLHMwOnLMtLprKYtKxQ51YLMb1uU
         MAzg==
X-Gm-Message-State: AOJu0YwyyKize0WD8WJ9GlriaZgKNrxNVnSuu/Id3gERqrwIUjsm0wQi
        zj7qDbkdjqO0oEqZNIn8utDNIkMkLP3azEoDKxeRbg==
X-Google-Smtp-Source: AGHT+IF+8PrFLp3wpewuEVn+bHYYKVvRzHZnMOswySbpEt5vKlsjn5f/ngk42dnNqgqMGcsc86hGujDbw+1tV3NCYD8=
X-Received: by 2002:a17:907:762f:b0:9a9:fb1c:34ff with SMTP id
 jy15-20020a170907762f00b009a9fb1c34ffmr682229ejc.73.1694568622990; Tue, 12
 Sep 2023 18:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com>
In-Reply-To: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 12 Sep 2023 18:30:12 -0700
Message-ID: <CAFhGd8pGikrizmQPF7qD6C4NcYqBVqECEUqb0j_4fuS3rqeeXA@mail.gmail.com>
Subject: Re: [PATCH] EDAC/mc_sysfs: refactor deprecated strncpy
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:26=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>
> We should prefer more robust and less ambiguous string interfaces.
>
> A suitable replacement is `strscpy_pad` [2] due to the fact that it guara=
ntees
> NUL-termination on the destination buffer whilst maintaining the
> NUL-padding behavior that `strncpy` provides. This may not be strictly
> necessary but as I couldn't understand what this code does I wanted to
> ensure that the functionality is the same.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/edac/edac_mc_sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 15f63452a9be..b303309a63cf 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device=
 *dev,
>         if (copy_count =3D=3D 0 || copy_count >=3D sizeof(rank->dimm->lab=
el))
>                 return -EINVAL;
>
> -       strncpy(rank->dimm->label, data, copy_count);
> -       rank->dimm->label[copy_count] =3D '\0';
> +       strscpy_pad(rank->dimm->label, data, copy_count);
>
>         return count;
>  }
>
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

I typo'd my grep and initially missed refactoring another instance of
strncpy in this same file. v2 [1] resolves this.

[1]: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-=
c-v2-1-2d2e6bd43642@google.com
