Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DC791C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbjIDR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:28:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0FCDE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:28:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so2331437a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693848511; x=1694453311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhPCx05WUQGrMDBfkZ0CMhccNBEJ/5RWaLJN+3UFg+M=;
        b=g3NIiUbzcmYutloJztqJ4crQ4VGiRsLP8PYEdzmJgue5Lpykr5O+pYZqWUpaV4lyIP
         lMm74kNg+TQ9ONU0xr22TZ+KNzJSlJXL0vHKqG+PuHrxizKgM9R88bcuiD+eWTT9ZWNV
         DhINhbamVwBl2RdXRtaIkQNSU30hHbLAVqsks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693848511; x=1694453311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhPCx05WUQGrMDBfkZ0CMhccNBEJ/5RWaLJN+3UFg+M=;
        b=lMIRvmgWnykPPOXhQMly3CXuPzzjDxURcIZtou3YWaz82OvZwP63Xb4Y6ZZSQBcmKC
         9VBc0JwsdWRjoQMiwTD7TXgBmeuSMRIZrmTxkpQTTAnEoxiaT52Jve9Io4SiSkGWN2VM
         U1RLnGbz6NfuqP5fo3VI14KT5I/niVPegPu4AC1Dp4xmPtgmxg5C9Y8uRdgcA+xSaXsF
         Dm5mRzGV4wSsbH7fFngCapRZ1d8LQUB2zsaCxZpBxZDnf79HIqG+tRmsOCjrVCVEsML9
         wezlgXNI1t07BuQpKrqK9eW4gySgxsnGpVKZru8teIJ0CLjCs5ztuCJUlT5muDq0SFac
         dd5A==
X-Gm-Message-State: AOJu0YxNbfqNbdZzaHoX88QsjIUOl0g+j1I1m2cc1K7kjJ1IMGLdS5uA
        45acA4vqJg4Bae/bx3TKRzwpI96bc9CyztdwTlsAc5GF
X-Google-Smtp-Source: AGHT+IESudZNYeFQB5mF/wQmvbbrPUKEw+XiyWxU7ECwIWy5bHF+Cr6Pt1Rnh852ZyP7aemz/omwzw==
X-Received: by 2002:a05:6402:b11:b0:523:3853:e01a with SMTP id bm17-20020a0564020b1100b005233853e01amr7487110edb.36.1693848511549;
        Mon, 04 Sep 2023 10:28:31 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005254b41f507sm6097187edy.32.2023.09.04.10.28.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 10:28:30 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2342191a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:28:29 -0700 (PDT)
X-Received: by 2002:a05:6402:751:b0:522:3849:48db with SMTP id
 p17-20020a056402075100b00522384948dbmr8085286edy.3.1693848509629; Mon, 04 Sep
 2023 10:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com> <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
In-Reply-To: <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 10:28:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
Message-ID: <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sept 2023 at 23:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Worst case if the 64 bit structs differ one can settle for
> user-accessing INIT_STRUCT_STAT_PADDING.

As I said, try it. I think you'll find that you are wrong.  It's
_hard_ to get the padding right. The "use a temporary" model of the
current code makes the fallback easy - just clear it before copying
the fields. Without that, you have to get every architecture padding
right manually.

You almost inevitably end up with "one function for the fallback case,
a completely different function for the unsafe_put_user() case, and
fairly painful macro for architectures that get converted".

And even then, you'll get non-optimal code, because you won't get the
order of the stores right to get nice contiguous stores. That
admittedly only matters for architectures with bad store coalescing,
which is hopefully not any of the ones we care about (and those kinds
of microarchitectures usually also want the loads done first, so
ld-ld-ld-ld-st-st-st-st patterns).

But just giving up on that, and using a weak fallback function, and
then an optimal one for the (single) architecture that anybody will do
this for, makes it all much simpler.

Feel free to send me a patch to prove your point. Because without a
patch, I claim you are just blowing hot air.

               Linus
