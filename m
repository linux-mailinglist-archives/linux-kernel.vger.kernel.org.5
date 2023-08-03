Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4776E24D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjHCIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjHCIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039B448F;
        Thu,  3 Aug 2023 00:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2453361C47;
        Thu,  3 Aug 2023 07:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD87C433C7;
        Thu,  3 Aug 2023 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691048907;
        bh=D5lDMFrgMHcckUZnIrPe3l/ki4cRPsnnJvVEUMdP6kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7+4zdTM6pzU6rTqz/aW1k5BdJncf1b5k3pvwzXGwV3yqcu/oT7hb/PCAEQVkenfq
         7UZPoRxt3bZE0P4jxHd9Ak1wGSZkfnmTkE0k2FhBJF68iujGYtOWiF0cSO3CrqXo8o
         Myb38YGP4Ev5NQF5nNgUS+DyMpvV4ZvcDul4w3nM=
Date:   Thu, 3 Aug 2023 09:48:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710
 ldisc
Message-ID: <2023080344-happiness-duffel-c6ee@gregkh>
References: <20230731185942.279611-1-cascardo@canonical.com>
 <2023080111-lucid-stiffness-ccfa@gregkh>
 <ZMkCWL4r9Z35j3hC@quatroqueijos.cascardo.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMkCWL4r9Z35j3hC@quatroqueijos.cascardo.eti.br>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:02:16AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Aug 01, 2023 at 06:53:30AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 31, 2023 at 03:59:42PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > Any unprivileged user can attach N_GSM0710 ldisc, but it requires
> > > CAP_NET_ADMIN to create a GSM network anyway.
> > > 
> > > Require initial namespace CAP_NET_ADMIN to do that.
> > > 
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > 
> > What commit id does this fix?  Or has this always been a problem?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This has always been like this. It is not really fixing a specific commit, but
> introducing further restriction on access.

So by restricting access, will this now break existing userspace tools
that do not have this permission?  I'm all for tightening up
permissions, but we can't break existing workflows without a good
reason.

thanks,

greg k-h
