Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A67FC17E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjK1RqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjK1RqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70310A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701193580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yk6j113tXJGPHpHs0u9jLw9sedPe3cO7CNbhi5A0g1k=;
        b=UwwkrzanyD1fG2YoJKlbwsEFsVBuS9gqzfNJmGdwq0JOnrY6GHytwjSwWDbo+JDLWvfQO6
        3aMaYnVb20xqL/YwDxsifDyz3bbVdYfqtvyCvazCPH9zRclkSz1996z0Vj137HaGVGgpiD
        4HOall0rEmg8I7RdE5L+Z0NLB3z/3XY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-iXk2tstZPAylBdQvRh38vg-1; Tue, 28 Nov 2023 12:46:15 -0500
X-MC-Unique: iXk2tstZPAylBdQvRh38vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654EA101A54C;
        Tue, 28 Nov 2023 17:46:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 414BB1C060AE;
        Tue, 28 Nov 2023 17:46:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com>
References: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com> <1297339.1700862676@warthog.procyon.org.uk> <1335877.1700868425@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2055975.1701193569.1@warthog.procyon.org.uk>
Date:   Tue, 28 Nov 2023 17:46:09 +0000
Message-ID: <2055976.1701193569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I have a new version.

David

