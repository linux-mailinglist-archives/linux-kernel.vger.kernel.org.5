Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C987FE57B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjK3BHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjK3BHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13AD54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701306456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gaB7sxRUp4UiPtrVF5Y50SK0RyEXN9nQyzM9BHGDG2U=;
        b=Xb152lNwhqnYfNjQuK1s+aePt2Qy7A9c16pce99lL0CFoaiptiVHVHjKiEyJdxRUxK0bPK
        HHJ5l7vcVGvzgZOcX4tgv90MNljRgeITb3YJRKt5lWMEji1NatiEkW2sohcmN6DaxB1ycc
        uyV1mEQwtIO8BZzsPwZALC4bzEMybyg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-sv9f3qJEMk2-l9P1BxWwvA-1; Wed,
 29 Nov 2023 20:07:32 -0500
X-MC-Unique: sv9f3qJEMk2-l9P1BxWwvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07A58380008A;
        Thu, 30 Nov 2023 01:07:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FCB52026D4C;
        Thu, 30 Nov 2023 01:07:30 +0000 (UTC)
Date:   Thu, 30 Nov 2023 09:07:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <ZWfgUJaNv0p8IS7K@MiWiFi-R3L-srv>
References: <20231130074350.7c758662@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130074350.7c758662@canb.auug.org.au>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On 11/30/23 at 07:43am, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP")
> 
> Fixes tag
> 
>   Fixes: commit 89cde455915f ("kexec: consolidate kexec and crash options into kernel/Kconfig.kexec")
           ~~~~~~
Sorry, my fault. I didn't read the
Documentation/process/submitting-patches.rst carefully.

Maybe Andrew can help remove the 'commit' after 'Fixes:', thanks.

> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected


