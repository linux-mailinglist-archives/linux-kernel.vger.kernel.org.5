Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761C380ECD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376519AbjLLNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376504AbjLLNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:08:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2641A8;
        Tue, 12 Dec 2023 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xC107OSUOyrS98vT6lQFgwTVXofuMQmJfl8JtYjRS6I=; b=mbTexFMvREG+oGVg3ZJAv5AJlp
        qbaEr5dxBs83kUiHFd1ek8KnX8G0L5eAHJTwNzOuGwkzBFMuwO8e3pLmAV7py0IWFPnj9ZPtbD7bE
        +vAKCwuXMQwlqMeFacYW3qrGLJJUFWmOir2bbZqYNPkZP7P6T+mIzwl5/pRFqKi5gyjxwLYeRm7iH
        oBSdEd3HMX1AKD8+5ug1pThQ2TK8wyvsuaWS1P4XDy3uM2ED0lRZ7wQnCKu3O+97ikbnBuGFxSXqT
        83/Uqen0eL4XlE4+3FtB0sHztovzKK5/IdXnLrawkrM95EtJnIlIH1cemAW44kTgJLhOHErGiajmm
        Zc9oYqHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rD2V0-00Bkzy-0i;
        Tue, 12 Dec 2023 13:08:34 +0000
Date:   Tue, 12 Dec 2023 05:08:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leonardo Bras <leobras@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
Message-ID: <ZXhbUmxzH6nWAzaw@infradead.org>
References: <20231208181802.88528-3-leobras@redhat.com>
 <ZXgMa57Ere6FJCJB@infradead.org>
 <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com>
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

On Tue, Dec 12, 2023 at 05:09:21PM +0900, Masahiro Yamada wrote:
> Unlike .gitignore, this feature is opt-in rather than enforced.
> 
> To use this, you need to run
> 
> 'git config diff.orderFile scripts/git.orderFile'
> 
> or
> 
> 'git diff -C scripts/git.orderFile'

Oh, ok.  That greatly reduces my concern.

> 
> Indeed, the file order is subjective, leaving
> us a question "do we need it in upstream"?
> 
> At least, it is harmless for people who have no interest.

.. but this is still a good question.  I'm not really sure there is
much of a need for it, but as long as it doesn't harm everyone else
I'm at least neutral on it.
