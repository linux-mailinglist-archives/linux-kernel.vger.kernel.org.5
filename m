Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB9B7542D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjGNSuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjGNSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:50:29 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F22D6B;
        Fri, 14 Jul 2023 11:50:28 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-98273ae42d0so66269466b.0;
        Fri, 14 Jul 2023 11:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360627; x=1691952627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adQmepUMEILo4i9YF6QGGhgy8BgLhz/J2d2M4gDP5H0=;
        b=Wa2KNQWkzjGRfhd+bH171bIF5pH4w/k+zzwqqSLZQ0dYv5Ktb8iIFtiBBTLNZSkoRc
         DNZKnzlladKQQwjjcS/7tnle1GDejlqCWmo/x8zr6GEwwn161KNtou5K+GWxP6kKBjbf
         MAW835FrbUhlqmhOgiuNTs6MUZkeudMZveDisG/NLutriOmuUJYy4qB654mAg5l05KwE
         HZu+jbk6LU/vTigPIwWhdk0V/FIbjRQ3gyItU7HZmXfmqIjAEfDmMDNEpES3B1hON8Ic
         2ml+TKtUyITiBe4PgHZOSA509hgcvuEKmRWbkSUsfR6Q0sQCgBV0Qxu1uTql+bUitPOw
         oALw==
X-Gm-Message-State: ABy/qLZNuleYq67THuHJCeaPlapNRC1zoqV/kTlPely1SP69mp1FjkXy
        qvzLf/2B4IQbfApCgqw/0Bvh0qS4PSEWtZ3eoNOAD0pY
X-Google-Smtp-Source: APBJJlG+fOXTah1oUMq+Er4XcRfzAi8ABmvH8xenkIVLFs3e2oUYV7T4xQkMcf8QXZqk9t9h6g2wv0AitEG8JwET4PM=
X-Received: by 2002:a17:906:778e:b0:988:3171:df06 with SMTP id
 s14-20020a170906778e00b009883171df06mr62199ejm.2.1689360626755; Fri, 14 Jul
 2023 11:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230714110051.4575ffbe@canb.auug.org.au> <71f62e49-3f2f-a8bf-2347-061902d39f7e@intel.com>
In-Reply-To: <71f62e49-3f2f-a8bf-2347-061902d39f7e@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 20:50:15 +0200
Message-ID: <CAJZ5v0iLuGSHkJjhhtxveD-0N0rp+vOg=Qwz5DvdqhXHghetJw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pm tree
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:20 PM Wysocki, Rafael J
<rafael.j.wysocki@intel.com> wrote:
>
> Daniel,
>
> On 7/14/2023 3:00 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the pm tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > In file included from drivers/thermal/tegra/soctherm.c:36:
> > drivers/thermal/tegra/../thermal_core.h:18:2: error: #warning This header can only be included by the thermal core code [-Werror-cpp]
> >     18 | #warning This header can only be included by the thermal core code
> >        |  ^~~~~~~
> >
> > Introduced by commit
> >
> >    bc1bb350b534 ("thermal/core: Hardening the self-encapsulation")
>
> I'll drop this patch.  I think that the rest of the series doesn't
> really depend on it.

The second patch in the series does depend on it, so I had to drop
them both.  Please fix and resend.

Thanks!
