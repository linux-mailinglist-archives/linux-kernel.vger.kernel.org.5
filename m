Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB375B289
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGTP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGTP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:28:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB94189
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13759a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866890; x=1690471690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ueWLYJ0Zpp28j5V5QPthaLz88fH+2254dOYDnHgAd5M=;
        b=NMSbGUMpK4C+K0lUFpR4U4mRLU2BGKqgVgy3KIZICDV9XOFW3qVvqLCVSIRLoocCJ3
         zx5HwTBJWP8G5Ukq8j3RLc3ZxO0nz8qfTO6pkgHoVa0NAJZnrNOzWYmTAZc3g5k8jc9c
         iqVtzrXFOKBFRiiZT8EJUMrIHV0PD2TU4a8YTQv8tFlSjwl7ytGHQbD0ou6BXQKME+TL
         BtoGu9apQZyLEmd78jSKxhl3jqft/NQXl7t+QYT3CmxUz/rAm4ZrIyar2PlCBE1Ql/gR
         /H7BUkFDgWCQRjPb9iC8bL7hDMohAHQYqjusxGEDOGW8dfxV9185lWbkRIFLsOLvtJiz
         D8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866890; x=1690471690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueWLYJ0Zpp28j5V5QPthaLz88fH+2254dOYDnHgAd5M=;
        b=PqdOwAkz/Ni8aTqsX+1VCVRFwqdc6vxpmcGcmbypz9LnxRn6kOB1yap/1UlWms383/
         WVEiQAKlRaV61Fsk9j3T7RYcJh6GBZORjq8mRYbxhuxg+tcVEs7hiRP39XfPQpgvWZbR
         isv+9hPgj/zsDnoMO620uPR9D6td5Btc3si2rbbK5GQEhuUwSl/3xmLeYguUspIGpiqX
         dVVpjBclZ1K/ksUEMTQLu5zhBfoHwNLyytayRmkZ4SqKorohK4LIpsED/m8/5+Jn8oZ7
         FvJrcB/pAVYZE2Z5eScgiPJn5g1Azz5ZCtWOuG+ppL2DgBvoiNfAUsqstbTT7AQRsuMm
         v7cQ==
X-Gm-Message-State: ABy/qLayxqpTzau70vWcqslQOO5I1Yfjs+UOiCJlIouDeHbSFEfencsy
        6XV7n/zLxGsLCH3GLMbH27qkVAnFFCc+8PxvAgbV+Q==
X-Google-Smtp-Source: APBJJlFq0GZ4ZktUOfXrO7gkLDHTJWhPSD/1jcusDXb2jRQnlEDKQRL7PkcO0BkiH+wKF+BeNtP5oYmOviBhd85v+R0=
X-Received: by 2002:a50:ab5c:0:b0:51e:54d5:50c0 with SMTP id
 t28-20020a50ab5c000000b0051e54d550c0mr113732edc.1.1689866890072; Thu, 20 Jul
 2023 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dbce4e05f170f289@google.com> <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com> <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com> <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
In-Reply-To: <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Jul 2023 17:27:57 +0200
Message-ID: <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 17:45, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
> >> Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:
> >
> > Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
> > So basically, you can't trust anything you read from the disc.
> >
>
> If the volume has been deliberately corrupted, then no guarantee that file system
> driver will behave nicely. Technically speaking, inode write operation should never
> happened for corrupted volume because the corruption should be detected during
> b-tree node initialization time. If we would like to achieve such nice state of HFS/HFS+
> drivers, then it requires a lot of refactoring/implementation efforts. I am not sure that
> it is worth to do because not so many guys really use HFS/HFS+ as the main file
> system under Linux.


Most popular distros will happily auto-mount HFS/HFS+ from anything
inserted into USB (e.g. what one may think is a charger). This creates
interesting security consequences for most Linux users.
An image may also be corrupted non-deliberately, which will lead to
random memory corruptions if the kernel trusts it blindly.
