Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C04754624
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGOBs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGOBs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:48:28 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ADF3A8D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:48:27 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9c744df27so541779a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689385707; x=1691977707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIKfmfllSWfBf6hOb2Iu/ba+uro1mOf2hVRBtGcnuXU=;
        b=E1yJWawnqRZlp9twDOTHlqbK5m4rDFjptGUpgUapMvFcOvf0nZIkX6vtr2vVBzIHUL
         7tLchPl94pJt8Ff7FOWamSbAk4Z4Pnck2YMepe/59KEJyI+pMG6+F/RipLlgHbEGPmt4
         flruTskswa8ZmbTsrINQAboRhD9O5Tuu8CH5RgixpDHdsbIhl2TjvD3Z6wnWJLh3vG50
         6s/G0P3H/DXrEpG1z+9bo/4tj0DoqCCELfyivv9Hwp7gAh5P9T7EIDO8BULQdE+RuK64
         0rA7xfC1rQueMjLTfyXjuxaFaOZTHW/Gv6+ERk4ZKvy0PJoTFk6dS2BqFFrw/OGqK1TN
         K49Q==
X-Gm-Message-State: ABy/qLZv+B2sZoIvPDIWSxN+vTpetq83ILG6IkOs642aFY450tkYMol4
        fNzCIELgOT8oAWhaZxvMoWbtqCLBJnd9QqdrfzLqvY/91Xhi
X-Google-Smtp-Source: APBJJlF46F7KTFglFGVlv5kBEVUayAl5iHEuxmozvzQNBPULji2mHv9+Hn1UGoYXtMM9YS03t1pjpc/A83YyyrswEUFw9F+fm/Ut
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1315:b0:6b2:a874:693d with SMTP id
 p21-20020a056830131500b006b2a874693dmr5243489otq.3.1689385706921; Fri, 14 Jul
 2023 18:48:26 -0700 (PDT)
Date:   Fri, 14 Jul 2023 18:48:26 -0700
In-Reply-To: <20230715012558.468-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f325d106007cc274@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com

Tested on:

commit:         c192ac73 MAINTAINERS 2: Electric Boogaloo
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10875224a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=268de7231d485f5b
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130c008aa80000

Note: testing is done by a robot and is best-effort only.
