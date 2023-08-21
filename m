Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6D78251C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjHUINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjHUINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499293
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B3362CBA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D45C433C7;
        Mon, 21 Aug 2023 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692605624;
        bh=L95VOeOqXHP4aQGVTzRlC4ci26zBJpdbc+9XZTcOtw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVNQQRs40bhEU6Pmkx9cx4vEkwHGoenL8y4rDmWH19rqyMLSxw0lauhYEvtjjMNx5
         bdu7dwTfSPuCQn4I/xlNgvHFCAhLjfkptTa9KTRkVtvH1vPTzhcCYeFDxXffcmKvUm
         537E/QD/Fgj3hpolp7VE0tEFkrn0lhPrRQro/g2xHWAqUaQudo5g8NNQXKAaHcZA8r
         8JuKfmM20+E2zekjwpjsGzCw3jhaI9m1Z4/aI8cgwll34pDXZoEvFzseVJAdWiae9O
         aBqq+BOcW2OQXzO34wudLo6QUfoXg9MqQk4FEe+ludrV+963jfs3l6HmBZ4OYDxQFA
         GB+WhHkwikPUA==
Date:   Mon, 21 Aug 2023 09:13:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
Message-ID: <20230821081340.GD1380343@google.com>
References: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
 <20230818155815.GY986605@google.com>
 <ZOAIplO6tcFN2H8L@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOAIplO6tcFN2H8L@qmqm.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023, Michał Mirosław wrote:

> On Fri, Aug 18, 2023 at 04:58:15PM +0100, Lee Jones wrote:
> > On Wed, 16 Aug 2023, Michał Mirosław wrote:
> > 
> > > of_reg is the only constant member of struct mfd_cell. It seems to be
> > 
> > Sorry, what?
> > 
> > struct mfd_cell {
> >         const char              *name;
> > [...]
> >         const struct mfd_cell_acpi_match        *acpi_match;
> > [...]
> >         const struct software_node *swnode;
> > [...]
> >         const char              *of_compatible;
> > [...]
> >         const u64 of_reg;
> > [...]
> >         const struct resource   *resources;
> > [...]
> >         const char * const      *parent_supplies;
> > [...]
> > };
> [...]
> 
> All those are pointers to const, not const fields themselves. Only
> `of_reg` is const regardless of the whole structure.

Please make that clear in the commit message.

-- 
Lee Jones [李琼斯]
