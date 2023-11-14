Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12067EAF78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjKNLrK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:47:09 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4517A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:47:05 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-58b57d05c70so5112744a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699962425; x=1700567225;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYWJN8lpILSyfiEcNiBTbqHzMRwjY0acvjNOZwjQY4=;
        b=IcJpQCab/LJXcYbfgVrZrt2u6071YmeVnzphy8LFDICdwbSOIB0DkIRN2fmPdH47lJ
         1EbecEfIpaUygVVN8qaRvoozhZ9VQ35MTQoepSNgpFFEDkv0lNR54ihhSG4wBNSMjpgf
         IPFfdmctruB8UFkRS1xH6V4IyfzCO+KfJH5T54GuE305s0Ty0GarFz4uZtXlflINK22R
         LzsxERqS/wru1xi6V0d6aVdUg6QP4iWfUFZSX0yXrG0IsyZHuQAmlUZP3S305jpbkOp+
         t1cNMNaiPCVXeT2rewDtZFpuuy93wgtUcgbEPiZFr3PJKKqHbsn/f53aNUPVtpFPCrvG
         nvdQ==
X-Gm-Message-State: AOJu0YyZwvkBdZVkg3uWq2EnNBEyY4sHSE4PjM/VFJILlsLCFoz7o92X
        b6YYGkL8SkKioCHwt2OEvOn4SvUPpuzNtJohxOQ1soW/LsNyWSY=
X-Google-Smtp-Source: AGHT+IFp5D5GjwNQhJUBlCsA6beHRqs8t/sdQ40nhQ9hi7KTuUUujOOt4trJuLJCQ6Qv02Xhjxztm2o9ZrySE9XyTAzcj96AsTFC
MIME-Version: 1.0
X-Received: by 2002:a63:4d24:0:b0:5bd:3d6e:26fd with SMTP id
 a36-20020a634d24000000b005bd3d6e26fdmr442289pgb.0.1699962425467; Tue, 14 Nov
 2023 03:47:05 -0800 (PST)
Date:   Tue, 14 Nov 2023 03:47:05 -0800
In-Reply-To: <0000000000005e44550608a0806c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000806b0b060a1b58a6@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
