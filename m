Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CC76A48D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjGaXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGaXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:10:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321881BE9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:10:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bff89873d34so4090457276.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690845037; x=1691449837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReAATiDTqfXtR4Ih033PAsrqNaryHayzmwnSBxn55LA=;
        b=cTp0F2gmkhKDsd7SsaAt1SJ0w8+SBhvg4pw3m6r9BPXjxMB/uu4QzCeRsZOKbqKsm7
         Z0CDmwXtOF3ybVyxD7KP23KSp39UC5ZiNC9iwFndTm8DcgYX/4/Avd9voLBJgBrxof9D
         znM1b2R/568WT603oAQTzwzFp0ivMk/VXkXJEV90hZJIy09PFM5PKV+7NEeoMpPrhXJ4
         nHlhvQuHlujlFkpLCU7U62ViVaTqaLYpCt2UvK2+SEfkHwQerlSEui4zGgAgBwfWku4l
         TaFjaib6JsurAscE31JtI4SQSo0RcaYPQwwLHNnhiDsEl/S0Yy4d6JUDGdG7QFZ9hjRB
         B3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845037; x=1691449837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReAATiDTqfXtR4Ih033PAsrqNaryHayzmwnSBxn55LA=;
        b=P+v1mbXzipr8E0usWVks4AHOlXU2/x9iXRr+FogjrlvLoZicUt6H5WMj9ZbUWgfyn3
         pV44Xd9MK2O6QWxKR/Rq/hdgi1c4H9OjPm5MNtu7tIJUeQYt4xXIkR5IzJMSqqrF9o1r
         N8thLIBtwUqoHU2DD6HCHE0/SEzUO6DVwbbaZgGBwX3z0Pc/Mhv9R6ZaFbZTOrwpyphp
         CyjYJvt7oLv/psK9hKFOhoMIePgOiOIo6gF1ChE8U9YFHVlzisGQwWRSTxWE8MMxuf0K
         HNtveV6GgfEN00daA+X7whKOGWpmFN3NJeo9LnoWFBTc1NQyt8TARHRdCbBcDdgyYkeg
         xz5g==
X-Gm-Message-State: ABy/qLbMZy3NyKkS3yQ6GgVVrXR4G/89+1NsV6LKEZ0BYyv/p4jY+HvL
        ldW9TArdYX5XmhHIBGvkGIktdXSw+mafBSSIqbI35j/Lx3oZMX7wxNT+Pw==
X-Google-Smtp-Source: APBJJlG6ASOip8deENMOeEcNF2Cg+LyB5qB2Kopy6mZL3oPgjq8vD3wPRAX+TvpUfnPzGCjomXaSc2fpsYY+y76TMLc=
X-Received: by 2002:a25:cf14:0:b0:c21:4bc4:331d with SMTP id
 f20-20020a25cf14000000b00c214bc4331dmr4756653ybg.43.1690845036562; Mon, 31
 Jul 2023 16:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
In-Reply-To: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 16:10:22 -0700
Message-ID: <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
To:     Ramazan Safiullin <ram.safiullin2001@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
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

On Fri, Jul 28, 2023 at 5:09=E2=80=AFAM Ramazan Safiullin
<ram.safiullin2001@gmail.com> wrote:
>
> While creating a patch for the psi documentation I noticed that
> MAINTENERS was missing an entry in psi.
>
> Add entry for psi documentation.
>
> Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5c16bb92fe2..2da6643b9488 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17103,6 +17103,7 @@ PRESSURE STALL INFORMATION (PSI)
>  M:     Johannes Weiner <hannes@cmpxchg.org>
>  M:     Suren Baghdasaryan <surenb@google.com>
>  S:     Maintained
> +F:     Documentation/accounting/psi.rst
>  F:     include/linux/psi*
>  F:     kernel/sched/psi.c
>
> --
> 2.25.1
>
