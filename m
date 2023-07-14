Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD56753EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjGNPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGNPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:31:23 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147F2D68
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:31:22 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39cdf9f9d10so2875516b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348682; x=1691940682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7sSZHfmPmMwSnKDeS/LYNRFHMjooDKw3TKG4ZxrK+w=;
        b=k8IQe/pc2lmVTL32PCzefK3Obr71/ZHH+O9dOHew1Z9nOPOcYZQfMRk0US646a3AsO
         X4DGkvSVXZRyBJiSwbSOlTJpCtcyvlKVrHdcHdpdkBK/CuBb0WO3HyO3SPkeRixEmgtV
         daJe8MtDGnGD6Z7nVxgQ9tnmsJy7+1QyaeAzcQfYW9sNMt2VsKqsK4cp45JeKmdkxo78
         Y75w0ieIzxxY17tD2BjCClCifmcudN5ANcpIQtPxd7y0c2y67vVmiZkmvnQtdw1foHMi
         X99DFjAyVupmbC8TxNKi+49L6xtzCVO+/sW70pDFWRmDEkQocl4zMmNFm3gEVQeCE2Pi
         GVVQ==
X-Gm-Message-State: ABy/qLZ1KEI1MPJPJIhIU54CbYB9pAU5913I/SIPFb8r/K32ReK4dkbm
        BDQufw0l4Cf5y4wftxoiaDdZC192Q6ZDT3cx3i74Yk5vByWV
X-Google-Smtp-Source: APBJJlEO7SDJzBanjllHj0OMQaarkOBoeRSZBRQYOWiHUr5A816YDqucajDumEt8SgiTfLBkERkeNjV6wMiR4iwf4GZGQhd4Xxyy
MIME-Version: 1.0
X-Received: by 2002:a05:6808:208a:b0:3a4:1e93:8984 with SMTP id
 s10-20020a056808208a00b003a41e938984mr7270461oiw.1.1689348682197; Fri, 14 Jul
 2023 08:31:22 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:31:22 -0700
In-Reply-To: <9f0365cb-413f-2395-2219-748f77dd95a4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001aaf4d06007424f4@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_resources
From:   syzbot <syzbot+cba21d50095623218389@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com

Tested on:

commit:         4b810bf0 Merge tag 'erofs-for-6.5-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1584e7d4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81133937a108454e
dashboard link: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1305e904a80000

Note: testing is done by a robot and is best-effort only.
