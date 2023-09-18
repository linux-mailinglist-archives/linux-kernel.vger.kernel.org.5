Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE87A53C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIRUSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:18:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996DB6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso6013064a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695068305; x=1695673105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hiqGPeu+uF2kVYNtC9QmaELCxRejOYJFO8VayGWNAw=;
        b=gnPtYwIWD9VYq0nKHU0jqdq0LngTIh0/PqrWRm5+GEtU1lCAN9y4oGeGUyv0UQ/Q82
         WqwBguxXgShXF5VK3zw+PxPS++I/x3w/ZEc5DPgEpKDlBcz10JBHpY2nqcY2By/z/ycr
         /64z6aGaBlqFwt6jYWYwK21A5XR3QOH1ezDZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068305; x=1695673105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hiqGPeu+uF2kVYNtC9QmaELCxRejOYJFO8VayGWNAw=;
        b=pvmZTKN24eUqdPOddLMFC4FgasfE/x7SZTiCGsogjqoboT6kWXx7DRMtrnrF5URxXQ
         1OwNEDL0Y3tg4qUAqvBK1xLQa7abVNlNoBB0WzJUPiHWX55UpinC/iaybhd62bA9DqyZ
         AZTxOZo07IlD6AYlif5ibCPyluDYdOCiF6rD0Ab3G/RX16DQiWXdFSO6zfaQl4t3+swS
         D8ASrQkwq6Rzx7ATLolSlWiquucIRmfiFaTp3Y+L4dJO8SzSRxXIHRKSOlG0daOHYdrC
         O9vB1E6oTgzJkf44cj3WmsyDQbjCQ3xE2ZrclVRZwf9uKPkxYUpSLdJkN3DlS7XNgzsZ
         3WoQ==
X-Gm-Message-State: AOJu0Ywxk9Fp6DzqOheeceXwy8bg5qRvg3IYpBptDBLJgOHN9KRYifba
        I8u6LAN4FeNA/HX88q3wB/eiiGOCPc9omwDOV9sl2eKi
X-Google-Smtp-Source: AGHT+IF4EuAQmGaNrQiSyuXfkZ1+kZCOFGNs8rIQo0M7PX+3s0QvdjwwWYPRrRc2O9bqZ/8Qs4gU2w==
X-Received: by 2002:aa7:d68d:0:b0:525:70b3:72c2 with SMTP id d13-20020aa7d68d000000b0052570b372c2mr8339341edr.14.1695068304870;
        Mon, 18 Sep 2023 13:18:24 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z21-20020a50cd15000000b00532af2a18casm213601edi.3.2023.09.18.13.18.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:18:24 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so3562495a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:24 -0700 (PDT)
X-Received: by 2002:aa7:c152:0:b0:52f:6942:4553 with SMTP id
 r18-20020aa7c152000000b0052f69424553mr8578677edp.6.1695068303973; Mon, 18 Sep
 2023 13:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com> <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
In-Reply-To: <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 13:18:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
Message-ID: <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 18 Sept 2023 at 12:39, Jeff Layton <jlayton@kernel.org> wrote:
>
> In general, we always update the atime with a coarse-grained timestamp,
> since atime and ctime updates are never done together during normal read
> and write operations. As you note, things are a little more murky with
> utimes() updates but I think we should be safe to overwrite the atime
> with a coarse-grained timestamp unconditionally.

I do think utimes() ends up always overwriting, but that's a different
code-path entirely (ie it goes through the ->setattr() logic, not this
inode_update_timestamps() code).

So I *think* that even with your patch, doing a "touch" would end up
doing the right thing - it would update atime even if it was in the
future before.

But doing a plain "read()" would break, and not update atime.

That said, I didn't actually ever *test* any of this, so this is
purely from reading the patch, and I can easily have missed something.

Anyway, I do think that the timespec64_equal() tests are a bit iffy in
fs/inode.c now, since the timespecs that are being tested might be of
different precision.

So I do think there's a *problem* here, I just do not believe that
doing that timespec64_equal() -> timespec64_compare() is at all the
right thing to do.

My *gut* feel is that in both cases, we have this

        if (timespec64_equal(&inode->i_atime, &now))

and the problem is that *sometimes* 'now' is the coarse time, but
sometimes it's the fine-grained one, and so checking for equality is
simply nonsensical.

I get the feeling that that timespec64_equal() logic for those atime
updates should be something like

 - if 'now' is in the future, we always considering it different, and
update the time

 - if 'now' is further in the past than the coarse granularity, we
also update the time ("clearly not equal")

 - but if 'now' is in the past, but within the coarse time
granularity, we consider it equal and do not update anything

but it's not like I have really given this a huge amount of thought.
It's just that "don't update if in the past" that I am pretty sure can
*not* be right.

                  Linus
