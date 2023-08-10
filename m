Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF104776FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjHJFrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjHJFrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A821704;
        Wed,  9 Aug 2023 22:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1616E64F20;
        Thu, 10 Aug 2023 05:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E283BC433C7;
        Thu, 10 Aug 2023 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691646463;
        bh=htlHuQhk5T9cq0I7Pg3xVD9EBmOQK3ocAWxxOzjy2lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txHIsiGcHKXIXVoW+19ep9keOXX0FWyJxKRRdCpgE4KhzD1PrTWAW7WIVfrz/ttvU
         nvHvQfWOPpMm4jnR1dx02V/rzTt17ys3jGMs9D53M9MSOdJdpgeln/mM6K2B7SViTs
         YVYToN7P36u3NMA7rK6/hf984IyDRSTYa6FhQYP4=
Date:   Thu, 10 Aug 2023 07:47:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v9 1/7] sign-file: use getopt_long_only for parsing input
 args
Message-ID: <2023081018-sturdily-district-6034@gregkh>
References: <20230809172211.343677-1-yesshedi@gmail.com>
 <20230809172211.343677-2-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809172211.343677-2-yesshedi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:52:04PM +0530, Shreenidhi Shedi wrote:
> - getopt_long_only gives an option to use long names for options, so
>   using it here to make the app usage easier.
> 
> - Use more easy to remember command line argument names
> 
> - Introduce cmd_opts structure to ease the handling of command line args

When you have to list a number of different things that you did in a
single patch, that usually means this needs to be split up into multiple
changes.

Please do so here, you are converting to a different api (getopt_long)
and adding new arguments (with no documentation) at the same time, which
means this is an almost impossible change to review easily.  Would you
want to review this?

thanks,

greg k-h
