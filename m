Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2E7E11E4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 02:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKEBfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 21:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKEBfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 21:35:06 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168413E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 18:35:04 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ef5310a497so4789468fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 18:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699148103; x=1699752903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQIdxx7h5V0fTWly2Vt/J1o7cnnsiinsY1vD9lUf3oU=;
        b=GA01l7gEck4anTB2gg3dP0WRM/FrcIxQ38214pA90+4T/nXLbChdLxuEP6e4hHM8P0
         hgwaxdDYY8h3xd55qAngChiUerxokTHAwbwCrCx29OP/0VQuvLiboRKlgL6fb0tZcxhI
         +tuJb7phRyRyAKgBt7MF1WHrAdzTEREPsfZ5ahyKsvW/u3OBfz9vUN2YHR4TlJIiQG7A
         B5qBv1a3drfht4LN6LJwbQpht/9b2e1J4bIAjANHKhK9IrO//EUNcd9qdY88ZTA9SCFU
         ehrg59ZHuKeQyFKcMHqzqAm9vMWWp3jh5B9f6RQowzFvkBnUImp5gcg/zCn8sXGnBd8d
         YsXQ==
X-Gm-Message-State: AOJu0YynTgeTFJZKryyU/DXsFgz/P/BPBxb6GQTbTtryO+bS5D8dtjef
        Pjf8ucrYRlEOxIPidPCw/gUmIcwvu67cX1QhtRFcGXkKIvBT
X-Google-Smtp-Source: AGHT+IHFaTZxRCWG88VdtxSwpGUoQoDUAmbmLNmBYIjhOSy82PSeXT95gYEqAGYpfWoBoYUeKWgIAJhT8Z3puGgBB0zbWX/amwvX
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d627:b0:1f0:6087:3afa with SMTP id
 a39-20020a056870d62700b001f060873afamr3452990oaq.7.1699148103329; Sat, 04 Nov
 2023 18:35:03 -0700 (PDT)
Date:   Sat, 04 Nov 2023 18:35:03 -0700
In-Reply-To: <tencent_C46D83B2044E376BB76286CF937A63682905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001eae8506095dbfd4@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

drivers/ptp/ptp_clock.c:250:23: error: no member named 'tsevq_lock' in 'struct ptp_clock'; did you mean 'tsevqs_lock'?
drivers/ptp/ptp_chardev.c:123:26: error: no member named 'tsevq_lock' in 'struct ptp_clock'; did you mean 'tsevqs_lock'?
drivers/ptp/ptp_chardev.c:126:31: error: no member named 'tsevq_lock' in 'struct ptp_clock'; did you mean 'tsevqs_lock'?
drivers/ptp/ptp_chardev.c:150:27: error: no member named 'tsevq_lock' in 'struct ptp_clock'; did you mean 'tsevqs_lock'?
drivers/ptp/ptp_chardev.c:153:32: error: no member named 'tsevq_lock' in 'struct ptp_clock'; did you mean 'tsevqs_lock'?


Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15743708e80000

