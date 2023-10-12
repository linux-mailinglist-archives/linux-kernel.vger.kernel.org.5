Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6687C79FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443051AbjJLWyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442450AbjJLWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:54:29 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D6C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:54:27 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af602b6512so2458424b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151266; x=1697756066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4GepxVdDqnOhbaVFfKyJNSNxiwxVpwbYv24b5W+rg=;
        b=JsuoiL+ryfX62d47RyyH7CbmAzGX8TKFo9TwmiJK/bofB5VMI1Hwkryq+8QOR+w3oS
         cKNAhCjnJjgFHyi8/q5obOL1Csto81lMYVrHkS6ZtyAojxUxdKW3u8c19AbAYFRrJN3l
         8xo6wo8ZBsRK7hoQLwVXeoSDd/B3uPRkPamnBqtyN+VHKQtx3LO1kWH2+U7u5twLq4C8
         0S3/AFiMJmwM8LrwbF1DI2FRjgmiCckOyMcO+jZWQigBN/h0QJfJDrVxhlFJIu3XVkuJ
         pggdYOdTTbyVDjcgzoemL8Y9B1+s107sn6hudU7MtLhr4CuuVhAeBeTe3+JcqBS8XqX1
         risQ==
X-Gm-Message-State: AOJu0YysD16Hb+lIvODfcPj94gxx20FLHV8dPipZy+IbNa60mqe98Ndg
        3R2cIVoK82kIOP0vduUl85EFssFy7eEqgCXf0HolL8lTZwPu
X-Google-Smtp-Source: AGHT+IFiFZCMZCnrYzOGO0I8ReDLC4j6yQVUiDVIELqVouH34B2TrIHyrLW5aeNBURvFTdw4IZu44eAbjHQFOC1ShPajiGKi6zhk
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1916:b0:3ae:2024:837d with SMTP id
 bf22-20020a056808191600b003ae2024837dmr13564961oib.8.1697151266486; Thu, 12
 Oct 2023 15:54:26 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:54:26 -0700
In-Reply-To: <cwc32sg4vzz6akduyvze6tu2dkzpljtvpycuhz43t7lmbzbyvb@jgywtsrcvuzw>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e814006078cd293@google.com>
Subject: Re: [syzbot] [usb?] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
From:   syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com

Tested on:

commit:         ce9ecca0 Linux 6.6-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10be5209680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59eae8406319284a
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dd84d680000

Note: testing is done by a robot and is best-effort only.
