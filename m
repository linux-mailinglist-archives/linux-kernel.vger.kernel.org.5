Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02CF7B6D28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjJCPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbjJCPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:30:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E155BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:29:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5033918c09eso1242959e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346995; x=1696951795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amro8Gq6QWRGZvPI8kQ8K9MaGGmsh2qAsN2cjlX45YQ=;
        b=C4vwP/YRS+PaN1DO/5xZBx/3P8upUxPw87HBcOcnh+QWDLvmv4pLsi1bQButNXigkz
         rrVKBZz6xfmJldDWDyt4LJb5NmxFXarIqprw8jf4Y84Msittsjgp2w1tiLpLlsacsK/l
         N1/c62Zyq8jI2jc+DCpwXZ7mQtlMJSjoGk0QbG41NQSnV5x913mgYLdXS6RVFjNFzoRT
         k8yQP1f7vNkNbIMk7F4NAfer3//gM2LDxLyYjo5NGhCum7UKMSn0tEtEKCIrLlmUmqZK
         sZaWGmlmZGB3MmzrtxZaiIICpgNcyi4kXuJnc1gPKESTJMRRxdcaJ+58oak5+8a/Fgpg
         2ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346995; x=1696951795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amro8Gq6QWRGZvPI8kQ8K9MaGGmsh2qAsN2cjlX45YQ=;
        b=mvSz8RPEZ87FQ0toLerA5tlFxVjRw4Gu3CeudtEne4fmaMwgeFF5yCOlvjAXkzfyTY
         AIvCD9msBaS7WlggzgFKDbezkQxOmnbmYT0Un8+z8bu9S6Ln2YsYqpqlwFykQBvNOnmq
         v1ys7Eo24JnV7VrG+TMyp8coO30OPk00FG/JyTImnQPe0RrMbKUigCHkqDEU3tvZjtaq
         jjYun+L/X/AANaDb2idkXq8ceufoJP3ssS9Dgk8qazDb4hLvpUQlm82GgL299b8TWUQ7
         2sAXzNynVZlJLH1Mo7i5lbbybfZOROCFqZ+xjHsFZxZxoemqig4AAtEJX/ZK/To0tcFa
         3zIQ==
X-Gm-Message-State: AOJu0Yw979NoTefyIayeyaNWCnxtWHRQ6xeOLOEKpNY45vOWAP9OQtjg
        0OApUmmmqgXI/rP4iDE+bmG53Sb7Hstw0SbH+xyVjg==
X-Google-Smtp-Source: AGHT+IGx0FgrW2Ah4ADgj45zfcrPkZEtVTpoj4C20Ji+ONiK6KoICzW/yWQ22hIx9FDK7G+rLghZBNV93m9mJQ5IaUo=
X-Received: by 2002:a05:6512:1246:b0:502:cc8d:f1fc with SMTP id
 fb6-20020a056512124600b00502cc8df1fcmr16458163lfb.37.1696346995109; Tue, 03
 Oct 2023 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231001003846.29541-1-rdunlap@infradead.org>
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 3 Oct 2023 18:29:18 +0300
Message-ID: <CAC_iWj+rqx1v1s6p3c92iv_nyzNOA7bRX=vLZPsHOSryXrmycw@mail.gmail.com>
Subject: Re: [PATCH] page_pool: fix documentation typos
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy!

On Sun, 1 Oct 2023 at 03:38, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct grammar for better readability.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/page_pool/helpers.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -16,13 +16,13 @@
>   * page_pool_alloc_pages() call.  Drivers should use
>   * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
>   *
> - * API keeps track of in-flight pages, in order to let API user know
> + * The API keeps track of in-flight pages, in order to let API users know
>   * when it is safe to free a page_pool object.  Thus, API users
>   * must call page_pool_put_page() to free the page, or attach
> - * the page to a page_pool-aware objects like skbs marked with
> + * the page to a page_pool-aware object like skbs marked with
>   * skb_mark_for_recycle().
>   *
> - * API user must call page_pool_put_page() once on a page, as it
> + * API users must call page_pool_put_page() once on a page, as it
>   * will either recycle the page, or in case of refcnt > 1, it will
>   * release the DMA mapping and in-flight state accounting.
>   */

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
