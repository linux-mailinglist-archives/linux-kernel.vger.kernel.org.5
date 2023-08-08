Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF8774A60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHHU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjHHU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091B282C3;
        Tue,  8 Aug 2023 12:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22F7962B88;
        Tue,  8 Aug 2023 19:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456C4C433C7;
        Tue,  8 Aug 2023 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691523476;
        bh=to8gfzE92OcWKdxzRG8vzKSw10/OQNdW2eGBBGwRMvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZx4Zj2ijwgUoBNm7tUkut7EUXYc+IsCJ+PcN5KZLk2sOuPu67d+SQT9MPMY7CR91
         2ihb5GMm/3FIXOKeHNI6wC/bN7Q14nWDNatCqWp94WAUmgH3/4/Anxxkqdr3684hRi
         Vy0OR2b0kRTiinydEQdFRfUOFYXJsNqgQuHDoIO4zoHSeScQxAX0/inZY3QsP9dk8Y
         XHeJQe7l4MrAEvwJwfBexgYED+lWKf1gXOIYA49hQ37Higbskev+rgiQ3f9axcQu0I
         SQYIh+orYxONwhJ7mTBWv4idUUWUIGhxy3S7jX9BbfyIwqEx3KlhLJ7+sq2EYhNIXn
         7MMTPuDh1CfNg==
Date:   Tue, 8 Aug 2023 12:37:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     corbet@lwn.net, void@manifault.com, jani.nikula@intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: staging: add netlink attrs best practices
Message-ID: <20230808123755.43610137@kernel.org>
In-Reply-To: <20230808035636.148552-1-linma@zju.edu.cn>
References: <20230808035636.148552-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Aug 2023 11:56:36 +0800 Lin Ma wrote:
> Provide some suggestions that who deal with Netlink code could follow
> (of course using the word "best-practices" may sound somewhat
> exaggerate).
> 
> According to my recent practices, the parsing of the Netlink attributes
> lacks documents for kernel developers. Since recently the relevant docs
> for Netlink user space get replenished, I guess is a good chance for
> kernel space part to catch with.
> 
> First time to write a document and any reviews are appreciated.

Oh, you put quite some effort into this!

I have a hard time coming up with reasonable review comments, because
while the doc is informative and pretty correct, it focuses on what's
legacy use of netlink at this point. People writing new code will only
get confuse with this information :(

Modern families are all generic netlink, and validation is taken care
of in the core :(

If you post a v2 please make sure to CC netdev@
