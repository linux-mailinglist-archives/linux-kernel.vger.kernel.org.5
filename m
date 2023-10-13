Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40FB7C87FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjJMOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJMOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:40:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C528BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:40:19 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C2D333F722
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697208016;
        bh=4Q8qjtTOqM69UGB+qq5ucuXcWb20VRz1rn7B8+UgamA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AHTFyC4Dy4Hm9lUhRO/+0ht1VWNm5xzeCPc+jMQXRDMt+VS7K8RLkypgv/jy3S5Hl
         XBKZTgX3/V52lG0iwS+Hi06RSeYaGWoYeLnP/cJJQVaIQWxxs1OmDc/+nMjMYbbwnV
         l9cRrO7GeqcMscG8vkHWZysmB25zeSVlVdgrIZvRxcI1STHho80jC67QI1+omZDvPS
         sMPhZyRAeNqNA3iCLKKk0Ak02B0pt2K3d5URYG4MMAVcIJ4ZaH18g4qPuSzD1zo3WG
         v6cGyxsQ4QIosoq3iivcGDTLVaJux3GK4gG4CQ4h+lSgWjexB3f5ygo3JISu/IWX0X
         ZWTbQFXYkW+IQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-325a78c806eso1244687f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208016; x=1697812816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Q8qjtTOqM69UGB+qq5ucuXcWb20VRz1rn7B8+UgamA=;
        b=BAoi1GScxYLyVzclzZwz6TcMsYkQFVMBIFOpYuM64OieTsKR74BwJL3rYd92kzK10w
         izi7Lf9H19UpOPl7pQW147wr5vGkcQYRD1XuSy/u7Q9sXW9SUdtJTiEnappYqBLihk6M
         GKh2j5BJnby+vjNgHvKcdpYKbqtilbV7zy10cZyNPCuwWFzIAtjOBHNQ/E55bBIgnNuW
         SjCYgrwBst9Fggq9iXfLCNw+aR4LF2nVTeutF+2aK8SMaO6jCSuedRhtck+hVxnKmvog
         2cLX9jEcwubjr/Uybw32z9yctDvYgfclFvQaGJIABSaEDnlpvX2xvio5myRaiq/FWWa9
         8vxQ==
X-Gm-Message-State: AOJu0YzxD/v1s8qQ3dSxTpYb7+qBmQomeK5RuCVPvg9BCwZL7n/fV8dU
        dGK75kSH/hb6Hmt1WBF3OeJt1wDDTRZa4Zq0LNBoyFiUajRR7kE9X0+6bVjNQud0yyYTJWY2wzK
        UNUem/jqpcZpFk9N3/PDgn4Pf3avga2PTuNAlNq1nPn1RLAgbeUhcKY+mndQmOkMgAXDW
X-Received: by 2002:adf:b613:0:b0:32d:9876:571c with SMTP id f19-20020adfb613000000b0032d9876571cmr2165036wre.63.1697208016286;
        Fri, 13 Oct 2023 07:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNMtvOMfvtHRsCfuYjDaRp2+xKVftk4EeEH80Pl99DSkhNsK0NT6vWxwfIWZRNNCDwt+rGXII5LrykndHgnuQ=
X-Received: by 2002:adf:b613:0:b0:32d:9876:571c with SMTP id
 f19-20020adfb613000000b0032d9876571cmr2165019wre.63.1697208016003; Fri, 13
 Oct 2023 07:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
 <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au> <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
In-Reply-To: <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Fri, 13 Oct 2023 15:39:40 +0100
Message-ID: <CADWks+aV+QzJo8LQt9eD4YSghF+Ez7iDx8zzz_hfL_2am2zLNA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

I will check all of the below and get back to you.

>
> Here's a thread regarding MD4 the last time its removal was attempted:
> https://lore.kernel.org/linux-crypto/20210818144617.110061-1-ardb@kernel.org/
>
> Please note that iwd does use MD4 hashes here:
> https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/checksum.c#n63
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/eap-mschapv2.c#n165
>
> Regards,
> -Denis



-- 
okurrr,

Dimitri
