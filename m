Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAF7EE1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbjKPNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbjKPNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD119B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700142645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRYUXNkoJkqjfiq94gnRR2tpyfMacneqCdIvg/D2QqA=;
        b=BC8saLjmDB2PJoEK6uaZIU40SlGDlKxHM7Mg5vUh1/b1ztmEQjbAPspMkIIRNkYf67hZCd
        QVeCj7VmrHj1EBJY82wYieBn2x7TyFak8Ipzft5S1hOM/IUSnzUFoNYPYJ9XrNZnAsdNWV
        nUWxWBLA6LXYIBhfnD/SiTKGJ0pE4UA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-A5A73WdPOM-nbQzROePm0Q-1; Thu,
 16 Nov 2023 08:50:42 -0500
X-MC-Unique: A5A73WdPOM-nbQzROePm0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 307223C1476C;
        Thu, 16 Nov 2023 13:50:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB6B31C060AE;
        Thu, 16 Nov 2023 13:50:36 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     pabeni@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        weihao.bj@ieisystem.com
Subject: Re: [PATCH 1/2] net: usb: ax88179_178a: fix failed operations during ax88179_reset
Date:   Thu, 16 Nov 2023 14:50:33 +0100
Message-ID: <20231116135035.21504-1-jtornosm@redhat.com>
In-Reply-To: <d17b696c81a57fb857b54a8c05e121be1cfc47fa.camel@redhat.com>
References: <d17b696c81a57fb857b54a8c05e121be1cfc47fa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:38 AM Paolo Abeni <pabeni@redhat.com> wrote:
> We need at least a suitable Fixes tag
Ok, I will add it in my next version.

> Do you know if there is some status register you can query for 'reset
> completed'? or some official documentation you can quote for the above
> delay?
I have only continued the previous way.
But, you are right, maybe it can be done better, let me try if possible.

Thank you

Best regards
José Ignacio

