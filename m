Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221377E8049
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjKJSIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbjKJSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DA28B0C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:23:38 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6707401e22eso11896516d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699611817; x=1700216617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QkwWxIGEOurCFKWXSk9BruqjsYwly8P0Gesk2pyj0w=;
        b=FDbLf3FGnVdR5E/WsV1HMu8xWevptE7QKJlGsykZ09rn3SvTaxJxv1ffFcU5F/guAs
         uAi5Ixgkj6pHoIQs6XoI/XqFm0MwEQfa8HtgFu1Dl/xq+XYln3+uyd7FkUUu9cgqCNvZ
         PktFJcgDzFg7Ac+ICAaNYHKt7wJbIM5UzwHvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611817; x=1700216617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QkwWxIGEOurCFKWXSk9BruqjsYwly8P0Gesk2pyj0w=;
        b=lQI3UFr64DGtjojnC2+bwRa+mCi4tG0HniPwSRIndbjYFhmFPsOXhyLTOl7/wr6Yoi
         NCkAXEVH4kccA7hthpFyG4n1VoxhnbZ2EUxYNOa5YpicE66MzdY/s2iv2ZxDG0MLzfV0
         GWsOixdpyW309meU1USQFj/9wW+CbhAeBXDESHAVRR10NREWMje+b43be1cbK2fuC+jw
         KukSvRpDLRfOznQCVfoOkad3s/vG/JpQqG9Oo6649hbZs9kHZOA9v9casfYIncj3zW/y
         oZNbyn+sjgWLgd074dRWHd97NDsWhXyx8iDuspVJQOowyhLOIN6ugMwQddjz69npUD9A
         /EDA==
X-Gm-Message-State: AOJu0Yw9MM5H6dEyWNP3dzcI7/8zfA57mMehGY4aX3wmDz+c+9hjVNaH
        279WWOgT6O70uEv6X2tKwziu8sxmHPYdE+XCeF2t1Q==
X-Google-Smtp-Source: AGHT+IENbhNKrU9JKMVoNoHyG0IJmRadKeNt6P1c7mGY4/tGHSfa5JC4Bm4HjCQ0wUflngrkwD3tqQ==
X-Received: by 2002:ad4:4d11:0:b0:670:faa7:d4ef with SMTP id l17-20020ad44d11000000b00670faa7d4efmr6376617qvl.23.1699611816919;
        Fri, 10 Nov 2023 02:23:36 -0800 (PST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id p14-20020a0cc3ce000000b0066d11743b3esm2804983qvi.34.2023.11.10.02.23.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 02:23:36 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6707401e22eso11896376d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:23:36 -0800 (PST)
X-Received: by 2002:a05:6214:2a4b:b0:66d:1f29:3ea8 with SMTP id
 jf11-20020a0562142a4b00b0066d1f293ea8mr8383989qvb.57.1699611815808; Fri, 10
 Nov 2023 02:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
 <CANiDSCtC2zOKtopkuuqJYqi6+FQ1Kav6LfMH5gGhKrnDeG7GYw@mail.gmail.com> <CANiDSCteBUraA0UrLM-cU_GqDSWcWERJNV_xhsi3LNQZNvX5dA@mail.gmail.com>
In-Reply-To: <CANiDSCteBUraA0UrLM-cU_GqDSWcWERJNV_xhsi3LNQZNvX5dA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Nov 2023 11:23:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCu9Ca_rxhu=KJb6q2=UPcUjXu8VchLNHTjquCj5qf7rTw@mail.gmail.com>
Message-ID: <CANiDSCu9Ca_rxhu=KJb6q2=UPcUjXu8VchLNHTjquCj5qf7rTw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] uvcvideo: Fixes for hw timestamping
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Another friendly bi-monthly ping on this ...

Regards!

On Mon, 4 Sept 2023 at 13:55, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Again
>
> This has been waiting from March, and it has been already been
>
> Reviewed-by: Sergey
> and
> Tested-by: Sunplus
>
> Is there something that I can do to help merging this patchset?
>
> Thanks!
>
> On Tue, 15 Aug 2023 at 13:26, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Hi Laurent
> >
> > Could you give a look to this patchset?
> >
> > Thanks!
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
