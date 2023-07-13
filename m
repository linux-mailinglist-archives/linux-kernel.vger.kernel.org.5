Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DA751AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjGMIG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjGMIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:06:02 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04230C2;
        Thu, 13 Jul 2023 01:03:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so397658276.0;
        Thu, 13 Jul 2023 01:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689235437; x=1691827437;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNc2pUv/smaIGLoP8Kp1HP8/RcjfUJ9VWG1zvqf1FRk=;
        b=QdNGjNEI4hzaUyyE7vA5jRRLDwnHf/GBv2mvnGl9QudbJavTc5uLYF02AL2EE4BzOY
         STJJ2WGhIp2Fj8EMNEvxDDHfng6gZdIXBdrrHsjH2AXUahTVjn0HAkJXLW3iGC75PBLu
         CCabxflcCi9dpDpQe/n8cMzpdtO050gJRBQ2Uz9t/RweW6YMIvHKiM4KncWLJJXBamIx
         M/8b/KV1EDS6ycM+QiKEdGAAOtbCrPD8dSxBsUfI1VmwNrpIfgomMXGr6fHRwxUZWOCP
         szf0JVZch8WuZdHHJoeCnFQe0ouytx44u4mdl/kmN2fiKqmfpynMk1nY3QJl5+lvbfNl
         I6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235437; x=1691827437;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNc2pUv/smaIGLoP8Kp1HP8/RcjfUJ9VWG1zvqf1FRk=;
        b=BcZ9ESe+EiAjpue1Lw3Glj68KRvCGV+CpIjKRi60hKyukY76cllitw7GFa9qu3lswe
         IOAPqnh7xqgCH5gt0f5JQSdDs8AkiDTWAvy0wicobastWUeODFmRQiPG7u/ljH7PntFr
         2o480joV32u498mNiECWdvigOhnl3kncgeM37s2wiLZVJTGF257w7FOsqus3h1gcHC6Z
         kA+i9WpxMwE7jBd9r211tjs7b5TGxj6AjGdWG6jV7KdspVab4k9jwlVpU92NMR2AaSHN
         ria/nQqoXQwKju8vIW3Fhl1C1WzeUnSzFMAwPyjBz7o4znJ9qV8Ox8zc4jVZkeibXHL3
         pq5Q==
X-Gm-Message-State: ABy/qLZOLAsmrboLw3RSrhRNhhFtu+YB7krVRRahrdIIix2LLKLz5KU/
        UvsBRv4SEMl9Rhs2DQzh9vIK7I0NbZNfIBcelEZTEtGLgrM=
X-Google-Smtp-Source: APBJJlEs/BW2S7clrV46fvJmu+3eBnO23VlcwbByQILp+Uk/fVxad+/5Pb3wy3N9QjZoKwP16JnEceQCL1lv6YjGNYs=
X-Received: by 2002:a5b:7c6:0:b0:bcb:523e:addf with SMTP id
 t6-20020a5b07c6000000b00bcb523eaddfmr622445ybq.65.1689235436627; Thu, 13 Jul
 2023 01:03:56 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Thu, 13 Jul 2023 10:03:45 +0200
Message-ID: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
Subject: Another regression in the af_alg series (s390x-specific)
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It turns out that beneath the first bug [1] there was another one
hiding. It seems to happen only on the s390x architecture when running
the following libkcapi [2] reproducer:

kcapi -x 2 -s -c "gcm(aes)" -i 0d92aa861746b324f20ee6b7 \
    -k f4a6a5e5f2066f6dd9ec6fc5169c29043560ef595c9e81e76f42d29212cc581c \
    -a "" -t 5f24c68cbe6f32c29652442bf5d483ad -q ""

Frequently (but not always) it triggers an oops like this one:

[ 3986.766763] Unable to handle kernel pointer dereference in virtual
kernel address space
[ 3986.766774] Failing address: 0000000a00000000 TEID: 0000000a00000803
[ 3986.766776] Fault in home space mode while using kernel ASCE.
[ 3986.766778] AS:00000000a43a0007 R3:0000000000000024
[ 3986.766825] Oops: 003b ilc:2 [#1] SMP
<snip>
[ 3986.766877] CPU: 0 PID: 271064 Comm: kcapi Tainted: G        W
    6.5.0-rc1 #1
[ 3986.767070] Hardware name: IBM 8561 LT1 400 (z/VM 7.2.0)
<snip>
[ 3986.767151] Call Trace:
[ 3986.767153]  [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
[ 3986.767160]  [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
[ 3986.767166]  [<00000000a2a60888>] aead_recvmsg+0x478/0x698
[ 3986.767169]  [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
[ 3986.767175]  [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
[ 3986.767177]  [<00000000a273e066>] vfs_read+0x26e/0x2a8
[ 3986.767182]  [<00000000a273e8c4>] ksys_read+0xbc/0x100
[ 3986.767184]  [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
[ 3986.767189]  [<00000000a312ff30>] system_call+0x70/0x98
[ 3986.767193] Last Breaking-Event-Address:
[ 3986.767193]  [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
[ 3986.767198] Kernel panic - not syncing: Fatal exception: panic_on_oops

This time the regression was bisected to:

commit c1abe6f570aff4b6d396dc551e60570d2f50bd79
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jun 6 14:08:52 2023 +0100

   crypto: af_alg: Use extract_iter_to_sg() to create scatterlists

I can't see what the problem is with the commit, so I'm reporting here
hoping that David or someone else can pick it up from here.

Cheers,
Ondrej

[1] https://lore.kernel.org/linux-crypto/CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com/T/
[2] https://github.com/smuellerDD/libkcapi/
