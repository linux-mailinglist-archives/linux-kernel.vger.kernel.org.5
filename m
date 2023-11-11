Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6F7E87D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbjKKBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKKBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:44:06 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA61422D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:44:03 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc9eb5b944so32487345ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667043; x=1700271843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuRccP5it1BDeQaqIb5yxoW0JgWVRO0qF5fPiNs/sjg=;
        b=a4GjJ6inLhwC+euOjGSwt04zQY/o3df6SnCMm3lNRzDYL/Q2VRP1OUVmJOKsxtcOjZ
         c7jCM8y3cGeqalII/BxT6oNLIKW0JYIG5mQlHipwRXXMk8QV0ZAf1RLJvmtiI/MwOkcl
         O+UG8gr638h8fRfEsmLbysMTaCoR9/ivN9Vk5Q7LMPhtiKEqd7/6bemObInMMm0X9dwV
         SYzmvR3U0I+ssjyzHnGTgwptEKWIRdTFHcH6CFFI1YvXARTIzofk5VV3rDf8z3/x8kXn
         tDJk1IFAfIpejNWw7EBCRC28z5gIUpGDTutJ7YRRhfrStv1yJfzN8Emmlg2kpVOux+Hv
         wVZA==
X-Gm-Message-State: AOJu0Yw0FzOC9L7qS2Wk/uKHyGbkLeBg6tZgau04DkLLwAp59qEbRsDa
        hUi7gWn0CgJbaussWy5eyeCbbp4aRc5JesA4oIHUPv8DfP+c
X-Google-Smtp-Source: AGHT+IEoU9iAhqau//8oj6PwJOkCd7n865VKPodSDq0NZhEpk1C1Mg6quCsuTJ/AqenGXLpeW/VDOonQahBXFbxvsSi3wwXFuMC9
MIME-Version: 1.0
X-Received: by 2002:a17:902:70c8:b0:1c9:f267:1661 with SMTP id
 l8-20020a17090270c800b001c9f2671661mr1039429plt.2.1699667043224; Fri, 10 Nov
 2023 17:44:03 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:44:03 -0800
In-Reply-To: <tencent_51DB92C1C65949A12EC3AED2CC8967F44606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005913c20609d69245@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/disk-io.c:4934:61: error: expected ')'


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e441ff680000

