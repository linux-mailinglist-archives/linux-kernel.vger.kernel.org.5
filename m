Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB417D8C28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjJZXU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJZXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:20:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E3121
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:20:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ac865d1358so1249138a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698362451; x=1698967251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g3EqhxCq65C/tYb/O2boXzXlPPUEvW+TMQUtT+idPE=;
        b=Urcpm9NFsT6EYzdW/A1UkLCudSFLQyd9SHxSkZOsQ6nvPesvxQ/1esC0WrhbJYyrMQ
         wjfZHCgW1iWlPme/amq24wLfsDrIPcX8d2q3CG5kJm1+ydz5mUtdR8bgeqXXJ5pE6xJs
         +lkymN58XUHsrfutEeZg9gz/VyhjkbTdxWWM2QhNaQpLrT9Gt9toJ9FHYfgz58TFPlxd
         VPh8ewXaLcaYAUzbNvomGvqEYjy14+awzqzED3aB5WyPjw94IEVRIUXp7yEvt4DA7kPu
         zcrswpMRanxJA9U9woO9HxDoMxzmVcD3manmwt8r9qUWyAcs075GYq6m95CWcbFzI7cx
         6A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362451; x=1698967251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g3EqhxCq65C/tYb/O2boXzXlPPUEvW+TMQUtT+idPE=;
        b=tIn52Qgthc7T8yPgK+QWBdDpco4UAPDuEwSGFjkFMrNag2mhKW2JQKh0TDhicu0gq/
         nRYqpxAFVj/F1bmmn6grYWsYH72bm/xEY+vUE1uAewq/wgohEBXe4dvxb/Or2rNKSrT1
         fxZKdGIAi6wsUJ0FbWpl/KI9z/KCFduIPl2vyOIqtnfIoEUWDOQjrZXDc6VnpeThehQp
         2jYSR7hTPKibsZci3bY8w9ZiO1Llrim9zZxvz/9AZq1c3us10JC6khelq0xVNOdkSsST
         0u9zys5xKW+F7e1wLSRaL+E6G4y9hjCmHl4mZ8PRE/GQYLaJbvA5Ahl0sVRHgYFxZmmw
         0GCA==
X-Gm-Message-State: AOJu0YzeJLmGX/WA5bAwSmkBsiX3bRI+7/cUibRVQTNRWK0+yj53DRAj
        u6bu/ZT8ZP+n7y3QuyaqmRD4OJIEftzWmpHkfgU=
X-Google-Smtp-Source: AGHT+IHMX5rTzN0WafqFPgAtdc8nPV0JuCH69MfQ0OjZcjCnxRDcQ1fgiaxiQjI8GfvbBX+5uwWrYtSFbRmTTt/bXYw=
X-Received: by 2002:a17:90b:1a8d:b0:274:616e:3fc4 with SMTP id
 ng13-20020a17090b1a8d00b00274616e3fc4mr1001903pjb.34.1698362451039; Thu, 26
 Oct 2023 16:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231026223340.333159-1-andrey.konovalov@linux.dev> <20231026160715.ea74f79dea9960b8ff46d077@linux-foundation.org>
In-Reply-To: <20231026160715.ea74f79dea9960b8ff46d077@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 27 Oct 2023 01:20:39 +0200
Message-ID: <CA+fCnZcy5cCHTtXmVmUngL_PPjLLX-O2uDYtSaM-=G_kO=GHMw@mail.gmail.com>
Subject: Re: [PATCH] fix for "lib/stackdepot: allow users to evict stack traces"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Oct 27, 2023 at 1:07=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 27 Oct 2023 00:33:40 +0200 andrey.konovalov@linux.dev wrote:
>
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Commit "lib/stackdepot: allow users to evict stack traces" adds another
> > user for depot_fetch_stack, which holds a write lock. Thus, we need to
> > update the lockdep annotation.
> >
>
> We're at -rc7, which is rather late to be merging material such as this
> patchset.  Please resend it all after -rc1 and include this fixup,
> thanks.

Ack.

I might send a few more additions to the series for review before
then, but then resend everything together after rc1.
