Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE47E8F51
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKLJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:23:07 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBE12D77
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:23:05 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc1397321fso33783715ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699780985; x=1700385785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bk2bpdr9RDGRB2/S1/uQIPFKy8AEqgxT3/4WzFG1+lg=;
        b=ErwwBFEJBYmDNZ91CKldGd+H2bp/Me/yVuJh6iRADjuWTMJGagv9/HvXl0O6GkFOFh
         m0bOjMtKQIUgSiy3d6Cs/KGADLetNQr2kyszbjHXgAm1rh5C+61XE53g4OOwPDGeL4EK
         Vnot+hwBEneBywOi52R0yN+prpGp3xG6MMlzqxv2N/gPr7vI5czZDKCGaQyyA4MIaNoa
         1Yr+sQXIY5aLzoFa9GWdkToYdtEnKwIfok0EQ3DZMexc9N6p+huqxI9jeGMrPHVwVPaR
         ApmT6IIY9ri7g5s1V5o8ljmjjFQsO1mCmLXOY2ZpvajBXDN5aqKHs4u8FwPfHxFgnUcV
         j7sw==
X-Gm-Message-State: AOJu0YzyT3ma1N6x9rjTUvZ02ooRba51dLdVH8IrUzd9CqjoJC1VEG2R
        Qp7n/GdaKzPeaQTD1PcWVFJuPWTTldj1+kl0Hsf3m/bS2/Tm
X-Google-Smtp-Source: AGHT+IHICnPM0s7SzWqBXzjoNT79gvlracPrqidooYwoZYqMNEPiJKoupLhN529p+cf4MUYIprD0NrgBPZMk2Cc7wlgawYxXKyYT
MIME-Version: 1.0
X-Received: by 2002:a17:903:3242:b0:1cc:4327:8bbc with SMTP id
 ji2-20020a170903324200b001cc43278bbcmr1223588plb.10.1699780984815; Sun, 12
 Nov 2023 01:23:04 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:23:04 -0800
In-Reply-To: <077cd80b-022f-4401-a32a-33c452bd0179@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc78b0609f11976@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16845fe0e80000

