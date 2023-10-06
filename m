Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313D7BC177
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjJFVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjJFVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:45:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D2FC;
        Fri,  6 Oct 2023 14:45:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bff936e10fso44189441fa.1;
        Fri, 06 Oct 2023 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696628709; x=1697233509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=let7w13fERPI5Kgpd7PXYHW2BAT0UKqxHvYuzVEYIh4=;
        b=KnSaxMRP7aAl7+gA0fsqcUR37kAwb/XtUEFKyHw/6QGgluRiKhyT4wWwKmEe63PXtD
         vTXIvZmTvm0dfIRJDC3mJjB20TDJsuXAGt8oZtPk0QskJsR9rhmrowaIK5tEYDJuWE9c
         vLDa+JnGgRPDsWxfW+PK8pOHuzllXCFuAKP7cLuJJxOyFU6uFOcJrsDmF3Qg3t0BjKwh
         K9/aitok03xRegjCtK2E4hAZFLGIHwz6nny2tmxM2zllrtUo7S9aWifb5YWJVitZiOgN
         7adDVmVo+xwHsfiiejG8nFEPeyDLZ1Xyn0eiCWYN6RBwCUqakmSXBWOHIjhKNAdRJbGE
         ABJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696628709; x=1697233509;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=let7w13fERPI5Kgpd7PXYHW2BAT0UKqxHvYuzVEYIh4=;
        b=Q0+Lqe9+0UE7gYWiTyIvpthjCLXbW7LNvxZUj60SPowZ64yCL+NHLqlwyCm2r1095D
         bh56z0qZi2jfjfwGhptMFU9ovKtPi8ZnUwf9BDfgdgoQrrhmq8chrj8maKqFMG3w37AX
         zmuSTm5NZczT3E7Vs1UEEYnVBNXwd4cawq2+9nQvSq7adAbhG6CYYfMV438l8wzPxyyp
         /NPNxQ66kZufbVEutAat3NA64aTa1+cnEtYyO4Yg8dBAqQS3XezcpnOjHUZXAOGJVRl7
         4MqrqhN8vsAbZKC48xiSsfkfUSzHECAxwAi+NL/Q1glbRRcTveEBjA/aRxypgdZr7Z/1
         sZ8A==
X-Gm-Message-State: AOJu0YzWNUWeOJTEtMMnfN4z+H6832TNEw3kAm0/zsbb/Hlw7NcfOGJk
        CuIFqAVOvA/JCMcRTdhRSCrXf4f3ojEQ1pUBIZcBbbU7j0c=
X-Google-Smtp-Source: AGHT+IHI9Y/zbE3QShTSTaIacMVNInp+QnF7V+VW65/b6yzhiuPuy1TkDt3pZwqE6ZF4n8r9rGajS1g0joQAiGD0hIU=
X-Received: by 2002:a05:6512:1154:b0:500:d96e:f6eb with SMTP id
 m20-20020a056512115400b00500d96ef6ebmr3946145lfg.19.1696628709061; Fri, 06
 Oct 2023 14:45:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 6 Oct 2023 16:44:57 -0500
Message-ID: <CAH2r5mv0jM=ydHxYsw8zNNAMcUAt30pdtc=s-X-nfDo2pdtZNA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc4-smb3-client-fixes

for you to fetch changes up to 3b8bb3171571f92eda863e5f78b063604c61f72a:

  smb: client: do not start laundromat thread on nohandlecache
(2023-10-04 16:21:15 -0500)

----------------------------------------------------------------
Two smb3 client fixes
- protect cifs/smb3 socket connect from BPF address overwrite
-fix case when directory leases disabled but wasting resources with
unneeded thread on each mount
----------------------------------------------------------------
Jordan Rife (1):
      smb: use kernel_connect() and kernel_bind()

Paulo Alcantara (1):
      smb: client: do not start laundromat thread on nohandlecache

 fs/smb/client/connect.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)


-- 
Thanks,

Steve
