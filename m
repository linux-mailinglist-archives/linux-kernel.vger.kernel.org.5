Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAF7CD935
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjJRKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjJRKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:30:38 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED9FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:30:35 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e9c1e06ce9so7777379fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625035; x=1698229835;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEOUFvFLj8BGIeeDw6dbDN1dpAqq/KfWUcaxHojzWJo=;
        b=ZxBmatEl4ekdTqB6K7iz+Rq73rW+Z/drM53x9/jY3Pml36kR2UgyDTQ47GPwc3txC1
         1EkeVlbSoOJEm35cV7D59ZV60pio7uQS5QKUdgjfU9fJhpB0nwMkmOopmKEOzBcGQ+m6
         7jCU2+y7ax/UHDXM0G3tp9xeMIt3bENWXBVZiC8ESfeYVe98l7mn8j2qEk8HLXwMczu/
         d8n/85k5Rl92YTsAZpRkmNzO1Z6Jc4TiEaXyzBcKRbPPmlHExzeXA+IQF12xXIzM/LUH
         YYdmA6TA6WxPpZxnXXBBDNF/stMBYgIaUuGV8OWAEIg+IENbR4aKEzxmRA7W8Y+RJtMy
         WXyA==
X-Gm-Message-State: AOJu0YyCPVq5jvcR00f7tcFa4bhDPsTYBYcU9U2NV8sLTfxAD+TAYHSw
        oX/S/kPg4ibJpCaRx3qIBA33wEkF2C4SCjj0l2s5oHZKK0Yp
X-Google-Smtp-Source: AGHT+IFrcWUt2XQ7APuRZBXOaspIaSCG1TmV5W/FBR2ZFo2UKJYfeGEIbuwQMt4XFWTWRYI3xdRZdkFDjTElmSGYtyLsVenMinzO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9113:b0:1dc:709b:4d3a with SMTP id
 o19-20020a056870911300b001dc709b4d3amr2072102oae.11.1697625034911; Wed, 18
 Oct 2023 03:30:34 -0700 (PDT)
Date:   Wed, 18 Oct 2023 03:30:34 -0700
In-Reply-To: <dc016529-51f7-4a8a-8c67-54a15b19b78b@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002af93d0607fb2163@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usbdev_open (2)
From:   syzbot <syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        usama.anjum@collabora.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20231018
console output: https://syzkaller.appspot.com/x/log.txt?x=161f5833680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f4d682cd6282b3
dashboard link: https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
