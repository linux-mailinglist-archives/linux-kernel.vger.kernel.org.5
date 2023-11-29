Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370617FDDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjK2Q6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjK2Q6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47901986
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701277090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PN693iXv6rn+BGgKTP3UDSjbiexkCbKdKEBIGtl7gRM=;
        b=W6/ryffg4kahcXTsm6mjWf5vYW8M/cdb49C+wCp550Lvd3DSFTriSUgYANmscq5tBNLj0d
        k8aiL63zQM9ilNXfuyyDXQCB6ep+jcueZSLT6dwE4RT/3Wkg0CFiB6Pl/a4dHTRg7FZiRk
        Vm+z5sfB5pNs2CFbxkz50ZjSLLQi+rg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-QQwa5L16NOSyU0abYOO_GA-1; Wed,
 29 Nov 2023 11:58:07 -0500
X-MC-Unique: QQwa5L16NOSyU0abYOO_GA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E53291C05AB5;
        Wed, 29 Nov 2023 16:58:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA78492BFC;
        Wed, 29 Nov 2023 16:58:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2056123.1701193802@warthog.procyon.org.uk>
References: <2056123.1701193802@warthog.procyon.org.uk>
To:     Steve French <sfrench@samba.org>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-cifs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix issues with copy_file_range and FALLOC_FL_INSERT/ZERO_RANGE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2355923.1701277085.1@warthog.procyon.org.uk>
Date:   Wed, 29 Nov 2023 16:58:05 +0000
Message-ID: <2355925.1701277085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

This patch should be considered obsolete.  I've split it up, fixes another
issue and posted three replacements.

David

