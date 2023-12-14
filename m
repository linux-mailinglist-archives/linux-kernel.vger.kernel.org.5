Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CC812AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjLNIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:52:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F4A0;
        Thu, 14 Dec 2023 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702543935; x=1703148735; i=linosanfilippo@gmx.de;
        bh=nVGZXwaLHN7v4BUnHdEIrojj3cfgCeXb8jS185agoEo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=rbFh6xG4CahoZaL/sMgl/3if2tf0TOBiPvD5QcPYaPhBQJa7G4E3164qwAP8xTor
         lP7SQ9HoO67Y5Yu0Ak6bqCnFm6/yn9aORt4u+Rhx7RXjC7MCAwgD/f9MUY0UBPcIb
         DXUomy83R5yO4VFYeTLtPh2Pbz9o4xrWwhPLMQTflGtPQJzjjigN6/qCnKPMm5enH
         2BDEDL0c4c2QrWErfGFjJjkhynSJ6iKpukgwwBf0arIjeWN59i9FsRKu2MzSmSgRh
         KLcQ3XaxSKNvv0rqYxHQ8t/l4AzN1zjeJPfy3oNQpEHUQ3RBUss3TWLA9f5j2dtt3
         BSAAFsYy/3KZBYRWww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1quwfz0BTQ-00L1Zg; Thu, 14
 Dec 2023 09:52:15 +0100
Message-ID: <d4a7ab35-cb81-4681-84bb-703f2d63fe43@gmx.de>
Date:   Thu, 14 Dec 2023 09:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Il2EdiqegOFeHXIgLDNacYB57UTBj/2H78z8fR1nAnaR3vju0uW
 6wIQlPcrsViy5HQGYy5nBtZE5YIwzfm9uh0syGDS8UF/tbVNz101FncwoIKLt9y+fYl49jF
 jkALz49RAkvCKi6IseMcXFvMhviTdWBYqX89Id7xPh8IuYgOLSqI76R3OSd8xwuE08X/wJt
 /0YA6Iu5jc7vowk6NxGrQ==
UI-OutboundReport: notjunk:1;M01:P0:y73/cztHYiE=;pUtBUjJgBrX8akDqFkq++QJ48kp
 lHZhpzLI/m7EARbZ02k5hbxdJNasRxaPpK4cgYi46oUmfrNw4oORjpEVHsne8ZzeeZk1wYNHX
 3sfXXeIWHkRVQL/Cw81l53RRWdYX24hAKERtjrGWOgQO/Ayt/3IPVQJqK3j5WucVHhDuVMekt
 TAF2IxLK8VfI0K8in9whGxhu7jMWdI0brXwvOlREcJILmfPkQxYmQJsgM3+nB7zvGIEdgzNVX
 awv4lAhG4e7AaUBJl0NenNL9SarGKZJnVlrd+klCCmEpIZnBgCDSfdPxwahVTTK50/D1H16aL
 F1y0nXJg0qI5S5Ftan6vdagZZ56rbWsCotVwIW35ieADZ6NGmyUeLgq7tFsC3ziRYUy+xh2ID
 2EtipEkI3eeJb2bbwxyOXzvHLeXQxGYybyQ7FnYKBno3uzCJIb7KWIDCR1nwVoFM4jvjuhjMY
 +4k39lJV2d/qTcB3p+FDIXNO6HRUpfl3ku5KpgHNt9zHQUYrqfuHt2mszowujOApFvRMfQSRK
 1PUX+FAW0QZuEyrd8i+XCjjBe7uFjNT80SiiDAaQCP9bPaxLy9j4nMNswfq+OQoXNiP0ZlDeS
 QVnRUuI509Tx+6BXDQb5yyWkXuEhCPnLLQ4EX2vzIEX3ofb0HpsyDaXnR6SODZehirtdjU8wP
 O6KVayLdnwg20/7gBLC59v7Ir6f9WSFcSQowWDVQXg0RMEfdkpsdK1pz9x0KoyExyppqtsebs
 LMVzDpqrWnUasRZKW9bI1QFPbAkV+UY/GmwR07yP3U6AHuMLrNQW0xvnxWLjFXKaEcwvjf43g
 Xenn/MLgq9Gvz6iP+scHKpIS0WR7JiXooUk7zRm6eqSRUfzkz+XqCpSI8gKGOLkWc20HKf3VG
 zipRw7ljepD9JEZlgZi5DG6dVpg3C4T+GovEo1+aQIkQ34B1X7yMnp5cJWe1Uy/tvDUo3vCy4
 rYNq+VTcnrqCXvTjEX0SZKlWjL8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.12.23 14:07, Andy Shevchenko wrote:
> On Sat, Dec 09, 2023 at 12:47:47PM +0100, Lino Sanfilippo wrote:
>> On 06.12.23 16:42, Lino Sanfilippo wrote:
>
>>>>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode=
 bit
>>>>>> to struct serial_rs485:
>>>>>>
>>>>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh=
@moxa.com/
>>>>>>
>>>>>
>>>>> That new flag was suggested by me instead of using SER_RS422_ENABLED=
, which
>>>>> would mostly be redundant to SER_RS485_ENABLED.
>>
>> A cleaner solution would probably be to not handle RS422 with the RS485=
 settings at
>> all, but to introduce another set of ioctls to set and read it.
>>
>> An own RS422 structure like
>>
>> struct serial_rs422 {
>> 	__u32	flags;
>> #define SER_RS422_ENABLED		(1 << 0)
>> #define SER_RS422_TERMINATE_BUS		(1 << 1)
>> };
>>
>>
>> could be used as the parameter for these new ioctls.
>>
>> Any comments on this?
>
> I have (maybe not so constructive) a comment. Please, at all means try t=
o not
> extend the existing serial data structures, we have too many ones with t=
oo many
> fields already. For user space, though, one may use unions and flags, bu=
t for
> internal ones it might be better ways, I think.
>

Ok, thanks. This is still a valuable information. So what if the above str=
ucture (serial_rs422)
is only used as a parameter of a new TIOCSRS422 ioctl and only internally =
we set a SER_RS485_MODE_RS422
flag in the serial_rs485 struct?
So we do not have to add something new to uart_port but also do not expose=
 the mixture of RS485 and RS422
settings within the serial_rs485 structure to userspace.

Regards,
Lino
