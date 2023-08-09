Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2547750C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHICMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHICMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CA1BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rv4Ker0R0fL8fxtzfnNJmiV4bNdRsYizF32IMrCh0MU=;
        b=YGewJdvHiWCrsF5lXbXJVTDL3XCt4eEDJaGOR72tF69uQvbzciHtELCzfJIAGAbo0rzZzE
        TE3gYhIRKOkEVCtkqzQw33vmWPdJIALd+8MRGSNJ/KRbNes2Fu5FGUYJngtg7dXOjXZJg0
        JlFb9q6IwsdhXL58/FI2YcdjWgt78HA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-yBSQL6PeNT2imycNOchykw-1; Tue, 08 Aug 2023 22:11:50 -0400
X-MC-Unique: yBSQL6PeNT2imycNOchykw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F34B80CC34;
        Wed,  9 Aug 2023 02:11:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F204EA54;
        Wed,  9 Aug 2023 02:11:49 +0000 (UTC)
Date:   Wed, 9 Aug 2023 10:11:46 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        piliu@redhat.com
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Message-ID: <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> Hi,
> 
> I am trying to bring up kdump on arm64 platform[1]. But I get "Cannot get kernel _text symbol address".
> 
> Is there some Dump-capture kernel config options that I am missing?
> 
> FYI, copied below complete kexec debug log.
> 
> [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html

Your description isn't clear. You saw the printing, then your kdump
kernel loading succeeded or not?

If no, have you tried applying Pingfan's patchset and still saw the issue?

[PATCHv7 0/5] arm64: zboot support
https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com/T/#u

Thanks
Baoquan

