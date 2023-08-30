Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3266C78E11E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbjH3VE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbjH3VEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:04:24 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA081A4;
        Wed, 30 Aug 2023 14:03:53 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1c8c44053e8so47995fac.1;
        Wed, 30 Aug 2023 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693429049; x=1694033849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6USKCRgwFTnMr5JZyE+WRG85qO3YFB4j+6ZOgnTQjlU=;
        b=q/Kpciv+NrW3EJBoWEdXwkxWV5vQdU//vTFoxEXijs0XiON94y2guranPhonheB/mG
         1xRAEgpqmJ1UiU0V2hXO347Mm3lRVy78IIfoYdVWsPEzD9Gz8qig/HOfQE8HtTT6Ncnc
         kINZEv1lnCG8qCcMVuxFLymAzB9/j9+h7+Sb/dxjegVXP8Qwef8nsbd6/jDpyyz8C2uR
         tSywtv+e0KYAwApzgt7lR3f+a9XC0h5tmYB5+P/qRvk9vx/2S5FJbUcGVQ7Lp/MjCWhW
         iIg8spCkGPutOWqk4k+Wa0yNwHhjTEmDVDuFRumevziq0uIVIxiQIbXyCG2VoDTe0ZvH
         vn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429049; x=1694033849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6USKCRgwFTnMr5JZyE+WRG85qO3YFB4j+6ZOgnTQjlU=;
        b=QxEKXkA4v9Ro8AKbS34tIzw+Jcj6UvITviH2zn6NmNr001zKmGT6uwqXzn1Dia6nZi
         CNgbC0SfAZ2YEt2pPqwA/PQDmN8xT+4ufh0cdjCImj01efh/rrFaiPnHPyNKhmFQQ9WY
         haTkPeZv0AMmxLgrVAh67zSVjXfiu+2YWgKvLElWhqlIBxHt0OJTLLTj+oTaCHQi9RNC
         ku+bf1WBs/p8NIbXWZ2zQ0rJPpFuWmvnb4xOEk7jB0/EeKjGZ5MdrTpU2VkvYMHqL5Af
         TOS2DQ/wk3b9zTly90CguvvPzYwdTu3hd7wys5oJGw966wKbO0w4rQBYAUvPYnQQaMLG
         pC4Q==
X-Gm-Message-State: AOJu0YxJeg92ZGdE9GPvZ887RpNNlBRZgownBHFJ0Wy1kE/uyFl3pUga
        q6hOVdx9eCHwkehtKWb5EkOMsluQ3mMAsw0Um2WG6jAviVWH2/SN
X-Google-Smtp-Source: AGHT+IGo8bBpm9gH4Qw0N4LG6dV9LXJofj/Vhyv+pLhvc5DT0+EA2AxG8JZUwOz8DwLQ8qgDfsOHeWL8WKM7Pu3+QTI=
X-Received: by 2002:a25:557:0:b0:d7b:97c7:c537 with SMTP id
 84-20020a250557000000b00d7b97c7c537mr488807ybf.32.1693426305012; Wed, 30 Aug
 2023 13:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230830200717.4129442-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230830200717.4129442-1-azeemshaikh38@gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 30 Aug 2023 16:11:34 -0400
Message-ID: <CADmuW3Wfryaj7gGLQhVwJm4eWbEoaQ50k_BwgEWfO+ETKWkNvA@mail.gmail.com>
Subject: Re: [PATCH] scsi: target: Replace strlcpy with strscpy
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch. There are more strlcpy()->strscpy()
replacement in the same file that did not get included here. Will send
out a v2 with all the changes to make it easier for reviewers.

On Wed, Aug 30, 2023 at 4:07=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/target/target_core_configfs.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/targe=
t_core_configfs.c
> index 936e5ff1b209..b3d2c14e2ea9 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struct =
config_item *item,
>         /* +2 to allow for a trailing (stripped) '\n' and null-terminator=
 */
>         unsigned char buf[INQUIRY_VENDOR_LEN + 2];
>         char *stripped =3D NULL;
> -       size_t len;
> +       ssize_t len;
>         ssize_t ret;
>
> -       len =3D strlcpy(buf, page, sizeof(buf));
> -       if (len < sizeof(buf)) {
> +       len =3D strscpy(buf, page, sizeof(buf));
> +       if (len > 0) {
>                 /* Strip any newline added from userspace. */
>                 stripped =3D strstrip(buf);
> -               len =3D strlen(stripped);
>         }
> -       if (len > INQUIRY_VENDOR_LEN) {
> +       if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
>                 pr_err("Emulated T10 Vendor Identification exceeds"
>                         " INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDO=
R_LEN)
>                         "\n");
> --
> 2.42.0.283.g2d96d420d3-goog
>
>
