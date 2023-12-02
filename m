Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07D801ADB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjLBFOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:14:02 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D91116
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 21:14:06 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d5604c050so3007378eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 21:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701494046; x=1702098846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEprxiqH+tzd5FI8p/HsLIIPRCuYNRJvhl2NZA3IIDg=;
        b=KCyoH5Sj8RFcnRK4ky2k8soyA3qMjMUeIg/nwpkyA5kxaj+09tzTn+6iqfw8SnjNTT
         GwM0ywtx5RGQHNcF66GMel72RAYaM0RdYHwBRrYOSsgqEItH+HLLQNFOdc/ZEkCaXuDj
         g1STOLvHiw1DLx9Sq8AHdGQxhaldIH1j9d/tsJiczbACFyZCXgS26VvsbiHyK+29sd97
         coQRs/cOUA6efpoC/X2g3xiKmGUF5206Qiqiw02MUIKlFPZ/7IhJpRfqBrtJsV9tAkKN
         MldjWrvQxtCb04Xsllfsd12nOIXq1IMemtDRU0MzApDXeGNHqJXCNG0M4ltXlLhj2VJ2
         zDiA==
X-Gm-Message-State: AOJu0YwbKBAiOtYI0tQiNNMEO7ytDw6zHci/4uHv95RftZRbiOkgE6rv
        JpQiFCmVcH+aRMIvHZjZ+q+giNCKUEa4arrfOGgfJT7HU/pg
X-Google-Smtp-Source: AGHT+IEsiF1nnP+IqudsoS5pF2KRU4rhufUg4zgSp1pnd+DSHPtnhNU04w3fHDlxkZw26QoIEKPqdtanIBdA5K9z97sv6ch3jMAi
MIME-Version: 1.0
X-Received: by 2002:a9d:4719:0:b0:6d8:4e3f:b53 with SMTP id
 a25-20020a9d4719000000b006d84e3f0b53mr277527otf.7.1701494045971; Fri, 01 Dec
 2023 21:14:05 -0800 (PST)
Date:   Fri, 01 Dec 2023 21:14:05 -0800
In-Reply-To: <tencent_75CC257BBAC7BBA6337C9E541B054BF91B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000329bb5060b7ff438@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com

Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125ebdaae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6eff11e3e3c25a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cd5352e80000

Note: testing is done by a robot and is best-effort only.
