Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA120758505
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjGRSrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:46:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C139B6;
        Tue, 18 Jul 2023 11:46:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b012c3ce43so4096366fac.3;
        Tue, 18 Jul 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689706015; x=1692298015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCMVug3pl9wzqAuL3sW58dLeqmSR5GH0lj+Naew2jl8=;
        b=TpDtNGXKtqv+eNLYqwYoP5G3ymNfjn4unQliKraWnIORl3l/u7mizN75s/qmx5ky3i
         7FnZ6VXRr200y/hAzUtCURT6yUyT3hoRVmEt3u6ynOqvjPWH0pLClClCgc9ryvuz0DOh
         s6mLnmvWIe5PML2f95GjcfBogD8eUkxZBUdO1q9FbuSR/4CNrIUbO443kbxwlSHSAcXB
         vntEjfi6fg5zXPEp4PPTDXoLFnz27tm6umeTbGMh0jfHL4OABzqmJAI3hDrGzFE4TJNt
         foY//OCstMxNHQ/aQXYkX231sfcPypN6OE1ZgRjfuEw6Yyc+DeJhqfJUKjd6ulZWWZU5
         963Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706015; x=1692298015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCMVug3pl9wzqAuL3sW58dLeqmSR5GH0lj+Naew2jl8=;
        b=K2ZSu/1nqQXWxABxmJ1NCFb9jPWQnzp9YhDEDFSVC9209ooCDo+rvd4jZC3WhQ/EJv
         XLiw9aV37maNCX/83bPJcJn9HZe/y9fnUfjRHPac6hbt86vAnnRHjrOD1TJxK5lGEdxF
         4enLeqOL5zUlrJ0yDh+xrvxDFwrZ+rxxQMy3nw9F8FZuKKBD+lnuKUMfPXYHNi1La3xY
         wku0EoRlaTYKxmhZDLINauz2fyafqk9gYZ9UWTPOaOtgrIM3syRrYwUVcQEzYkAINNFs
         Qy1ifFk7d5Bm89rKxPDnD3ucc78oUswGU+HSeYFxWt+xGi3FaHU3PNCEx46DEUO3QnF7
         +X+Q==
X-Gm-Message-State: ABy/qLZ+HziF9U8uLLQFAjOE0fIjKK8Xr7ZCjfGSAGBAbAXKtxW+F2yV
        WGDFFRgwQ4Tvdh2AyzYcpcjzj5pBR3AvWEW3k6M=
X-Google-Smtp-Source: APBJJlE3OL5mrDrZgm1kUvsYuh/StsHqPwwMwWt8k7EhBP5Lu+XHAQ2mPoDJ+2ODKNICuesiO8Q7rvCb7YkeY24sov0=
X-Received: by 2002:a05:6870:315:b0:1ba:caf2:acc3 with SMTP id
 m21-20020a056870031500b001bacaf2acc3mr148395oaf.5.1689706014859; Tue, 18 Jul
 2023 11:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230717192004.1304287-1-samuel.holland@sifive.com>
In-Reply-To: <20230717192004.1304287-1-samuel.holland@sifive.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 18 Jul 2023 11:46:43 -0700
Message-ID: <CAKdAkRT6YoXiJfHQG77AJsp3KjoFr=qNmJWU+8xBdqN2PR_2YQ@mail.gmail.com>
Subject: Re: [PATCH] Input: da9063 - add wakeup support
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:20:03PM -0700, Samuel Holland wrote:
> Mark the IRQ as a wake IRQ so it will be enabled during system suspend.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Applied, thank you.


--
Dmitry
