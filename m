Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D67F8A07
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKYKpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:44:58 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC1810E7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:45:05 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1b986082dso2310147a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700909105; x=1701513905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vp9C6rmlKfGTC3GyNjcHeARjPxOMdSOfNrf5Xm6+Xcc=;
        b=fyNy3HXi3lXUFehoPyGwJUlDyoWy+CYc0/nVRN5ovbp2Di7HXhZ/V28Eljnm9Kye8R
         rOO569cLdjsodjGbOAPLXYiGIUt1dTIIep2KVGZK5dJgk73nippapibTyzAxqwD8HgI0
         eQyXjdOp4DWi3wzyDAR40PYwE/yRxx2gsKNlEs1Fc5LdRMvyHbw99PIiHPbV6ia2xBzI
         dfw4nWwWWMXFwfA16OpcR1vaVBw6ruD0/NyGx39M8utLb8CTCB5IJPL3dWMOMvKlSlcG
         M1hsMyudN/ad4k/KWSIoEg20+f9Kqh7uPWDkt5i1ZGHSNF9E+S3wDWs1o9UcrX/Ehd90
         1ltQ==
X-Gm-Message-State: AOJu0Yw4bpbguD4EwSPwR59aJHwYGylQRtrQudo3rgNJALiHL8k8OLKy
        JGrAQlOUj6rCsZ9UK6XCWwscML2LM93Vqy3pqT3nTgsIIk3A
X-Google-Smtp-Source: AGHT+IEL2e0ek7ThZjEvWQQSHyDuInQ6zKys/ulnHW6f8jSvmUWQM4zcZO/8oi8maAIdDN6A84Xi53KHfvAkU8vmiLS6Diw0qcts
MIME-Version: 1.0
X-Received: by 2002:a65:688d:0:b0:5bd:3e52:93ea with SMTP id
 e13-20020a65688d000000b005bd3e5293eamr924959pgt.5.1700909104730; Sat, 25 Nov
 2023 02:45:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 02:45:04 -0800
In-Reply-To: <tencent_BFC9C6EF52D0C64F09BAAEE06ECACC82A706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb994c060af7c205@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ntfs3/index.c:1912:35: error: incompatible types when assigning to type 'struct INDEX_HDR' from type 'struct INDEX_HDR *'


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e9fd9f680000

