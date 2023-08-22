Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2987847D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjHVQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjHVQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:37:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9319A;
        Tue, 22 Aug 2023 09:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692722240; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VrMPXu126qA1zWg4T1cHKT67k4Mrm+mLMeWmykui9qpSLhbudlToJMAydjo0zrcsH8
    0CWua1x9ZQVCniasSw8s8VaV1/gXMCM5B0zZhdke1wxyXcGI1Wo3QbRHgWaKx4evO76J
    w8oZwFjLRNmQpNGudeYFFzw1px7fD9AP/3PZZV96jMhNREYm2TDrPZK98V0lEuekFRiB
    AsGrB4TmBWZo4dZDLPpzveS9RQ9sp7EJ5qYOAs5eorIo4r8XDaWWqZVur8Ms2IdjEeq3
    l+bY6Huy0OR+6eks7NhzggfnHnek9L/hdzWli3E1OK1aO+m4mwmCvActl3uCHz3EHxYz
    983g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692722240;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3UwJzMbkLFZw0nZ0onj9BUDO1u+iqWdju5iLoQEeJmA=;
    b=ps3in1mETE8GmhYcqIeypfXdTHD3fBRM0tVLqmmj3bUBwIiLJVXfkeksxudMrzfAky
    bFpL7XjNIQbpChGniPyf4iGnY8C6e1H64wsrJSKfM6IcnS6kJdY0mpNuCP03XDDsGXOa
    pfITe6VHuz0FSkCHDnyGI3snZlUQpT8/IEqmgR1ZI91VMsumEyU3WLWIlsTE4Gb+jbGz
    JQIe+vPyaH/bA66CyQnT5SGZzea0GbC/Z5F8lAx6aEOZdz/t95CxnPFK1S5s/htRp6xm
    TDVNXfq3E+AXvihXMsKPjmCfhHVbd8DY7lTXoht2jTMoXjXa7XnFBCncNWNEIJJGQ71t
    Nknw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692722240;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3UwJzMbkLFZw0nZ0onj9BUDO1u+iqWdju5iLoQEeJmA=;
    b=PgouducNIKqjoEDrVlxhxebFSFBhQpj1IYN05CYgdfet3ODykxU559rLGi30v/EyUu
    8uh9LHUTkhXITXOQ5Q04AFi5NV690++Hy+BJENSXA0Jmemt8z1CXvwkxSU7W47LlcKo2
    +ktARgzEPV0D2kqS/xzHxbf/cutXICOQeurKWoo47349muDmJCj4r0AdqKwnwY6mwbaG
    FPmxmmpk23h1rbs5bI0pWfzkFI9QibNb294zUaDNNYLU4RpoDtWEyQV3BGn77h2und52
    QbgkSVUEIycVXg/VBtQmFTc5BlNSDwvBczZizL8NMbgmvKmGD60j3t8nPASA51Q3NJaN
    82lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692722240;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3UwJzMbkLFZw0nZ0onj9BUDO1u+iqWdju5iLoQEeJmA=;
    b=3mGb9sYCCWhaTkmznNezAs5xfK2/JM3XiM2Wh4OCzDT0D9NwPsEqx2gVDWs/Qra1jV
    /bSzEasiFELCb67o1aCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7MGbJ3h5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Aug 2023 18:37:19 +0200 (CEST)
Message-ID: <04fd32bc-b1c4-b9c3-3f8b-7987704a1f85@hartkopp.net>
Date:   Tue, 22 Aug 2023 18:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
To:     Lukas Magel <lukas.magel@posteo.net>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
 <87cz1czihl.fsf@steelpick.2x.cz>
 <2d8a4d46-f1e4-4e2a-819d-6c28ad37273f@posteo.net>
 <577b6372-47b0-4009-b83c-706f9bc7abe7@posteo.net>
 <f39ae7f2-6216-e5b4-1f4d-e01bdee7cf7c@hartkopp.net>
 <f4221e5e-8fee-4ed6-af54-46b8ac0e5c03@posteo.net>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <f4221e5e-8fee-4ed6-af54-46b8ac0e5c03@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 22.08.23 08:51, Lukas Magel wrote:

>>> @Oliver I adjusted the exit path for the case where the initial wait is
>>> interrupted to return immediately instead of jumping to err_event_drop.
>>> Could you please check if you would agree with this change?
>> The code has really won with your change! Thanks!
>>
>> But as you already assumed I have a problem with the handling of the
>> cleanup when a signal interrupts the wait_event_interruptible() statement.
>>
>> I think it should still be:
>>
>> /* wait for complete transmission of current pdu */
>> err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>> if (err)
>>           goto err_event_drop;
>>
>> as we need to make sure that the state machine is set to defined values
>> and states for the next isotp_sendmsg() attempt.
>>
>> Best regards,
>> Oliver
> 
> 
> Thank you for the feedback! Can you elaborate why the state needs to be
> reset here? For me, the loop is basically a "let's wait until we win
> arbitration for the tx.state", which means that the task is allowed
> to send. I'm imagining an application that has two threads, both sending
> at the same time (because maybe they don't care about reading). So one
> would always be waiting in the loop until the send operation of the other
> has concluded. My motivation for not going to err_event_drop was that if
> one thread was interrupted in its wait_event_interruptible, why would we
> need to change tx.state that is currently being occupied by the other
> thread? The thread waiting in the loop has not done any state manipulation
> of the socket.

Please don't only look at the isotp_sendmsg() function but the other 
possibilities e.g. from timeouts.

Look for the documentation from the commit 051737439eaee. This patch has 
been added recently as it was needed.

Best regards,
Oliver
