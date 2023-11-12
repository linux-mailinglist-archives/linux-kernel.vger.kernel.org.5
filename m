Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E787E8F69
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjKLJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKLJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:58:07 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726DE2D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:58:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be0d708b04so3580088a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699783084; x=1700387884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScsTIr4Ho+xj9akmtxXhGGa0r7j40PjknK2yYSLuxZk=;
        b=FhXlrWdXUgOzRaer0RRxcl2ciXoOvgwj8QN+ZL+TrI7c/3vv24RoGFIT4Mp1kRye23
         1H/EJeoCMCyWJNTxcjPx7kWCM9IrFuAydNy76/Ey/VibOtVMtPbVbNsgCE1lwUAXsrZp
         xc8pRJ5oHvWokzm1Q8z9NKCGKW3QGlZR/DuKCgeK9LYsJCyg1sx14XExj//S+Q5uA0ap
         GIp7DtagqpzbMdDmavqpw1WdJsOldzCHQilBb6wAS+fP1LU/CKWwjq75UQI0nL5N0bSR
         1pi6NjNVbiD+42OGokdyuRztaY5JarFFa/BRRC+09RXTuRzJpm3uVd1Jynjtqz+6GrJl
         491w==
X-Gm-Message-State: AOJu0YzG54RDcJnEQYiIDVF1Vrc45ZsAiEwBdy3KaOiGmoa24avzxVSq
        d7hYjBeO/L4mRW7EAcy5tfEeFHwSEd+Z3e1/IekZtWOdhURN
X-Google-Smtp-Source: AGHT+IFhsgDePioQmsk9vH54a/9qZX7jigVilDvOcKaCxIlT7ZnNylMuVEZveSEBOwMi37CAzLZiQqVcNAuAykw976Mz3RoQ0Ds6
MIME-Version: 1.0
X-Received: by 2002:a63:c5e:0:b0:5be:3685:c1cd with SMTP id
 30-20020a630c5e000000b005be3685c1cdmr943966pgm.8.1699783084053; Sun, 12 Nov
 2023 01:58:04 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:58:03 -0800
In-Reply-To: <143960be-a7d7-44fc-a69f-60e1d12eacdb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb9afb0609f196ea@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

failed to apply patch:
checking file fs/btrfs/ref-verify.c
Hunk #1 FAILED at 791.
Hunk #2 FAILED at 800.
2 out of 2 hunks FAILED



Tested on:

commit:         1b907d05 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1652c75b680000

