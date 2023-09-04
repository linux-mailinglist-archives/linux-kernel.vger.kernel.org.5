Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6E7919D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbjIDOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbjIDOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:42:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185A1AC;
        Mon,  4 Sep 2023 07:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9FD3CE0E30;
        Mon,  4 Sep 2023 14:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD577C433C8;
        Mon,  4 Sep 2023 14:42:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="erscZtev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1693838524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2mxU5TZV9/VGUzbpSKuMwiywMryzvy/egJoCl8MqhA=;
        b=erscZtev+i3wlwJo3Gq9Io16CLWjMKg0eFFm2qGjCV218Zvj2SfrZgIViM2sPZjwXWOr7Y
        WZ3/KHg4YMlyzQ1yiv0msN7EL090cCVT5BUMJPcnBa2VxoZCe5B26E4bcIl1lcUFfd2N9H
        lJW8NdtsZAmIilX3U32o/yhFSF0ekVk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fb3289a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 4 Sep 2023 14:42:04 +0000 (UTC)
Date:   Mon, 4 Sep 2023 16:42:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Babis Chalios <bchalios@amazon.es>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, graf@amazon.de,
        xmarcalx@amazon.co.uk, aams@amazon.de, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/2] Propagating reseed notifications to user space
Message-ID: <ZPXsuhXJhN9Q3hfH@zx2c4.com>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <32756034-2fd4-4246-830e-c1a0eeab0a55@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32756034-2fd4-4246-830e-c1a0eeab0a55@amazon.es>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 03:44:48PM +0200, Babis Chalios wrote:
> Hello all,
> 
> On 23/8/23 11:01, Babis Chalios wrote:
> > This is an RFC, so that we can discuss whether the proposed ABI works.
> > Also, I'd like to hear people's opinion on the internal registration
> > API, 8/24 split etc. If we decide that this approach works, I 'm happy
> > to add documentation for it, with examples on how user space can make
> > use of it.
> 
> Some time has passed since I sent this and I haven't received any 
> comments, so I assume people

Nope. This still stands:
https://lore.kernel.org/all/CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com/

And honestly the constant pushing from you has in part been
demotivating.
