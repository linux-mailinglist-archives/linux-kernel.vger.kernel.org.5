Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C67E02A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbjKCMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKCMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:15:13 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67131A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:15:06 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-581e1d59302so2189216eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699013706; x=1699618506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhYgZ43ZK1aJfYZQ5tVJC7yEO9pHCRBYSEpEHIZDHWo=;
        b=CuTuiR8l85cUHfKaeo3W18/IG53Ahiox4gzgu3Vag2RCZ7jV3f2adC/JCQeampIKha
         VDMz2Fci25aTaCibU5ABto7eQMz36r+piV3rDZDivjSh6z1v9q9FEU0WihJOhON8kB4g
         69FWnMIbFHXyI/3OGOYztAgYEBMVUNDM9ByKl8caXCrPL1bENRzGAd2c//E1aSkZC4sr
         LSyr67QYo8uHAQax7/iLCTyTVKTT8p8LwRhPrOqgbTjS0GdWkuQn3lPs1fel9F5dh64C
         cbUdXDXP6Q9YU1M1L2rO3vWEs/u4CitVxZaB04d9h7ufumrP4mDg8+yXPmyyl07E1siw
         1UIA==
X-Gm-Message-State: AOJu0YyvsF+3rD00/Qz9Qats6U4G22whXnmFYPteEwjwmc4hbczJaDFT
        tQHg+16iqWKTGHRkrvPqb0l0Q2nCFZkcqo42XtMtFtB3hi8h
X-Google-Smtp-Source: AGHT+IHKNTrjIuB93IOddVxxkl9EB8OFOwxS7xaGeM2Zkz3mVE9KY915DTkgTELT2eLde0vAfqRosXB+T0DcTGVv8zRP4bDdmNGy
MIME-Version: 1.0
X-Received: by 2002:a4a:ea4a:0:b0:57b:7849:1a4d with SMTP id
 j10-20020a4aea4a000000b0057b78491a4dmr8275172ooe.0.1699013706271; Fri, 03 Nov
 2023 05:15:06 -0700 (PDT)
Date:   Fri, 03 Nov 2023 05:15:06 -0700
In-Reply-To: <20231103114509.1232-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e530806093e7487@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com

Tested on:

commit:         8f6f76a6 Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=166db0eb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c856b92a9ee7d89
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138b353d680000

Note: testing is done by a robot and is best-effort only.
