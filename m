Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9F79104B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351348AbjIDDSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjIDDSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:18:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5E10E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 20:18:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so207601666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693797492; x=1694402292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRiIbAFg9Tz0ie5BKjJ3bgiyNx9YoHAeVLR3Pw+mO9w=;
        b=dIPlkmCz0F5zNX/tRpeEC/4t7L2pfB2AnErHazb63A5trEhd1OluiwyXjG3dx+xZ0N
         hhasWg0Gzky7//3OJGIZRj/fgJpxlMhjwktmV540sA73n1zS2AFKK1gEqXDTx0LH3/qT
         0/k8bI6/mMgPOQ9kUS9kiWxYsVZBSDXqh0QtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693797492; x=1694402292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRiIbAFg9Tz0ie5BKjJ3bgiyNx9YoHAeVLR3Pw+mO9w=;
        b=g//y3AhIo05liTQhJf3HtncMSZ6npowTBzMYgWxjQo5vVhqpv3uYGOQV/gqY/OQsKh
         Nl/ENz8cA37XpivcCKhPBq2eQ76cEhvzNpAmvltdxhCGcPoRs12D8BfbkG1Nzb0rFVlR
         3Ke2IcMfjK3vlRou1p++lE61ZPKPaCiDy2c63zinDn/ULLgVEW7zMR6nxA9u3hEqinHZ
         WVRUWh6ZTPuJ1VPEFVbO9ozRQsxKjayDqvRrFWue5L8/ii2YRsXO/B3rZ7LlPMgpLlum
         hURgiCHU20oDa9AOHdMZowyOK6elAydDWtxXROBPdc2bAVblrtRl2OO/2Z7CnaXIj13l
         wkJQ==
X-Gm-Message-State: AOJu0YxA+q0KiK1wOpJFVBIgA9itsKE8hCLSU7JNsEaVBAgEApejT8X3
        3VsJqfAAGnaeL5fhE8tNf02ItojbPWP0MZb8LhLpKeSx
X-Google-Smtp-Source: AGHT+IGYGGrs2m7kZFxp+8u/fW2LrEyEv7fpX4VsmQj34rWngr4Lpa/fI4NvYLSyZXVJPUNEeljtQA==
X-Received: by 2002:a17:907:1def:b0:9a5:d2f5:c76 with SMTP id og47-20020a1709071def00b009a5d2f50c76mr9587783ejc.5.1693797492268;
        Sun, 03 Sep 2023 20:18:12 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906264400b0099bcd1fa5b0sm5535787ejc.192.2023.09.03.20.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 20:18:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c93638322so207599166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 20:18:10 -0700 (PDT)
X-Received: by 2002:a17:906:5d0f:b0:9a5:a7cd:1f02 with SMTP id
 g15-20020a1709065d0f00b009a5a7cd1f02mr13692231ejt.13.1693797490682; Sun, 03
 Sep 2023 20:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com> <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
In-Reply-To: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 20:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
Message-ID: <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sept 2023 at 20:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Try it and you'll see it is not even *remotely* as easy as you claim.
> Not when you have to deal with random sizes and padding of 20+
> different architectures.

Perhaps more importantly, nobody actually seems to have the energy to care.

As shown by the fact that even the current really simple "just define
INIT_STRUCT_STAT_PADDING to avoid a pointless memset in a hot path"
has been taken up by exactly zero other architectures than x86.

I wasn't going to fight that kind of history of apathy.

              Linus
