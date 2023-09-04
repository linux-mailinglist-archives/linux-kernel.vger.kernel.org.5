Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE23A791DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjIDTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjIDTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A19E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEFA60AF8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C59C433C9;
        Mon,  4 Sep 2023 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693857203;
        bh=ObkgXYfTWN/0i1o+0497QuGwwaIpL97LayysgndHzLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wWrTeAW7wcSAt1iv4PCrLSGUl0erjqpQD+TVZ3e7n39DULdw0fHCV3tfvVTwXJ40l
         0hY8K4eA4/OsO9w96F5L5K9IaYIbXlcFGfk+Wfk+s6894tGgcZ3TqSEJBp7R1jp4xy
         fktLA2CNjzGxulTfEQKN/QYVhbny3Tn8bWOpr4Nc=
Date:   Mon, 4 Sep 2023 12:53:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-Id: <20230904125321.f827471daaf0997bf935cccd@linux-foundation.org>
In-Reply-To: <ZPXv6o3a43xisdmc@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
        <ZPXv6o3a43xisdmc@pc636>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sep 2023 16:55:38 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> It would be good if this series somehow could be tested having some runtime
> from the people.

I grabbed it.  We're supposed to avoid adding new material to -next until
after -rc1 is released, but I've cheated before ;)

That (inaccessible) pdf file is awkward.  Could you please send out
a suitable [0/N] cover letter for this series, which can be incorporated
into the git record?
