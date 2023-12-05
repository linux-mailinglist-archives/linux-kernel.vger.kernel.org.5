Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A1804EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjLEJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLEJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D819E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701769907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dVZSK5HrOSlXE62GRvm87IDdzGVk4JEDjk3rU5ubq8=;
        b=fxEPKqtwd6YgUUPy5LkaNGX2giwpgystIsQNDEZsKsoTJMs57Xw4ndbtRxNeDn4ITJMWD1
        xB/BnmRfE9HxYYudT4yV3cf6hrTd+UmxRuuW0MPpnOZoPY/kbfWJLlrRryTxslOaWXYMTV
        /Jp66xmigv5ClQJYbmMKNFuboJ4V0ks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-F4k2HGFBPB6w4DHHBWvnrw-1; Tue,
 05 Dec 2023 04:51:43 -0500
X-MC-Unique: F4k2HGFBPB6w4DHHBWvnrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E0002806040;
        Tue,  5 Dec 2023 09:51:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4BCF1C060AF;
        Tue,  5 Dec 2023 09:51:41 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_LIST)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
Date:   Tue, 05 Dec 2023 10:51:39 +0100
In-Reply-To: <6b399b86-a478-48b0-92a1-25240a8ede54@p183> (Alexey Dobriyan's
        message of "Mon, 4 Dec 2023 20:18:48 +0300")
Message-ID: <87v89dvuxg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan:

> +/*
> + * Page sizes available for mmap(2) encoded as 1 page shift per byte in
> + * increasing order.
> + *
> + * Thus 32-bit systems get 4 shifts, 64-bit systems get 8 shifts tops.

Couldn't you use the bits in a long instead, to indicate which shifts
are present?  That's always going to be enough.

Thanks,
Florian

