Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2166B779535
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjHKQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjHKQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:52:08 -0400
Received: from sonic309-24.consmr.mail.gq1.yahoo.com (sonic309-24.consmr.mail.gq1.yahoo.com [98.137.65.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719B2D7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1691772726; bh=9yRPhWfwjZ+Fj+eI4AWFqnJ6OvjUNvQ1xZra4Vx6iCo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tt/OSXPi68pKZswcnqcS/2COZuQp37VTPwX5zVHd2QjDy441lRyzQF8JU/KWtxMbcaRw8hyA5YY2qEtqwSrKz22KANRzjaHZg3kc/UVRYqtt9JmO5732C1WoRKzBpOE1KgGRJKoiigT2XSHW/Uw1FF4TjxSY9YxkyqlZ7ZibBLk=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691772726; bh=YPw8IR4Y5CS1GCa34jNewXvahTvzaqZYKkFC/FzQzPC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CQ6JNz7mn+dRHZGiFbpjj5ObVT+r5ZvuYFLmq430fEUJm3yjNDEIdXEVidy4r/QF6K/VkIXqTZ9VeyU0bICD7v6y8H436C8DG0ZnMgu/b7aUfGKucFEMAdWkucJQzT1KiOxYaEu97TucuePaY/jW58nSbnugFH0AGxuTLRG/APtOq6rfeVX6FgxL6fQuc5Z/Gm1Z+e00E7gRrD0ClKQEMFQgDJPLWGGIy9sKqsKB5x+Iggvj9uD2dW+FOedNWKC78ASDz6bdbAnqs+NeJW58WNbzTr2OQ9/8TUm9G7a+obJUvm4uUUhJqEi5B+WM9hKtUJDSa+DuJhhKFVn5svbo9g==
X-YMail-OSG: BUvXCx0VM1lZce299u5_JyJaNkh3VBhNGRyBWhfuAdIKrGWgkqTnoKrtm4cW_eP
 APN6a2edkHkQfqPVNkCcIXWVZ4zRk8mZ3w1cyWNtwZ8u9CCJp8yk4VIx919_PIp.MY.dXgv3TOxC
 oyUH_8i5Mvk0S5oIpLLdkpaDmIBTYW.5swX3KNFe3JRDoqYTRrVLs6mORGDqq.6wdjeVjMgCnE.b
 Bwdfazq03oc05Ff6gjtBOmbzcwdpmTEkYa9qHFAqaLeGDoBEq7uKljrsToXjyYL_Kha3BzxV1VhJ
 N4NjKHxw6bncrwqKKETB9DWU7tAdg3EO7oFiCjY.6hjhIR6PyG6_9oOE.4DMaG26j463MUa4crJ7
 XQg98h_Twap1jvv2UJOmfWEK_K6JJyAI9cBItL3dFnr5u.vn6KU.jCag0e5_NBQS_UbaH4n7.ISB
 44HBmPrZLbpySRqISGp0qF2UdGkB67ZPIxxxao2HqEPMF2oVWtliCFcq2gtZNrDuCcfaQIV09WJb
 vZ1Q8H5Mv.bO0h_BlrP6JdAe0O5DM9B_XAEPJPuuIwFsN7MFqbVS5aN2ZhyOSUNhAS5R65SDFgSx
 cHtZvf0rn3JeUTudyZFSrHyhgiIxMi1dFlsUhx04U7u4KXvr7Cg5j_PLfxviGl9owh9kRdx.vZCy
 yQZkR5ylN0cSfSEst8NVjo21yA6UZRQWALF7gn7yDSUhIK5kaNjc9s97yiwYDMHbAHMQdsoN_KiY
 Gmaccu.27UOGMvnqrbvNeTuDTbUXvgNU.CDF_Ol6cHY9VxYkz.30xcf9Sm_jo2sxw98eP4pwK6jx
 gelS5up_30ysJKGY8b.7436bda_p3RdqgWe8jc5wD76XAjTFKiLiMNcehBSZVzr_Ktbg.Ho7iBsx
 iLH821VT9HJy4e5hAk1CI9UG3xRPjXGhlfdoAfDGchCUXJMWi.CWoG4IFgqUdlLXCgvQU7..bNKW
 NhJCg4nSBLARHRwk20iAXB368n.ZW._q2fWYGyYs53ISIDCGJp6uX81g_nIVwTmDjHUO686mlbAY
 NlgKm.BplpQWgofh_M0IiEBd9tnwoDE2hewLiSvU9us_4P.uz0QR0lvglDkDHv_Quv3DjccPfXf2
 QzM65yGqHKTYG9Ld_mSD1FYA0S4wr46XPbB9CQNhXi7zdBrdCX539fUERgortcJHHqFexU9mDldr
 7q7DE7OOgAoolRreRvqR2.T3ooJwwR3x9X0y4PWAI2kEe9dvnYsh5MltmZWIQEqqj7FWyeY34EG4
 QjieaUT8OruYtTcXzWFnPaQUbqt_qGOY2q3wvb_3TgLvHxUtJshXK_772A26Cg0f.rPHVZ9cqNGA
 rKH0BvZNJfyZN5nMsRSNpfahIAl_q9gjXFyocP71sjNIuN6QIL1ZKpPsJrOvhqCGB4piu2Cv0q87
 yAjIOHk8EjPFIjGUWbOEw0.rZpBhfnqENdVMpQACWoGxE80DuPxgqSutRGFV6HRWVZi4_d1ave5N
 kmCKy9TYNuneUCWCG_ccciAj0TLD1.tSRSUEdCBS6uXyWRZ7HuLf9yx3hxYHDkUwS8bUc3_tbLlo
 tanhQgjDRYleZe3T40R8L..TUpROSTdKwz2ish3.dtkDnwJOVxvCOgG2WzgXQ8SYyspIIX0t4iaT
 T3Hlz.IfPu64ry1_FqDVkD_W8C8fG_AzZnMvXYcrqR4r.vEF2bTgWf90k2njL1nT0u9J6.iFeETb
 aLU8aYll08BVIRtMCtEcl9GpNlzEMjmDwRkf5rszu2NI6Hrkx9yDao5Nrd1hAwbqBp4XEjBaQU3z
 vVp3FX6leORhWwx5gNrVSTFlJG_CzUXnUmDTdaH0KPPe5Fbv.74U3sr.NVjIxvtuOy4n_W.p6inb
 2dhkFlNDmYHx8VTOF5uX4jn.ehgD7AAZ5GNMVUjbWCmR94zWQufPJWxh9SaryOtfvQbWUfPM3P7.
 5DJ2evAdLlgsLDwHqXnacMPRz0pDfG4NYb8SnklnP083l6RNOWwh3sV.HspB4tem0ghKq6.yVq9n
 5sOhpy0U3YgP7TxXmsr5FDv.V0SDaa7Q4KTowWe20Txn5EZtahxA8dCa34o1PwX8yItokXbgNrCg
 9IbiYpONItjtmng48RgZoriTky..Aq8cQlbKRTHyvbBUCUy3s2Yy0WVlz9L1Ds5ztaWmD.G7Vj33
 3q9NKdJPjrq.r7UOO0TEHOqcwcRAU6dEQy.bBQu4f2Y377wX2ND80OGz_vurxBlzCxcBKXt.HelN
 AwGhzULkkxztUfRYNs.FMj4IKQ0j1vW.cw2esEh7cTVuJXOMJyyPG0g5KBnM-
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: 50fc90c1-c7e5-411e-beb4-cecd77059b49
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Aug 2023 16:52:06 +0000
Received: by hermes--production-bf1-865889d799-x5klk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 117796502f38e9189e85b86278535230;
          Fri, 11 Aug 2023 16:52:02 +0000 (UTC)
Message-ID: <38c4f2b5-4585-c1c6-cc07-fc41b4dbca94@att.net>
Date:   Fri, 11 Aug 2023 11:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Majordomo not working
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        pmladek@suse.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        postmaster@vger.kernel.org
References: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
 <06bc7efa-c486-f995-a73c-3f1dd6a5ce64@att.net>
 <38f29379-4a8b-3cb0-c5dc-7cb4c8246fa4@att.net>
 <f95da2a4-996c-cd81-5ae1-715d33f577cc@infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <f95da2a4-996c-cd81-5ae1-715d33f577cc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	I had a friend of mine attempt the same thing using Outlook, and it is 
also bouncing all the messages.  It looks like Majordomo may actually be 
broken.  It seems like it may not have been updated in 20 years.  Can 
anyone else sign up for a conference using Outlook or Thunderbird?

On 8/10/2023 11:46 PM, Randy Dunlap wrote:
> Adding postmaster@vger.kernel.org
> 
> 
> On 8/10/23 20:53, Leslie Rhorer wrote:
>>      Update: I finally managed to get a message through from my AT&T address to the linux-modules list.  I am not certain what the issue was before this.  I am still not sure what the issue is with the Majordomo, however.
>>
>> On 8/10/2023 10:48 PM, Leslie Rhorer wrote:
>>>       I know this is not exactly the right place to post this, but I am at a complete loss what else to do.  Please forgive me, but I cannot get the Majordomo at vger.kernel.org to respond to me.  I have tried everything of which I can think, but the Majordomo will not recognize when I send it the authorization command in order to try and include my siliconventures.net address in the linux-modules mailing list.  My att.net address is supposed to already be a member of the list, but whenever I send to the linux-modules list from mt AT&T address, the message bounces.
>>>
>>>       Thus , I seem to be having two issues.  The more immediate is I cannot get any messages through to where they need to go, both to the Majordomo and to the linux-modules list.  The more important long term issue is I am having a problem with the NIC card on one of my Debian Linux servers.
> 
