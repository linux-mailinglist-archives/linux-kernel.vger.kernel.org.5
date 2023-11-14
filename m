Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25D7EB562
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjKNRKa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 12:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:10:29 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23876CB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:10:27 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c4d4b1f223so7138267b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699981826; x=1700586626;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYWJN8lpILSyfiEcNiBTbqHzMRwjY0acvjNOZwjQY4=;
        b=VNTjnQW2Bw9vnNjMfJPhuP+1QlkEFggQn2tF7C57vNwRgFUXwpZjyb9DW5fOl4puKO
         hjjHRWTzIweZfVplNQ+zGbicKgyqkuKwsd8lcQePQ5BuF5lswbtgYDvbO6Kz43F4UydF
         OWMHVfW8pVHQVhhpIO5qNT7YyFlGepKGCoVBfa2TJUCy/fn1DDT217Z38g55aEbp7t7a
         ABPAToGTiC6G7QkS9bzjcAN6cmC1KUf+dkDs7NhqkRv6iJMZxg4JsXtn9Tjozg2FV9tj
         87LhXr739pSh75HaCRfoqtw61FAPE8WCL4js9C9fT8Dy8GbdfgqD5wVu/Wu3TSVAI7m2
         GE5w==
X-Gm-Message-State: AOJu0Yw+4Q4+3xCHizPrENt+nPXbdRM5+x/e4djNSIGE1HzUDwjLQke7
        JL8NAf3KN4xY5lOe2c4sH0GkodtioZQTl19lLOaCAK54fpkwdIg=
X-Google-Smtp-Source: AGHT+IHNu8h6z5EMaVHadx6g5P7tBnMBdt4oUMG6OGje/6nAAtzzRmuil7jdlp/C96xoVrmIY3qTz0ENjxufxJI17PpWvc26Lan5
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2da5:b0:68a:61fb:801c with SMTP id
 fb37-20020a056a002da500b0068a61fb801cmr3466965pfb.4.1699981826696; Tue, 14
 Nov 2023 09:10:26 -0800 (PST)
Date:   Tue, 14 Nov 2023 09:10:26 -0800
In-Reply-To: <0000000000005e44550608a0806c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7ae2a060a1fdc8a@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
