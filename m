Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877817A0DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbjINTKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjINTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 938101FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694718601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G30aDEjWsGwHEBcRnJQg8/XZtFrP1rxiHjsXrhoF9jc=;
        b=EJ+nqp/cSzcvyUu6SmbIlkjkLsudcvnOUHBWcwCDu+Fo6FXmUGiUg/Fl8CoIAaTH4/fP5a
        FAQHmjjC1vMDanRqC9M5RwswJR12Re78J+ninrX0bwaUskboCwhtJTeIkvT3wvMEfv5tiM
        NL9751o9Wcl2DxWo9ZxOWkdpHnbbQxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-5-Yls00iPaSiIW2Kk2t_Kw-1; Thu, 14 Sep 2023 15:09:55 -0400
X-MC-Unique: 5-Yls00iPaSiIW2Kk2t_Kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84833185A79B;
        Thu, 14 Sep 2023 19:09:54 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E22421B2413;
        Thu, 14 Sep 2023 19:09:51 +0000 (UTC)
Date:   Thu, 14 Sep 2023 21:09:46 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>,
        lennart@poettering.net
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230914210946.25730571@rotkaeppchen>
In-Reply-To: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
References: <20230911052535.335770-1-kernel@jfarr.cc>
        <20230913160045.40d377f9@rotkaeppchen>
        <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Wed, 13 Sep 2023 16:42:33 +0200
"Jan Hendrik Farr" <kernel@jfarr.cc> wrote:

> On Wed, Sep 13, 2023, at 4:00 PM, Philipp Rudo wrote:

[...]

> In [5] Luca writes:
> > [...] we fully intend for the UKI format to be an open and stable
> > specification, that anybody can support and rely on.  
> But that is unfortunately not where the format is at this point.
> 
> What is annoying though is where this leaves a user that actually
> wants this feature. They can carry a patch or they might have to wait
> a long time.
> 
> Can you indicate what it would take for the kernel community to consider
> this spec as stable enough?

I don't think there is a good answer to that question. In fact I
believe if you ask 10 people from the community you will get 20+
different answers.

My guess is that either (1) the spec is moved to some official standard
committee where people spend decades to polish it before it makes it
into the kernel or (2) there's a big flamewar on LKML until Linus had
enough and passes his judgment on it. So definitely (2) ;-)

Thanks
Philipp

> 
> 
> > In the end the only benefit this series brings is to extend the
> > signature checking on the whole UKI except of just the kernel image.
> > Everything else can also be done in user space. Compared to the
> > problems described above this is a very small gain for me.  
> 
> Correct. That is the benefit of pulling the UKI apart in the
> kernel. However having to sign the kernel inside the UKI defeats
> the whole point.
> 
> 
> [1] https://uapi-group.org/specifications/specs/unified_kernel_image/
> [2] https://github.com/uapi-group/specifications/pull/72
> [3] https://github.com/uapi-group/specifications/pull/73
> [4] https://github.com/uapi-group/specifications/issues/74
> [5] https://github.com/systemd/systemd/issues/28538
> 

