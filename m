Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E827E9A28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjKMKWh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 05:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:22:35 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBC10D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:22:32 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3366262a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870952; x=1700475752;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF2c93KgGkIWVuCkoEKj6HITlnPwJYZR0kmHSz78KSc=;
        b=iycHVHjPqlCma5rF+gPNtdSF1vY1UJk5DGtOKbDimKdk7l3740GircOnOalacffj5g
         f1ut4UJt2fNNdxQDJ5N4nndghz72oMvyxv37uouIywgLP4NFI4xlv15OLh8/8PCDFXXM
         p2akaugogULUpJcew3Ygp31J+9r30aHcy3NNw7g2gfQfxc0m5qoaPCES5YssWN1vu7kK
         hgoyBzJBKKVh/an89flaWDOldaMFQHwp5yeV6XBHzgbyDTPvQEp7zwR1CQiCcFnpDzVL
         1OtddlSXDOVUl4JKO5BWPTQju3BLa82RxTHqAROHlg3RIU88toNg3whoNCCk5KNa7fUb
         c2xQ==
X-Gm-Message-State: AOJu0Yz5JazfSbLCsS+ibsL9Ldi7kkcgu4JmPDN30NFDl9WpMzjSv5qu
        BTxbrQ8zY4PkUtaOv1VFNL+glJ2E/vKwQ14935cvKBiXOYRljzk=
X-Google-Smtp-Source: AGHT+IEZ83E6N/paq7M5PFYyrM6+7HRwSCH2nE01HAbxtUCT/BR56E9K1gvquorXu+Ax5BzCbv2plyuVGKOhlJwhMBwcD+DZ8nJm
MIME-Version: 1.0
X-Received: by 2002:a17:902:b58d:b0:1cc:cc77:73b9 with SMTP id
 a13-20020a170902b58d00b001cccc7773b9mr1844487pls.10.1699870951760; Mon, 13
 Nov 2023 02:22:31 -0800 (PST)
Date:   Mon, 13 Nov 2023 02:22:31 -0800
In-Reply-To: <000000000000e5a65c05ee832054@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e6a37060a060c0c@google.com>
Subject: Re: [syzbot] memory leak in add_tree_block
From:   syzbot <syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com>
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

Subject: memory leak in add_tree_block
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
5a6a09e97199d6600d31383055f9d43fbbcbe86f

     José Pekkarinen.
