Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009D7E2735
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjKFOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjKFOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B6EA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699281644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kACIP7GDh0+h4vv2zlCPYJD3hmqzFL0/Lj7oS/N2oGE=;
        b=e92EYzNKNwz1rGURh4yGuX+zlIBnMVb0UTmOLDx/WBzDAgKkW8ncEBr4ijnVuOnR8LCYg5
        vpIDtOWlnZLQa80/THNvDuKvsUKC58GnE3oWapHBhHwJH+EFPjRljogwb+vWEOCeTPVpAo
        gcMfAv0x/PNWKcrjBfWCx2xZnc/MuhE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-MMlwinTBOHyBxE8KK-DDjQ-1; Mon, 06 Nov 2023 09:40:43 -0500
X-MC-Unique: MMlwinTBOHyBxE8KK-DDjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CC95101AA44;
        Mon,  6 Nov 2023 14:40:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECFE2026D66;
        Mon,  6 Nov 2023 14:40:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
References: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net> <20231027-vfs-autofs-018bbf11ed67@brauner> <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net> <ZT+9kixqhgsRKlav@redhat.com> <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
To:     Ian Kent <raven@themaw.net>
Cc:     dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610870.1699281640.1@warthog.procyon.org.uk>
Date:   Mon, 06 Nov 2023 14:40:40 +0000
Message-ID: <2610871.1699281640@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> David, are you ok with me resurrecting your conversion patch and posting it
> on your behalf?

Yes, that's fine.

David

