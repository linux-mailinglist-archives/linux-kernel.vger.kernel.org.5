Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0257A6CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjISVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjISVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0778FBD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695157426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQ2jSb2HniT/9ZxZOqq4fZsdcqlotGNawe8KlI6XEwk=;
        b=aNwF24+fherV2NSMsf8v/sZHfEUS1clpawFv07BFvLUhpQ7ZK4FlQ5OOR0K6Ore+z66L68
        KEZylSloSHke4rjwg9qChW5qWBeFh9k+f9Y2liRMBJWV2J4ypUTQRo88Jix2aY7wwy+PUM
        IccrJUJGOWjXMuFdAcStHwTRgDPb2lk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-eIRUBykjMwCw6pvVHAiSTw-1; Tue, 19 Sep 2023 17:03:42 -0400
X-MC-Unique: eIRUBykjMwCw6pvVHAiSTw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31963185A790;
        Tue, 19 Sep 2023 21:03:42 +0000 (UTC)
Received: from rh (unknown [10.64.138.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D042C492C37;
        Tue, 19 Sep 2023 21:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <dchinner@redhat.com>)
        id 1qihsg-001H19-1L;
        Wed, 20 Sep 2023 07:03:38 +1000
Date:   Wed, 20 Sep 2023 07:03:36 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Charles Han <hanchunchao@inspur.com>
Cc:     corbet@lwn.net, djwong@kernel.org, allison.henderson@oracle.com,
        bhelgaas@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <ZQoMqI/QGPWEpkEi@rh>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918071905.296081-1-hanchunchao@inspur.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc linux-xfs@vger.kernel.org]

Hi Charles,

For future reference, can you CC the XFS list on XFS documentation
changes please?  That's much preferable to sending patches to random
developers and hoping they notice it....

On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
> index 1625d1131093..a0678101a7d0 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
>  2. The second transaction contains a physical update to the free space btrees
>     of AG 3 to release the former BMBT block and a second physical update to the
>     free space btrees of AG 7 to release the unmapped file space.
> -   Observe that the the physical updates are resequenced in the correct order
> +   Observe that the physical updates are resequenced in the correct order

Change looks fine, though.

Reviewed: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
dchinner@redhat.com

