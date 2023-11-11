Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C675E7E876D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbjKKBTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKKBTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:19:09 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7D422D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:19:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc591d8177so28285595ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699665546; x=1700270346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPKMLLuC0lmtrX8uqBQvklqk38SAanPbuVSQNwb92EU=;
        b=qr3JCQhrodMiYai+/+HEMMCMawxK6VMSdNl1lZgXIQ7jsV80ZndDPbDtpNA5hXUg1s
         Cx8SHrkSVDby4bEt0GFdPAvXuXvcFbdBo0XubTjuiun4ceVdoPjPPq0fKRaSJ7iblKtr
         Lpdv2IXyyCWtyvo+I33hVhBAzzty+LArqbsuyukrMjuNeClX6OGHykqBRxZugbMhcylK
         Oz/UCDzaJXc2xNMbRP+z4NKctaKN9gnDDe/iMIrDkRhW14pIATvOaNHS4WhBZGUQFg4O
         xih3tU2WoNL34egdefTALgywzxH23pWojBYRA3WeS3ymPLhWL//dl8KOg46pb2vBHMmX
         SqEA==
X-Gm-Message-State: AOJu0Yxk68BpuQBrUxGiA2nODT8HiBrFsCZYpluvz7DewTQtG7n8aHQH
        hDlsM6sEKa7LeZz2RNgLf4aZVB/3iMzUndQhnVbSJnHjUuAM
X-Google-Smtp-Source: AGHT+IHShXUi+CRWycdsfzUHN4x5ZR58fQJc08Swtf5VWDrsiGTGDL+Grjzh9Op3OwW+sbBYeK4zQMAb9/dUZhxB2PbBaY6X13wF
MIME-Version: 1.0
X-Received: by 2002:a17:902:efd3:b0:1cc:533e:f52b with SMTP id
 ja19-20020a170902efd300b001cc533ef52bmr251169plb.4.1699665546267; Fri, 10 Nov
 2023 17:19:06 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:19:06 -0800
In-Reply-To: <tencent_1252E00673099CEECDAECC0CAA67E306C706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f546a0609d639f6@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/disk-io.c:4934:9: error: call to undeclared function 'find_qgroup_rb'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
fs/btrfs/disk-io.c:4934:61: error: expected ')'


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124c62b7680000

