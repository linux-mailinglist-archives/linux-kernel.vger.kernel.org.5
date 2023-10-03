Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7C7B6B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbjJCORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjJCORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:17:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420FEB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:17:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B9AC433C9;
        Tue,  3 Oct 2023 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696342627;
        bh=kSy8cr3ZOx+YW40kNqWscNITU4mfjvRvlwOvHDKsVWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1tOg/O43eTvAqg0eVtYLHBWNOqYX1o7L1YKzcJsH/8CpSxp1CgEPzBE4f7z18OLb
         lWI6cqx4YRAgQD5daubhzYtVTzKOmWOH+w2mB2Lh41c3TgU0yELsZhPAGyXluNc1cE
         4GMl5NA6bDvBAQCZ4K5drcFhZj79BdLk6ZgdVKx+gjd1XrydOsnRmecOJw0yCKfQdT
         XAvLJOBfAoXprKoNIVOE8SUkjDOw6z9onIkG1nVXBnDZMeVZo55tP4IW/3pR6iGAAr
         vkPlyCmA42Bh8ZvDayF4Y4NV5DVHeu9v9wFGf4z60LEYYKGmMgvjG+N4VEtAGbnR8s
         pESlf/uRjCI3Q==
Date:   Tue, 3 Oct 2023 16:17:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Michael Pratt <mcpratt@protonmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rafal Milecki <zajec5@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v1 0/2] mac_pton: support more MAC address formats
Message-ID: <ZRwiYOH8wsNqPmED@kernel.org>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002233946.16703-1-mcpratt@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:39:55PM +0000, Michael Pratt wrote:
> Currently, mac_pton() strictly requires the standard ASCII MAC address format
> with colons as the delimiter, however,
> some hardware vendors don't store the address like that.
> 
> If there is no delimiter, one could use strtoul()
> but that would leave out important checks to make sure
> that each character in the string is hexadecimal.
> 
> This series adds support for other delimiters
> and lack of any delimiter to the mac_pton() function.
> 
> Tested with Openwrt on a MIPS system (ar9344).

Hi Michael,

I am wondering if you considered a different approach where,
via parameters and/or new helpers, callers can specify the
delimiter, or absence thereof.
