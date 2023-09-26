Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A157AE745
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjIZICp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:02:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202EC9;
        Tue, 26 Sep 2023 01:02:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD53C433C7;
        Tue, 26 Sep 2023 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695715355;
        bh=+bdOGKgX54Uph/y5/+UiUHfOhsH5oazHJwtFtKfreBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEtwNwPAE/qP9Yn/czy6CEhsKCMF3toxuKY9zJ14T+fvcV/b1halOX6FwehXakJR2
         Ea70FiLdFRufd0J5lfEHq0uiITmg7v+NZdg9RWliwFcboSCOinAatGdxcnU4JcA6rR
         a+7hU/c1lgGHqFUshSYBR5ndDTTDB62C6/towlNM=
Date:   Tue, 26 Sep 2023 10:02:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Dave Miller <davem@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: SPDX: Appletalk FW license in the kernel
Message-ID: <2023092606-fiction-finlike-97a5@gregkh>
References: <6100798b-ab1d-262a-fd5b-435d6dfc4a53@redhat.com>
 <ZRKJa+cMsFxiizKb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRKJa+cMsFxiizKb@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 12:34:03AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 15, 2023 at 09:39:05AM -0400, Prarit Bhargava wrote:
> > To be clear, I am not asking for their removal, however, I do think a better
> > license should be issued for these files.  The files were trivially modified
> > in 2006. It could be that the code in question is now unused and it is just
> > easier to remove them.
> > 
> > Is there anyone you know of that we could approach to determine a proper
> > SPDX License for these files?
> 
> The code contains firmware that is downloaded to the device.  The proper
> thing would be to convert them to separate binary files in the
> linux-firmware packages.  But given that the driver has seen nothing
> but tree wide cleanups since the dawn of git I suspect there is no
> maintainer and probably no user left.  The best might be to indeed just
> remove it and see if anyone screams, in which case we could bring it
> back after doing the above.
> 

We should just remove them for now, I have no objection to that at all.

Want me to send the patch?

thanks,

greg k-h
