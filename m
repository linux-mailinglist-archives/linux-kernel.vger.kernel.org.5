Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C88011D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjLARiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjLARiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10426B7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701451645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIN6tLPw09H9zOs4zuK0VfA5bwhOPcu5mP00NJGpiN4=;
        b=D9iiemAJnlkecMtuYTcYE5hGz8GXsbcRCLf8HAVECjzbxTPDW15zFHXv5n8B9FeSFp+32c
        NSi+WJo4TkILcJ7R9SmOqNG2FPX4nkP08o8lUkWajf6l4JSRfO0RBSlzU/KBIL8IwHeQqk
        lyIwTGIW1sz1KXwczwSTqzQSjDH2Dqg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-eD3LDQIjMwmrsUndj-JnrQ-1; Fri,
 01 Dec 2023 12:27:19 -0500
X-MC-Unique: eD3LDQIjMwmrsUndj-JnrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4735B3804528;
        Fri,  1 Dec 2023 17:27:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 362E22026D4C;
        Fri,  1 Dec 2023 17:27:17 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     stern@rowland.harvard.edu
Cc:     davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        jtornosm@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Fri,  1 Dec 2023 18:27:14 +0100
Message-ID: <20231201172716.182693-1-jtornosm@redhat.com>
In-Reply-To: <140e912f-8702-4e85-8d6c-ef0255e718f8@rowland.harvard.edu>
References: <140e912f-8702-4e85-8d6c-ef0255e718f8@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Alan,

> Would it be good enough just to check for ret != -ENODEV and not do the 
> stopping_unbinding check at all?
I thought about that but if possible, I would like to ignore the failed
operation messages only under a controlled and expected situation. 
I think that if there is a problem with the device it will be easier to
analyze it later with all the possible information.
But this is my opinion ...

Thank you

Best regards
José Ignacio

