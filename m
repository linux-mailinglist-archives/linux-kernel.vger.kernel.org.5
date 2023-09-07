Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F2797422
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbjIGPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjIGPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:22 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844001FC1;
        Thu,  7 Sep 2023 08:31:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 41C535C00B0;
        Thu,  7 Sep 2023 08:42:18 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute6.internal (MEProxy); Thu, 07 Sep 2023 08:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694090538; x=1694176938; bh=UI
        lscQB4tPzAVE0ptc61SxJC9os7aFiFRvMXeXkTLIM=; b=DwP7eSFhMrJJjUmX3h
        l1OXxKsGNJp4ATvgVOMuhS7AnL3ONEopuBO2W/0CUYwrkZ94CWlVxN4AXTpbYoY1
        9u69NY5vCJTVty3tRZ8iWTjerJb1GTdB+s8XMO4RiPa6v+FuHuinkRRT7lccOlTT
        T9TqHYWhnx8TrOhK+DxU7PFjaYWi5fDCjcDlz9P0+PDl6eZnE2XlHGfhKUXzpG+M
        l/L2JTRoKm7QZdxdk4KYV8Jep1JJs7w3d/K40tGx+8AKLGK3qiyW47fIVAZ6noWP
        RwTyESVsvQQX48bIoU+TNxBVbLSxwQf41Uq2pUeA58bGSvJcJ5M5HikanT0pFHKR
        gEIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694090538; x=1694176938; bh=UIlscQB4tPzAV
        E0ptc61SxJC9os7aFiFRvMXeXkTLIM=; b=ckZjZP98rzW/Hpq7CqnvHeePkkOuh
        ESD2C1NhsZ45uV1SHSkTHdwgsa3mebqYsk5N1UOdBBFh3U8uPE4wku83TYeONSE2
        Ty2nxHWY4SagAxI3Ta21gOsiPYYmNELkeEAXmbWo5N4csNAP0YqxvzoU10t1LYLa
        n5tf3BfiAsoRGUlEZ/BcOCM9XNDd7xoc6fBeMgI9XeHSNGBam+D2LMZ+roP8hD6D
        LUSiaD1WpLEmbFCS/A/sLGmOCfPX65XRWQg1v2Xsn8YsD5/PrDOTT2aduNbWE4Mu
        N9uqmZ4STGkVNH3izf+MFJRVjeq/q/H5ESq0L27bf32btZSAeAfuof39w==
X-ME-Sender: <xms:KcX5ZO71UeN7P_8q6Y6JP85apDu3MaKU3ua21J-A6M41qKugW1ZqaQ>
    <xme:KcX5ZH6mN9BkbH_XIQGsaHDSSiiBXN100MU7Ndk3IsQt3eRXy7iTuNx-TKorD_OGo
    vrp-WYkpTSq2CQIDWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfgv
    rhgvmhihucevlhhinhgvfdcuoehjvghrvghmhiesjhgtlhhinhgvrdhorhhgqeenucggtf
    frrghtthgvrhhnpeeuvedthfdttedttedvgeelleevvdehveejhefgheefuedtleelueek
    vdeggfeiveenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvghr
    vghmhiesjhgtlhhinhgvrdhorhhg
X-ME-Proxy: <xmx:KcX5ZNdvz16s5UQpurybmsQSrmVqGg3Q0Us33NTuDBax5lpCu5EUAw>
    <xmx:KcX5ZLI05Y3FcEGg0_klIK65_cesxI9HH8Yb06k1OIj1h4Vwl0IWHQ>
    <xmx:KcX5ZCIgS4Q8rxAkaLBk_OgGTH05DofANLfA37dNWNa5pUGdGZsvRw>
    <xmx:KsX5ZK-yALfukI5ggs_Wl3rqgsWkwG8cRPK8oP4g1nT7C_6reVVySA>
Feedback-ID: i7a7146c5:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B618BC007C; Thu,  7 Sep 2023 08:42:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <cb4fa1f4-2250-4aad-823f-7cd286f30ccc@app.fastmail.com>
In-Reply-To: <ccf7072c-cebb-0491-f07e-8c781a2f4664@linaro.org>
References: <20230906233347.823171-1-jeremy@jcline.org>
 <ccf7072c-cebb-0491-f07e-8c781a2f4664@linaro.org>
Date:   Thu, 07 Sep 2023 08:41:56 -0400
From:   "Jeremy Cline" <jeremy@jcline.org>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com>,
        "Hillf Danton" <hdanton@sina.com>
Subject: Re: [PATCH] nfc: nci: assert requested protocol is valid
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 7, 2023, at 2:24 AM, Krzysztof Kozlowski wrote:
> On 07/09/2023 01:33, Jeremy Cline wrote:
>> The protocol is used in a bit mask to determine if the protocol is
>> supported. Assert the provided protocol is less than the maximum
>> defined so it doesn't potentially perform a shift-out-of-bounds and
>> provide a clearer error for undefined protocols vs unsupported ones.
>> 
>> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
>> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
>> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
>> ---
>>  net/nfc/nci/core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>> index fff755dde30d..6c9592d05120 100644
>> --- a/net/nfc/nci/core.c
>> +++ b/net/nfc/nci/core.c
>> @@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (protocol >= NFC_PROTO_MAX) {
>> +		pr_err("the requested nfc protocol is invalid\n");
>> +		return -EINVAL;
>> +	}
>
> This looks OK, but I wonder if protocol 0 (so BIT(0) in the
> supported_protocols) is a valid protocol. I looked at the code and it
> was nowhere handled.
>

I did notice that the protocols started at 1, but I was not particularly confident in adding a check for 0 since I was concerned I might miss a subtle existing case of 0 being used somewhere, or that some time in the future a protocol 0 would be added (which seems weird, but weird things happen I suppose). If it is added in the future and there's a check here marking it invalid explicitly, it will trip up the developer briefly.

Since the next check in this function should still reject 0 with an -EINVAL the only downside to not checking is the different error message.

I personally lean towards letting the second check catch the 0 case, but as I'm not likely to be the person who has to deal with any of the downsides, I'm happy to do whatever you think is best.

Thanks,
Jeremy
