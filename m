Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D47F2631
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjKUHOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:14:42 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601510F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:14:38 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso5742603a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700550878; x=1701155678;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb5eBHtKo9o5wZBV0GeMQfGRt2HgsWBlIIVmyXAEVCs=;
        b=RwUUr6md9vu1lsRl8WInqPgLkHqE9ciWlS3bZLwE12dMneJmK3exh8etE/roqd/82g
         rSSuE7oYwbm70AWaqYsS2bRp1mTSSyA0t9eDt0jWFnvnyqda+sNvvMCDpNoK+JJ9cqvQ
         4yYNLAgjVPAvUNDCE6U+WUAnQcin5vWcXAg0PBSfrLFAc1lBmMgzdP4Y+0nvw7eJW62S
         eMyNV9W+wQAAvJlhSUMhB0W5/W0WrC8sUc0nseBVD+7/NZf5JpF5FHXxH0g+LgMZWCpG
         upVZFR2AO6V188CCfC2EfsxdYrKj6ngo3REtURtkV6z+YnxrRJYV6CrHZYQQ/A6n5uu+
         0Mzw==
X-Gm-Message-State: AOJu0YwAq9Yitt/b9URQS9idvcgpWjdWu1dxL9smiFiOCTpHpi2HH2Lv
        SL7mLevf6lhXmRkkrXFR2+pvE2PHK80thWTnfLE2iHtsdb3D
X-Google-Smtp-Source: AGHT+IG3bSUsRl8U8x4Cld38Ky3XlNkGafgmdtj0EFLkUT8Emo9hXrfgUhwiXJn3abe4sIwwihNwx+HSgqYHRk0o9hzcAb6l9Ydx
MIME-Version: 1.0
X-Received: by 2002:a63:5a17:0:b0:5bd:9c1e:c557 with SMTP id
 o23-20020a635a17000000b005bd9c1ec557mr2031955pgb.3.1700550878180; Mon, 20 Nov
 2023 23:14:38 -0800 (PST)
Date:   Mon, 20 Nov 2023 23:14:38 -0800
In-Reply-To: <be80be80-eb37-bea1-43c8-0c97b133f676@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000043a22060aa45b5e@google.com>
Subject: Re: [syzbot] [nfc?] memory leak in skb_copy (2)(test updated patch)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     phind.uet@gmail.com
Cc:     phind.uet@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> #syz 

unknown command "test:git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"

> test:git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> master
