Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05E8008CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378408AbjLAKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378390AbjLAKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0510D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701427582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NA57GVpcAlUrYRXA0xtGWCe36ignqDZBMAU0zkJLz4=;
        b=JBGpZma/OSceaaaPYpNUG2dz4xVL5ljtn5JQQ0tiKlLTvBLX6wRHnButmgGbbPU1/OLbV5
        o6S2PmrXtT/u06PNPJootxZt4tKK3DWhGn//4duQe6CSgqkQCjohdhVAQPH3ExUIc4zeSd
        aCED52ovm08PJxryx2+tFxx9Bx37TEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-bWjaQz9HPTCrFgStonuXtQ-1; Fri,
 01 Dec 2023 05:46:20 -0500
X-MC-Unique: bWjaQz9HPTCrFgStonuXtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AD7C3C0C127;
        Fri,  1 Dec 2023 10:46:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12C8E10E46;
        Fri,  1 Dec 2023 10:46:16 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     stern@rowland.harvard.edu
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Fri,  1 Dec 2023 11:46:14 +0100
Message-ID: <20231201104615.173933-1-jtornosm@redhat.com>
In-Reply-To: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
References: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thank you for your help.
    
> Another possibility would be to have the unbind routine set a flag in
> the private data structure, and then make the ax88179_write_cmd() and
> ax88179_read_cmd() routines avoid printing error messages if the flag is
> set.  Or don't bother with the flag, and simply make the routines skip
> printing an error message if a transfer fails with error code -ENODEV.

Yes, I had thought about those possibilities and I think they are the only
ones from the driver. As you are commenting as well, I will try a second
version with that.

Best regards
José Ignacio

