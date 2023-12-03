Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6401A80224C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjLCJrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:47:20 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20416DA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:47:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35aa6107e9fso14880725ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701596846; x=1702201646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+bxWhgSrWR9hNjabL8i2+0TzMETPf1z+GLfNoJ9zJ8=;
        b=IGe4fhHVo4lGRBVPAPtrTmFWTGazl9XvwNSwwl/ETYakr+A5wHK5LghKgAPwXXNB1S
         FJUKP1nXYJ3EZkGbcuW8r9L+2mbrDjmIkTroWjQncfKRP7DOMrjgjjEH+Nj0PD4l9BYw
         O05kLUp6KtgLis6QVbJd4IqF9RKa5OlZb2W0CVMfbBogEcGTXuJVV21sRFnAnR9tuBUh
         gRqlIDutssnsXK3m16aFPmkqaRAHzkZ1iYh4rnSlwMd+6VNdE9rBxWV4zwWwABmu798O
         GV4twfYT2nUYmpMyug9NK73nCJgGi02zTUYpF99YUiRXtfBwwhaSP4p3Qqul/B84d0Y6
         IeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701596846; x=1702201646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+bxWhgSrWR9hNjabL8i2+0TzMETPf1z+GLfNoJ9zJ8=;
        b=Hax90678uTeFwAyMI8Nshn9XoTyap2reom/jknAadZgv836mVaX+y7Uh41EStdMmu7
         0BeaolBY41AhyNb+wAfGsYWm5H5XLmSapiwgNsc2Py+j9mSNQAvvEByYfiKaKfxb73aq
         LPpYMnDTD9QmlgNrv8xP6TYteJjlcjb1r7qA99VrfmxS1oYyuxKOi4gVJwbxdCxPKGAa
         8p26U0iBcj/8h5zOU4MRZlRZsAPBHLru193U8R1um7z60CSsAIzF4NHfPvmOMMTYrX0P
         GpS/XUSOVAjW7TJkyTMrO1Mnei4XrGBQZAD6XHo0lB8FeGpFBUQLm48rhKeL/qb+C9ld
         sOiw==
X-Gm-Message-State: AOJu0Yw8hgh5GGnWk72yYzXw5+WDeaQGZAykrJDbz7OIzYqmdZvM3Cht
        FctDlEIQiHcW6IKFPPVWHMDt8jjAqMmjD7KbSfA=
X-Google-Smtp-Source: AGHT+IEB/MI2aa8cbaWymUflduhtaIGxonyyFw5LGSLaYQe49fEL0UrklcHthFdspyx2nGEx+8X3DkiuyCC9RkT7rfc=
X-Received: by 2002:a92:ce05:0:b0:35d:6227:4efc with SMTP id
 b5-20020a92ce05000000b0035d62274efcmr1392700ilo.57.1701596846435; Sun, 03 Dec
 2023 01:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-10-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-10-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 18:47:14 +0900
Message-ID: <CAB=+i9TpWy3uPA2nKEw3JGBZaFA76ZTdp_tpBHKn6QuX40xrag@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] slub: Update frozen slabs documentations in the source
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:25=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The current updated scheme (which this series implemented) is:
>  - node partial slabs: PG_Workingset && !frozen
>  - cpu partial slabs: !PG_Workingset && !frozen
>  - cpu slabs: !PG_Workingset && frozen
>  - full slabs: !PG_Workingset && !frozen
>
> The most important change is that "frozen" bit is not set for the
> cpu partial slabs anymore, __slab_free() will grab node list_lock
> then check by !PG_Workingset that it's not on a node partial list.
>
> And the "frozen" bit is still kept for the cpu slabs for performance,
> since we don't need to grab node list_lock to check whether the
> PG_Workingset is set or not if the "frozen" bit is set in __slab_free().
>
> Update related documentations and comments in the source.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c20bdf5dab0f..a307d319e82c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -76,13 +76,22 @@
>   *
>   *   Frozen slabs
>   *
> - *   If a slab is frozen then it is exempt from list management. It is n=
ot
> - *   on any list except per cpu partial list. The processor that froze t=
he
> + *   If a slab is frozen then it is exempt from list management. It is
> + *   the cpu slab which is actively allocated from by the processor that
> + *   froze it and it is not on any list. The processor that froze the
>   *   slab is the one who can perform list operations on the slab. Other
>   *   processors may put objects onto the freelist but the processor that
>   *   froze the slab is the only one that can retrieve the objects from t=
he
>   *   slab's freelist.
>   *
> + *   CPU partial slabs
> + *
> + *   The partially empty slabs cached on the CPU partial list are used
> + *   for performance reasons, which speeds up the allocation process.
> + *   These slabs are not frozen, but are also exempt from list managemen=
t,
> + *   by clearing the PG_workingset flag when moving out of the node
> + *   partial list. Please see __slab_free() for more details.
> + *
>   *   list_lock
>   *
>   *   The list_lock protects the partial and full list on each node and
> @@ -2617,8 +2626,7 @@ static void put_partials_cpu(struct kmem_cache *s,
>  }
>
>  /*
> - * Put a slab that was just frozen (in __slab_free|get_partial_node) int=
o a
> - * partial slab slot if available.
> + * Put a slab into a partial slab slot if available.
>   *
>   * If we did not find a slot then simply move all the partials to the
>   * per node partial list.
> --

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> 2.20.1
>
