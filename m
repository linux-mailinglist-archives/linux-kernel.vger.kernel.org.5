Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E4778A62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjHKJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHKJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DD19E;
        Fri, 11 Aug 2023 02:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDEB66D2E;
        Fri, 11 Aug 2023 09:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF87DC433C9;
        Fri, 11 Aug 2023 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691747593;
        bh=u8bULopGztMMXDUlY34aexEHjdKcFlVqp4+mps7Hlto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEOfoWwsm4u+avTAMjCNM0I+BhgmX40uO3SjypS0LkfWEUPy8/g1TP4OsY8FKKA9m
         6AxfVr6mhqMLui/q9ltAbQ18+1lKb6rsrlNRdzneE30y/7R+XBzFsUOIwIM/dKWg2W
         oWRPkGIAoWLz/tdjJ3DA//54n1G+cxlcCnL8ddkgH+PKoDNfwi/t0ysoL7u1bT+IMh
         ii/0+V68aIgH237ARY7hfSt9bBkELa2gPwkfOOd9j96NrbrEmXBRddqGs+rBR+pfvH
         JFSE9vw0gOsPI+87/XqNMFVEUnjzBGLmdItaiEsIpwyJcujJGyr2xXNpJeKIq4MJpi
         RQGENS8CgQYGA==
Date:   Fri, 11 Aug 2023 11:53:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     Simon Horman <horms@kernel.org>, corbet@lwn.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
        jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] docs: staging: add netlink attrs best practices
Message-ID: <ZNYFA6CbHHQdAAsd@vergenet.net>
References: <20230809032552.765663-1-linma@zju.edu.cn>
 <ZNTw+ApPS9U4VhZI@vergenet.net>
 <41722e43.1049b3.189e02f50f6.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41722e43.1049b3.189e02f50f6.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:02:24AM +0800, Lin Ma wrote:
> Hello Simon,
> 
> > > Provide some suggestions that who deal with Netlink code could follow
> > > (of course using the word "best-practices" may sound somewhat
> > > exaggerate).
> > > 
> > > According to my recent practices, the parsing of the Netlink attributes
> > > lacks documents for kernel developers. Since recently the relevant docs
> > > for Netlink user space get replenished, I guess is a good chance for
> > > kernel space part to catch with.
> > > 
> > > First time to write a document and any reviews are appreciated.
> > > 
> > > Signed-off-by: Lin Ma <linma@zju.edu.cn>
> > 
> > Thanks for writing this up, from my perspective this is very useful.
> > 
> > Some trivial feedback follows.
> 
> Thanks sooooooo much. And feel really sorry that the v2 still has so many
> typos, grammar issues, and word misuse. I will prepare the v3 carefully
> with all those suggestions. Really appreciate that.

No problem. Much of my feedback was subjective.
And Randy managed to spot an error in my feedback too.
It's hard to get things right :)

...
