Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D968757FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjGROfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGROfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:35:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D2172D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:34:49 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a479e7a37dso267047b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689690889; x=1692282889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqZASbUSLs/4+sh3KkkB2pzPrQYa5qP3ESXWTg+1yuU=;
        b=OgXmvj9K/Jc8X81/HC/BY5Sk28n1yC+yn6Jiaxy2Uk2YFx0rTutGSuypOEcq5lhCXM
         b+JenxBCS7F9ZBFSZhSc1DczKBKwV/2sSe0/4x/mvD3DimwzYIR1pZDX5VLzJeeFaTgm
         x/r7Yf1qSWVBmDdCX7PWber1kNmXLbCdtvLoDcOQZXA1oBERYybHBqhWW4XUIR6to5Bf
         HEkk3ZBJToKcuto2/A+NgyCSAfo9fyVXCNUBf6CYG/jcU3yfTEO0wwiXbtPm21y1mG7M
         AGY1ZkhFvOZJl6zsHmLCzSxsAaVCap37irkGmONu2I2c8f48gfRSIrnUq1J8o2Y24PeO
         RhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690889; x=1692282889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqZASbUSLs/4+sh3KkkB2pzPrQYa5qP3ESXWTg+1yuU=;
        b=RVhuJ7oKe79XHCjxKFwkBZpDg9YwTrm1jUzAyrQh3NIpUIHk+Ly33eQOzo+rmmvpcg
         aVO20eDK/n02pu1nxkqSHRe6Qw2BTyJIwVn6rxwslWFkfcvdXhEeMldpHOaTDpPcRLOR
         nqSaeRbjeMvE8Y27n21K1iax6e76wNuZWvBFZogUv9gQRnAH2hX3eWzC5XLNmf+vOrBU
         52smb2rjIxDxnyMCqWhjI2P0oSsNpW2PXP6tTZU2Xab13eFShosvSBJtrbkJAiLnuAAw
         l5wX59DnvZVXQMfWBsBTA4jq93Hgu9Mt5VYW2AcsJeyunL7muW0vc2SKdjDUijf4eFuu
         j1Pg==
X-Gm-Message-State: ABy/qLaVY5kw/WX/iQVW0+TiKZ8S8w+Mrv7syoaXVfWdTSTj+Ubo6kPX
        oDItnHvFsCk+aSumGD7Q8tFnzML1NpKGLXQirIA=
X-Google-Smtp-Source: APBJJlGfXJg5VFyKsFvni80V3YE397IUwqaDBgN8fkFYrFZWn7PrYlFRnGMd9JRnky5bYSfYJozT9lnPW1g5OT4EmZA=
X-Received: by 2002:a05:6808:159e:b0:3a4:3c87:675f with SMTP id
 t30-20020a056808159e00b003a43c87675fmr14984240oiw.52.1689690889052; Tue, 18
 Jul 2023 07:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230714060105.13377-1-xujianghui@cdjrlc.com> <e565a40b4ae73352204fbf49e55de452@208suo.com>
In-Reply-To: <e565a40b4ae73352204fbf49e55de452@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Jul 2023 10:34:37 -0400
Message-ID: <CADnq5_NFZWUJO-MiLq6krqKJAzD8qkGTkA3qkE9bV7Pj9kLP6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: open brace '{' following struct go on the same line
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to apply these patches, but please check your mailer.  The
formatting is messed up and they don't apply cleanly.  Please use
git-format-patch and git-send-email to generate and send the patches.

Thanks!

Alex

On Fri, Jul 14, 2023 at 2:04=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the checkpatch error as open brace '{' following struct should
> go on the same line.
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/include/yellow_carp_offset.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> index 0fea6a746611..a2c8dca2425e 100644
> --- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> +++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> @@ -7,13 +7,11 @@
>   #define MAX_SEGMENT                                         6
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>       unsigned int segment[MAX_SEGMENT];
>   } __maybe_unused;
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>       struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>   } __maybe_unused;
