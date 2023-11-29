Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525897FCE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376918AbjK2Esg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjK2Esf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:48:35 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B293DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:48:40 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 76EB9240028
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:48:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1701233316; bh=UtCQJrH4PhHRdhqntKG6LE5UKdmC2VnMzTyyMjTF9E8=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=H1xPhpwMWygFMRivR3I9lKr0vHvy4iBOLULqP2K/H7dEGyvNG6kLMzv0AYxqujFN8
         bxoFjTzTPLfH3af7r4IpTuSwUqHBuQBNO7/MDinBkzue6CmxfUgyZU6JVkDLXPlEPV
         nYstHcJWv0fzCjE4v9b0x4Uf9GuW30Eofpv3VZmP2mf2DNKF5ext6WzPAtKpTLvBlO
         RIm37m3vISnHOFSE79yYYovUvUEpXQ1Vkv/Wpgw1ThZQNG0Kxbn6TaTMjoUeIsLnL/
         c9kydeZXENuvlJOxUMuOj9rrcl6T6KkbsgmGtAPciE4EXoLYYD0/qwiWKmfIP23D/8
         LQiK51A6qZfig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Sg6KH4ZBjz6twX;
        Wed, 29 Nov 2023 05:48:35 +0100 (CET)
Date:   Wed, 29 Nov 2023 04:48:34 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib: kstrtox: fix typo in comment
Message-ID: <20231129054834.2ffbe481@posteo.net>
In-Reply-To: <d9ac4b6c-e473-4c00-b016-a9cebdb59325@infradead.org>
References: <ZWWkeVTvDBQDA_SF@monster.localdomain>
        <d9ac4b6c-e473-4c00-b016-a9cebdb59325@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 08:26:03 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/28/23 00:27, Wilken Gottwalt wrote:
> > Delete one of the double f's in "iff".
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> Nope, see:
>   https://en.wikipedia.org/wiki/If_and_only_if

Oh, interesting. Never thought of this. Though, now I wonder: How often do such
"fixes" happen?

> > ---
> >  lib/kstrtox.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > index d586e6af5e5a..b0a9fdce15b3 100644
> > --- a/lib/kstrtox.c
> > +++ b/lib/kstrtox.c
> > @@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
> >   * @s: input string
> >   * @res: result
> >   *
> > - * This routine returns 0 iff the first character is one of 'YyTt1NnFf0', or
> > + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
> >   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
> >   * pointed to by res is updated upon finding a match.
> >   */
> 

