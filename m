Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E378B378
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjH1Ops (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjH1OpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FFCC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9738764A06
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D8C433C8;
        Mon, 28 Aug 2023 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693233910;
        bh=gItZ/b/cT8XHJYljt+p4zktoff3dL4UmwlQU6B+fOV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ql0sro2OmTgWdUWo399MBvzRoUoYRXTySvYh1prNaVv5cp7seuufZq3uJMYZ/krFg
         yTduhYpkzkfNfOohTk/m20m2dutHsXwLljNhhRdKhtGMAA+ooqGMHzcPPSnBM6/EqS
         7zsCHnAiH5JKn0kg6FF4QfMivHpnlCPTwNxRf3wk=
Date:   Mon, 28 Aug 2023 16:45:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Oliver Crumrine <ozlinux@hotmail.com>, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 1/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <2023082849-crushable-emission-862b@gregkh>
References: <cover.1693229582.git.ozlinux@hotmail.com>
 <PH7PR11MB7643C65E067BAB032F930488BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZOyxaLDCI81W96/X@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOyxaLDCI81W96/X@nam-dell>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:38:32PM +0200, Nam Cao wrote:
> On Mon, Aug 28, 2023 at 09:39:14AM -0400, Oliver Crumrine wrote:
> > Make the octeon ethernet driver better adhere to the
> > kernel coding standard
> > 
> > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> > ---
> > v2: Actually send the patch set properly
> > v3: Fixed a bug where I forgot to change all instances of a struct
> > v4: Actually fix that bug (this is my first patch, give me a break)
> 
> Don't give up! You will get it right eventually.
> 
> This is not important, but I prefer you revert the order of the change log.
> The changes compared to the last version is most relevant, so preferably they
> should be put on top.

Either way is fine, this isn't an issue.

What _is_ an issue is that all of these have the identical subject line,
and the identical changelog text _yet_ they do different things.

Oliver, please read read the section entitled "The canonical patch
format" in the kernel file, Documentation/process/submitting-patches.rst
for a description of how to do properly.

thanks,

greg k-h
