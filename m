Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2677FA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbjHQPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352717AbjHQPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:03:11 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC542D7E;
        Thu, 17 Aug 2023 08:02:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 50CB041FDC;
        Thu, 17 Aug 2023 15:02:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5DDB84205E;
        Thu, 17 Aug 2023 15:02:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692284573; a=rsa-sha256;
        cv=none;
        b=obOU/x0Y30heMlVeyHmmWH/Tsx12DAhOZShjEzBYfYQ8r+WLzpub7hganyajOxVp0kfRSE
        eRIuEyMJUHNehcME91c4Q1ulU1B9JXcJ1mFQyrbU4J2/HJa5Vzfm+L7xZYoTfIw0Mpu6L5
        ch0w+6Tl3TSZjz/akRldrtbiylD52cuXPeqQX/+4xd0gP3VQXCavnDnzBK8W41pbmqPNpW
        2ZlhEKK++pbqnP5r6DXIywnsH5MrADqJSy7lSCb0ik/ZxxA5KHJdulsLeX5+Kgtz9lySHK
        M80q9eRePVAKyWbkbkAV81OD1WK0SMRaL8mycq+qcwBjpeFoB0BbivdHNAvIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692284573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2ikIu5Vu9hrwUCXXlJg+KGfK7awTsQni2Zw7DEGoD6Y=;
        b=q8GMs5lfayiD/mkpSBAhM6dX03N+XtZbDK3KUyWiRT0bEgqiZ6tAyDmo81TsV52O/52sY6
        a5qxPuhKdmmSkNw3Xo0iRjXk5tAGIYVRjZ8nfj7+9uz1y+Y4byNh45swpwhYRz9Z3cmH2i
        /cNMsm63/Fch+0rJAaXGwYtrlyEErpCZPbvJ9mU2TLKa/+gLjBeROxI5fuPIeInPLyz0QG
        39L5EBqRWqeV0yipv2fp9n699+KGw8P+5ZVTMat6aECnaI4ywVSFJH6rXY8QnynIg3/qfN
        F9FJ36mPit7C3FGI0R0wQv2CNVWhhrIqssibNDcIJ1cdh9IEe3uxnlHJGZ8iaQ==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-bl8tx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Company: 04d594e336ec7684_1692284574126_3500299165
X-MC-Loop-Signature: 1692284574126:1619188933
X-MC-Ingress-Time: 1692284574126
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.184.221 (trex/6.9.1);
        Thu, 17 Aug 2023 15:02:54 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RRSt44G1PzlT;
        Thu, 17 Aug 2023 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1692284573;
        bh=2ikIu5Vu9hrwUCXXlJg+KGfK7awTsQni2Zw7DEGoD6Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nMzNfljsgfso3ZioKJSyDJeu9yqw1nTPnYudU1ZkGSwXYKPNtUE83wCIIxHg00oiM
         sC4UbdJELd4UgpRRR56wC3vHpoE2Pl+un3w0+1xKxp1INdtcRkLNt0BISVvy7ebSqO
         Iuct2nMcHWU3Q0uHkkDUlBusMFC/rbWRK+q8ku1x7zITCqLcD+lDV8cry3ll04STCn
         7HZnIG1eiyk3HHc8KzQDL3v7lZFOcRiusUL2WAN6iAHyxhGQZgNCsW2vEmyghkYpAe
         XK4TKmzo3kfkA0UQ2H5hD2xR8xFWUF6Mi3Dj9aqx52gC4A8try/NDRona5N8v63XDV
         ITHehtL6o29Bg==
Date:   Thu, 17 Aug 2023 07:24:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock
Message-ID: <unc6tesuw2b7wi3nqacikah2wxbefmnlufjn7x3gidqbo3u5gg@jopyg7nj5ckf>
References: <20230816155524.5913-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230816155524.5913-1-dg573847474@gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023, Chengfeng Ye wrote:

>There is a long call chain that &fip->ctlr_lock is acquired by isr
>fnic_isr_msix_wq_copy() under hard irq context. Thus other process
>context code acquiring the lock should disable irq, otherwise
>deadlock could happen if the irq preempt the execution while the
>lock is held in process context on the same CPU.
>
>[ISR]
>fnic_isr_msix_wq_copy()
> -> fnic_wq_copy_cmpl_handler()
> -> fnic_fcpio_cmpl_handler()
> -> fnic_fcpio_flogi_reg_cmpl_handler()
> -> fnic_flush_tx()
> -> fnic_send_frame()
> -> fcoe_ctlr_els_send()
> -> spin_lock_bh(&fip->ctlr_lock)
>
>[Process Context]
>1. fcoe_ctlr_timer_work()
> -> fcoe_ctlr_flogi_send()
> -> spin_lock_bh(&fip->ctlr_lock)
>
>2. fcoe_ctlr_recv_work()
> -> fcoe_ctlr_recv_handler()
> -> fcoe_ctlr_recv_els()
> -> fcoe_ctlr_announce()
> -> spin_lock_bh(&fip->ctlr_lock)
>
>3. fcoe_ctlr_recv_work()
> -> fcoe_ctlr_recv_handler()
> -> fcoe_ctlr_recv_els()
> -> fcoe_ctlr_flogi_retry()
> -> spin_lock_bh(&fip->ctlr_lock)
>
>4. -> fcoe_xmit()
> -> fcoe_ctlr_els_send()
> -> spin_lock_bh(&fip->ctlr_lock)
>
>spin_lock_bh() is not enough since fnic_isr_msix_wq_copy() is a
>hardirq.
>
>These flaws were found by an experimental static analysis tool I am
>developing for irq-related deadlock.
>
>The patch fix the potential deadlocks by spin_lock_irqsave() to
>disable hard irq.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
