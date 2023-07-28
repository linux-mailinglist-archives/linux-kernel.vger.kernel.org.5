Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED99766245
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjG1DF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjG1DFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E11BFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690513449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GStcZIMJcpm3mEc/b6/z0GhlYIMNmnnV6wFHKdIVD34=;
        b=brP/FL66dLn+T9qd6ldQK1PpoC73Iw9+4CLM3ZKMCasTWlxAhj9byu62kFfjqBosJtdw3H
        8hiurJycvgwAK5HFh5A6HnyBHnpLKHFeA8k7PzwyIe6AiZXHnr3Bi2WW994+wKL2b+38Le
        SKx6UFyQh52TLpbCDPOVQSTtGxg51nY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-UZIbd7wuPReYBwkAFZlj-w-1; Thu, 27 Jul 2023 23:04:05 -0400
X-MC-Unique: UZIbd7wuPReYBwkAFZlj-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 134EB800159;
        Fri, 28 Jul 2023 03:04:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A4994094DC0;
        Fri, 28 Jul 2023 03:04:03 +0000 (UTC)
Date:   Fri, 28 Jul 2023 11:04:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 0/3] percpu: some trivial cleanup patches
Message-ID: <ZMMwIYCw8YQ0WeKK@MiWiFi-R3L-srv>
References: <20230721131800.20003-1-bhe@redhat.com>
 <ZLry5gupx9mp1659@snowbird>
 <ZLtNRsDuN4xEMSMB@MiWiFi-R3L-srv>
 <ZML0qwKTG5zB4VwL@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZML0qwKTG5zB4VwL@snowbird>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/23 at 03:50pm, Dennis Zhou wrote:
> Hi,
> 
> On Sat, Jul 22, 2023 at 11:30:14AM +0800, Baoquan He wrote:
> > On 07/21/23 at 02:04pm, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > On Fri, Jul 21, 2023 at 09:17:57PM +0800, Baoquan He wrote:
> > > > There's a left issue in my mailbox about percpu code at below. When
> > > > I rechecked it and considered Dennis's comment, I made an attmept
> > > > to fix it with patch 3.
> > > > 
> > > > https://lore.kernel.org/all/Y407wDMKq5ibE9sc@fedora/T/#u
> > > > 
> > > > Patch 1 and 2 are trivial clean up patches when reading percpu code.
> > > > 
> > > > Baoquan He (3):
> > > >   mm/percpu.c: remove redundant check
> > > >   mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little
> > > >     bit
> > > >   mm/percpu.c: print error message too if atomic alloc failed
> > > > 
> > > >  mm/percpu.c | 39 +++++++++++++++++----------------------
> > > >  1 file changed, 17 insertions(+), 22 deletions(-)
> > > > 
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > Thanks for these. I left a few comments. I think I might have some stuff
> > > for v6.6, I'll figure that out in a couple days. If that's so, I can
> > > pull 1, probably massage 2 and send that out again, and then I think
> > > you'll need to resend 3.
> > 
> > Sure, thanks for careful reviewing and great suggestion. So I only need
> > to send v2 of patch 3, right? Or I should change and send v2 of the
> > whold series? I may not get it clear.
> > 
> 
> Sorry for the delay. I've pulled 1 and 2 (reworded the comment). Can you
> please resend patch 3.

Sent out v2 of patch 3, thanks.

