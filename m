Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050477C56F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjHOBuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjHOBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:50:45 -0400
Received: from sonic301-23.consmr.mail.gq1.yahoo.com (sonic301-23.consmr.mail.gq1.yahoo.com [98.137.64.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB5DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1692064242; bh=e3QLhortNOm7cxp8QR30xkckGB5D/eW4mdIxLYggzUk=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=t9EntMMkpe5u6mIaHIO/pBTiEIixyoobGvvNiHoeAZoZEwCiS97reA4Nu18Cc+F9h1P+AnaSg7BGNzGboHdI7aZsQJU/yFXrtUzeOUKox0hr48huO6kpp2WQDTzfwRsTcGWl0CrvRUJa6K+mode+eWsJFd8+zVmpwHyrV9VXzXI=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692064242; bh=cNn6J8MTh61kWFegHthFXMGDe8gtsxABFfg6K9tr/ES=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PxrmUOrTEcJ33vxmOPNIz2v4p0pStSumJCbDh0/1RSvos/hv4ccwVZB0pUGX0wvHN2PPL/kU1PnRLxkmYUOLp9yFIIJJx4CNn6kpjldhXMW1/+cWZFMgf9Twe7tlKm7FLVjVhh5VmXZEU13wpOtx/PbT/GI4ZZbs6+uTjKO5yPp/XjJ0RWXfApRZT5xBKPCXqUqvgnwL5y8A/uGRtgrPalk6VFcfCm2YM8Pq8Q/Wd8EADKIwg7Bw3p10SPOq7m2d3NtHwb73UFwU3V5YY1bzMPeuhSs99fcknkRB0X+FjmrhxstegTL+J0GkV14HEf6gODcTs75IkDfeYxV/GvF+kw==
X-YMail-OSG: oPHBU88VM1m7pmq9hs2B07J2UNGMUtFTMDfJEdnRuTlf4ixMCL.Oups8XwAjiVH
 YP42ePGwtxjYr.fytEqULWqfUrzxCjHwSq7XcyxRt0kQJHqvK2i.ZjaNoSTH.nsmRElTEnkDTG6A
 gIE9usjrJMIMDEwUY2LU3wkaG6MM5NKLtMHU0_c9rDLM.P.Sl1MC80zRGBZr945Sqk_i1I_umk8X
 nfgMZO8_cuMZ5mFc7Ho_VNru.u5sr9VSiYKlL7uqHYO86MAHHi3Ts3fw7MV3voB1WHQG4vviW9DX
 EFlBsIDX2WC.R7DOLvERtr3iaYIhFb6snObIy6Fmkt78_EAr6PRf2CBn0BLtvWh5FtH7MHGg4sWb
 HzkergLf7.V71AgsCMX8sqsY4tErYN18qQ_I7lCPPbeWl3c9hCopQ_F_SOvyZlDecfqHuHyrfOlt
 Ri.tMa8.E1GqIQYBKepQlVwpQS.KbEswzhhPHTSf4FeDgC.jUhIxQnmkffmWEC9ajlKeNKl0kaNT
 EE0AwJ58KAk_yfPgjwFFqdW6VrT8ChGprpcGBJJVwljhxvu6HrZSK4Y2tjx.9qBLgDj.nZKlmJYh
 SRijRgPBG2_7J.jWQ943yorF._HqYVVI9_NZNeRGM6s86.surHp7jpuh3oO4MlIxvoC4oLnkc_kI
 1bS85wSoYHw9V3vmSyxXlpZRzy9KQd7hnijtOJzCQO6XUf6UoNmkwU85SxbpxZbWa0yR8cQP2623
 NY3aShH93woPWFlXJq_U71THchyPyUoIriy8wBdz92Efv4PUr78V0Sgeu9MVCJEopX37AAAGl1sg
 fyfKvQYsrza6Ym6c2OGA6YCjMlTjwnoZatd7oCDDT.PuKCSq11t1kcmLY03QrCwD9ZV_qY_aITEL
 0KNhSa6FHGUyJPY3yPX.BD1R0YTzxdyC9xCJ.hKahQe1TZaPpzP5Vn6ZUXUHtbOu84dq.sgQ8xi4
 _PS9m27es7t57rYrkaeCQaFzDyx5pBN2xTlQNWiWMYhO7LMmCEOI_f7ToEhdwkYWy4TQ1gWwCkSr
 BD8MC87NR3FBAPD6DuRBRnzxdDwD5pRixpRvdQsdFVQZsUznx24o6r7fuz0HlrgAjq_ujjZtmOJN
 1WJ2rbLV0zA.o1scQ916gp.xo2gCaDYuhkVRwrCshD3sJ2igUAW0sTytzaqWo7TKlrcWu0tYNbYD
 S.WQgP0dRDr88HqwkAYwxE7dZyf_XxZ3DYY4ZIkazlyFR_OttBm5NFvfDLW6wdK.ARPfKhQUpq9c
 yBQIF7pwPiT61x9DaL8FDvExNP9BlP_fsuyuvW1UFngelhSWt1qvhdNnWM.kdeJ0bdmzlkyxBkZa
 O9Q7K8L_Igd53dQIthOYMQer1HD3gXvlLC8eZBlOuD7F7oNh5AlI6exZtjCsWsJxA1bfTAGC7JDx
 R5DvE19oXwQUxjE31aTMHIHN4ykW4n5W_aVCopH2S3BYBwaY1QE_1AmNsRIPcMdsoCD4dAmPCarB
 cM45xyMX1PRIqmXbaCiF8inmCqux3Q.Z4XzO25p8dNYiJI8kHS96HxXG8l3Os6QsHTciJ7FNcR7y
 cEZJYjjWeYMm5bs5VI0cd.nlBcwEPUrpYYW4oo16QPXtf7ynMnEB1RXEWOphaUeK8m.O5ndNlhl3
 UcBq7AJaIx7Oy2AUlW_8RMqMNCXSdN2KuH9hfMzG3zWpPzkM9bL7PrxnzNTIEyU4UFQ_VlSUmxiN
 lfdOsbl.oWaxThJVVecaUUd5sXm4CEHaegSnAzM28.tb3paDlYcYceoabnqS1lIWqFDtu6clNtEF
 4rLl1yXD7fDTPYIa_CJ4Ul2k2DlrwtXufmyoKyBDzjvsK6wQypUtEOg6N98XDkUnkobY1pD_rw.M
 elptMLFZwYI8Xyja0yeije44T6_s0RAUuVPfe.T0TZNtGs.pHGvjuXsKqB12KxlT6XMmS.5I55ii
 hT13s5ZhKhEGJroj2BplVGhs2FTYlgXixV70U4fqJlgGhMEFA4QaAp636r466qpdCG7X4VEW5WqJ
 IARFjDZCTB6xXhXl3GrTrDXsmfX2vMmCM0l8h1xb2g1sghlpsug3Wszp.0QAG.BFNeK0TgNiGUyk
 4p_2Z3h12H1qYGlCU3OlP0N0X4XidEYygGKHLLd9QZE2kHu7dLAWB7h5oaQUCna9fuYuPRwbisXY
 MuH4XbBrWDZQriUEAm.ttwnJOIUAmm1UQpJtq9476Q4KGdA0Ner7pnOTCY1BjAucXTneQ5wvFTWg
 67yJuhSnTjxbyoNTFxOdd5_1ebF0KJJMyTn.TdH49.4LVZM9qEK9U
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: 18c4b4dc-ecf3-43f9-b31c-d850393f52d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Tue, 15 Aug 2023 01:50:42 +0000
Received: by hermes--production-bf1-865889d799-g7m4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ae2623078254bd6ae927e5f772d8cbf1;
          Tue, 15 Aug 2023 01:50:40 +0000 (UTC)
Message-ID: <edfeb028-02cb-35b1-e828-9b5931c8d65a@att.net>
Date:   Mon, 14 Aug 2023 20:50:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Failing network hardware
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
References: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3.ref@att.net>
 <ddbed5c6-4ded-df22-fae0-bd256e40d6b3@att.net> <ZNrSwBqP1vPW8OKz@debian.me>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <ZNrSwBqP1vPW8OKz@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 8:20 PM, Bagas Sanjaya wrote:
> (fixing up netdev address)
> 
> On Sun, Aug 13, 2023 at 01:53:58PM -0500, Leslie Rhorer wrote:
>> Hello all,
>>
>> 	About a year or so ago, I upgraded one of my Debian servers to Bullseye,
>> and it killed the 10G NIC on the server due to issues with the device driver
>> in the Debian repository (it was missing).  I jumped through all sorts of
>> loops and hoops to try to get it working, but I finally had to give up and
>> resort to using the 1G interface.  Recently, I tried a new install on a
>> different server to the new Debian Bookworm, and it worked for that server,
>> so apparently the issue has been fixed in Bookworm.  I reported a bug
>> against the Buster distribution, but it was never fixed.
>>
>> 	With that in mind, I went ahead and upgraded the original server to
>> Bookworm, but the NIC remains dead.  Unfortunately, I cannot find my notes
>> on what I did originally to try to get the 10G interface working and to shut
>> it down in favor of a built-in port.  I do recall I tried compiling what was
>> supposed to be the correct firmware driver and also changing the udev rules,
>> but I do not recall the exact details.  I have tried several things,
>> including re-installing the firmware, but nothing seems to work.  The
>> Ethernet interface does not appear on the system in order to be able to
>> specify it in /etc/network/interfaces.  What can I do in order to try to get
>> the 10G card working?
>>
>> 	The card is an Asus MCB-10G_PEB-10G NIC and uses the bnx2x.ko driver. The
>> system uses an Asus AMD-64 motherboard.  The bnx2x.ko driver is installed,
>> and lspci shows the card in the system, but ifconfig does not see the
>> interface.
>>
> 
> Too many moving parts here, hence allow me to rule things out:
> 
> If there is any of your system haven't been dist-upgraded to bookworm, can you
> confirm this issue on vanilla v6.1 kernel? 

	One, named Backup, is a fresh install of Debian Bookworm.  The NIC on 
Backup works just fine.  The other, named RAID-Server, was upgraded via 
dist-upgrade from Buster to Bullseye, at which point the NIC quit 
working, and then from Bullseye to Bookworm.

	I identified the problem on Bullseye and submitted a bug report, but no 
one ever bothered to fix the bug, which was simply the fact the driver 
was missing from the Bullseye distro.

	Both systems are now running kernel 6.1.0-10-AMD64.

> And also, can you check latest mainline?

	I don't know what you mean by that.

> If all have been upgraded, though, you need to reinstall bullseye
> first.

	I take it by that, you are making the distinction between an upgrade 
from an older distro and kernel to a new one and a fresh install of a 
distro running a 6.1 kernel?

	I definitely do not want to re-install Bullseye on either system.  It 
would break Backup's NIC to do so, and it would be an incredible mess 
with a potentially unacceptably long down time to try to back out of 
Bookworm on RAID-Server.  If I follow your intent, however, this should 
be unnecessary.  I have one working fresh install and one broken 
dist-upgrade from a known broken distribution.

> As a side note, when you reply to mailing lists, please don't top-post;
> reply inline with appropriate context instead.

	That is my usual practice.  It has been for many decades.
