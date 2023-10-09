Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76F37BE3AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbjJIOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbjJIOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:55:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299FB4;
        Mon,  9 Oct 2023 07:55:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8142706a12.0;
        Mon, 09 Oct 2023 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696863344; x=1697468144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j46zcTawL9T8Eu71NYkiSsHKaV8Y8edTrMAxgjTz/ZA=;
        b=jZhec/jB88YSwmFu/kKS5zdshJdIA/g5qcmnEmW1daPGE97VukzmR+Txr3tFGK6BY0
         sq4esXhhs2LBeUZoESeJQ/6dkE6dYGEdJauisl1pTHJsNL8EfkujJhfVeWDBy0eFCiS+
         UxIASDi44n3sIGonnOXn9g0oat/iARoWiBm0Fzff95FcxaG/Gmbzyjmwk56H2EhxCyNY
         wuiAyYGdypZouQTqde58rvGbzIygZtm4fqmRHgoeWoPSlERRnWZ+zwxjCLNqss/cVyyx
         8ONolAzxPGj9JETz0BVKf9TUEvf3RIXGXe9OrDTjcq1A7WjLI657C0VxOVTKCRtzdPBD
         P7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863344; x=1697468144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j46zcTawL9T8Eu71NYkiSsHKaV8Y8edTrMAxgjTz/ZA=;
        b=QhuTTD/aJJrQ9bga8IVENuhLtAFkE1A3iw3VKLl7hwGR/yzx1NhFAgCsZWK5Ccyoz6
         8EJWH/glgVitkB2WZD1JLNiCK+0Ej9O6PQwS56YTeT/wJ8RuxV8+KxEyt9fBRYYpgune
         D0e9gcVS7UZ4JqRTs0UB6LgI1YbKa4PQQArRfMxXUywZ6PwgSnBCkxhQAd5wQC5KzriZ
         dm0LWwxL8fA2i2YPq9WMQNf9u7ekH+KDyfWo7CjiXlfzH0goNTRWQDsx2p6whzJL/FpO
         095FfNXy+sXTwKWEY27Q9pE0FhTB5RS2RcKFP/+DM/RFvhbkvtvtnE8edygPcRnIcChX
         UT7A==
X-Gm-Message-State: AOJu0YwF7EwO/tOQH4Fb2QqATzoUql0Ft366+T61uYRmCgoY3YQ0VMM3
        AF6j8FiOF6HmYG+PUyn77lXgFZCJv61qFu2W85s=
X-Google-Smtp-Source: AGHT+IG/gvihxcr0lSXmqhzAg7KinQRPWFPXtOnHdValzaFrait68oMnzm14gRBytChi/uOqO5waYy/elg9FWzQgwsw=
X-Received: by 2002:aa7:d506:0:b0:533:23e2:c48 with SMTP id
 y6-20020aa7d506000000b0053323e20c48mr13245977edq.3.1696863344225; Mon, 09 Oct
 2023 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231006201719.work.356-kees@kernel.org>
In-Reply-To: <20231006201719.work.356-kees@kernel.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 9 Oct 2023 10:55:32 -0400
Message-ID: <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: p54: Annotate struct p54_cal_database with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I randomly peeked at this patch.  Unfortunately, I am not familiar
with the actual p54 code.

On Fri, Oct 6, 2023 at 4:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct p54_cal_database=
.
>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/wireless/intersil/p54/p54.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wirele=
ss/intersil/p54/p54.h
> index 3356ea708d81..770e348d1f6c 100644
> --- a/drivers/net/wireless/intersil/p54/p54.h
> +++ b/drivers/net/wireless/intersil/p54/p54.h
> @@ -126,7 +126,7 @@ struct p54_cal_database {
>         size_t entry_size;
>         size_t offset;
>         size_t len;
> -       u8 data[];
> +       u8 data[] __counted_by(entries);

This looks incorrect - I think you want __counted_by(len)?  The
presence of entry_size made me suspicious.

>  };

This is the function that creates struct p54_cal_database:

static struct p54_cal_database *p54_convert_db(struct pda_custom_wrapper *s=
rc,
                                               size_t total_len)
{
        struct p54_cal_database *dst;
        size_t payload_len, entries, entry_size, offset;

        payload_len =3D le16_to_cpu(src->len);
        entries =3D le16_to_cpu(src->entries);
        entry_size =3D le16_to_cpu(src->entry_size);
        offset =3D le16_to_cpu(src->offset);
        if (((entries * entry_size + offset) !=3D payload_len) ||
             (payload_len + sizeof(*src) !=3D total_len))
                return NULL;

        dst =3D kmalloc(sizeof(*dst) + payload_len, GFP_KERNEL);
        if (!dst)
                return NULL;

        dst->entries =3D entries;
        dst->entry_size =3D entry_size;
        dst->offset =3D offset;
        dst->len =3D payload_len;

        memcpy(dst->data, src->data, payload_len);
        return dst;
}

You can see that kmalloc is performed with `sizeof(*dst) +
payload_len`, and payload_len is assigned to ->len.

I don't read Coccinelle, but, if this patch was auto-generated, I
wonder if the script has an error.

Regards,
Jason
