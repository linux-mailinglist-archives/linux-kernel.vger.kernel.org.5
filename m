Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874C7AF4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjIZUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjIZUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:06:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D8A1BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:06:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fa2125e19so280097639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695758784; x=1696363584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROwwicfVqJzQjY5acEsiiIZMrlm7ip2jQ8qIfyOCsP0=;
        b=AoBdnQa4tryiMeF3ivU+N7WIDMx+LibJbgvyAZHmIPia9oN11tqEUcqCG1cuIZNI++
         oM+HpLzpF9+jLnHfhyn5wSiU3FcH235ezckJ91ocx3OKUUcwuvADqdKe88COsThrIfUv
         Fz1u7L+k1UA7w88BIl3wshu2OO5+bgMFoq5QKbYP93ldJuT36C3OpHxjCRhQH8KXK1dm
         oWQQBwuKB3q9nVPODrAO8wlRjMfsMQ/58HcmFjRPgWuVexAO3JZ7z/eVufNvLKkYyZsi
         sRBH+zMM/y2RUV3U4EUMXe/iSO3b71VBoMOdj0A7KU8fKmAtBHq1boemxcqQGVUuupWQ
         9/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758784; x=1696363584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROwwicfVqJzQjY5acEsiiIZMrlm7ip2jQ8qIfyOCsP0=;
        b=S4l2fuUHOx8ADUVqpwIAUpU42Uspaojpwc5hCJKQf+jNl9FFu2lLtu4Wak2RugkCl+
         0jPE/d2MEek47y4q3rOWcipUHseaNU/JbWNuoy9WXVEoJIkJQTnhWcaM3E9bDjFmzWvi
         lkEVP6L/eEkQQgcM42uLueYA6s72mqwY7a8XDPC9wZnZj1ngnW4m7g9mD1rQF7KDGmVc
         t51Qc8qRW/rsIQRdE6VX8rYMwACakPXsnUqwshZWnXoUS/ASqZMJrzHzl5zWQ0/E7/LL
         dRFpcRVgBjz4e3uyiQuIaePmJYEYW2zDY0y6CR5eViDRLxKhTt0/gjZInttbKkX6vfHm
         ux9w==
X-Gm-Message-State: AOJu0Yw3br1vdNdZzmwKUDAwZiYgg9XXLPD8peZi+8VFPmomj6amNv2O
        z1WDbVbQDEnVEw/Tx6dqFwwR4XCv3fYQwsIuQZs=
X-Google-Smtp-Source: AGHT+IEtjxPs4x1IgblTngMLujVLgqNN+U9yZr3AHJwqwHSTTwgo4ZUxCvsuxMVmsbfB1bpGNujHF0wNw3JRaj4QQ6I=
X-Received: by 2002:a05:6602:2186:b0:795:16b8:8601 with SMTP id
 b6-20020a056602218600b0079516b88601mr11403668iob.0.1695758784562; Tue, 26 Sep
 2023 13:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908235115.2943486-1-nphamcs@gmail.com> <ZRKIRyYYkAbJ5uOP@infradead.org>
In-Reply-To: <ZRKIRyYYkAbJ5uOP@infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 26 Sep 2023 13:06:13 -0700
Message-ID: <CAKEwX=O3ydrSKoZKv-6T0QHTEh5WkgRfK3b7Aa_H6GmQbn4QsA@mail.gmail.com>
Subject: Re: [PATCH] zswap: change zswap's default allocator to zsmalloc
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 12:29=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Fri, Sep 08, 2023 at 04:51:15PM -0700, Nhat Pham wrote:
> > Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
> > memory utilization, both in theory and as observed in practice, with it=
s
> > high storage density and low internal fragmentation. zsmalloc is also
> > more actively developed and maintained, since it is the allocator of
> > choice for zswap for many users, as well as the only allocator for zram=
.
>
> Dumb question from an outside, why do we then even keep the other
> two allocators around?
>

Maybe legacy users who explicitly configure zbud/z3fold?
We have a couple internally, and have to manually undo
those configuration after we stop compiling these 2
allocators.

But yeah, I don't see why we should keep these 2 allocators
around. Time to deprecate them? :)
