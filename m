Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC080990B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572991AbjLHCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3E172A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702001452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il5oopo58FBky7wapbSa4VtHGAOr6/LyABJzUA84HrQ=;
        b=B+8Jhnni6g2PdTCMcvsR1wQ5ksIIrXQYL0/8WX4InCJ59VntgT+V8Uiw5zqFc0CJ8DCjbM
        RqFmancyODUeOiAO6CUtUcK2aTCs5rUAYGNkWKvY1+h8CLEdHm0IUverUZzlYMEbAA5oHK
        3yRnBe1GKYzcbpKsbesr412X/FNDblk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-1J2f_jeiOX62oP58qsBoLQ-1; Thu, 07 Dec 2023 21:10:51 -0500
X-MC-Unique: 1J2f_jeiOX62oP58qsBoLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95D37881DF1;
        Fri,  8 Dec 2023 02:10:50 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D71DE40C6EB9;
        Fri,  8 Dec 2023 02:10:49 +0000 (UTC)
Date:   Fri, 8 Dec 2023 10:10:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXJ7JpcZALSeFvox@MiWiFi-R3L-srv>
References: <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXGIeAgCcatUDa2h@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

On 12/07/23 at 09:55am, Michal Hocko wrote:
> On Thu 07-12-23 12:23:13, Baoquan He wrote:
> [...]
> > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > it will be a venture.
> 
> We can't guarantee this of course but AFAIK the DMA shouldn't take
> minutes, right? While not perfect, waiting for some time before jumping
> into the crash kernel should be acceptable from user POV and it should
> work around most of those potential lingering programmed DMA transfers.
> 
> So I guess what we would like to hear from you as kdump maintainers is
> this. Is it absolutely imperative that these issue must be proven
> impossible or is a best effort approach something worth investing time
> into? Because if the requirement is an absolute guarantee then I simply
> do not see any feasible way to achieve the goal of reusable memory.

Honestly, I think all the discussions and proof have told clearly it's
not a good idea. This is not about who wants this, who doesn't. So
far, this is an objective fact that taking ,cma area for crashkernel= is
not a good idea, it's very risky.

We don't deny this at the beginning. I tried to present all what I know,
we have experienced, we have investigated, we have tried. I wanted to
see if this time we can clarify some concerns may be mistaken. But it's
not. The risk is obvious and very likely happen.

> 
> Let me reiterate that the existing reservation mechanism is showing its
> limits for production systems and I strongly believe this is something
> that needs addressing because crash dumps are very often the only tool
> to investigate complex issues.

Yes, I admit that. But it haven't got to the point that it's too bad to
bear so that we have to take the risk to take ,cma instead.

