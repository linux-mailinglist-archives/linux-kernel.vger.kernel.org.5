Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFC7C972E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjJNXDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjJNXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:03:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6CCE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 16:03:10 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 929993F314
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697324588;
        bh=g4FZTSl0d4ZJADlSvm57nChfceUNZzU0dP0RCDb94EA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=g6IRxgfbQK3zPzzy8ZM4tHFvebXOwaBBDqrCHAP8FETXV8N5PYtQnfnUnd73aglwL
         TWqJQdwOTz/GxjVnyhDLFzdzb1xzHsCRf6Xl7ditzx8UtVUodBqrc8+T4tEzoLv4Hk
         Ws222R8dpFMHhuwYg5F/YUIkK79LVkHIUu4qrexu3la1tBia9q6MpWTXS6mrN8HnRr
         9whh4Ejmic4GTBd8aUeabjzSv5skocfNijJUebWkDlHpWJW91rVV12T3oMMpecgm2e
         L5deCUhkzrGSCPw1odN9ECRzVmxemqw89iBScgnizuylz3Mv9opmTIkBjwPMwQ3GsK
         HPEsLKx39u5Ow==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso2030207f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 16:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697324588; x=1697929388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4FZTSl0d4ZJADlSvm57nChfceUNZzU0dP0RCDb94EA=;
        b=wlnsA0O5ilbNn1vqslQbGOppoU2JWnpn/UFgApxuwPv/NgcBNUAxuG29UIx0iCbNvH
         nVGukTfjDeH+pmN325qYdc5uSrsi/4SW2uZV3YjgMogxr+Kjh1GtodWgnH0WDkPJFQlh
         zg6lMDR9fUI6601PGMm+PIRfcyjaT1OFcJ+KU8iyBWJEuvFVxu9739YB7Ozk5MxTrsRs
         zCZtJLKJB/Jkr4UMu1PgrNw3X9nCDzW6pzdtkmo+FIdCFPqAnDtChOJ0bqAdKv6uiRQC
         pVNnVitLv9PrgIJhVvMGzFfQqcMIZ+Fb2Ug/Irmcycgh2zN+uhVQK74m0on0kO8g2pfI
         66EQ==
X-Gm-Message-State: AOJu0Yw312a8EPEgiTeAna763PKO9mwZtv6MZkFEutPYKiHeI5lDSvYg
        yqW3Lh9xPJBkkNBLda/LCM6EUMFc86iYEJ4UCxiXlgx6Ct3JiV48plAfgTdF9limtQ3I50bbtPD
        65U2xphwiYiayjvym49mMR+obTWnDYearnszZRCYEVyGOmmtFs2SSkDhv3g==
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id f7-20020a0560001b0700b00321645062eamr26180417wrz.36.1697324588144;
        Sat, 14 Oct 2023 16:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJOb0XCESRaZNsKxGDIHX5HswxMXGFvre7WUTS/9leErz6A4oyrNkphQTIFfBH43Pd5OvGYb6ogvO9KIDWmeU=
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr26180409wrz.36.1697324587746; Sat, 14
 Oct 2023 16:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
 <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au> <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
In-Reply-To: <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Sun, 15 Oct 2023 00:02:32 +0100
Message-ID: <CADWks+ZV=BNzEUUgw4YuE_1cr7O7puunBy5FJf-_jyWJyPz=sg@mail.gmail.com>
Subject: Re: [PATCH] crypto: remove md4 driver
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 15:37, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Herbert,
>
> On 10/13/23 05:39, Herbert Xu wrote:
> > On Sun, Oct 08, 2023 at 05:01:39AM +0100, Dimitri John Ledkov wrote:
> >> No internal users left and cryptographically insecure. Users should
> >> upgrade to something else, e.g. sha256 blake3.
> >>
> >> Some drivers have their own full or partial md4 implementation without
> >> using crypto/md4.
> >>
> >> Userspace code search indicates a few copies of hash_info.h
> >> https://codesearch.debian.net/search?q=HASH_ALGO_MD4&literal=1 without
> >> need for MD4.
> >>
> >> Preserve uapi hash algorithm indexes and array length, but rename the
> >> MD4 enum.
> >>
> >> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> >> ---
> >>   crypto/Kconfig                 |   6 -
> >>   crypto/Makefile                |   1 -
> >>   crypto/hash_info.c             |   4 +-
> >>   crypto/md4.c                   | 241 ---------------------------------
> >>   crypto/tcrypt.c                |  12 --
> >>   crypto/testmgr.c               |   6 -
> >>   crypto/testmgr.h               |  42 ------
> >>   include/uapi/linux/hash_info.h |   2 +-
> >>   8 files changed, 3 insertions(+), 311 deletions(-)
> >>   delete mode 100644 crypto/md4.c
> >
> > Patch applied.  Thanks.
>
> Does this patch break userspace?
>
> Here's a thread regarding MD4 the last time its removal was attempted:
> https://lore.kernel.org/linux-crypto/20210818144617.110061-1-ardb@kernel.org/
>
> Please note that iwd does use MD4 hashes here:
> https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/checksum.c#n63
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/eap-mschapv2.c#n165
>

Thank you for this reference. The WiFI eap mschapv2 based
authentication indeed relies on MD4. The IWD code uses kernel as a
basically impromptu userspace library to gain access to MD4, which
sounds like a poor way of doing this. In comparison NetworkManager
uses userspace crypto libraries to compute that.

Note that iwd has an alternative code path of using md4 hashed
password, meaning it does still work on kernels without MD4.

It worries me a lot that this is still in active use.

MS-CHAPv2 has been completely broken since 2012 with a cloud service
at the time offered to automatically crack any communication. It is
insecure, does not provide any confidentiality, and worse off allows
to steal & reuse credentials to later impersonate the original user.
It is worse than unencrypted WiFi in that sense. Even Windows 11 since
at least 22H2 release prohibits such connections.  I will propose
patches to IWD to stop using the md5 crypto kernel interface. As much
as it is convenient, users of insecure & obsolete cryptography must
not hold up removal of such methods from the kernel.

-- 
okurrr,

Dimitri
