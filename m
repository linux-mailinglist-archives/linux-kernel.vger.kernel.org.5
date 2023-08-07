Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56F772C26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHGRLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHGRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:37 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1C1A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:11:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bb782974f4so3488666fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428295; x=1692033095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cb719TiPSFcf9uKZA1yFMTUpQqmltNXq0TvmhepyQ0=;
        b=iZPqUxsoLXrPzqwuobnTpx/R9Sgwl9x0cdvCVM9Ne1AdS7BMX+OcpQlLyA9Whfray6
         fyq3f66qtgIZIbEh55XMI4dTChcsaqdiAeeprULuVuhouJ0hX4I9JEGxd6pb/q3WNQSV
         RRFznkugFVEmfoIQ4F3IYFnlo0t9u/fK0syCFU92gvm1iQ3HkOHydOhlADPajgl748aC
         YRYIOkLYCUDVZhJdEgkA7ww+Odmj6zFXVerp21sL+cjfuCPab9zi554KuiDHwmnAS3df
         klyPA48fAd3uIA0rqyxXa/C3QLbAGWsSWoaJFsL/Jx1l0F8Loo1p4ejJ7lvrVvV6y/jS
         ln6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428295; x=1692033095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cb719TiPSFcf9uKZA1yFMTUpQqmltNXq0TvmhepyQ0=;
        b=jAFu1Kb8pFKjmnyllJEhpKQcKbI7BguMKi9zLKgRDwEkY2Kd5PfCaCMmWoynAY9W3w
         bMRxX/DMrxdOsvoOSWsCotsW6wTDbpIN6dRCy4ClkgQlNT8/aXhShW+Ef1VzBUlqkFMn
         GU+xsV7jBu1jQOuaHcv7+9QWLMmR8zBSJPlE7BjAs0SwRFssCE7m4ZHFx66JdxJzK/K6
         3N/U8qAOKAqYoY3TxQxdQpD0Y7/UdL/L3uG3By1rJGKptGbgwT+cCYmTW8ERsn/6buxr
         c408e0nT26j0NaTbAe0eV/0oeM27IvX3o7szsU4NJXvJiyavYMTkFwMdvyMV7gz8b19+
         iMew==
X-Gm-Message-State: AOJu0YxgtnzwSDCQwLfqzuVE7pw1lL4/uyxeND+lvSWs78wX+m3rEDsc
        pIl7N63sgQIUrgUJtVTtIfbcKsf1Zu7ymmiqyzE=
X-Google-Smtp-Source: AGHT+IFUJnFHo3CrequPs1Hcxl1cl53hPeVVld+cCrZ+J+VseiFurZ9BnY7NzcqbAfK/hR5QJ2sFjOC6SCbHU+UB3mI=
X-Received: by 2002:a05:6870:350f:b0:1b4:685d:55e4 with SMTP id
 k15-20020a056870350f00b001b4685d55e4mr11879096oah.39.1691428295449; Mon, 07
 Aug 2023 10:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230802030111.10658-1-sunran001@208suo.com>
In-Reply-To: <20230802030111.10658-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:11:24 -0400
Message-ID: <CADnq5_OZnaYnTkz7zNEDjsHxrRMXoS3HwXbtT3tuj8gL7fmzfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dcn316_clk_mgr.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Aug 1, 2023 at 11:01=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c  | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> index 0349631991b8..09151cc56ce4 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> @@ -45,13 +45,11 @@
>  #define MAX_INSTANCE                                        7
>  #define MAX_SEGMENT                                         6
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>      unsigned int segment[MAX_SEGMENT];
>  };
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>  };
>
> --
> 2.17.1
>
