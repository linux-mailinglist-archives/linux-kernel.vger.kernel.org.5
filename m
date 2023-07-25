Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B189761D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGYPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjGYPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B5E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690298327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvJT1Nrqg3NuKZyozBDgNxTT7my/YGr0ImgVXCIWT+Q=;
        b=CCd1TSTmM/2RMJLvxhpY1F9xt3uZEyA8LVTY1lBpspueWBz2VSgtQF0+c3YUgWZKIdXytw
        /g7tI+0V3pk30PdzHeU3JcWCeVa7kBMgwWqzOEfjfUNep6ixpwhgMndw37jPUel/+eOj57
        zj3bqis+baNssjH3xLvCBycT+lL0pdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-ydjjzhLKN3mWGOToHbmD_Q-1; Tue, 25 Jul 2023 11:18:44 -0400
X-MC-Unique: ydjjzhLKN3mWGOToHbmD_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74DD9868021;
        Tue, 25 Jul 2023 15:18:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 241F74094DC0;
        Tue, 25 Jul 2023 15:18:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000c6527105fe7fdab8@google.com>
References: <000000000000c6527105fe7fdab8@google.com>
To:     syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <103845.1690298320.1@warthog.procyon.org.uk>
Date:   Tue, 25 Jul 2023 16:18:40 +0100
Message-ID: <103846.1690298320@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

