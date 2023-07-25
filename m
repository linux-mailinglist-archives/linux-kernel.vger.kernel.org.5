Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE87F761ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGYN6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjGYN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:58:05 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA81FDF;
        Tue, 25 Jul 2023 06:57:59 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 20DD060C40;
        Tue, 25 Jul 2023 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1690293478;
        bh=EASKgZm2zhJpZ1jX6hn1QdaYqF09hmwckitf5a3vrQc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=Xcs+jyhe7GTNzonveiewqkOJEFYyltqYkrAKZaqavQrnFJEJrEcvw+vsn9GcDbOMl
         /38stZ9g5U2TYtQdmfd9xlGPjyLRHCQBgckaD9CKFPslkwFVC1NYTmxZJnfvwV/VyA
         Y9jVTQlAwB6Y1FtuXBlGPZEiIogkgfC7/oMs++8tcpWv7ZydqaVXmse6pNno1uglOL
         OhCw8SJw3Wy+fvP6ha5QifQNKi7+FhBrTASSnVZNatmxhETixqzDrwznbYg7qPiDaF
         KP0fMyT9brTfgiaAukpj+TRh/ZZeUn4ZIgwaymbeoES99hYaq4xv5jZftUqdnTenY8
         Cei3zJaVDfLHQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 9177C145E24; Tue, 25 Jul 2023 15:58:22 +0200 (SAST)
Date:   Tue, 25 Jul 2023 15:58:22 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] kconfig: port qconf to work with Qt6 in addition to
 Qt5
Message-ID: <boris.20230725155503@codesynthesis.com>
References: <20230724074625.458456-1-boris@codesynthesis.com>
 <20230724074625.458456-2-boris@codesynthesis.com>
 <e11e6287-9b27-90d7-da95-1dc88348b8b0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11e6287-9b27-90d7-da95-1dc88348b8b0@infradead.org>
Organization: Code Synthesis
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 7/24/23 00:46, Boris Kolpackov wrote:
>
> > Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
> > are no longer guaranteed to work.
> 
> Was there such a guarantee somewhere?

I don't believe there was anything explicit, but seeing that the
qconf source code hardly changed in the past couple of years, it
could have worked with earlier versions of Qt5 and some people
could have relied on that.


> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!
