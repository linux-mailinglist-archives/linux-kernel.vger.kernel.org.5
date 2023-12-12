Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010980F36C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbjLLQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLLQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA30A8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702399446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySoNw8vEdXTg7E8ZJq7ueigpTixV3dy0V72vf7J6xk8=;
        b=gPHGrZfyguAYB5QtARssbHMAJTfZTCeAkDDBGx0xmX6A1XoQjg5n6PV+ge7zRyBokoiABg
        w4FK2Qt3aU4Gy4XH0KsCnnO3cjzPy7SeoVZU81Cb0zx/NPgboBgt02r021vPswsegkoxNv
        iBBG6mQaNzVFiaXtZgUtPdlvQyonp6U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-Snvm0x-rPr-_QG5-pJQSXA-1; Tue,
 12 Dec 2023 11:44:02 -0500
X-MC-Unique: Snvm0x-rPr-_QG5-pJQSXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B1D1C0BA4E;
        Tue, 12 Dec 2023 16:44:02 +0000 (UTC)
Received: from [10.45.225.77] (unknown [10.45.225.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBABB492BE6;
        Tue, 12 Dec 2023 16:44:01 +0000 (UTC)
Message-ID: <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>
Date:   Tue, 12 Dec 2023 17:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to start Raise network interfaces error
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
 <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
 <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
 <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
 <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12. 12. 23 17:33, Julia Lawall wrote:
>> Look at 'systemd.net-naming-scheme' man page for details how the interface
>> names are composed.
> After booting into 6.7.0-rc4, I have the following in
> /etc/network/interfaces:
> 
> # This file describes the network interfaces available on your system
> # and how to activate them. For more information, see interfaces(5).
> 
> source/etc/network/interfaces.d/*
> 
> # The loopback network interface
> auto lo
> iface lo inet loopback
> 
> auto enp24s0f0
> iface enp24s0f0 inet dhcp

Just change 'enp24s0f0' in /etc/network/interfaces to 'enp24s0f0np0'

Ivan

