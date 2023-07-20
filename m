Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054175B5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGTRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGTRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1602690
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61DE261B86
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD6C433C8;
        Thu, 20 Jul 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689875597;
        bh=kFQpUoh4kpe+V3yjAvtA+pGQek8ZBGTb2rcrSK1Qwlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfOUGegsVzsOyx/+ydaKbX3ItFePfjxFRHw5GEGdHeA5Hx/f5U9JjaLoWzyd1fITD
         NJWzkoDBx8iVgUzkn2duoABDDOCDaVC1wqasMbWm5lcQCk4AXMdbzMQ/DAtkReARZK
         BraoEJwvGHimp1S1SRRo88G9FlHtdDJhGXuQTJ8uMWABSTzBizn6VT3/OAZnPvLxrP
         WMs4CycGsbN2Zb0/WosUHZpJ2Ul7B6ED/yNNaKpRwcJV+Kzva4oE7CXnrQslDacoO/
         mPzMR5+wd6jV/2ljOTInp50DxmJD9Uv319Yo6eBlurJHRijNqdfIcQRZCIuuOZL/wI
         rsVk9KfHrZBXQ==
Date:   Thu, 20 Jul 2023 10:53:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v8 00/23] net/tcp: Add TCP-AO support
Message-ID: <20230720105316.0ad41719@kernel.org>
In-Reply-To: <20230719202631.472019-1-dima@arista.com>
References: <20230719202631.472019-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 21:26:05 +0100 Dmitry Safonov wrote:
> This is version 8 of TCP-AO support. I base it on master and there
> weren't any conflicts on my tentative merge to linux-next.

doesn't apply
-- 
pw-bot: cr
