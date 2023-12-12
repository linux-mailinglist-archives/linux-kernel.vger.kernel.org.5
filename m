Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC280E409
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjLLFqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLFqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:46:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE999;
        Mon, 11 Dec 2023 21:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rswgQXutE23EE2adeFRVlY8v1PLpQypzn/gMfnKSSok=; b=rVXrIHDIzJhF4HMqm4VfVY00IB
        sIqfR/Cd+JP6Xs2v0k2Eme38qoI8mUEYTXbnrhQSzfO379TtdKtZbTYHUM9Ca6gRyKluTOeJ1hmNS
        iCkRmLgFdJ8Gej8fBoQ1FJ7AzpJ43A25+Ns42U7EORWN+pNex0CrBQj4nFY1kaZqc6P6xODVp29DO
        f8Zt/9N7UrsGkzSpo65wBeqSJBlQdYaElxXLwr5vnUvV206qfmR3HLnS5cYiMSVJmZvZfsWmdgzwn
        A1Q9PxnlbZd/s2wbROi+Vu7dyQdsfq/oc0XvSh6udsVR+XHC4pT1Che7NVCQHGx2mePothYZ/St6i
        42qTB2rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCvb0-00Ap6A-0r;
        Tue, 12 Dec 2023 05:46:18 +0000
Date:   Mon, 11 Dec 2023 21:46:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible
 array
Message-ID: <ZXfzqsstA6tTPpF8@infradead.org>
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
 <202312041419.81EF03F7B7@keescook>
 <CAPhsuW43g-M+xvzD0N1JsJ_zGnvZQOw2Bi1TEqoHKanPnvMHLQ@mail.gmail.com>
 <202312080926.FBF7A2DDD2@keescook>
 <CAPhsuW5F1aRrCRW-ad5Sq=cgxHX+QgXgYZyMX17Zj4Mj=Jnhjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5F1aRrCRW-ad5Sq=cgxHX+QgXgYZyMX17Zj4Mj=Jnhjw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:11:10AM -0800, Song Liu wrote:
> We marked it as deprecated about 2.5 years ago. But to be honest,
> I currently don't have a plan to remove it. I guess I should start thinking
> about it.

Let's just kill it off ASAP.  It never had a large user base and based
by dm-multipath not long after it has been added.  It also doesn't
support any uniqueue hardware and has no on-disk format.

If you want any blame deflected from you I'd be happy to send the patch
to remove it.
