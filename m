Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F607B7C15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbjJDJ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJDJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:27:44 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B67B4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:27:39 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af7219c67fso2732650b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411658; x=1697016458;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ib8OsmN+l9hS4WSHapHdz4QJybGsr7F93ZbuDJEM+s=;
        b=Wbd82Qw0aAzvr7+Q7OwwHX9yRNyHtL4WNTvNjcfbQLBk4NTdEUMTiGXly0GmAEyoSY
         I4iFNjMeQesxfhjSBOwc94+C7pJxtoUcz+wFnj+FTmOEs1/Pkf7jryapgxUfHXYP3hTn
         wNm6C1qFAWUy00HxJYkCogzPpNRRlq15oOK3YRuwy7+nSeQebL1VMqpYYENABEwzNaxJ
         iHElDaAGDsLqzujELaRmuqjJdcWresffjpSW+n3TNQl77iy6S9YDYUHDsW+UBuVWYhQm
         nMcibuZuZPyjN55nF2w8SHOumVQ1wlJP5I8viWiHyzpdz4L8MGSFFXO1872RDN2rZ0IU
         7y3A==
X-Gm-Message-State: AOJu0YwE9ryLTDwAUMFs61PmZJvf8yjdevKHepfVARHABTpuLpnRUDdk
        oKmAxmtC8QB3Nxlo717tn9j3lRqxdF8L1adcbdHewc/5NDuu
X-Google-Smtp-Source: AGHT+IHYOL1M7N9QCiQZReshAhpID17SJ9puzwNce1bM91QoH83bG82Scl1CikhTsvyf8LmwZ/1iSfGTqpR59YVOaViugKL0+ZRT
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8e:b0:3ae:17ed:fdc9 with SMTP id
 o14-20020a0568080f8e00b003ae17edfdc9mr975891oiw.9.1696411658456; Wed, 04 Oct
 2023 02:27:38 -0700 (PDT)
Date:   Wed, 04 Oct 2023 02:27:38 -0700
In-Reply-To: <20231004090157.1850-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b95d80606e09ee6@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
From:   syzbot <syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com

Tested on:

commit:         c9f2baaa Add linux-next specific files for 20231003
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15545321680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=ec78016e3d67860eec28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152b55b2680000

Note: testing is done by a robot and is best-effort only.
