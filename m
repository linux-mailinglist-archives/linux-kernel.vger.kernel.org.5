Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B8781DEB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjHTNDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHTNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:03:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2583E67
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:59:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso3040384a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692536366; x=1693141166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYCxZwhLKjTbTVXNyU36rn1PDkh3vGRS5ay1eb7B0IQ=;
        b=GzRzxnrcRHfVeWS900iy3m/imxylcGjCfHzIoVQb2wJr9NkVk0+ArxIa6n6zeOeobo
         gf9yxo/pOsxpgz7BD/Y44xv1LzspT7PCTwL4VfQP1+SSxjGB7niFF6/abeu4VF801qm/
         mePCHGzJBzr+re/2aLV6CVQaJZZncY+76J9Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692536366; x=1693141166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYCxZwhLKjTbTVXNyU36rn1PDkh3vGRS5ay1eb7B0IQ=;
        b=eCtXy6wVV+Kf3vpGCSIz+DLa8tjKFuFNAo3fOphpmQk9VawQPsc2YquRhUc2rnasjF
         Gn4cqF3x4jR8+q2ZzwPNx82PWFd6m0kIugaDcchTK8o3d46PHDT48EWGa9TN6liRMxzj
         qLyo2VS7Mx1nd0BPpg2bDrP4KlQnuAaXKv7m+KGXvCv98fawAzY0iQrbBsedNhVdmDAL
         aLh2sRS/4Cd4xunogri1BzdpXSrCeoDHTxKA+9K0RSJSU/Vtf2bHZz+WqUzia+a6Mw9X
         P2D5h0T7osj7lrcvHQdyOd8XMuTnc7npZP8P5Yk655jvncfhhtKdR3GMrdBUk9qUjCRG
         xKHg==
X-Gm-Message-State: AOJu0YzFVJFyqok/l62v9m0jcZLwn2ZOrXMlS1m4SSN5p/zSp7KWQdYW
        OoFovg5jksg9ujM4picrPYmmyZDXSZiKAEuWiWwcRTfF
X-Google-Smtp-Source: AGHT+IHhQI9ThgeKUDwXIcAJCit+nTeQu8O8DePhf4T6+K9TGvbAkrztKg6YfvJGbyTZrElmYLMCxw==
X-Received: by 2002:a17:906:3058:b0:99d:acdb:bad6 with SMTP id d24-20020a170906305800b0099dacdbbad6mr3063315ejd.77.1692536366090;
        Sun, 20 Aug 2023 05:59:26 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090640c800b009a0955a7ad0sm4136506ejk.128.2023.08.20.05.59.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 05:59:25 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9936b3d0286so328533066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:59:24 -0700 (PDT)
X-Received: by 2002:a17:906:2011:b0:99c:56d1:7c71 with SMTP id
 17-20020a170906201100b0099c56d17c71mr2982614ejo.26.1692536364343; Sun, 20 Aug
 2023 05:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOH62Zi/yao/oC8y@casper.infradead.org>
 <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com> <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
In-Reply-To: <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Aug 2023 14:59:07 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjW7W-eLpxz-Rnztx1J0Ay=kaXNFsPe=MZG9hQBXBPL3Q@mail.gmail.com>
Message-ID: <CAHk-=wjW7W-eLpxz-Rnztx1J0Ay=kaXNFsPe=MZG9hQBXBPL3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in get_mmap_lock_carefully
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 at 14:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But without that odd ifdef, I think it's fine.

Another option might be to just move the might_sleep() to the top, and
do it unconditionally. If the trylock fails, the overhead of possibly
doing a cond_resched() is kind of moot.

IOW, the main problem here is not that it causes a scheduling point
(if the kernel isn't preemptable), it seems to be just that we
unnecessarily schedule in a place with the mm lock is held, so it
unnecessarily causes possible lock contention for writers.

With the per-vma locking catching most cases, does any of this even matter?

Mateusz - on that note: I'm wondering what made you see this as a
problem. The case you quote doesn't actually seem to be threaded, so
the vm lock contention shouldn't actually matter there.

Does it schedule away? Sure. But only if "needs_resched" is set, so it
doesn't seem to be a *bad* thing per se.

It might just be that this particular scheduling point ends up being a
common one on that load, and with those kernel config options (ie
PREEMPT_VOLUNTARY)?

              Linus
