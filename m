Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D017BE62B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbjJIQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377879AbjJIQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:18:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF1B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:18:57 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c61d955161so2634656a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696868336; x=1697473136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0reFAzRvsauKybkytWT5W1CKofJm2eID7oqapjKx08=;
        b=V/iqhpWmL9Cgty9qrRXg7bykSEGdMWCqRgut5QwEOAssm/zQpV4CqYu9yzweYYltsI
         cbO/Vx5FW6cvuKFuZULC10KmuNwnpK0wW7TeT+NZUAPPx/f7rnhPSkZV54ZM7DKoiDOX
         YX3p90CYOn8QgoHVmM6etTgtfUuLH3VkIE3DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868336; x=1697473136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0reFAzRvsauKybkytWT5W1CKofJm2eID7oqapjKx08=;
        b=I+S3MoSnST85evLzmdhA1JLso0JzuMuy2YbNSmDtCUog9w/TuUKqxbIGZxa/KMb77i
         OxBqu9yUkTHHIsz8Rc6J0kqbi6rQAP7ctMNPPk8AcZ3bfFnfaMVt2ao+VfU/EHF5sqcl
         VV1oTjVslLx471YEFl+7uj9qgDya5HF+YIme93oyCES+Bmi5dYLJWEn4CoAl7chBjVi9
         kXPitXBAoEL2/NsqSIA047CQa6ZkD+xHpTaLU9Ge+e4FV5b5VFE8NQUGsxIyIs6kuyGP
         Hho7Yesbe67PNm/XBZKVZszVkmuiqjTQF13gkyizoS4HhSOzNotvcAZkRqZdrbmUwNfz
         l90A==
X-Gm-Message-State: AOJu0Yywjn0uyN9OR8xiBTiI0QKJP5Cwj87g7GHLzpY2OF5yRzo4f2uZ
        E+PUAfeN0GlLxFnh281GHnqA0Q==
X-Google-Smtp-Source: AGHT+IGXnFxbwBWQ4z54uFIjZfW6mWOyC97H3o0aqCnpeOHfg+GS9hRTB9FmGO2olXW3iQcatkcdFg==
X-Received: by 2002:a05:6830:4875:b0:6c7:c723:c31c with SMTP id dx21-20020a056830487500b006c7c723c31cmr6665192otb.37.1696868336427;
        Mon, 09 Oct 2023 09:18:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w25-20020a639359000000b00553dcfc2179sm8659990pgm.52.2023.10.09.09.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:18:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:18:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] wifi: p54: Annotate struct p54_cal_database with
 __counted_by
Message-ID: <202310090914.A6BAAB9@keescook>
References: <20231006201719.work.356-kees@kernel.org>
 <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:55:32AM -0400, Jason Andryuk wrote:
> This is the function that creates struct p54_cal_database:
> 
> static struct p54_cal_database *p54_convert_db(struct pda_custom_wrapper *src,
>                                                size_t total_len)
> {
>         struct p54_cal_database *dst;
>         size_t payload_len, entries, entry_size, offset;
> 
>         payload_len = le16_to_cpu(src->len);
>         entries = le16_to_cpu(src->entries);
>         entry_size = le16_to_cpu(src->entry_size);
>         offset = le16_to_cpu(src->offset);
>         if (((entries * entry_size + offset) != payload_len) ||
>              (payload_len + sizeof(*src) != total_len))
>                 return NULL;
> 
>         dst = kmalloc(sizeof(*dst) + payload_len, GFP_KERNEL);
>         if (!dst)
>                 return NULL;
> 
>         dst->entries = entries;
>         dst->entry_size = entry_size;
>         dst->offset = offset;
>         dst->len = payload_len;
> 
>         memcpy(dst->data, src->data, payload_len);
>         return dst;
> }
> 
> You can see that kmalloc is performed with `sizeof(*dst) +
> payload_len`, and payload_len is assigned to ->len.
> 
> I don't read Coccinelle, but, if this patch was auto-generated, I
> wonder if the script has an error.

It seems that my Coccinelle script got confused by this:

p54_convert_output_limits():

        priv->output_limit = kmalloc(data[1] *
                sizeof(struct pda_channel_output_limit) +
                sizeof(*priv->output_limit), GFP_KERNEL);

	...

        priv->output_limit->entry_size =
                sizeof(struct pda_channel_output_limit);
        priv->output_limit->len = priv->output_limit->entry_size *
                                  priv->output_limit->entries +
                                  priv->output_limit->offset;

It thought "sizeof(struct pda_channel_output_limit)" was the element
count, since it wasn't able to identify the array member here.

Regardless, I've sent a v2 now. :)

-- 
Kees Cook
