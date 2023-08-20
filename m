Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841B3781F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHTTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHTTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:52:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74306D2;
        Sun, 20 Aug 2023 12:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692561099; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cM9UQBCVzf8TCkZEY7/hJFAJjYGxvnJTyWcHIWkHvIybiM3OFdELmRLhcpeUn6U8Vz
    yUMCIXxT1t9U1Y3BsjV78Df6EAFJM3mmivGrBLysCDhRupI1/Nx4Fk8xrnlyRxDUjtz3
    tHHa7Hx0QcZrFsxzeveA9YLZjTIE3UWdHXlKIRdrAR2h8ui260qi2Zbsqs/QEjOfvN7S
    b1sRTJQphjXhldpeW1sx1JI4Usk123zDgjewL+ECyl5TTn0Pp6acY+cn2ExmE6iM3P0x
    vo6QnXnNbdGzqVUr7T+0pMX+aJk1g2DCTYiqiiknOJLpx+B3q3x5HJwyYXAK8AYKxqc8
    g/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692561099;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sdfx9sDLwyI6D9UElyHDXnmu4xGM2WUkaLrAYoKq+EY=;
    b=pmhGuVrd7T0fBbgzBUcK15wn6wzNCTGoKi0Lq7O180p54Tnqw3RHffpy4jiAknQdGj
    b9R3F8MfA5UrSyuVI3GYLQFYMDK+Spy5dZUPACOq8lQNTOrRgpV8uNaVyQoXAGqDCAbN
    DWTjIHEvzWDuK4Swc6gEJdkS0yvz4m1AxVaMpfPMWVLqcbCubh5/5bgg13JAm++fSfVm
    qeT/MXGvV2/aMEvRpapV+Fs6oKocvFB8rlUGF8ws+AcuGhXQvVNoZn2Y9yeFBxMUgPXX
    meNHmFW7/rRWANBSKsr4By0SS2+zMBvZ+k0sWC+ZSLJG6F3FbwMIMzLL4c5q13mKbe0L
    /xoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692561099;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sdfx9sDLwyI6D9UElyHDXnmu4xGM2WUkaLrAYoKq+EY=;
    b=A3aYON0j9C+eRESmR1SD3eQpSH25jBwTFZGm7LmNJUPAdBJbOq1j4qc3gVgUvePYM9
    GNt0hDhP0Pm5gTwTwDZ0i8TUp6Xsi/YWBs7/yNtDM9CA8SyREqfT1p+iwDMAuOOjKlgQ
    9nqSF9OXFF9BzJ9d57lOA0p+KH6jf4u6F4jM6LEhz7sYyKefkhk0fHlqeX4a+6XFKJGG
    leoxQnGaRfAC3SM0zrDzY712RIfwUgWfCa8YTPDHlAb2Zc/jsZc4eAqRJsbg67FtbNJA
    1/vryaonPjny2XLYjbOl201uN2Rat/DYbjo/6lvNoHdBlHSg3D9cDB8ZOmrSQVoezAsH
    h5Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692561099;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sdfx9sDLwyI6D9UElyHDXnmu4xGM2WUkaLrAYoKq+EY=;
    b=lYJJomqDIZtFljzg5THgsqgPKfrGt7jX9O3aRu9ac5FlqGJ11DxJeT8y0n/ojidApW
    7ndl9QX3vgpJLpkl7ECQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id Ka8a06z7KJpc9Ea
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Aug 2023 21:51:38 +0200 (CEST)
Message-ID: <f39ae7f2-6216-e5b4-1f4d-e01bdee7cf7c@hartkopp.net>
Date:   Sun, 20 Aug 2023 21:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
Content-Language: en-US
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <577b6372-47b0-4009-b83c-706f9bc7abe7@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 18.08.23 13:53, Lukas Magel wrote:
> On 13.08.23 13:23, Lukas Magel wrote:
>> Hi Maxime, hi Michal,
>>
>> On 01.07.23 00:35, Michal Sojka wrote:
>>> Hi Maxime,
>>>
>>> On Fri, Jun 30 2023, Maxime Jayat wrote:
>>>> Hi,
>>>>
>>>> There is something not clear happening with the non-blocking behavior
>>>> of ISO-TP sockets in the TX path, but more importantly, using epoll now
>>>> completely breaks isotp_sendmsg.
>>>> I believe it is related to
>>>> 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false
>>>> EPOLLOUT events"),
>>>> but actually is probably deeper than that.
>>>>
>>>> I don't completely understand what is exactly going on, so I am sharing
>>>> the problem I face:
>>>>
>>>> With an ISO-TP socket in non-blocking mode, using epoll seems to make
>>>> isotp_sendmsg always return -EAGAIN.
>>> That's definitely not expected behavior. I tested the patch only with
>>> poll, hoping that epoll would behave the same.
>>>
>>> [...]
>>
>> I am writing to report that we have been witnessing a behavior very similar
>> to what you describe. ISO-TP send breaks with EAGAIN if a poll (for a read)
>> occurs at the same time.
>>
>> Our Python stack uses two threads to do concurrent, blocking reads & writes
>> from and to the ISO-TP socket. The socket has a timeout of 0.1s to facilitate
>> shutdown when requested by the application. Notably, the blocking semantics
>> are handled by CPython, i.e. the underlying kernel socket is non-blocking.
>> CPython polls until the requested operation (read or write) can be executed
>> or the timeout occurs.
>>
>> What happens during execution is that the socket is continuously being
>> polled by the read thread, i.e. so->wait is always filled with one task.
>> This process repeats until the socket receives a frame from the bus and the
>> poll returns successsfully. The app reads the data from the socket and
>> sends a response. Since the send occurs in a different thread, the reader
>> thread will have already returned to its poll loop and to populating
>> so->wait. When the send occurs, isotp_sendmsg checks so->wait for sleepers
>> and returns EAGAIN because the socket is non-blocking although there is no
>> concurrent send operation. This dance continues until the timeout occurs for
>> either the read or the write operation. If the write times out first, a
>> timeout error causes the Python app to break. If the read times out first,
>> there is a race that the write goes through or the reader puts in
>> another poll.
>>
>> This behavior can be seen rather nicely in strace:
>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 1 ([{fd=5, revents=POLLIN}])
>> 110580 recvfrom(5, ">\0", 4095, 0, NULL, NULL) = 2
>> 110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>> [....]
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 6) = 1 ([{fd=5, revents=POLLOUT}])
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 6 <unfinished ...>
>> 110580 <... poll resumed>)              = 0 (Timeout)
>> 110569 <... poll resumed>)              = 1 ([{fd=5, revents=POLLOUT}])
>> 110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>> 110569 poll([{fd=5, events=POLLOUT}], 1, 5) = 1 ([{fd=5, revents=POLLOUT}])
>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>
>> I believe this is consistent to the behavior you're witnessing with epoll
>> because epoll also places a sleeper in so->wait that is left in the queue
>> until the epoll descriptor is closed.
>>
>>
>>>> By reverting 79e19fa79c, I get better results but still incorrect:
>>> [...]
>>>
>>>> It is then possible to write on the socket but the write is blocking,
>>>> which is not the expected behavior for a non-blocking socket.
>>> Yes, incorrect behavior was why we made the commit in question, however
>>> we saw write() returning -EAGAIN when it shouldn't.
>>>
>>>> I don't know how to solve the problem. To me, using wq_has_sleeper seems
>>>> weird.
>>> Agreed. I've never tried to understand how synchronization works here.
>>> Hopefully, Oliver knows more.
>>>
>>>> The implementation of isotp_poll feels weird too (calling both
>>>> datagram_poll and
>>>> poll_wait?). But I am not sure what would be the correct
>>>> implementation.
>>> I understand it as follows (which might be wrong - someone, please
>>> correct me), isotp_poll() should register the file with all waitqueues
>>> it can wait on. so->wait is one and sock->sq.wait (used by
>>> datagram_poll) is another. The former is definitely used for TX, the
>>> latter is probably used because skb_recv_datagram() is called for RX.
>>> But so->wait is also used for RX and there might proabbly be be some
>>> inconsistency between those.
>>
>> AFAIK, it is correct behavior for isotp_poll to register all wait queues
>> with the poller.
>>
>> Before 79e19fa79c, I assume datagram_poll always returned
>> EPOLLOUT because its corresponding send buffer is unused and empty. This
>> return value can be incorrect if so->tx.state is not IDLE and a send would
>> block. With the patch, this behavior is now suppressed. I believe that
>> the inconsistency could have rather been introduced with:
>> can: isotp: fix race between isotp_sendsmg() and isotp_release() 0517374
>>
>> With this patch, the behavior of isotp_sendmsg was changed to only check
>> so->wait for sleepers instead of consulting so->tx.state to see if the
>> socket is busy. Since the wait queue can also have sleepers only interested
>> in read operations, I believe the return value is not a valid indicator
>> of send readiness. Additionally, in this state, the behavior in isotp_sendmsg
>> is inconsistent with isotp_poll. I will try to test next week if reverting this
>> part of the patch could fix the race condition.
>>
> 
> I submitted a patch to the mailing list and would very much
> appreciate your feedback:
> https://lore.kernel.org/linux-can/20230818114345.142983-1-lukas.magel@posteo.net/
> 
> @Maxime, I tried your isotprecv / isotpsend snippet and the issue did
> not occur with the supplied patch. The send operation went through right
> away.
> 
> @Oliver I adjusted the exit path for the case where the initial wait is
> interrupted to return immediately instead of jumping to err_event_drop.
> Could you please check if you would agree with this change?

The code has really won with your change! Thanks!

But as you already assumed I have a problem with the handling of the 
cleanup when a signal interrupts the wait_event_interruptible() statement.

I think it should still be:

/* wait for complete transmission of current pdu */
err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
if (err)
         goto err_event_drop;

as we need to make sure that the state machine is set to defined values 
and states for the next isotp_sendmsg() attempt.

Best regards,
Oliver
