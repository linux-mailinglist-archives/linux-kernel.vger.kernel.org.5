Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335A7FFD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376801AbjK3Uvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjK3Uvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:51:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BDC170E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b35199f94so43075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701377508; x=1701982308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0w0LWsaVhx7toijCRasOWOsbuYywvP2QO/AJh+x5nA=;
        b=bSwEsTQnp+crTLTYct7mku2qJuzj8DUAMNj6KRQfs2JpPRtbh4c1kwhok0CW257zo3
         eL4lIO2XcRVBqZl2eYYbFoKMP8DglA/2FAP/o2pNpUocE8oR9OEz1c8/hrwARmVCqV7T
         H2QEKGd0mOI39A9DtYVAUj1TMY55o+rqyOb7KkIIBhTxYYCGT86AbZ6XEafP4gnrATdK
         Qw2C6glat3peIhbLicbfNvWJzz6d6V3Ztl6RF+ohxSEFeAfeCbaL3z195HJG+EhSHz4N
         XATr59VwSpe/DZTnPDRRSwEdlHakXs42TJK7giDX57erDHdKv6GxgdP7DeYI+Vw2jfCU
         g0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377508; x=1701982308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0w0LWsaVhx7toijCRasOWOsbuYywvP2QO/AJh+x5nA=;
        b=hPZ/HTolM8b65E91G3pQg37moPGcER+/OSL7PT4tffwFZRe3seVt5wYZhUK9hdzmqM
         si+rz1/+WQPRqIfrPZ0bEALJm8eSgItsAFIHm4YlBPJM+wRdy7pCYBjq96jHsYJTOd9D
         HAosKJlqgB4B0PQ2zNBJgoMyG/OewgZSw7nVNU9J2zAfZl7aowDR7HWhSjuQB1Gwgykx
         k/deDgOyYy4FXHhNr99m4uDvBTdFjiEBE7kN/Eq2nFsXiLAfSkkiBF+gPE/Rqy3DAqFV
         le5i44M+5/PiEAApd+atT4SzGyu8Fnejk19CR6dBeHU1joIJLX3J/sVxc21/ikR6WcG5
         rerw==
X-Gm-Message-State: AOJu0YwMgRuFHdIsWhY3QbuiUTctmpOWcwIjUqzYBLbNtbaiJmBZrxDM
        g2y8EB3ZhA6uhKF5G9jJIBSYuceTZPowCQjLoQ+nCQ==
X-Google-Smtp-Source: AGHT+IEWmm4zsK7trudVYwAf/DSQ/1DbDzKa3t2Na71SAO1Fo9gW6aO96foQVVUNCaJicwhtrG1KXyXxqnrGD7i/HQo=
X-Received: by 2002:a05:600c:3089:b0:40b:2979:9cc2 with SMTP id
 g9-20020a05600c308900b0040b29799cc2mr15935wmn.1.1701377508071; Thu, 30 Nov
 2023 12:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20231030104746.241414-1-rf@opensource.cirrus.com>
In-Reply-To: <20231030104746.241414-1-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 30 Nov 2023 15:51:36 -0500
Message-ID: <CA+GJov7r9AiQSfFrWZLCL5SDtM2J6RND+zy_ieHGq8H1pJO5Mg@mail.gmail.com>
Subject: Re: [PATCH RESEND] kunit: string-stream: Allow ERR_PTR to be passed
 to string_stream_destroy()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 6:47=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Check the stream pointer passed to string_stream_destroy() for
> IS_ERR_OR_NULL() instead of only NULL.
>
> Whatever alloc_string_stream() returns should be safe to pass
> to string_stream_destroy(), and that will be an ERR_PTR.
>
> It's obviously good practise and generally helpful to also check
> for NULL pointers so that client cleanup code can call
> string_stream_destroy() unconditionally - which could include
> pointers that have never been set to anything and so are NULL.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

Sorry for the delay in reviewing this patch but this looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index a6f3616c2048..54f4fdcbfac8 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -173,7 +173,7 @@ void string_stream_destroy(struct string_stream *stre=
am)
>  {
>         KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
>
> -       if (!stream)
> +       if (IS_ERR_OR_NULL(stream))
>                 return;
>
>         string_stream_clear(stream);
> --
> 2.30.2
>
