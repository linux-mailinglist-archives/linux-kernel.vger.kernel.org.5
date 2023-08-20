Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95DD781EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjHTQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjHTQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 12:41:00 -0400
Received: from sonic301-25.consmr.mail.gq1.yahoo.com (sonic301-25.consmr.mail.gq1.yahoo.com [98.137.64.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C216E44AA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1692549500; bh=RQGOnXuvG5OiED/amDx02JcIwlPS15cUAfcJ3OWkzrM=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=yqMoqQ2pzC9PTh8WLEOnQX9kU0ihsrO5PfBGdFjG4ETsFSTGHjVwC/qviQdbLC/YqGT+1TQjElEd4w7Dd54ayr7H2W+QatanHFXo1JORAM2Gyb/7xUlunIXSRIKrtxUTwgXPSeyg2aZnrQkje2bsrkRMnqhbCrXIhFt/Yqwx0e4=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692549500; bh=RZ9BDKaiFYgcvc3ho47H/euU8Za+mFy0qCs2PGunYvC=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ZMRN6IsQ4DojHt1WyWgWzavuaT3onBI8/2kFVnzTJWwD0B3KL35T9WXINKUX9gRPp+4jGJklUoSgWizOxPO1TDRNvQVej+L0Rwltc7+9/5fM5yGNZzbSJ9WZhpNgF18t+gj4pDBYbfYs1qin5pDMqHCOcmguPjaB3V8ayLvkRno/1EetQx8ZT4PaQFO5feA3DrpPJx6/6I8S8GFqT03fVYuy+EilbTa+4S3Z4f1ERy8THpmZfOplLeEns7yliXdZddxkHfV3obndeMoFN0IuSPJnmKOksGTdVH9Ai8Ovjs1K6wD+w7JBBUk2drm5I33xA4mptQM61m3hSZSjHH7k/g==
X-YMail-OSG: JewAgyAVM1mghxv.aOOmZxM3TCqrIlYI5zufzbRTDAbfdCg7Y1QAgx6VAcT5Mqo
 4WotVkZaSWwD8csfNFyKNNGUwQFNLQixNsTPT_44vlaUan18KpyeBMR5GPnjOTMlLteTBe0DM1QU
 ivuV23wXaAA53KCk_hLMgNzFDxt7KY9Q0Ijh77kmywQZqjszLOLV7t_Rn8p632WN6M3Qblns5w_L
 H3C7zctZt8qXwYwzyvtV9f16BKfcrS_hMnfkWRRkh0bB0rbpv1KW6M40AhxZicPW5my6VRGAAn.B
 w7Rp2yKSMAWPRJlLVNq8mex2mqcOrrrLxwJLBQyfBePpBEP9jceq6slOxBgro.MW.0AcBrV79Qn1
 saLsQTzicr9x1Jw.NeKq8K4as511qC1_zOyBtMrbbqVdxOYIrvSJmYe3xfLA4rj8OV3rMWkO6G1B
 Zg6IN99GL37zJ7K0I_ptMulOTDHaPg8xmUc8d5I0QyaRW88yQncGziZ1uRonpiwJA.To35cqnh0X
 lLuRtPRqo7hJzed_18eH8qdYFhRx7fANbnxcNvScQC4XUt3_fRkONnqKC2C_wCYPTX.kk5ZUskg4
 5Y8dD4hJYvGn5BBOVA0CWxr2MPOxSEa7zVWQgKma057N_IpN8xnxVSPapuIv8JStE7N1FgMCtPj.
 f.cMgN_MCJziykYVMCYwGCFvWGV8WowWnwujHBeykyhhMAJQ2eQTP3i7hdMLURnDWv74LjQFFgX2
 aIc8zMjaJuIzkvTBxK12.5GGFadAcI5tMnM2LbpIF7O89z_9rkdsT0fZFXMC6Hyj_9FGZzw1njQB
 p.Qb_d4wpVul4ZUtyZhC..FJEXmXvHkQLuOwJNiCDA4DKCXIzwcnXzUuv75kOxwu2PkJROi6_zkE
 E09uTykCAYTDi5e2BEVXY6_66WSiAhOe3vnhSdTkpVCh69AzKfrb308hcHSI7vM1.JCJm_vnj.8z
 TKmati0Zn_7GFU_fvs0mXNA9AnWFUrjwZwmRJcpBqEOH4kgH5gLxeI3wF4MQnHM4h_RFUeSt6fn7
 AcSPtAhgKZa.m3ggA60_T5JsIROFRXU_vjf89YoYbOQMv19ey8uqShe2U5OnPBG9a.oaZBhlFgsl
 dCK0XYDeBuYW9ZlkiCcwR9ZNRDLs7NWtgsVmzRkdckMKDmrbhh_oPYRRsjGRoSSuNSapUEspfN4p
 XF1mW_jxj.tAu1mxeS8FyEYV42kSjearsdzQMvsOvWimmZ.sLkoAzhRB514S.rgWYu.x8EKqPfd_
 1irO0qFD31yMQ2ODAA_rtP4KUDZ7fjIOXuynHXIwUKWYajqeEQ0NB4Ecikp7DkgTpRm3RK7R84gY
 .rbg5m6Kt4iXOT2RAHNxTeGwvIsiWwY09zQxZfhnaSBtdwssQtGDg2HyhyZvAJsQY3OWL93Iuip0
 YVijb_7xrmjEKtDEHxnRYGohWZvzZ3M5EANkwoFivCKrjgAOeCv0MnsYrLpQ9dM2zUSLIZu2kK5T
 fW57PIxgUJ9JTA8hdsCIKWXgHPtloxrz6s8ICMFgjpgVOqQj.FNlGGz5gxzkuIxMnNlhdseuIKWG
 PlFFSUVywBi3Jckxm5PEovwmj4w.Zq3UAoLOEOuO_fOVTAi3nmOHOBK9.gHMx6YV7rFxnbKhdp5y
 xDjruvy2xk4RYgQ_XhXXbObXy_kfrvd3b_qPMEVKYvrda8O7I2EjH0sAGrx8_W7caZFCPVcUojpl
 rGc8L9qIGhJj5XLu_r0fN4ZKDbspx1GujWDbHuJ9EMnWt0lHdRFM3LlhcbJdZNtezH67e71naXWp
 DPQYpElbUt8zJ_Jh_1YgyU06dvcX7SL7S4NTuR3iJ13N5jDwKrWuKKGwn91Z5P5XGhxR3I9SOEAy
 hUN.pdssCJNwaZfPWXYhew.ZZGCp99KioLPDJ4sHDhNH9Vy8MUlu37cLPXGNSy7tdiTVQ_cmJJ8Y
 QKGvJF36l4ynn.PUCx7dkEWn_A8wU77ZYvAgx37GUjTB9KY1d4.eCrFKUywuf7_S6Lec5ZmcYBLw
 cAB9LjVbMNT9_Gnf3MGNtcincfmfxvkN8ZKTK_qSdS0wfauX5AwSQu1I4Yn9GCDo_WahNSsgr3eX
 hltjaia4Mt2txUoJ6H32RNtnJhbratFTVFDJs.cij43QS36hT5Q5HAsRPLg_6LKYHHBgqQ2wK9xw
 XynGJmzu0_KmMYbA2cWtaY0d2qali62IJH5Mta3GS1.rLciBW5BVsvc__PJ8eVDtzeuyXKOQLp50
 Yduc3ascWSkrE6Y8Pe77AekVZoUC6xfypcnFA8rO_JR6fhg--
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: 0b297b99-4b15-4757-b411-2be9d1177d66
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 20 Aug 2023 16:38:20 +0000
Received: by hermes--production-bf1-865889d799-k7hdq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 65a72c385c026970582942b127cd9e64;
          Sun, 20 Aug 2023 16:38:15 +0000 (UTC)
Message-ID: <a5db211c-f862-aa3a-f6ef-5b724891c74d@att.net>
Date:   Sun, 20 Aug 2023 11:38:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Re: Failing network hardware
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
References: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3.ref@att.net>
 <ddbed5c6-4ded-df22-fae0-bd256e40d6b3@att.net> <ZNrSwBqP1vPW8OKz@debian.me>
 <edfeb028-02cb-35b1-e828-9b5931c8d65a@att.net>
Content-Language: en-US
In-Reply-To: <edfeb028-02cb-35b1-e828-9b5931c8d65a@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21732 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     I haven't seen any response to this.  Note I can pretty much 
guarantee this is not an issue with any distribution of kernel version 
at this point.  This is almost certainly an issue of my own making, but 
that does not mean I need to get it resolved any less.  I strongly 
suspect the problem is something I did in the udev rules that is now 
preventing the network system from recognizing the presence of the  
network card.  Assuming for the time being this is the case, how do I 
get the system to recognize the presence of the card in order to get it 
to assign a network interface to it?

On 8/14/2023 8:50 PM, Leslie Rhorer wrote:
>
>
> On 8/14/2023 8:20 PM, Bagas Sanjaya wrote:
>> (fixing up netdev address)
>>
>> On Sun, Aug 13, 2023 at 01:53:58PM -0500, Leslie Rhorer wrote:
>>> Hello all,
>>>
>>>     About a year or so ago, I upgraded one of my Debian servers to 
>>> Bullseye,
>>> and it killed the 10G NIC on the server due to issues with the 
>>> device driver
>>> in the Debian repository (it was missing).  I jumped through all 
>>> sorts of
>>> loops and hoops to try to get it working, but I finally had to give 
>>> up and
>>> resort to using the 1G interface.  Recently, I tried a new install on a
>>> different server to the new Debian Bookworm, and it worked for that 
>>> server,
>>> so apparently the issue has been fixed in Bookworm.  I reported a bug
>>> against the Buster distribution, but it was never fixed.
>>>
>>>     With that in mind, I went ahead and upgraded the original server to
>>> Bookworm, but the NIC remains dead.  Unfortunately, I cannot find my 
>>> notes
>>> on what I did originally to try to get the 10G interface working and 
>>> to shut
>>> it down in favor of a built-in port.  I do recall I tried compiling 
>>> what was
>>> supposed to be the correct firmware driver and also changing the 
>>> udev rules,
>>> but I do not recall the exact details.  I have tried several things,
>>> including re-installing the firmware, but nothing seems to work.  The
>>> Ethernet interface does not appear on the system in order to be able to
>>> specify it in /etc/network/interfaces.  What can I do in order to 
>>> try to get
>>> the 10G card working?
>>>
>>>     The card is an Asus MCB-10G_PEB-10G NIC and uses the bnx2x.ko 
>>> driver. The
>>> system uses an Asus AMD-64 motherboard.  The bnx2x.ko driver is 
>>> installed,
>>> and lspci shows the card in the system, but ifconfig does not see the
>>> interface.
>>>
>>
>> Too many moving parts here, hence allow me to rule things out:
>>
>> If there is any of your system haven't been dist-upgraded to 
>> bookworm, can you
>> confirm this issue on vanilla v6.1 kernel? 
>
>     One, named Backup, is a fresh install of Debian Bookworm.  The NIC 
> on Backup works just fine.  The other, named RAID-Server, was upgraded 
> via dist-upgrade from Buster to Bullseye, at which point the NIC quit 
> working, and then from Bullseye to Bookworm.
>
>     I identified the problem on Bullseye and submitted a bug report, 
> but no one ever bothered to fix the bug, which was simply the fact the 
> driver was missing from the Bullseye distro.
>
>     Both systems are now running kernel 6.1.0-10-AMD64.
>
>> And also, can you check latest mainline?
>
>     I don't know what you mean by that.
>
>> If all have been upgraded, though, you need to reinstall bullseye
>> first.
>
>     I take it by that, you are making the distinction between an 
> upgrade from an older distro and kernel to a new one and a fresh 
> install of a distro running a 6.1 kernel?
>
>     I definitely do not want to re-install Bullseye on either system.  
> It would break Backup's NIC to do so, and it would be an incredible 
> mess with a potentially unacceptably long down time to try to back out 
> of Bookworm on RAID-Server.  If I follow your intent, however, this 
> should be unnecessary.  I have one working fresh install and one 
> broken dist-upgrade from a known broken distribution.
>
>> As a side note, when you reply to mailing lists, please don't top-post;
>> reply inline with appropriate context instead.
>
>     That is my usual practice.  It has been for many decades.
>
