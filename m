Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79EF7BB78B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjJFM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjJFM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:27:34 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86CAD1A7;
        Fri,  6 Oct 2023 05:27:24 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2FE0C9200B4; Fri,  6 Oct 2023 14:27:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2D9209200B3;
        Fri,  6 Oct 2023 13:27:23 +0100 (BST)
Date:   Fri, 6 Oct 2023 13:27:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Dan Carpenter <dan.carpenter@linaro.org>
cc:     Su Hui <suhui@nfschina.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
In-Reply-To: <ceaa146a-2781-4266-ade8-6a25eb39abbf@kadam.mountain>
Message-ID: <alpine.DEB.2.21.2310061312460.20732@angie.orcam.me.uk>
References: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com> <alpine.DEB.2.21.2310041557310.61599@angie.orcam.me.uk> <d98f7107-56d7-44a3-8b77-b8766cdc02d9@kadam.mountain> <alpine.DEB.2.21.2310051305530.20354@angie.orcam.me.uk>
 <ceaa146a-2781-4266-ade8-6a25eb39abbf@kadam.mountain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023, Dan Carpenter wrote:

> This is a W=1 static checker warning.  We've already reviewed it, and
> marked it as old.  There isn't anything else required.

 Good point.

> Or are we close to promoting the unused-but-set-variable warning from
> W=1 to being on by default?  How many of these warnings are remaining?
> It it's like only 20-50 warnings left then maybe we should consider the
> other options but that kind of information needs to be in the cover
> letter or otherwise we won't know about it.

 Hmm, these warnings do help chasing dead code, which in turn may reveal 
real issues, such as where someone missed or forgot something when writing 
their code and a value that was supposed to be used somehow is instead 
discarded.

 Most commonly it will be the case when some code has been deliberately 
removed as it evolves and a part that is no longer needed has been missed 
by chance and left in place.  I've seen it happen.  Apart from the code 
sloppiness resulting it shouldn't matter that much though as the compiler 
is usually pretty good at discarding dead code.

  Maciej
