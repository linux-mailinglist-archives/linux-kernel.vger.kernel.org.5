Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD780EF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376948AbjLLOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376986AbjLLOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9375D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702392772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TM/ETYDn3/wj6XRz5306aJPuGSPiUb3WuXkZY3U46Y=;
        b=dFs52zzinLh9JAabxGvngVd+b8LE3mRGwh2sj32NXq2l5teoEDOef20Bd+cELnNbV7DQzN
        3PrnREuUu41BSYv2trVuRO3677aCBMXYbJa+q1JFb4U3Rdlmqp2Axg4gypFsA5dpmclYJ8
        va4RACE9hSTD3n9znkZg1R0BBuJW3pM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-csq-8HPtM6eEJ0-9qvy6CQ-1; Tue, 12 Dec 2023 09:52:51 -0500
X-MC-Unique: csq-8HPtM6eEJ0-9qvy6CQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABEB383B871;
        Tue, 12 Dec 2023 14:52:50 +0000 (UTC)
Received: from [10.43.3.45] (unknown [10.43.3.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39488492BE6;
        Tue, 12 Dec 2023 14:52:50 +0000 (UTC)
Message-ID: <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
Date:   Tue, 12 Dec 2023 15:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to start Raise network interfaces error
To:     Julia Lawall <julia.lawall@inria.fr>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On 10. 12. 23 23:28, Julia Lawall wrote:
> Hello,
> 
> Starting with the commit:
> 
> commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
> Author: Ivan Vecera <ivecera@redhat.com>
> Date:   Fri Oct 13 19:07:51 2023 +0200
> 
>      i40e: Add initial devlink support
> 
> I am not able to boot normally.  The console shows the message
> 
> Failed to start Raise network interfaces
> 
> Searching for this message on th internet produces some old discussions
> that suggest to look at the file /etc/network/interfaces.  That file on my
> system contains:
> 
> # This file describes the network interfaces available on your system
> # and how to activate them. For more information, see interfaces(5).
> 
> source /etc/network/interfaces.d/*
> 
> # The loopback network interface
> auto lo
> iface lo inet loopback
> 
> auto enp24s0f0
> iface enp24s0f0 inet dhcp

The problem is maybe with interface name... after this commit the 
interface should contain port_name suffix. In your case the name should 
be `enp24s0f0np0`.

Could you please check it?

Thx,
Ivan

