Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554577627A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHIO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjHIO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:29:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34791FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:29:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so107899571fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691591374; x=1692196174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8FitPhYl1bw/RbzqKoKTQcV3ylIG1k/12INyc5DHZ8=;
        b=DV2B5uOxm0xt7UyOES30f0HxFNx+7J7iBW6mvXOlUTaVfhDY3ZJfUIMIAasBloG4fz
         9lvBGnbWWSDdEOvRkLRYdRoix0+UV9YbGEULfea/4wKelbVYFuLfOt7i+b0tC088AYUJ
         IqGdzYUjar3PLnEEqFh88ynZfHPLo5SxBWVJdxcW6D0M04XXY7+9GVB07/vRQ8cwlJ65
         qztX+MBHVWmFZb6Z/2jwuJh4b+XbGzKJT/ZiyTpBVbd4MI6dcJElEIZcOdewAF8B0eGx
         M1yrYYdifX0YMkh/4B4avzvfkoFrn6PiXCHbIkK4ZglSg/yly3sSV/48JeivOiscumi/
         T5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591374; x=1692196174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8FitPhYl1bw/RbzqKoKTQcV3ylIG1k/12INyc5DHZ8=;
        b=fssjpFqhVlWJMbl3EAgswyqOBD+iq1J9sXLoZyBxAO8G0qeGuZn5QKJgo8WsxMiwlx
         p0O0SvaZAei3Dj67Y5G8azm7fqFJUzc9wsDfaOhottBVSa2Me4ptVe5gkgDFnOhLpMvX
         YRIPAOTBK/eEAUDEMSZBhSKwm5Ff4a1QZGmFfY3BrZQ3karvzUi7l2qFXbUcclyWaK64
         J78Tj9kg99KhwREtyNrD/WVHf3Ygbh9AIasm5y0FcRWhFxLscKGD66upKmtvFMWGcILN
         gVZl8m4bVhNxlxmAXdNUzqjHwX1wD2dlnREMyru4bSY2U0B/YcXxcoEmt3J+S1q2iSkd
         mCkw==
X-Gm-Message-State: AOJu0Yz3yXeorKTd1cLKcK6vaOHnG7OFc5uMEGo9LwBZd0FdWsZkF8KG
        lyoI2pUXy/6EDqCo8w9Fqr46YUDNEIKgWQ==
X-Google-Smtp-Source: AGHT+IH5rkstwyUYASBosdCGaItnG09JoYLdgtEi5/UoDU+8EBPkBlpWWYECaN+yeFMdiryAYsnqtg==
X-Received: by 2002:a2e:9195:0:b0:2b9:acad:b4b2 with SMTP id f21-20020a2e9195000000b002b9acadb4b2mr2206921ljg.6.1691591373921;
        Wed, 09 Aug 2023 07:29:33 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id gw1-20020a170906f14100b0099b8234a9fesm8186866ejb.1.2023.08.09.07.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:29:33 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:29:32 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <ZNOizFnDXojT4s85@nam-dell>
References: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:59:40AM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Alignment should match open parenthesis
> and deleted the trailing whitespaces as reported by
> checkpatch to adhere to the Linux kernel coding-style
> guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
> 
> Changes in v3:
> - Rebased against staging.git and staging-next branch, noted by Greg KH
> 
> Changes in v2:
> - Fixed changelog, noted by Greg KH
> 
>  drivers/staging/vme_user/vme.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 977c81e2f3c7..741593d75a63 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
>   *         returned.
>   */
>  int vme_master_set(struct vme_resource *resource, int enabled,
> -		   unsigned long long vme_base, unsigned long long size, 
> +		   unsigned long long vme_base, unsigned long long size,
>  		   u32 aspace, u32 cycle, u32 dwidth)

As Greg said, it doesn't look like this in staging tree, so your patch doesn't apply.

However I look it up and the last change to this line was 12 years ago, so I doubt
that it is because you didn't rebase to Greg's tree. I think the more likely
possibility is that you have a commit to this line yourself (by mistake perhaps?),
and this patch is on top of that.

Make sure you don't have any accident commit that modifies this line in your tree.

Best regards,
Nam
