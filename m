Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD17C80B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJMItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjJMItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:49:47 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C247CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:44 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-sTSYr53zPc6DLKLlrA2nDg-1; Fri, 13 Oct 2023 04:49:37 -0400
X-MC-Unique: sTSYr53zPc6DLKLlrA2nDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D00F8185A7B3;
        Fri, 13 Oct 2023 08:49:36 +0000 (UTC)
Received: from hog (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D5540C6F79;
        Fri, 13 Oct 2023 08:49:32 +0000 (UTC)
Date:   Fri, 13 Oct 2023 10:49:31 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     syzbot <syzbot+66e3ea42c4b176748b9c@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, bp@alien8.de,
        daniel@iogearbox.net, davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        liujian56@huawei.com, mingo@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vfedorenko@novek.ru, x86@kernel.org
Subject: Re: [syzbot] [net] [crypto] general protection fault in
 scatterwalk_copychunks (4)
Message-ID: <ZSkEm99MvaKOc_Ju@hog>
References: <00000000000006e7be05bda1c084@google.com>
 <0000000000004b2b3d06078b94b0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000004b2b3d06078b94b0@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-12, 14:25:30 -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit cfaa80c91f6f99b9342b6557f0f0e1143e434066
> Author: Liu Jian <liujian56@huawei.com>
> Date:   Sat Sep 9 08:14:34 2023 +0000
> 
>     net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17338965680000
> start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
> dashboard link: https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10160198680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15feabc0680000

Yes, looks like it.

> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

-- 
Sabrina

