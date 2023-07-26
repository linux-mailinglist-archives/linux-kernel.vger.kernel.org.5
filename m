Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6A76341E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjGZKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGZKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2238E63
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690368189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h2bZ6fkGnjjiUXO0kDMBnPkuhQcio8YOy+L/LeFNu98=;
        b=G4OeBeDSD/lZ7d738mcdoJ5qbDMY8QXtrsScdczDfozQgbaTeSeuONYt5u1MmpcC3VxwZw
        SzknpJXwrYr6DXKnjQpoqCEH3gkkeiiWw86NpyGs3JnijadwBMiDENg3pcjIvF3npWKYX2
        tjf4YUvPuB5xgo4zQ9uWxEj/lqvJTcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-KcvHA5d_Ni-_yRXPlaRE9g-1; Wed, 26 Jul 2023 06:43:05 -0400
X-MC-Unique: KcvHA5d_Ni-_yRXPlaRE9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E937388D7FA;
        Wed, 26 Jul 2023 10:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 856E2C2C85C;
        Wed, 26 Jul 2023 10:43:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info>
References: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info> <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: Another regression in the af_alg series (s390x-specific)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20078.1690368182.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 11:43:02 +0100
Message-ID: <20079.1690368182@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux regression tracking (Thorsten Leemhuis)" wrote:

> What's the status wrt to this regression (caused by c1abe6f570af from
> David)? It looks like there never was a real reply and the regression
> still is unresolved. But maybe I missed something, which can easily
> happen in my position.

I was on holiday when the regression was posted.  This week I've been working
through various things raised during the last couple of weeks whilst fighting
an intermittent apparent bug on my desktop kernel somewhere in ext4, the mm
subsys, md or dm-crypt.

I'll get round to it, but I'll I don't have s390x h/w immediately to hand.

David

