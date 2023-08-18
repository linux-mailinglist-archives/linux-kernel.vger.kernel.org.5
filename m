Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5A7810DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378698AbjHRQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378883AbjHRQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:47:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E12701
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:47:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692377230; x=1692982030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcYBK4IDMWdZXBUH9qUpJWq6mMj5wrlrL6q6rkCUyi0=;
        b=DZchxW7NW3WIGfXMnGboGBURwzn7WFGdeJG+sgmIXEimzDVc8m75Y/skORcrUBqh43
         xFsQQf5kHDGo2tSO8fvROhiiNwe3/aGiD4kAb0eOXgzVLpbplYd2Ph33tJzQBNrI6YaH
         BeOf1H6b5FTqKuZrVwD7lBj60By+89vFgf4hUL96Lsic+URcqAXpkfHHvZG5HG7+nM72
         skJJRmCrsNeyZccYYVrqYg5XIhswhK+MDK0C24bdsjB2D0fzGSafmLO8kdwDGMTXCraR
         HlptcFEE5XjwTmPRnA2+FWhioo/IKtiFifqVDmAKubMyGxg9a2lNcc7r9nrB5/1qS1BM
         oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377230; x=1692982030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcYBK4IDMWdZXBUH9qUpJWq6mMj5wrlrL6q6rkCUyi0=;
        b=djRDzI6rBopaheEwvRLRBr0GdzOshVwHfsuOPYXR6icUwxVIphPn3JHDs2wI1P8oVx
         uYAazMIEAUVPLDdGgIEvbxWaD0XALqt4E2Ar6UczWDcABukGBkuEYk/gENK9vgU/+8WE
         YIcHRXswD85fqDFoLeuxTIz4hVxmKEgZQl8GKsuJltfMPLF8YYbXCPxlqOXiDyPjJ1o8
         dmG2kXWw65svqEM8XLxrZ2Bl7CjWEG+G/3RpcKIl0ini/WTR5DMXSUqCyLfPOW7oH4fv
         0phURVyxYMBl+lXRJ7HRut3HcqJeLji8QyCYIb+8R42HqR3J4d9oRHxRnH6Pe9WOpWZQ
         CY0w==
X-Gm-Message-State: AOJu0YxZJYlDvEINivOkqdgJ3BHhlD8zHKIOxuS8sEP+3HOJHM7g6iIk
        Lwynhjt1g+X29GzhretnCxdynSnf6gLxkWHSLPsQ9oyx4Lou7UNXSJrD7Wbi
X-Google-Smtp-Source: AGHT+IHONJU+ctmsr9aVMkdjHd8jipE/NT/Q0+Z+iy7ah9jBa7kpTKIKB44dhx/A+QLF7kEmMzhGxMlCIOAlBtWCi/w=
X-Received: by 2002:a05:600c:3b0c:b0:3fd:e47:39c7 with SMTP id
 m12-20020a05600c3b0c00b003fd0e4739c7mr119961wms.4.1692377229649; Fri, 18 Aug
 2023 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000530e0d060312199e@google.com> <20230817142103.GA2247938@mit.edu>
 <CANp29Y7jbcOw_rS5vbfWNo7Y+ySYhYS-AWC356QN=JRVOm9B8w@mail.gmail.com>
 <20230817144505.GB2247938@mit.edu> <CANp29Y4HGnp6LJ7jw2hrXNFd7S4+MKfjdpjOGZALUuGK1L3wPA@mail.gmail.com>
In-Reply-To: <CANp29Y4HGnp6LJ7jw2hrXNFd7S4+MKfjdpjOGZALUuGK1L3wPA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 18 Aug 2023 18:46:57 +0200
Message-ID: <CANp29Y6JE-HyYL6XZfBy8QvE2CwLHw-HdtVsYxAGMhfy9qT=RQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 1:43=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> I've taken a closer look at the issue.
>
> Documentation/filesystems/ext4.txt says that the "errors=3D" mount
> parameter "override the errors behavior specified in the superblock".
> So syzbot can prevent it by passing "errors=3Dcontinue" as a mount
> argument and there's no need to filter out such reports.
>
> Syzkaller actually already does that in the C reproducer. It just
> seems that this time the tool has mutated the mount options so much
> that the simple patching no longer worked (most likely because of \0
> characters in between). I'll update the syz_mount_image() code.

Ah, it's a bit trickier -- the syz_mount_image() code is fine. The
reproducer first mounts an ext4 image via syz_mount_image(), which
appends "errors=3Dcontinue" to the options and it doesn't lead to the
panic. But then the reproducer does a direct mount() call for the loop
device previously created in syz_mount_image(), this time _without_
mount options.

I've sent https://github.com/google/syzkaller/pull/4143 to sanitize
plain mount() calls.

>
>
> On Thu, Aug 17, 2023 at 4:45=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wro=
te:
> >
> > On Thu, Aug 17, 2023 at 04:28:33PM +0200, Aleksandr Nogikh wrote:
> > > The console log has the following line:
> > >
> > > [   60.708717][ T5061] Kernel panic - not syncing: EXT4-fs (device
> > > loop0): panic forced after error
> > >
> > > Can we consider a "panic forced after error" line to be a reliable
> > > indicator that syzbot must ignore the report?
> >
> > Yes.  And the file system image that generated this bug should be
> > discarded, because otherwise successive mutations will generate a
> > large number of crashes that syzbot will then need to ignore, thus
> > consuming syzbot resources.
> >
> > Alternatively, you can do the moral equivalent of "tune2fs -e continue
> > foo.img" on any mutated file system seed, which will clear the "panic
> > on error".
> >
> > (The other alternative is "tune2fs -e remount-ro", but given syzbot's
> > desire to find kernel crashes, "tune2fs -e continue" is more likely
> > find ways in which the kernel will find itself into trouble.  Some
> > sysadmins will want to chose "remount-ro", however, since that is more
> > likely to limit file system damage once the file system is discovered
> > to be corrupted.)
> >
> >                                         - Ted
> >
