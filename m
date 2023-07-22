Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE975D969
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGVDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6E359C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689996623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQcUTucxYD9NggKH30+z4KZSkDmNi4HWKkE2UQtXruw=;
        b=Sj1fOaLpbqre/wpheHifzR4WyAK8DDIyBeQEFSEJl3j4V6sdQZU+2NoFr0iqibKx4RQ97K
        NuGN2GLWv74rKdVr4YqrCMNA4SOVtA7k+oj/DUkNVWH/YbtIpaE4E1hUzuVb7WF9EQcUxA
        4VcC+N5Tli/O3TQVthIIFp05asnKimA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-vxQnj3-7PrSxChngzlucYw-1; Fri, 21 Jul 2023 23:30:19 -0400
X-MC-Unique: vxQnj3-7PrSxChngzlucYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AF0B185A795;
        Sat, 22 Jul 2023 03:30:18 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCD09200A7CA;
        Sat, 22 Jul 2023 03:30:17 +0000 (UTC)
Date:   Sat, 22 Jul 2023 11:30:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 0/3] percpu: some trivial cleanup patches
Message-ID: <ZLtNRsDuN4xEMSMB@MiWiFi-R3L-srv>
References: <20230721131800.20003-1-bhe@redhat.com>
 <ZLry5gupx9mp1659@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLry5gupx9mp1659@snowbird>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/23 at 02:04pm, Dennis Zhou wrote:
> Hello,
> 
> On Fri, Jul 21, 2023 at 09:17:57PM +0800, Baoquan He wrote:
> > There's a left issue in my mailbox about percpu code at below. When
> > I rechecked it and considered Dennis's comment, I made an attmept
> > to fix it with patch 3.
> > 
> > https://lore.kernel.org/all/Y407wDMKq5ibE9sc@fedora/T/#u
> > 
> > Patch 1 and 2 are trivial clean up patches when reading percpu code.
> > 
> > Baoquan He (3):
> >   mm/percpu.c: remove redundant check
> >   mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little
> >     bit
> >   mm/percpu.c: print error message too if atomic alloc failed
> > 
> >  mm/percpu.c | 39 +++++++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 
> Thanks for these. I left a few comments. I think I might have some stuff
> for v6.6, I'll figure that out in a couple days. If that's so, I can
> pull 1, probably massage 2 and send that out again, and then I think
> you'll need to resend 3.

Sure, thanks for careful reviewing and great suggestion. So I only need
to send v2 of patch 3, right? Or I should change and send v2 of the
whold series? I may not get it clear.

