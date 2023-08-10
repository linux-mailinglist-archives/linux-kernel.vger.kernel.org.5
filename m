Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB78777FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHJSJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjHJSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:09:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3C1703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so2513984a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691690991; x=1692295791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdVO7LGdqPVywscLfXnXC7vbQR6Oxa8Ot+Ua+mHkMYE=;
        b=WzCIt8KVNJVdUdDcoICwW+y1kes2mDvZQAnTaZ6ICrlBFD2xuSWvx79+xCbSxwCNt5
         0BZH4+mr4QPdacXjUPLHH+3Nkk6gDfHJWnBunWIQb+ByKli4xNSoMgz2mWMA/ZjNuv+2
         ddxaQz7M3kybukD0yF8CCam9KHjAfVNNOtGyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690991; x=1692295791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdVO7LGdqPVywscLfXnXC7vbQR6Oxa8Ot+Ua+mHkMYE=;
        b=Q7+UP0AQaQNePkEU58p0iSJAhXLU9s+9ohR3k6K8eCIL0e6avvoYOkS9nfkaIr0tAi
         tSZotlzfxGSAsz0qvkUsN1ykg82R9/AK0jDU8tvOODbOv52Q+o1L+3LlWaUIywyzGZYt
         XhsktmOZ+2kAWS93bwXBJIZNTOurBZ6Lt8rzQ14IOHeD3EpNcZM2JLevDMKjab2DYrIu
         YDc/6h4irBNiFVHZCqekO0TBkxied9NiMgj/sxkAxK4jOyFdhqSUPgaVgFbsOjOOzNlz
         rgtmcvisg1cvgykSGWONC2seRYsupT2PeipTfFJUzfgX4VpwwBFnTmDWpaEQXsue868z
         /37g==
X-Gm-Message-State: AOJu0YyJO87WGzRkgaWlGAqhFFYMAQFE3HO4i+stRr6QPDvDpZm2aXi3
        kkVIAusGNY8aDUfHOTq3F51Y5Z7phvQRV4Ut+IbNjPeG
X-Google-Smtp-Source: AGHT+IGIsD9DhePdO/GdVWp97pzhAeeOlT2AsJgQ4Fsdf21e3OXZrlWi6wiHmEPi+tGp9gYXXufcGQ==
X-Received: by 2002:aa7:d812:0:b0:521:728f:d84e with SMTP id v18-20020aa7d812000000b00521728fd84emr3715064edq.0.1691690990967;
        Thu, 10 Aug 2023 11:09:50 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d98e000000b005231e3d89efsm1098889eds.31.2023.08.10.11.09.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so2513932a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
X-Received: by 2002:a05:6402:520a:b0:51e:5206:d69e with SMTP id
 s10-20020a056402520a00b0051e5206d69emr3555926edd.10.1691690989521; Thu, 10
 Aug 2023 11:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan> <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
 <20230810180244.cx3vouaqtisklttn@moria.home.lan>
In-Reply-To: <20230810180244.cx3vouaqtisklttn@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 11:09:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6R1z=6v+qJpe7qAZGNYZK1ZMs1+dhD7FahVywnMr1Uw@mail.gmail.com>
Message-ID: <CAHk-=wh6R1z=6v+qJpe7qAZGNYZK1ZMs1+dhD7FahVywnMr1Uw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
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

On Thu, 10 Aug 2023 at 11:02, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> When using sget() in the conventional way it's not possible for
> FMODE_EXCL to protect against concurrent opens scribbling over each
> other because we open the block device before checking if it's already
> mounted, and we expect that open to succeed.

So? Read-only operations. Don't write to anything until after you then
have verified your exclusive status.

If you think you need to be exclusive to other people opening the
device for other things, just stop expecting to control the whole
world.

                Linus
