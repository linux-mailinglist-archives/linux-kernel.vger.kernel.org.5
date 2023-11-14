Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659537EB652
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjKNSZZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:25:23 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240C11B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:25:18 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b99999614bso5724718a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699986318; x=1700591118;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYWJN8lpILSyfiEcNiBTbqHzMRwjY0acvjNOZwjQY4=;
        b=IUQiHrAYHhinMfZocyh8xz5leN7a83LdCEPzAZpXE43Yz/+MPkVvutjuyQn9zJUICr
         7X7KKmSPHEMTMr1ZFzlD0ihHpTbDdSNMhddRhwRZr20MwjDftDrVARTUGDpOfQLbtFB4
         2C7A81ioBMDi8NKk68ihe5bVfhjrSN8AI7Bn85oXbIQgo8S2dx+KpM1Kne054pZpVJVM
         xrxxoQFWNIiEz8MG5zZr+N6HYH5zieqDLcpAazFGdBzFTr454pdCRP5JTA7Qr7hgCrGd
         JlZwxh3YSMZRwuLMqb/BUjw1jgAed7qf5UZmPTqRLExbaLi3EtaDZg7Wj+k3/cDaCzLh
         U0fA==
X-Gm-Message-State: AOJu0YymKDZuuzFsGmWOhTNnwXK0iih0JWdHe1RUvk+DYdzn0D0Tojxz
        i1bzbNaHzNPPFaP4Im30aE7NGVCR+ODaBjB1Vx6AqIqMTqJlZ/k=
X-Google-Smtp-Source: AGHT+IFnfJTjUBdK8tVjoTUe6w8qvCiu7JfCn5oKbp06ZLj+5kebG7iHfLurqXNvw9y+CuKOkTFRnv8rVHsQKSOkgge7/PBElwzn
MIME-Version: 1.0
X-Received: by 2002:a63:fc23:0:b0:5c1:7124:d9a9 with SMTP id
 j35-20020a63fc23000000b005c17124d9a9mr683021pgi.1.1699986318584; Tue, 14 Nov
 2023 10:25:18 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:25:18 -0800
In-Reply-To: <0000000000005e44550608a0806c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a47182060a20e848@google.com>
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
