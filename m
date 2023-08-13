Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1B77AAAA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHMSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHMSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:54:04 -0400
Received: from sonic307-10.consmr.mail.gq1.yahoo.com (sonic307-10.consmr.mail.gq1.yahoo.com [98.137.64.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BC1709
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1691952844; bh=GdslDEyXLh88RZSGn4baOneEKFA/HY744dJtvSREcv4=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=dr7yn37ssOveQ67p2wrOzKcgpGp6fD8vIhU4sAfWzRAHc61hVMaM4qUKIxE4c31ErP3s+5CcWGJvcsFH9HB7EP2FIOtEKUKPB8CeeHtznEQf+QN8n6/pnbKW8d9ZNLCkhcwpPIs774rDhNnJDAioitez4iZE5rNLiASDeWESimU=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691952844; bh=sBG1b7Uto4m8jxTD/94st2Cj3J3SXHw8PAteVVkCinB=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=aF4rooub3IS8+KRkgSyoqiyuoGvXYa6/eZ9IpF4QTrf9wyKtBj6d7GlwGEn0iR9w+aQBaLDp2yZDkuSzKUXLYbboCNCV1WZKc9NO85gDd4sCqxodt/DilTbVm3v2tct5Dqv6Tqj12dJTRoq5G6O+rbxhFQ4di6PL6UAopNNbHfdmS19rRLBWuTHGiB+L9Xry/VrXsNtAhaZL0DtlinC2fbaxS5BVhPKS5S+5EqV4f6xWJjGHJ7tu8XxfViSCyOrrt9nZtrUaKksJHUobcb0KZsEfXEQVNv2HMnSqheXt4cqHTaNZsLJ94z381d8Ms+uo7RprtmFL5WWYbLaLic5duA==
X-YMail-OSG: 0Xhxp5YVM1kfMS6MxbIRepT23P72fSRJXvN9TBV8.3G_cuHYEa8hd_2oKaz744U
 OXrY1At0vKtzuuVlTv78ZxDg2aU4f3GmQ2riPiNaJIqNS1epVEJYokvSduLzJq9roRiOYDHbIxil
 t_9mnKILF5hip1XMMw4rmBfEEFkoiVvZDoX9_Sv9Y7O07Cnu1liMxAvf1JU5qSkyNg59LpnEFNKo
 we_eMujSOVLZK517osCD2DHciRCpeDyzpzS5bzKvYiyDlbXzON.XLY6P9fIvuJTDfoLhXWfVt4xq
 Ir_I9yQzKhkMWSl1ZkFsdG_3bmzkRvoksNTi59pbeXeWR41VA_eRjjU4fIomXxNezY.O6UWXVNzg
 Y2W41NABfjIu0532ysYtGkzyi0s7kdjr9bbK7pvo3thBVD05h2AfY7Vy83L1g_U.NPdOFIEWZK3P
 T8XovOn_Ps5IPGY0VoSBHKs_5ag1et6VkM7vtaWV2dTzaiAnu3wtsQ75mAv0zdJ8Nwq6vjysOb0j
 jHLVg8HtTiqG7sMGG9nejaMxYt.NQlUvlftZPTStmCF6d6N1sBN9x.8l2MvlLIzZAhpojKl2jLzK
 OrjPSzYgrUXSqnTnz0kgn9qlWNcre2J.wFulzwgBYUP_VcsOUbN68iNONkBEOIV86_CPNeS24T34
 7nuNkOmqwmCD8ezr0RcwSEwya_PBytAddLxxrWZzjP7sJt3CjeTmqk4.xmQdxZLopb4JCmdQYBvF
 syN_HhufKlqWQJfepoLZ6z8WyytdKUM9LPXi53Aw3xgW851nXR1rW7SQ.nX773vkoIMqXnrNu3tL
 xxiICBWESh5YfEVzNioRU8GUtrTHPPUiOyz3fdL3TRIkxu.l7zKOBpjfnvelgym7jdjndRgfAfgV
 VniKj6emoZHIRIQum0bQmr605if4.kld1cWkqTx94lkPtaVPnDmdDCtBd.AJk8R.ub6s3k5Rwn0E
 ZUw3hj3F9h9eVRNp6Z2WuqdcWug9Qco3MSRBnWbbK9OXxs48P_5dxAU4pFkclJhEF1IIzwdUJKXh
 xNrY1cVXFK5g62YqIdTxyIrM_t_tjHaWW3piAPqCjwcm7YDMH8KWFPjmHYtpYfsDadCewl5hkVwh
 yAx.AKAQy054Ho7dDzCJOkrJN1oWClWcrtaQ5htH3h_.9bSgC3fFurohn52MtqlXASU95LcoOUkI
 cy0FOy_hpRaRHJYXNmIVpIQB0EpznfJ2MgSb0WnxwLCNC_t745Hgupj4VztJfAfj3fMSMvv6IzmK
 MTU1XSqJrwsiioNK5fT1pQSUNiNtld4ZCg8j3XchYoF.oL0Z7aBv5WdyeQkEOYiUQ8naftceOioo
 ri0gLHVCcJv.NAVOHPU9MQ2wknXUY9ahFFh8uaa.aSG6YkdG.K9rG.VmVdOR8sHQ7iueHB56tLor
 ohWDv3TqaYUc7ZbOTFwE58sCVU8Q75GABoWRDkGrhxMxbhij7.tBH5ZMN6fPsOOzzI26nku3aB3n
 nVeEZZFpHOootL0eqCfeuJoAt2v_N5S0rQO3A9CAhSQ_KKo0_7XshEjjg2QvZvzwZ79Kvcoz7VLy
 PhuM_07QgZavZNTp4FBppBJJ8YWtbpGQrzHNPrA2uoFAECKAac6jipaPKehVXaTWkAQop6MYauHA
 cgbEDz7n8R7H.5urqSwqqIX2w3ya57MsImd.ih6R3GHk6B0NT.lJN1dOSN1EgaDYteXFd8RYDAVh
 k.KYtsViTVwyPPQdoqmMktC2TwdyweUZGECpFBWL...Dd0tgTUOk0Jw_Ngu_4kWlcR9blmLnFzvs
 HgtwxhTIMI1d.N8lscxqz0x_1jN5mXhakklJ1UVHUgqMIxKgwNoXZd2Vy_84RYdqdDE00UlHCChm
 AlrWYUiWnxX3XxFqTpj8nvxHOri8.9Z6M7SG4vx7axZsSupUzA0MQsh6.et0QA0nFe_TkB.ERXNV
 YqDQz0Rzwj9RwGTttaBlr4K0wFacXSKLhHfQhOKGEbF1tKWyp6ZTU2cbxe38QYb7.bv8QgMegH8h
 JjDV_Wt7ZMJbvnpgvLwlX_1BGQqBhwOnQlBsgRVxI4H0uKraFij9IRQyBqA3JEPpTy3hUfsAycDR
 XgDyYkJqYdfOiorI8vPaXq9O3wBBQhzXdNfV0OOE7flhdj13bNQH1alYBmdAcEP2YoD27a8dZIct
 UOyF3UjXtGpAFXmLf3wzcORiYWh044htgAvpdqkl0nReEA0nRLgebwJfJRNcVJVjCxt8YgWqHWIs
 Ph9oWzwK1OmqNGaUKDlwbHuKLPAPP1Ap5kW3XswM1h2CFLAVOL_7J
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: 61dc3191-fe8e-4e0f-b54b-4e79051d45c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sun, 13 Aug 2023 18:54:04 +0000
Received: by hermes--production-bf1-865889d799-7vf9r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4a877a590653e4c750807e3ac1d52164;
          Sun, 13 Aug 2023 18:54:01 +0000 (UTC)
Message-ID: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3@att.net>
Date:   Sun, 13 Aug 2023 13:53:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Failing network hardware
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org Ariel Elior" <aelior@marvell.com>
Content-Language: en-US
Cc:     aelior@marvell.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3.ref@att.net>
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	About a year or so ago, I upgraded one of my Debian servers to 
Bullseye, and it killed the 10G NIC on the server due to issues with the 
device driver in the Debian repository (it was missing).  I jumped 
through all sorts of loops and hoops to try to get it working, but I 
finally had to give up and resort to using the 1G interface.  Recently, 
I tried a new install on a different server to the new Debian Bookworm, 
and it worked for that server, so apparently the issue has been fixed in 
Bookworm.  I reported a bug against the Buster distribution, but it was 
never fixed.

	With that in mind, I went ahead and upgraded the original server to 
Bookworm, but the NIC remains dead.  Unfortunately, I cannot find my 
notes on what I did originally to try to get the 10G interface working 
and to shut it down in favor of a built-in port.  I do recall I tried 
compiling what was supposed to be the correct firmware driver and also 
changing the udev rules, but I do not recall the exact details.  I have 
tried several things, including re-installing the firmware, but nothing 
seems to work.  The Ethernet interface does not appear on the system in 
order to be able to specify it in /etc/network/interfaces.  What can I 
do in order to try to get the 10G card working?

	The card is an Asus MCB-10G_PEB-10G NIC and uses the bnx2x.ko driver. 
The system uses an Asus AMD-64 motherboard.  The bnx2x.ko driver is 
installed, and lspci shows the card in the system, but ifconfig does not 
see the interface.


root@RAID-Server:~# lspci | grep Broadcom
06:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme II 
BCM57811 10-Gigabit Ethernet (rev 10)


