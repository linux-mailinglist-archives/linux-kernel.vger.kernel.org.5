Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42B77AA9A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHMSdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHMSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:33:03 -0400
Received: from sonic308-10.consmr.mail.gq1.yahoo.com (sonic308-10.consmr.mail.gq1.yahoo.com [98.137.68.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E8710E4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1691951584; bh=71U6scTsLhefxtjdiEB7wKVAw3YauZe2IDKZ1w2/3rY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VzVCwuEm7x8MxuEF1F110mrpmj6i+3jHhVLPUNezMc4sgM4oxB2RJ0dJTFB9Zu5BEapQbej18QKbST9BIR5jGN4xu43tzQQrp5CJw9hFJi6P7ar2/1Jkn4RO8dXwG6kQ1kp96v8/BLi1fF3mfunl+LPCvMCM1PLH+1FZM/j5H4o=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691951584; bh=sGVxM8kuay7M3kRwFjJDHOEOEyAHEs6FxF3fN9vwLic=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZvQ794VzIOyGFQCEdWvOIqBPu+nLIfvW5R++YEZO0qI9qV29lIt4ltv/loJEcIli7GugCOHhVbnRKW0ef8goaiNziVcoLRfcVpQOL8R6uDNLjqN8CD7W07gbaJeB50l30wX9alC3RFKfPfaLc2cN10WgZTQr8UbLpUOh+pKE7Ma+oxQ4VsdC4ubylAEK8m0GIBvawp8Djtp8SLwUUpeDZWN6s3+cG+TFETpgJS9xWkfh3sOO47IzrirtSdgXQPKUzF7GcUGYLo9eJuCVfm9K8OW83KbOq3mpBxMw1gpB9Hisizo1IjwL3k8Ek7NJ3GPz/Fh2XIBrr7AhxFIY1zeCLA==
X-YMail-OSG: Z5f4K4YVM1kDBjw3xsWUcHifDimeKcswv0ZeudfKJVsNvWJnadD9sfnCV5UVpWL
 s7CTDLeBFHKKE_WpGZjtzvroBO9wR1qm9EYzq9WhRGDhnntE6qbGQt3qGiOrGCFfkKHnXVgo6o9h
 a.aO1QpChLgTZ58_wmj.LaaMLGd_gEnX17uOD9_WKo6iyuXudcA.jivqxjweVe2jssOehPdXt16p
 EnkxXi32vgLG4F2jACy0KGx0emCV0H9_pbYFVVYpaNUv_zb.y3T8uen_gaQxMiyq2wJPtM0bAiIo
 QsIchYIVXVXRk1W.1EKeuYOn0w.dVwWKtV_abDNXdeUXhNYdsJuRgeNcS25i2Eq7hHE3OHE7n4XC
 ZG1usbElJfbZgzjX7CC2nxLahYGV_99QeVSZoKL9t6ZDZI.99W310leL4MlEIDa9DbUu5OhpnyYs
 1B5lwUqWIUhKXEDwaygcvI.dfjHMjnwho6AbOz9ym7gM4QnFNRNSSCQ01sQFYQVbsthT9Vow5PkS
 PAJJHvFlsfF5Dk_YEojbmu8fNTSIX34746DlNSQKV8_2hSCKcx0k4D9MnHVLS68Z_MNHiml0Z.E.
 PXQ3ofOzGgbfxZixlvB2PugIGsz2hSlvzIVOWok9UFRSKDGlWFD2nyCiUbeXbZZLgHwa4Vm5ppSu
 JbA5KblGwN02clQPD75DZBR7Af6QKcoxoU7PSBrDeOI1bs_4V1AF2utE0F6FuLZM5GjnFexe_GYR
 bSdXMDH.sgDFYwi9e60JJ6u08EudKj0Z5O2G.k_or.l0_lZEc0XghtIcmHSwNlR2WdrWcHMjezM_
 sHKeahxOX4zJeY.yFc6JqCE6_xie8ckWtG.eFC1q4Ds25dvsP9gpVZMk5fmltNt3CqHoNBsduli0
 lcGFtq7XlfJu4SLQdyuCg.M6NiIndPPpqC9w3AfzVD0UVmNm.FHK1zpvFxKPx2MQq8.75J6My5Mm
 yW31AolXivabPu4H_5rfAznavxR.X4rJxk6Q6let8xasl5WKND.AC5rSHWqFODVZULd_I7hATl4F
 WFdoHt_ij3EF4gG4HaFS5g5xsy.tYf7oAwv0cs1Cybt2qtC0IEfxbuHcu670.BRGTGWBv4SBUxBd
 W6XPtD2p36.wRC6.yxyBUdKTU9p.7W4ZmpXFH31oLyMJ73QqXMVQJ_r8zq8mkBUv3Ebzkmxtifry
 qVxtFrDFBsqlq8A9mEldIMjQ0I3tizSb5DYyH2jtQL79Bv4s_xr0t2cnZbzgffq1AexuIpHOcZ1z
 WIL0c7yzDYR.JdPSuVQPuuR5JPe3Pzy8ywtOoMO762FBYUom4by8JoEX8Ovsoy6289xrQcRNh.wn
 URhsfCpkCADiXpHQetP_OwwHgdEUfmz5KVYzsF9g1eRtAJ5vz7SIXA2ZT72XlEPFSup.pa.cerdr
 PE.bLmv8urukE0AyyKZAuntpvk7Ng4Q7WTyAbWhcgjRSX.Hca7P823ngKFD19dQb.unzu47OpvpN
 JTF8aY8XdjHwqmakYExeYflqYU5Vpm5CZocQRal4Po0pla.HvPIjLwLZ5Zf68lSX2bFr0mhveDlw
 7LffSVAQAcY4Fct6WuEklqzH2VwJdxKxmHMNppp0XaEwc8tKtKn9sCSQMo12WF9p9a4O99l_lwMG
 adS5M_Ebt9rrKsv3fJaHoxG50R3sj.pPh.btjVoieC_ufXLk78prXE70E2myr5yrk5T6dcufOXTy
 jXWbgoIgh404prF7Cm8NEh4U1xV7k2COiO5xofFHNQTHBGBNP0k7fsD43OUNB9cnxVwn5OvkZNVf
 VxnIfH50dpmxno6tr8IHrUy4XO9bP7oJQz.PX78aMW8HgXwGvL1uB5FD7gT.4V2mPIj2xDTH7VX_
 4yV19aPZVwELFqi63bhuV0FJZiZW7Vu1l389fosJqfKrU2pEHwBxRw9cWkQyfhgneZbu2HjjgFY6
 gMf.UrhTwrTUTkGHQNTsTJmkN8ebw.YJRanXgIBXFprYCvHaN0r.w7z9jMKsAJpSbMACdSbGi9nn
 0e2Rs..SDhtIvpZV4pvyBzG5TNoPOUFJIKn18BidPqwDjVJW3HJuSMyURejbxF0hYhPqkZEq0qYw
 hNUe.wMM9W6cT8KOXoRFmod4DuEJ0V9oNPtkYSJMxYjcpZeZdruR.ZNR3Avzgn2QFzLsS8j9sm8G
 i6PLVFBpu_unEZQEyp_cogKsG64VULeTgMlVueePk92WqYAG__YtIG.__oyQnKrava2Jp87oAzgx
 Bpepn1Ih0NvCVrRP5VqlzN86w0ipm9S0H0gexgNioW53KjQtHXGSol0nr
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: a4f56d3b-992a-4b02-96e7-f264c2ca79b1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 13 Aug 2023 18:33:04 +0000
Received: by hermes--production-bf1-865889d799-r6v2w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6730b73f9673016d70bfd2d040112d33;
          Sun, 13 Aug 2023 18:33:01 +0000 (UTC)
Message-ID: <09d9262b-17be-7efd-9abc-95914aad800d@att.net>
Date:   Sun, 13 Aug 2023 13:32:59 -0500
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
 <38c4f2b5-4585-c1c6-cc07-fc41b4dbca94@att.net>
 <a50a9929-936d-4b4c-0f37-ea5082b96af9@infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <a50a9929-936d-4b4c-0f37-ea5082b96af9@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	So have I, for many years.  Through the years I have subscribed and 
un-subscribed to quite a number of different mailing lists.  Something 
seems to have broken it.  I just now tried to subscribe to 
netdev.vger.kernel.org, and I am getting the same thing.  No matter what 
I try, the Majordomo does not recognize the authprozayion message.  At 
best, it just re-sends the email asking for the authorization.

	I am having some fairly severe issues, and to get them resolved I am 
going to need to join netdev and linux-kernel.

	If omeone here could please try it, it would be appreciated.  The 
authorization request is

auth adfc895e subscribe netdev lesrhorer@siliconventures.net

On 8/11/2023 11:55 AM, Randy Dunlap wrote:
> 
> 
> On 8/11/23 09:51, Leslie Rhorer wrote:
>>      I had a friend of mine attempt the same thing using Outlook, and it is also bouncing all the messages.  It looks like Majordomo may actually be broken.  It seems like it may not have been updated in 20 years.  Can anyone else sign up for a conference using Outlook or Thunderbird?
>>
> 
> Hi,
> I don't know what "conference" means here, but I use thunderbird all of the time.
> 
>> On 8/10/2023 11:46 PM, Randy Dunlap wrote:
>>> Adding postmaster@vger.kernel.org
>>>
>>>
>>> On 8/10/23 20:53, Leslie Rhorer wrote:
>>>>       Update: I finally managed to get a message through from my AT&T address to the linux-modules list.  I am not certain what the issue was before this.  I am still not sure what the issue is with the Majordomo, however.
>>>>
>>>> On 8/10/2023 10:48 PM, Leslie Rhorer wrote:
>>>>>        I know this is not exactly the right place to post this, but I am at a complete loss what else to do.  Please forgive me, but I cannot get the Majordomo at vger.kernel.org to respond to me.  I have tried everything of which I can think, but the Majordomo will not recognize when I send it the authorization command in order to try and include my siliconventures.net address in the linux-modules mailing list.  My att.net address is supposed to already be a member of the list, but whenever I send to the linux-modules list from mt AT&T address, the message bounces.
>>>>>
>>>>>        Thus , I seem to be having two issues.  The more immediate is I cannot get any messages through to where they need to go, both to the Majordomo and to the linux-modules list.  The more important long term issue is I am having a problem with the NIC card on one of my Debian Linux servers.
>>>
> 
