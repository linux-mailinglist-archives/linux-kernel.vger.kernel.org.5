Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983C781F82
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHTT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjHTT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:27:51 -0400
X-Greylist: delayed 176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 12:24:04 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2352C3C0A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692559263; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IidOfcG5Q0g6nk1y0QzKmu2r0fNYEwtVsvFt6i4blWDQYC2DKndqSvq2l9U9frNS93
    1t9Y9h6AAbNUDAUAe9LNkLkOIEERd0dZ4xW0QZBe5qo5VnieQSeWn9rCiBcuG1gL8jbH
    hDXUfApFNeYKm+mnzh/LCOcLWnWJYxo4M1vJ11fyT4dvB79cAJ2mscwGQUa1jJjANpv9
    81mSGN8O1J5Ol4IXiS2OqByQ6MBdK3ZdO/LPEMrc9p876T2bA8rQaqbXH4HIY6jbCoLe
    jLg+YVvlVr2KCBYkORqX+YrA7EY0fR2hzxBoN8U4jYCKETRW4JP77sOi6BMlWZE6BHjf
    hXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692559263;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3qXNFAomSv2Uru69C/70SX8XeWDv1RjFidF5e+vVMco=;
    b=MDiRcxVPp5tqAmcx3Ze8wlb7b6nlzmFEDmu6zupTcG6fsoKA3x9S/iz+9lHj1JLS4l
    GyFXUNG9ZBLI4j0n/1EApoxTwLygC7QxUDz5EksTHPEfkFJmTYCSEf39vDhL96FnGSfW
    klepX+wyPPb1+anaTrbUH4AwV39R4SztorjX5/2qoXZUVdYBTiwQk3c3Z7LDG5uZG7qp
    IsvmXNkFrEv7AMVPijjPWIzyDOKQ3f97F9vJUAY3Sg726N5/2zIOONgrDyGWGXggGdmO
    CMM/emacoRc3AIjxhE4ByWuxhoSiP+8cxbjLu392bjUGh30lRqQMyzXk/KqwscUxj+rq
    r44g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692559263;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3qXNFAomSv2Uru69C/70SX8XeWDv1RjFidF5e+vVMco=;
    b=BZns0Oa2NJ5/SI0hubkisKWXap6YZ1MSDtE3Jaa7nipHQIiuuPRi0M5TjwufsRev6w
    Koxe2ifwYKyXnWCrtFXBqlmzDuaHuTRIk7tKirgNaNNiXCAGbfM1ALCh668yszim4L2T
    XU7GmKDNMemKhPa+YYryBxWaXpPk/kA+kNIr9Lweg7lPz7kRZnpm25kQH3ASfvnMk3U2
    moIeA483ox9qwcbbZOYwrzhHMmo6YCU57LEoV/2DUuAP9cgLkydNRPh/RNT0b8EOsZDh
    V9f+YdAyf+ba8MHAT5JYu2DRMsaMACN0uLaFngRUAxDGM1oKRwJBoDbhKDr1wBLFiqk7
    Izdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692559263;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3qXNFAomSv2Uru69C/70SX8XeWDv1RjFidF5e+vVMco=;
    b=xOTrEKBhWRV/yuB9KCYuzgmynq+6fi5Ha+DxmdBAAlDh8ZF9fZv/9+E3VqRUFc7Vxs
    ApQsGOqipRNHE2ZVAdDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id Ka8a06z7KJKx9Dk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Aug 2023 21:20:59 +0200 (CEST)
Message-ID: <cca27b04-8b06-78d1-fe0a-50a10dcbebe2@hartkopp.net>
Date:   Sun, 20 Aug 2023 21:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] can: netlink: support setting hardware filters
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        linux-can <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230817101014.3484715-1-martin@geanix.com>
 <20230817101014.3484715-2-martin@geanix.com>
 <20230817094529.68ae1083@kernel.org>
 <CAMZ6RqLvbp8EStaSRFQUimhUMpn75=3pkQZYspnP1gYRsspv-g@mail.gmail.com>
 <CAMZ6RqLmNJ0zL9XO9zGCu=CbUHgm68M42fwqkSKk-rSAosCWzg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLmNJ0zL9XO9zGCu=CbUHgm68M42fwqkSKk-rSAosCWzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.08.23 15:29, Vincent Mailhol wrote:
> On Sat. 19 Aug. 2023 at 22:10, Vincent Mailhol
> <vincent.mailhol@gmail.com> wrote:
>> On Sat. 19 Aug. 2023, 01:19, Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundebøll wrote:
>>>> +             int len = nla_len(data[IFLA_CAN_HW_FILTER]);
>>>> +             int num_filter = len / sizeof(struct can_filter);
>>>> +             struct can_filter *filter = nla_data(data[IFLA_CAN_HW_FILTER]);
>>>
>>> This will prevent you from ever extending struct can_filter in
>>> a backward-compatible fashion, right? I obviously know very little
>>> about CAN but are you confident a more bespoke API to manipulate
>>> filters individually and allow extensibility is not warranted?
>>
>> I follow Jakub's point of view.
>>
>> The current struct can_filter is not sound. Some devices such as the
>> ES582.1 supports filtering of the CAN frame based on the flags (i.e.
>> SFF/EFF, RTR, FDF).
> 
> I wrote too fast. The EFF and RTR flags are contained in the canid_t,
> so the current struct can_filter is able to handle these two flags.
> But it remains true that the CAN-FD flags (FDF and BRS) are currently
> not handled. Not to mention that more flags will come with the
> upcoming CAN XL.

You are right with FDF where we could use the former CAN_ERR_FLAG value 
which is not needed for hw filter API.

But regarding CAN XL we could use the Standard 11 bit ID handling with 
another flag inside the remaining 18 bits.

The general concept of re-using the struct can_filter makes sense to me 
as this follows the widely used pattern in the af_can.c core and CAN_RAW 
sockets.

Best regards,
Oliver

> 
>> I think that each of the fields of the filter should have its own NLA
>> declaration with the whole thing wrapped within a NLA_NESTED_ARRAY.
>>
>> I also think that there should then be a method to report the precise
>> filtering capabilities of the hardware.
>>
>>
>> Yours sincerely,
>> Vincent Mailhol
> 
