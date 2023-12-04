Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6B8037A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbjLDOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjLDOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:55:08 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7AB3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:55:14 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d87eb452c0so2535647a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701713; x=1702306513;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6QyLOEw8J1M7T3niTmIA6K2nNn+7/w4xfvqfBGQTNs=;
        b=iEPgWx5idC+EWlZwDIgSe7UgbIOd+C7R1r/m0nZTRlhUPhFEfodRkJTu4mGtqFBClB
         NcK2Bq29KyNcTY0Aujcju8+RoZMKGeOOKzXxieCJZTE4tjorLM8xrIMeCEomhkdCPvvs
         j5IOHEc6tT/TMB4y0ad+hn3wX7FAjsT9i/fGYb46k1fUkFYttLs+e2WvsbhCGpLoXBmZ
         70YYb3poNSZfr46BRmoWsP53zPeARTeA4DLZWgxoUfUlRkQ/HB4SZTDocL2eL/9rvcMd
         NHTTvLN4eTdnkf0IIoM/kE8T+YNeLnvf69XLwQCvcK9GZKRGl8w09y5mOwtRPx/Tke7T
         BQeA==
X-Gm-Message-State: AOJu0Yyq04pli4sogYsUVqgSQiZSAVwtAwkWGsNv1LfBCYCUadPLCOCw
        5JMh3YMjopaBmeFbQ08Ma5Cd7gU3y4c+QBKbgRMbBUx58Tj44WI=
X-Google-Smtp-Source: AGHT+IH2iyfAHDOkseb6N5psLPzFTCP8GW5qXggYba0vg4AHLwSWugJxqtx7CgYFH1mk3JRAmW1qWz6ppGZmC7EFaN4kmc3d7esU
MIME-Version: 1.0
X-Received: by 2002:a9d:74d3:0:b0:6d9:9d56:a94 with SMTP id
 a19-20020a9d74d3000000b006d99d560a94mr932552otl.4.1701701713864; Mon, 04 Dec
 2023 06:55:13 -0800 (PST)
Date:   Mon, 04 Dec 2023 06:55:13 -0800
In-Reply-To: <000000000000f841fb05eb364ce6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b2ead060bb04eb5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in txCommit
From:   syzbot <syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in txCommit
Author: dave.kleikamp@oracle.com

#syz fix: jfs: define xtree root and page independently

On 12/2/23 11:25PM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit a779ed754e52d582b8c0e17959df063108bd0656
> Author: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date:   Thu Oct 5 14:16:14 2023 +0000
> 
>      jfs: define xtree root and page independently
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f67ce2e80000
> start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee601744db6e780
> dashboard link: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e974ed680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2588b680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: jfs: define xtree root and page independently
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
