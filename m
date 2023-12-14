Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913878128A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443234AbjLNG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:59:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4333CB9;
        Wed, 13 Dec 2023 22:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=sCcjsVfvGrL10f8KrjBhxlZMbVCOfy10t/MAoJlx8KE=; b=CViAJ6fS5ELM4EZ55saHCscxb6
        55bQzcdnMTPt49sOOjGICOW9sPzDsc5RmzyJGX/og7owMIZ+TRHC0++ZFHXPlJlf1tcdncRsUlvJK
        TAweBcvzHZVOgsyZCmbK0A1jUya1ddqZVcX2MjtmUAwxkZyrBaAgtcRmbkek24gKkPfj4yED8QIdT
        vUHm/3dV8GlRjnfqJb6mhk7pvEd5YUcliFV+vGD8cKQ/CtVu5acx5WDqNJC1ig4oJrvqBLmjrZYlZ
        ZgMF+L2vR2xIm9IlUrvthVJeokCDIcovGuRsHoVzQ6xYOdvKJpAI7AhtZVLLCHf+zKPXp22UUBrnZ
        8d6Ah8RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDfgs-00H2ux-0b;
        Thu, 14 Dec 2023 06:59:26 +0000
Date:   Wed, 13 Dec 2023 22:59:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        patchwork-bot+netdevbpf@kernel.org, shailend@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jeroendb@google.com,
        pkaligineedi@google.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org,
        willemdebruijn.kernel@gmail.com, shuah@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linyunsheng@huawei.com, hramamurthy@google.com, shakeelb@google.com
Subject: Re: [net-next v1 00/16] Device Memory TCP
Message-ID: <ZXqnzuYxcqlapcpa@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
 <ZXqlWT2JYg0sa7IF@infradead.org>
 <CAHS8izNCvxuTsKV73oTu3xS7ZVr0riBdYGbKnsHptVe_e-t5MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNCvxuTsKV73oTu3xS7ZVr0riBdYGbKnsHptVe_e-t5MQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:51:25PM -0800, Mina Almasry wrote:
> On Wed, Dec 13, 2023 at 10:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> > > Hello:
> > >
> > > This series was applied to netdev/net-next.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> >
> > Umm, this is still very broken in intraction with other subsystems.
> > Please don't push ahead so quickly.
> >
> 
> The bot is just a bit optimistic. Only this first patch was applied.
> It does not interact with other subsystems.
> 
>   - [net-next,v1,01/16] net: page_pool: factor out releasing DMA from
> releasing the page

Ah, that makes sense.  Thanks for the update!
