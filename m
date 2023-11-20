Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455047F20C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKTW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKTW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:57:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80CC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:57:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50931d0bb04so1003e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700521058; x=1701125858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWVFW2RnOYhgO1cRQlFLQGYRwK79uUTtHuGNl8l1qxM=;
        b=lpzjqKY/mxl0L031w6tixUNcUlgI5OOJ7ka85MYGTYfQ9hGlOrzLY135tPGEyF1/TY
         lxSt++Si1ULcdQ9fp3hld1J6+xD9hcWJ4P0O58vMgoeQeN3SJ97B7w8+Pr6rHVvOyKsD
         kqmvr+V85ru1AsZKzCPUyYcTWwamr6mqX1G8QlLiO2X1KC4FuUSm8r/sAxbMwnyGY1sS
         PXRK5/Bm6ZG8uNXjgqxYuYa+PeaXBhjKa/bbPGt01HvtYfzjB1QpFEqNv/NIVzyumHXf
         FNVj6vPxnVmUUt0jCK38ZE89VrGUvlBVHy214xonyCfXuH+XRX01qTQsRgnlT/keejCn
         XV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521058; x=1701125858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWVFW2RnOYhgO1cRQlFLQGYRwK79uUTtHuGNl8l1qxM=;
        b=KWqNeujGoHYtRr4pK3FRM2M8wP1veFdXmnRsgUIZEOXIXKlr9nLnRwVNEQ2ts4R651
         OUkkcqoXzaNQFFfaGLjW8Fmfu7G1zVByeEKseG6U2wOX4IJJ8HlRjiYBhAw2AcJ7AsNQ
         wOEl1nx51+zzBSjHNUEwmhYD8c0CIKUSySft7hViBZXKVZeeXFtm/wzO3oZfeY7daS3i
         d1CGFUpo7ShBtF/o2+YzZk3DqQe7fNV6yLZaeWyELu1wmC8EJbgq3Bn8dqm58KHWpsha
         G7vOueNgxUBGVTkN910SxRSvpZjl7xllZYQqtTjSPRNsigM+YJ8orIdiROW4SoUZYryG
         hNqw==
X-Gm-Message-State: AOJu0Yxp3bpgJmMD1Yi8B1ASj0DnCVDC5CLT7h82/0inBu+96y1NHJVG
        FEfJqBGcaJlkMTptBPVsuGJrs6Sq3+4I2q/GuDPW9A==
X-Google-Smtp-Source: AGHT+IFBxF48a6mrpZhZlo3Ykv3kzih0QaBtSTI8yav2r5eRNHsGrToX10g9hskxPXwgXg0Ogo6zEqHI+FdwVI6q+KM=
X-Received: by 2002:a05:6512:3743:b0:507:9a37:1483 with SMTP id
 a3-20020a056512374300b005079a371483mr227375lfs.3.1700521057603; Mon, 20 Nov
 2023 14:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20231115071109.11511-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231115071109.11511-1-zhujun2@cmss.chinamobile.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Nov 2023 14:57:26 -0800
Message-ID: <CAP-5=fWvnEaNSMRRNEF1ijX_AcuP-AM0rfPnRZ9kr7iYeKzeTA@mail.gmail.com>
Subject: Re: [PATCH] toos:leds: Fix printf format string in uledmon.c
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, david@lechnology.com
Cc:     acme@kernel.org, ast@kernel.org, namhyung@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
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

Nit in the subject: toos:leds: -> tools/leds:

On Tue, Nov 14, 2023 at 11:11=E2=80=AFPM zhujun2 <zhujun2@cmss.chinamobile.=
com> wrote:
>
> When the argument type is 'int',printf '%d'
> in format string.Problem found during code reading.
>
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/leds/uledmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/leds/uledmon.c b/tools/leds/uledmon.c
> index c15a39c1f271..62befe06eab5 100644
> --- a/tools/leds/uledmon.c
> +++ b/tools/leds/uledmon.c
> @@ -55,7 +55,7 @@ int main(int argc, char const *argv[])
>                         return 1;
>                 }
>                 clock_gettime(CLOCK_MONOTONIC, &ts);
> -               printf("[%ld.%09ld] %u\n", ts.tv_sec, ts.tv_nsec, brightn=
ess);
> +               printf("[%ld.%09ld] %d\n", ts.tv_sec, ts.tv_nsec, brightn=
ess);
>         }
>
>         close(fd);
> --
> 2.17.1
>
>
>
