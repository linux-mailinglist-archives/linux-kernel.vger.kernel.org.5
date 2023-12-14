Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372E813384
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573410AbjLNOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573501AbjLNOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61A131
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702565289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQrhIHbv64EnZ37/gcr7zz8rNHgYkKc/dh/c/WTZJ7U=;
        b=WN7hR1gXk3aNkl/WK2zc/nLeH4nZ8M6froo42esLK/a16FsNhN2a6ya4/CLCBk00FU510S
        UuBewzyLXHOq0yGbNuEpLm+ATZvUZJa7nvzY6fFg7NJbUEjVStnRyh08uPyUytZn2N0gnX
        aKmhwWgKyBqd//SKY/FVJQpSu0PA8k0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-dKF00F-TNeSK-gS_hQT0aA-1; Thu,
 14 Dec 2023 09:48:07 -0500
X-MC-Unique: dKF00F-TNeSK-gS_hQT0aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 816C91E441D1;
        Thu, 14 Dec 2023 14:48:00 +0000 (UTC)
Received: from [10.45.224.252] (unknown [10.45.224.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCB971121306;
        Thu, 14 Dec 2023 14:47:59 +0000 (UTC)
Message-ID: <4a053d6a-92c6-4d01-bfe5-2349d64cc429@redhat.com>
Date:   Thu, 14 Dec 2023 15:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to start Raise network interfaces error
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
 <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
 <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
 <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
 <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
 <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>
 <alpine.DEB.2.22.394.2312141530500.3217@hadrien>
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <alpine.DEB.2.22.394.2312141530500.3217@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 12. 23 15:33, Julia Lawall wrote:
> 
> 
> On Tue, 12 Dec 2023, Ivan Vecera wrote:
> 
>>
>>
>> On 12. 12. 23 17:33, Julia Lawall wrote:
>>>> Look at 'systemd.net-naming-scheme' man page for details how the interface
>>>> names are composed.
>>> After booting into 6.7.0-rc4, I have the following in
>>> /etc/network/interfaces:
>>>
>>> # This file describes the network interfaces available on your system
>>> # and how to activate them. For more information, see interfaces(5).
>>>
>>> source/etc/network/interfaces.d/*
>>>
>>> # The loopback network interface
>>> auto lo
>>> iface lo inet loopback
>>>
>>> auto enp24s0f0
>>> iface enp24s0f0 inet dhcp
>>
>> Just change 'enp24s0f0' in /etc/network/interfaces to 'enp24s0f0np0'
> 
> Hello,
> 
> I don't know if anything can be done about it, but this change introduces
> complexities.  The people who manage the cluster that I use say that the
> name of the network interface should be predictable, which is no longer
> the case because it now depends on the kernel version.

In this case, you can configure custom udev rule that will fix the name 
of the interface... Like:

host ~ # cat /etc/udev/rules.d/70-network.rules
ACTION=="add", SUBSYSTEM=="net", DRIVERS=="i40e",\
ATTR{address}=="xx:xx:xx:xx:xx:xx", NAME="enp24s0f0"
ACTION=="add", SUBSYSTEM=="net", DRIVERS=="i40e",\
ATTR{address}=="yy:yy:yy:yy:yy:yy", NAME="enp24s0f1"

Regards,
Ivan

