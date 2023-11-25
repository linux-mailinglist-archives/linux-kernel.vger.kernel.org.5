Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6932B7F87CD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKYC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYC3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA31990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700879389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPID5CjYb2m6MvI+i3cidt4yTGrsfS5NjhuE3IlMXf0=;
        b=hsnWA2GMXJ9fis9CXpxpI1tdaweyE0rq4luf32s/PIbDToWwa86iBrhvJoAibBSgFUJawe
        Unw5i0m2c9G1d0KNkbfH3DD4dWeZF0lkES+zwqiP5wL1ej/vqBZWWd1V44GotKqTmVtgjQ
        llvjNs4AJ35rg2Iowp6lNy3L4PQwtUI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Bz5UptqaO1Kx4oL_jq0oKQ-1; Fri, 24 Nov 2023 21:29:46 -0500
X-MC-Unique: Bz5UptqaO1Kx4oL_jq0oKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74094811E7D;
        Sat, 25 Nov 2023 02:29:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C57782026D4C;
        Sat, 25 Nov 2023 02:29:44 +0000 (UTC)
Date:   Sat, 25 Nov 2023 10:29:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        eric_devolder@yahoo.com, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZWFcFU9PjHl2L09u@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
 <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
 <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 at 08:44am, Andrew Morton wrote:
> On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > > >
> > > > Fix it now.
> > > 
> > > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> > 
> > Makes sense. Will add it in v2 since I need respin to add the missing
> > stuff in patch 1. Thanks.
> 
> Please avoid mixing cc:stable patches and this-merge-window fixes in
> the same series as next-merge-window material.  Because I'll just have
> to separate them out anyway, causing what-I-merged to unnecessarily
> differ from what-you-sent.

Got it, will send them separately because the issue that this patch is fixing
has been there for very long time. Thanks for noticing.

