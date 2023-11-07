Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B667E4A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjKGVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjKGVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:12:16 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B31734
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:12:14 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1eb43ff49b2so7935992fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699391533; x=1699996333;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=vic60QLbX0yZ8A4LJDhBTVWS87mDZQjOD2i4G+CH3YBO3BWfVYTb3038Q01shUmv/L
         cIM9bmqpLM0HRh9oph4Zfq+yA5V2R/ZKMBmDg1nhdtXZNYhEj9KVJJzy0Yq/02FtJLNU
         ca5SdHQO2kXgmnjXA+DBxWOiMLpCdO8eGyO2Q1osmT6rafuOoR+ziqHV8es/lr5Hxgo7
         7fL9apFNh/CW/mVyysukYqbOnzJ0xuMRV3QVxKPnL2pfsRjrvDmQjZHT/bKSbdNw1Rgi
         z8nUCW3SwH07gNkDQHrQidXNBPXbnLzh/nFQYfV9lVisp459PtOC3Pr2n0UUPPuibGrI
         pZWQ==
X-Gm-Message-State: AOJu0Yx7uc9qLm0Mz6cz3swrARSR5aERe8zjw0s1qz9tfiu5ZtXoj6vV
        hCnrU6UaB0dPIePJFHn4/XG433Nm7zglNZHMwFVyOza1e5Po
X-Google-Smtp-Source: AGHT+IGLHHUmMnRU46DQFfD8S2H72t+cm9IJUOhFoEozLFTonUls6+08qYbjyWR1qTuXgbDu8Q8Varcnsio8An9CiRXWhSej/lyS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:2397:b0:1e9:8db0:383 with SMTP id
 e23-20020a056870239700b001e98db00383mr2216610oap.1.1699391533429; Tue, 07 Nov
 2023 13:12:13 -0800 (PST)
Date:   Tue, 07 Nov 2023 13:12:13 -0800
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af3ad30609966cee@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From:   syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
