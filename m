Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD73C7EAF40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjKNLcW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjKNLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:32:08 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899782D7F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:30:20 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be10675134so5176750a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699961420; x=1700566220;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYWJN8lpILSyfiEcNiBTbqHzMRwjY0acvjNOZwjQY4=;
        b=TQglx6AXvblcRXe+InqRcg8Xek3839oBibxtZULgWJyFR2dkwvb2hJSE5lU8iF6chl
         oNyKtM/JsFcCYOfx1BEmwQS3aez/OHM5pRMX/Tjx/AadJR2HbZFhQqJaT+JC+MtSwUaG
         cj60NJO3TbTbrhyLuC+EPS5kdm7EcQa3xyvfO48NeLIat8P1ynPWl4DlCrCFTrrYSos0
         9BBxCn+LTahTdqt5LrpMZ2gTVa+PFb42ku/kfmkgNyqtxKQndIBLJv2iB7Hv72U4//Dc
         xdW0imrPjwp2/K5zhTlbedoaX/6jbfDuvNz8KJ+f9jxqbQSukqb9uwjXEsSlF5KZVfJe
         O71w==
X-Gm-Message-State: AOJu0Yx9RlO84C8ESFkCsOjdpfmZS1YEYN0e5mjYtRWWMz7BKDcBXuab
        cV2CwC/vijqoTwGLth7T5TZi9svgPSpU8obMnUukioY5G1csgQA=
X-Google-Smtp-Source: AGHT+IG4BTfeRdzrtf+m950m/jOaQGesMJd3Gh/Nm+FU3QG6DUuSgRqecob+zDdC0RUo3QCOKTITV56W9rlYNgN4TU5jmY4E73kv
MIME-Version: 1.0
X-Received: by 2002:a17:903:5cd:b0:1cc:2ffe:5a23 with SMTP id
 kf13-20020a17090305cd00b001cc2ffe5a23mr467069plb.8.1699961420101; Tue, 14 Nov
 2023 03:30:20 -0800 (PST)
Date:   Tue, 14 Nov 2023 03:30:19 -0800
In-Reply-To: <0000000000005e44550608a0806c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093bd7c060a1b1cd6@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: unable to handle kernel paging request in __pte_offset_map_lock
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
03d1179639b1515dce087335c1fb5c962908683b

     José Pekkarinen.
