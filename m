Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D880240A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjLCNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:17:26 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E33E6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:17:33 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8fe9da425so172815b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 05:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701609452; x=1702214252;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/qRgVNKUlzs44fDiFKxRLv7Z8hO6eaI2yOJ8z4Iim4=;
        b=PhvcUuc6b+vtwWgOkHI+vfnoXXmx+rZbOq+d9kpwx6oVP58D4+1HnDGKQrzz9M26LV
         go63fayxrpSb6iGBREr3lMA1WFxPAlYKFVENQ2JvTMAvLdmNBUXQj0qdbgqIGGK250WX
         yQVYsuQ1rEAWZnwHnVC60aayNeZNnTinuhIgOum96KNGSdDN/zlVAg76GkSluOfO6Z9x
         /I2mrOJLaTkyqxpqBfod7PzuRa5bp3P+0+z3MDNPzerZA897utuxScMXmP2uqykI5orz
         98pPCWhsGXhn1lS3A0Ab2H5WCCJo1Dw3M9Pu4pVZJhGgxaAgYsAvKPwIFQY+JjNHj1dD
         PPOA==
X-Gm-Message-State: AOJu0Yx1r+hG3TlbZen1lun8cmBO4Jpn1wxg7bLdo3YICv7F7wud7o35
        24nUzFqYBvSVRyAZfGyoAEXenUh5IvtDPKDWKNBH4YKooco+Iy0=
X-Google-Smtp-Source: AGHT+IGYRLJLc7n50a1U6z8qC6g5L/8vkeWJmIhheQkUErzL3deRBuWLy+DBQuMOYKqRUu03HXTILIPxnzK9pToaQNihrkjWLO7r
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2014:b0:3a8:45f0:b83a with SMTP id
 q20-20020a056808201400b003a845f0b83amr1597026oiw.5.1701609452429; Sun, 03 Dec
 2023 05:17:32 -0800 (PST)
Date:   Sun, 03 Dec 2023 05:17:32 -0800
In-Reply-To: <000000000000784b1c060b0074a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f56750060b9ad216@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
From:   syzbot <syzbot+186b55175d8360728234@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
Author: penguin-kernel@i-love.sakura.ne.jp

On 2023/11/26 6:07, syzbot wrote:
> refcount_t: underflow; use-after-free.

#syz set subsystems: kasan

By the way, shouldn't pool_rwlock section be guarded by printk_deferred_enter() ?

