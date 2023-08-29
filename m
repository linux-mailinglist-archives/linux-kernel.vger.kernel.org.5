Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121C778C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjH2NjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjH2NiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFF2722
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693316123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cO0xjhpEIbyDRGh2W69E0QliiyPI0y6q0VdT9HQwIsM=;
        b=XUxW+568IdXvx5YX0a2PZrDNOc/U5uU1uo9AOXEhZJUeXjQCSL15C0ron0R7HuiCys+gNO
        cfMHURZECtvexQc8twmcrqUSRJNilZPZzWwQI0lTqWGz4tYnO+Gc+lPMMYfMEVv4rLdKZj
        s5GZ6gYI0ms3ui/s0a92oEHHlyQcFtw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-0Ylzmtb9PWuDpI77SDLYrQ-1; Tue, 29 Aug 2023 09:35:19 -0400
X-MC-Unique: 0Ylzmtb9PWuDpI77SDLYrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A31912815E21;
        Tue, 29 Aug 2023 13:35:18 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A2A40C2063;
        Tue, 29 Aug 2023 13:35:17 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chengen Du <chengen.du@canonical.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] NFS: Add mount option 'fasc'
Date:   Tue, 29 Aug 2023 09:35:16 -0400
Message-ID: <73E82F73-1621-4553-8019-2946EA573415@redhat.com>
In-Reply-To: <CAPza5qe0NBWiKZ1yLyfdPGOsmM=VGqWMs=oWJqVzLRcd8AFyJQ@mail.gmail.com>
References: <20230828055310.21391-1-chengen.du@canonical.com>
 <CAPza5qe0NBWiKZ1yLyfdPGOsmM=VGqWMs=oWJqVzLRcd8AFyJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2023, at 3:14, Chengen Du wrote:

> Hi,
>
> The performance issue has been brought to our attention by users
> within the Ubuntu community.
> However, it seems to be confined to specific user scenarios.
> Canonical has taken proactive measures to tackle the problem by
> implementing a temporary solution [1], which has effectively resolved
> the issue at hand.
> Nonetheless, our earnest desire is for a definitive resolution of the
> performance concern at its source upstream.
>
> I've taken the initiative to send the patches addressing this matter.
> Regrettably, as of now, I've yet to receive any response.
> This situation leads me to consider the possibility of reservations or
> deliberations surrounding this issue.
> I am genuinely keen to gain insights and perspectives from the
> upstream community.
>
> I kindly ask for your valuable input on this matter.
> Your thoughts would significantly aid my progress and contribute to a
> collective consensus.

Hi Chengen Du,

This patch changes the default behavior for everyone.  Instead of that,
perhaps the new option should change the behavior.  That would reduce the
change surface for all NFS users.

The default behavior has already been hotly debated on this list and so I
think changing the default would need to be accompanied by excellent
reasons.

Ben

