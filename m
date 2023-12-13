Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57A58122E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjLMXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:34:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DBDDB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:34:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so195972266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702510494; x=1703115294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmKUeoxDw6l+n+MCYivR63GVY7ugnAhnYXWP7qAfaXw=;
        b=GysVPTOF8qi+useRfDcIXIwBiYkbQRpFweRQC7EE8f1QGx5rIe/YJH4/NmJEY2/Hgk
         yMzr+jkA14ux1WmL/GlxAPtTxE2YWD9HuaQDDOH3xxK5irpstX+Q3C7713Eo9tGWQWqJ
         ZMN3GqTDGifP34e0ZMcyIxbmnZR5xzA7rYk32xoMd/zkjpWm17dr63y4ejBDVzOtIZyJ
         BgRS/f0isMVxpdD+tFUtbIqxmeoceV/J5M9/BELXKNdt1Vulgqq4/govNHMmp8lPH7vh
         oDtW5/Nx9/FCkF4ujQ4JWOTR4Nnn0sqb5Du4VDP4lBZ0jrk2SpKBldH3Jx3WX3yzBhz9
         gj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510494; x=1703115294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmKUeoxDw6l+n+MCYivR63GVY7ugnAhnYXWP7qAfaXw=;
        b=o+UX/Xz8EwIRV/2n+Ylq3MQzn2v/BkMLCZJQLHck7BvtqvU3DLEOeoJiakjNVCaPD0
         WKJkChywu+awEiMeAzpBdS5WdGHeq6MNeiJNY24qfoaIFU3dzAlBmw2mh1/QT+R2Uz9j
         7evbWVbCLAvbAKj79/ixM1OdsEZDjrCb+LhCUxN3+BWryDo4UopQFfm28oZ8J1sU/1LA
         +j/HDeL0SH3RrS2mC9UWgH27KsAUEAnkIecHQDYTMli+HzSU6obR3NudhQsYXH2Pz9va
         QfoFWxf4GgmwiOgUDLHUD177XhHV/eP2vq4FSCSIKKibAHngHWJ1r6/zveI+8rlBbqDU
         Hvgg==
X-Gm-Message-State: AOJu0Yw+SpCRSMv40yidS27xZPtyAE/v0U+r9sUvs84zi4wwii9rcs6X
        664YWN+aeKcPQw1j3CY8Ls4xwnay6mchwJZqDMTQvg==
X-Google-Smtp-Source: AGHT+IHIDVYtxTwDEsCbrajo/+/dlFRF+2YRIFEUPIKU5oavwCuVSNaOUwvnSttGdEBYmDhPWgxPoinR6E6kyO+bH0o=
X-Received: by 2002:a17:906:287:b0:a1f:9bc9:84e with SMTP id
 7-20020a170906028700b00a1f9bc9084emr1857809ejf.187.1702510493635; Wed, 13 Dec
 2023 15:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 15:34:17 -0800
Message-ID: <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> we only need at most one page when compress, and the "dlen" is also
> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
> we don't wanna store the output in zswap anyway.
>
> So change it to one page, and delete the stale comment.

I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
be nice if someone has the context, perhaps one of the maintainers.

One potential reason is that we used to store a zswap header
containing the swap entry in the compressed page for writeback
purposes, but we don't do that anymore. Maybe we wanted to be able to
handle the case where an incompressible page would exceed PAGE_SIZE
because of that?
