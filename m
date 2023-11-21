Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316437F2633
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjKUHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKUHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:16:29 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F5FBC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:16:26 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso61991065ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700550985; x=1701155785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1kmMcGTXD0qrgPgJBEXI9/po/nPhjRKLnIrd8AUIkI=;
        b=sXDg5I2R0+ZqvJkmuxsjkIazNJHpzJsbD+7KqD8ZF65N8SeCbZXTQCJG2uq5q4dn/U
         +wJq9iH6gJpbE1oZbiN2+9Md82dG7weabi7RPJLfCSfj+BQMV9RJxpO+hczHjlSrQfe1
         OsCbwmNZB2ygXimmsAoiUVvAA+qjWVcqvcr5X91XftZ/Jti7T3Ma353mhC9wtt9gl/H1
         ZMuEmdf6Woaa+1iKxxiO7MPZO2ZtIyE2GLELXt4KG+SnmBtKA2c74V5OnadHvmpCy7zQ
         RGC+fPu5VedfH5mC8sjJ83idPilOLHiCZJB4jwsghhncnNCwwPgU/mE6ZNmqAMnmowLL
         I+1Q==
X-Gm-Message-State: AOJu0Yz1mMMwVvAOwyU1pO4kINVGgaGW3tz6healmTPG7G5jlN/SbOhD
        PlzaRuC5lx5y/UZ28NmLu1MZFsJsdZHlikPEAxit6GewkDy+2f4=
X-Google-Smtp-Source: AGHT+IHMq/AcwwVc1qi6W8HbANRDZrWaYaRnN7XekokSQeqUkj9PA01FWeYqmBtw4Ct5cc1p9yP6XfDxSSR+KJ/td15msmwtdxE8
MIME-Version: 1.0
X-Received: by 2002:a17:902:c78a:b0:1cf:6d5c:6f73 with SMTP id
 w10-20020a170902c78a00b001cf6d5c6f73mr332625pla.6.1700550985716; Mon, 20 Nov
 2023 23:16:25 -0800 (PST)
Date:   Mon, 20 Nov 2023 23:16:25 -0800
In-Reply-To: <00000000000075472b06007df4fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d19f9060aa46187@google.com>
Subject: Re: [syzbot] Re: [syzbot] [nfc?] memory leak in skb_copy (2)(test
 updated patch)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [nfc?] memory leak in skb_copy (2)(test updated patch)
Author: phind.uet@gmail.com


#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
