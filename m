Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57C27743F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjHHSOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHHSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:13:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BE3744B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:19:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so8255310a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691515148; x=1692119948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LPhKJdQTcwFoDItceYL3qjZJlSnPxbCU8xvPi+Vd8A=;
        b=a7Y7Uja51LpOnsbvN2jw/j0zaBQumTDCa3kDQPJebVDIhi71lEgwqgRZg2v1lUeAov
         GjAQpU1TASBkwKved/eg0zQ3Fts5ESw//r2XleDJ91OfhWRiLeI8bEdvbI1JduXN33Nw
         6qBxd8Febunk14JGeFM93LdBvrXvf6iR88sqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515148; x=1692119948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LPhKJdQTcwFoDItceYL3qjZJlSnPxbCU8xvPi+Vd8A=;
        b=e87gSdoyxfEHeBXq5zhBq3S3FZBiCUnGiVGDtbA2bEc45DHj1ozsI+rfyHmbyYLGFN
         VhK2TpIrJpLdhEvB2sbBJjS6XRZwdBSv8wSrOiWcIxjYYr9roWubvPKGvHN0nPavTHiI
         i/0drRIlu+kMfH14/vmdAYHvgKfl9DrkhHeM54RvORtj60bBuMz15kqpsRGcc/JNsCjn
         hYuSi4p7LxqqBg9uW3/v3OpdPGkI8ZveeDgLUelDDScZil+tgUU0RtS+zx4ADXs2gbrj
         dCPGXthYtk5ltnFix+1BrGoZoJwVAKOy7XO/8XMum0UVri6LPUzTTDl7Zvubbg2MIL2K
         HA4w==
X-Gm-Message-State: AOJu0YzCskYt/FeDEriZdwzKVDNkZSpLkEUz9dj4d7/T6kccwVNHP3xl
        jHkxLUUBo/ofh6sxS310cCKv6svuDXVHjAi2+NVbiNkB
X-Google-Smtp-Source: AGHT+IFAzWoc0IDS581pyP5K0bq7Rd9AC4vVbef/hJ0W/NAonpQyDTOli00KoSkj7Kn3ST670yGuhg==
X-Received: by 2002:aa7:d052:0:b0:523:95e:c2c0 with SMTP id n18-20020aa7d052000000b00523095ec2c0mr308166edo.42.1691515148174;
        Tue, 08 Aug 2023 10:19:08 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b0052228721f84sm6969393eds.77.2023.08.08.10.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:19:07 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so8255290a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:07 -0700 (PDT)
X-Received: by 2002:aa7:d6c6:0:b0:523:1ce9:1f41 with SMTP id
 x6-20020aa7d6c6000000b005231ce91f41mr435083edr.18.1691515146925; Tue, 08 Aug
 2023 10:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com> <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
In-Reply-To: <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:18:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
Message-ID: <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 10:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Few hours ago I sent another version which very closely resembles what
> you did :)
> 2 main differences:
> - i somehow missed close_fd_get_file so I hacked my own based on close_fd
> - you need to whack the kthread assert in __fput_sync

Good call on teh __fput_sync() test.

That BUG_ON() made sense ten years ago when this was all re-organized,
not so much now.

> I'm offended you ask, it's all in my opening e-mail.

Heh. I wasn't actually cc'd on that, so I'm going by context and then
peeking at web links..

             Linus
