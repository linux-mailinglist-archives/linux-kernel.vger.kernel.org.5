Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420079F87D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjINCyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjINCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDD7B10CC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694660038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79Pt1h07snqQgLqURn+X2LUbFiUGOvFlgIEpyAPEPwA=;
        b=PGLDo9+UbINTkJkYntelr378T7dEbRC93YoS/weWtMEdhv1s52BpmcWDIBajUpzXT33PJr
        yJkYqU/mLzKpdaeBXlb+AjGRHapiMJ4dXgOOtaEFh8S9cEyyrcfNWuq4jx6dgWvmB9gHeG
        /TRClzCnuUNMwQtDb/mXOS5jUezfafc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-CJ_HSQmDN-Czg3KoLomsow-1; Wed, 13 Sep 2023 22:53:56 -0400
X-MC-Unique: CJ_HSQmDN-Czg3KoLomsow-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-273983789adso431952a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694660034; x=1695264834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Pt1h07snqQgLqURn+X2LUbFiUGOvFlgIEpyAPEPwA=;
        b=MFGovkfS04NPVmPV7ajTcg9TbqugHJm/VyyLJWDp2hcm79Q00c+minmsp2ZbcRbfMe
         wtHdYWfuMxMz7ltKaYrzixn8KOSnpOKpF5qilZY6A6stwbWoo9FpPvOPz+1e9Udxd8o6
         BIJc6k8jxE9g9WskkK1H/MELF4sc0vgh/xucubm2rG3nlvNc6SXwfMAj+7pEtfAnxmpX
         VK54WIWi2q2PecsHU3BMyZ6isDeSOd+VY+c3mzXouUOc5LEL+WYZ4RqV6pMboR0G/pEk
         eMnmKVmMn6/VnWR+AK0JQoisasrcRVBFm48e+xLKU4PyloQR6YdEKnwkHqBvu/0eDosY
         gcAg==
X-Gm-Message-State: AOJu0YwGQhLMT3A4D21isAKLHr9fEiNv9MU7GC2IpXAIMyRv5o6CLC2B
        ai5EZHKG7qoe+Axxnmi9yHo+i9SvGuRE7goojlGlESqerktRQZxLiO4hDmXitllz0g2hGKgSqvE
        ws/XwoxpITN0V/n/ksaUQnOn2IdIKCnIuyPjKd6Ui
X-Received: by 2002:a17:90b:e91:b0:268:f987:305d with SMTP id fv17-20020a17090b0e9100b00268f987305dmr4020244pjb.5.1694660034366;
        Wed, 13 Sep 2023 19:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi2VFjCUSN7OBpxQVIme3+SE2HYZ6exMH5klV6ao7jQvDUKQlgbnRiJ1efcAAWy6Z8PoxjrXE7/8b1wykrEIQ=
X-Received: by 2002:a17:90b:e91:b0:268:f987:305d with SMTP id
 fv17-20020a17090b0e9100b00268f987305dmr4020231pjb.5.1694660034080; Wed, 13
 Sep 2023 19:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com> <20230828020021.2489641-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230828020021.2489641-2-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 14 Sep 2023 10:53:41 +0800
Message-ID: <CALTww28MiiWTOyLYHErAZWTzn8iGif5=adY7yohxmn1OxrpK=w@mail.gmail.com>
Subject: Re: [PATCH -next v2 01/28] md: use READ_ONCE/WRITE_ONCE for
 'suspend_lo' and 'suspend_hi'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Because reading 'suspend_lo' and 'suspend_hi' from md_handle_request()
> is not protected, use READ_ONCE/WRITE_ONCE to prevent reading abnormal
> value.

Hi Kuai

If we don't use READ_ONCE/WRITE_ONCE, What's the risk here? Could you
explain in detail or give an example?

Regards
Xiao
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 46badd13a687..9d8dff9d923c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -359,11 +359,11 @@ static bool is_suspended(struct mddev *mddev, struc=
t bio *bio)
>                 return true;
>         if (bio_data_dir(bio) !=3D WRITE)
>                 return false;
> -       if (mddev->suspend_lo >=3D mddev->suspend_hi)
> +       if (READ_ONCE(mddev->suspend_lo) >=3D READ_ONCE(mddev->suspend_hi=
))
>                 return false;
> -       if (bio->bi_iter.bi_sector >=3D mddev->suspend_hi)
> +       if (bio->bi_iter.bi_sector >=3D READ_ONCE(mddev->suspend_hi))
>                 return false;
> -       if (bio_end_sector(bio) < mddev->suspend_lo)
> +       if (bio_end_sector(bio) < READ_ONCE(mddev->suspend_lo))
>                 return false;
>         return true;
>  }
> @@ -5171,7 +5171,8 @@ __ATTR(sync_max, S_IRUGO|S_IWUSR, max_sync_show, ma=
x_sync_store);
>  static ssize_t
>  suspend_lo_show(struct mddev *mddev, char *page)
>  {
> -       return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend=
_lo);
> +       return sprintf(page, "%llu\n",
> +                      (unsigned long long)READ_ONCE(mddev->suspend_lo));
>  }
>
>  static ssize_t
> @@ -5191,7 +5192,7 @@ suspend_lo_store(struct mddev *mddev, const char *b=
uf, size_t len)
>                 return err;
>
>         mddev_suspend(mddev);
> -       mddev->suspend_lo =3D new;
> +       WRITE_ONCE(mddev->suspend_lo, new);
>         mddev_resume(mddev);
>
>         mddev_unlock(mddev);
> @@ -5203,7 +5204,8 @@ __ATTR(suspend_lo, S_IRUGO|S_IWUSR, suspend_lo_show=
, suspend_lo_store);
>  static ssize_t
>  suspend_hi_show(struct mddev *mddev, char *page)
>  {
> -       return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend=
_hi);
> +       return sprintf(page, "%llu\n",
> +                      (unsigned long long)READ_ONCE(mddev->suspend_hi));
>  }
>
>  static ssize_t
> @@ -5223,7 +5225,7 @@ suspend_hi_store(struct mddev *mddev, const char *b=
uf, size_t len)
>                 return err;
>
>         mddev_suspend(mddev);
> -       mddev->suspend_hi =3D new;
> +       WRITE_ONCE(mddev->suspend_hi, new);
>         mddev_resume(mddev);
>
>         mddev_unlock(mddev);
> --
> 2.39.2
>

