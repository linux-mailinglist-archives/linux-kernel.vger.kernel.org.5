Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC0809CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjLHHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjLHHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:15:57 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA07171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:16:03 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9dafd4eb5so2214688a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702019763; x=1702624563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWbqQqOHRfzIzhrYfQh7a8qS6Dk9xuot9jI+mx8WBpA=;
        b=cpCVbvXrMNVXPZthoexbs6soWgoVFub3AvQKhyq/Ug+lumOmdSEFU8cv5cxbWPMK+G
         VciNhjw43nSZGIgNzkta/DYiQrlIvkbT4XteKUZo1CFzvw00QgNxpSIWrXuMPlygrGsN
         HgsEIzuQHhn9aje12BN8bignZFbIV45mR0RrPt98KvZC7wAwzMRXzHEvdZPsoq66ZhW3
         jpz3BYQx26zXcS0jwcfCXBFmL6Hy8S0RTR+v0NSO2XdIY89rKFLhGHeCDs9tuMbMuQ+i
         ZCW3qwe000SE9Fflg2Ijq2VMq3vfbsE1X0rXD9OfFssxsea5b5jIG0qptmQt1FQyoxTM
         U4jQ==
X-Gm-Message-State: AOJu0YzPwczuaWEg4Ja9nrtOf3tubfekTbZ+JNkNDgskctJbw/lRaqxY
        VXsOJIrb3fUvXGRPiZf0b6YihZ8RbHP0ecoPDngFcqga6MLGPwA=
X-Google-Smtp-Source: AGHT+IGSwoHSqtffPivwtyl4wWa/pPz5FpYpLOrDUASmwb8F+p3E8PK4zB55PaMS35vmlY/x/hYgW4ddZam+uPSvWGq84/A9Eap1
MIME-Version: 1.0
X-Received: by 2002:a9d:53c5:0:b0:6d9:da80:7f34 with SMTP id
 i5-20020a9d53c5000000b006d9da807f34mr1354078oth.0.1702019763107; Thu, 07 Dec
 2023 23:16:03 -0800 (PST)
Date:   Thu, 07 Dec 2023 23:16:03 -0800
In-Reply-To: <20231208065944.3611430-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000617be2060bfa5b24@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file lib/radix-tree.c
misordered hunks! output would be garbled
Hunk #2 FAILED at 581.
Hunk #3 succeeded at 1363 (offset -4 lines).
1 out of 3 hunks FAILED



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fee232e80000

