Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE827CE791
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjJRTTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjJRTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:19:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6C129
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:19:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507962561adso8700103e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697656741; x=1698261541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ne6XlZkvrqbgYXFwibkwS6QVtHojWCVkTUV60CnBXA=;
        b=BunhL8vEinbtMzTobkYonStJky9F0F3H6gr/fGEhsF7xRMQV8NYr666XLtr22jPNbU
         J9pqRBLYmrFEs0bSbQfVJOe8VwBUFC676HMshHaKGBBNymcdZNEEuQwEN2R7+f51F3p9
         fXevfbvD2dqSNXU6J0CS+IeTc7Z3zrrUh9kTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656741; x=1698261541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ne6XlZkvrqbgYXFwibkwS6QVtHojWCVkTUV60CnBXA=;
        b=mxngMP1/mX0mGwsaueAceytietvq8syr4nGJejBIRGN3S3rayMIKyyzAZQtGdZuH1n
         JD8NuEByMHSkxKyWMuIJepWxo2zv3mPrSHzw1urgg3f1TV9KIyhVHGv7P4kMdv/J9qw8
         sw4laq8sGnSN/SjLTrp+kzhoN0TyX+2J791HUXdIcqMV39aKuLC/m9BLuThdZxd2Dmvd
         gne0W36rNRbT1by+Ywv3vbmRnTwZs0SOLwBv9KTB8Jd8lqZGfh5gdERGnbrhlqFLh4WS
         DWtJUBKnuQAlI/fqiKVbmth6d1FgU5oDjjUTG2nwjqrinwIHm8ZsKKopSw+95poWBSfK
         mlIQ==
X-Gm-Message-State: AOJu0Yy/JIKs11vFjgDzxkxNyUBnUHMu3hcxZga0EayICYdPcMhzS7lO
        6oG33BOrNnqehJ/ZU+y8aBAwMtJO5Gbuy9wUSXV9R3G5
X-Google-Smtp-Source: AGHT+IHERBFJVmnhfSITUp90k/YwX9LpA/dpQZgzjw57mG/1Jn3QAKlHuj33Fn1CRYkqsfRCrjomMA==
X-Received: by 2002:a05:6512:b9e:b0:500:92f1:c341 with SMTP id b30-20020a0565120b9e00b0050092f1c341mr5860371lfv.54.1697656741522;
        Wed, 18 Oct 2023 12:19:01 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f12-20020a05651232cc00b00507a622184dsm807346lfg.173.2023.10.18.12.19.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:19:01 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso7299621e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:19:01 -0700 (PDT)
X-Received: by 2002:a17:906:99c4:b0:9bd:a662:c066 with SMTP id
 s4-20020a17090699c400b009bda662c066mr149569ejn.76.1697656719721; Wed, 18 Oct
 2023 12:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 12:18:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Message-ID: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
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

On Wed, 18 Oct 2023 at 10:41, Jeff Layton <jlayton@kernel.org> wrote:
>
> One way to prevent this is to ensure that when we stamp a file with a
> fine-grained timestamp, that we use that value to establish a floor for
> any later timestamp update.

I'm very leery of this.

I don't like how it's using a global time - and a global fine-grained
offset - when different filesystems will very naturally have different
granularities. I also don't like how it's no using that global lock.

Yes, yes, since the use of this all is then gated by the 'is_mgtime()'
thing, any filesystem with big granularities will presumably never set
FS_MGTIME in the first time, and that hides the worst pointless cases.
But it still feels iffy to me.

Also, the whole current_ctime() logic seems wrong. Later (in 4/9), you do this:

 static struct timespec64 current_ctime(struct inode *inode)
 {
        if (is_mgtime(inode))
                return current_mgtime(inode);

and current_mgtime() does

        if (nsec & I_CTIME_QUERIED) {
                ktime_get_real_ts64(&now);
                return timestamp_truncate(now, inode);
        }

so once the code has set I_CTIME_QUERIED, it will now use the
expensive fine-grained time - even when it makes no sense.

As far as I can tell, there is *never* a reason to get the
fine-grained time if the old inode ctime is already sufficiently far
away.

IOW, my gut feel is that all this logic should always not only be
guarded by FS_MGTIME (like you do seem to do), *and* by "has anybody
even queried this time" - it should *also* always be guarded by "if I
get the coarse-grained time, is that sufficient?"

So I think the current_ctime() logic should be something along the lines of

    static struct timespec64 current_ctime(struct inode *inode)
    {
        struct timespec64 ts64 = current_time(inode);
        unsigned long old_ctime_sec = inode->i_ctime_sec;
        unsigned int old_ctime_nsec = inode->i_ctime_nsec;

        if (ts64.tv_sec != old_ctime_sec)
                return ts64;

        /*
         * No need to check is_mgtime(inode) - the I_CTIME_QUERIED
         * flag is only set for mgtime filesystems
         */
        if (!(old_ctime_nsec & I_CTIME_QUERIED))
                return ts64;
        old_ctime_nsec &= ~I_CTIME_QUERIED;
        if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
                return ts64;

        /* Ok, only *now* do we do a finegrained value */
        ktime_get_real_ts64(&ts64);
        return timestamp_truncate(ts64);
    }

or whatever. Make it *very* clear that the finegrained timestamp is
the absolute last option, after we have checked that the regular one
isn't possible.

I dunno.

            Linus
