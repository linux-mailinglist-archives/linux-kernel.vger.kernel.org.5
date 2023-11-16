Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747B7EDA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbjKPEKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjKPEKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:10:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB4194
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:10:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c2a0725825so51794466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700107827; x=1700712627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMzCj5P9fSwcVXlU8EVUh+tUUR0usCMZQ9ylB0bPUZA=;
        b=d3D+e3ChqnUGtmInsc+rNIkmB/0k1xnEnUWVpOu9+ZlIg4yE0aeRoFbe/Wkr78xud0
         Dk0GD8NaPfcXpcI0LK/crIKpx64j2L3qqXDv5Rx5PupRRilfcoMxz23lCjWBGSkalPvR
         qD0fR8Kun3G+d13o9wDnMBkb9ry5vPYVdcKitOB46iYmrRSI6xyEx2LfDX5mQp9te344
         WMicVSeB5PLdZLNy7QJB0NooqEBmgTKl9ypyZjj5/sxCpcEv7Uc3VmgMHQ/WDIEQrjwJ
         t69bJvMBKCOvRAq7z0+hUGerelD1E8EALMfZS2KEmhB8o+ygtSOdnRbq8UfnnrGMcsAs
         on9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700107827; x=1700712627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMzCj5P9fSwcVXlU8EVUh+tUUR0usCMZQ9ylB0bPUZA=;
        b=N3TwwbzYDSqR17qHJOH96sEr4D+dMqdpU6ens/HejrYgRA1nJB1RO7R6ZiWJ0broiF
         b42H/BieuGCwSDWCz7ezZxZN1Jozw63kLGCCMWm8urwCeLSovvbW6bJmyUsjubQsKq4b
         bC4HNpZQxOrjQAvy3B3INzIu9XHJ2D7lUV91lmJZA8I/zyK8n8za/8ngLOqA7vPS/tH6
         l6hG6ocO5s4/p0sxYP0NPyGUnMecdrD1qqO8dbuZ3nGmBe+srwV3gAWIkwFEWhmnvUik
         C4PnUB74qRUGRoP6mHKhQTAF/d4J6ce4jcx4KvAJjIF7FY+/F5zt7ll/1xPUmGPNHy/v
         uRhQ==
X-Gm-Message-State: AOJu0YwcaTvj8ThTNOI1Pg8XJLg+tuRxjsOtRmgdFijHXLmlVndRwhf2
        FGdrkaHzaJZ12iwt3yIhYuycsTCnkFGj9hzaZfckzw==
X-Google-Smtp-Source: AGHT+IGJFFso6GmC8lJdP1PBOxHgcqZtboEIbXbEOVelXERWcSrUeCiqT/9/q2VHeLGt1Dc9I5cx0u8N1C1qsSLTwoo=
X-Received: by 2002:a17:906:b10b:b0:9b2:d554:da0e with SMTP id
 u11-20020a170906b10b00b009b2d554da0emr871908ejy.69.1700107826785; Wed, 15 Nov
 2023 20:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com>
 <CAJD7tkbkPZ-Fiyz_4CKNQmufCpWSF330xK3bc7aHNML_cPi2sA@mail.gmail.com> <CACSyD1Nav7+zppx3BZS8vU5uF3AaBin0XOKCdtdQ1d6sA4wu9w@mail.gmail.com>
In-Reply-To: <CACSyD1Nav7+zppx3BZS8vU5uF3AaBin0XOKCdtdQ1d6sA4wu9w@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Nov 2023 20:09:49 -0800
Message-ID: <CAJD7tkZHwg_u7UhzugVmmH6-FNORb+D+5SyMX6cGefp93uZr_Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
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

On Wed, Nov 15, 2023 at 7:33=E2=80=AFPM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezhon=
gkun.hzk@bytedance.com> wrote:
>
> On Thu, Nov 16, 2023 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > I think we may need to try to lock the folio. Otherwise we may race
> > with reclaim reading the dirty bit before we set it.
> >
> > Taking a step back, this seems like we are going behind exclusive
> > loads. We "should" keep the page in zswap as exclusive loads are
> > disabled and the page is not yet invalidated from zswap (the swap
> > entry is still in use). What you are trying to do here is sneakily
> > drop the page from zswap as if we wrote it back, but we didn't.
>
> If  we want to reclaim the cached zswap_entry, Writing back might
> be the easy way.
>
> > We just know that it was already loaded from zswap. We are essentially
> > making the previous load exclusive retroactively.
> >
> > Is there a reason why exclusive loads cannot be enabled to achieve the
> > same result in the (arguably) correct way?
> >
>
> zswap_exclusive_loads is not enabled by default, so the shrink_worker
> may fail if there are many cached zswap_entries on the zswap_pool->lru.


It can be enabled at runtime, or enabled by default by using
CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON.

>
>
> Is it possible to make zswap_exclusive_loads the only way in zswap_load?
> It only makes sense when the page is read and no longer dirty.
> If the page is read frequently, it should stay in cache rather than zswap=
.
> The benefit of doing this is very small, two copies of the same page
> in memory.


The reason I added it behind runtime and config knobs is to preserve
the existing behavior in case someone depends on it. At Google, we
have been using exclusive loads for a long time. If other users of
zswap agree to make this the default behavior or make it the only way
to do zswap loads I don't have a problem with it.

>
>
> Thanks.
