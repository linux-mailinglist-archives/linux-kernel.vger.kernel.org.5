Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D17B8324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbjJDPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbjJDPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:02:07 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79BB2AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:02:03 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 364FF92009C; Wed,  4 Oct 2023 17:02:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 336BA92009B;
        Wed,  4 Oct 2023 16:02:01 +0100 (BST)
Date:   Wed, 4 Oct 2023 16:02:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Su Hui <suhui@nfschina.com>
cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
In-Reply-To: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com>
Message-ID: <alpine.DEB.2.21.2310041557310.61599@angie.orcam.me.uk>
References: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2023, Su Hui wrote:

> This variable is been used but never be read, so gcc and W=1 give such
> warning.
> 
> drivers/base/module.c:36:6: error:
> variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]
> 
> I wanted to use "__maybe_unused" to avoid  this warning.
> 
> However it seems like a wrong using of "__maybe_unused" as Greg KH said:
> 
> "But no_warn is being used in this file, it's being set but not read
> which is ok.  That's a real use, so this change really isn't correct,
> sorry."

 The warning itself is a real issue to be sorted though.  Is this a use 
case for `#pragma GCC diagnostic'?

  Maciej
