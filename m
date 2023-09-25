Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5D7AD865
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjIYM6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIYM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:58:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72139F;
        Mon, 25 Sep 2023 05:58:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FE005C270B;
        Mon, 25 Sep 2023 08:58:26 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695646706; x=1695733106; bh=y1
        AEv3cc3cMi4BLcmac96MLhAomJwW8QvnSJb6BHLcI=; b=YxUpn7F+SmUNRBTjG+
        oiViwCwDFakxI2XXkyJbyvIXfEYIrnZeUUIaSeqLw9k+hOJfkhP67urzx9CFSy+g
        urHtOtujHLDKO/aWzz8AV20OGMJ+10/ehRNqYFoMeAzKMFRijNH9XkvGh4EEpeUr
        WezKo6xoVPL1EUWVYM1AEQNZdYoDpgPi+5omhEJ3PfTenAweXotZ09P7yg9n9WEP
        99wuetXM4RhrX6TqQN8QeuQT7tnifYI4qSTPiubFf21aDn6029X4jA/PpTCc2frW
        iXFzut1WuaUf/iQAFbk2lTVotsS4K/pMRfBKS6+dy7vE6UESYUmVlwmCVsaIMDD0
        Uj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646706; x=1695733106; bh=y1AEv3cc3cMi4
        BLcmac96MLhAomJwW8QvnSJb6BHLcI=; b=SchpavSlrqIowzfBBdc5+HLXjlXQQ
        4dr1FVlLqUv64h6Bkg9sMYWjxmTEGJVAGylSEvlnGWVZ/H7RWTdrxSR7POrWY6Vr
        mCbcfka733KdZw/3CTfLKP2z+JKQOkyIsKcIKmjN/Gh6njxPyKP0+Bl1LZoHGqkn
        0SfXtyIvI3QU8NxwbdO2EuzaihnQrfI1Bd5vb5wM3Yy1iS8USkzbohhvzdMh3Q7O
        2iHsbEl4UwWRsEwVPhI8PNUKnr5iM5ZpJdIG+X3FD0Gzg0vyS3j3Ddn1ploHntH3
        D+7SWj+w3XhxaRFH9tUNRoCV5jdz661EfHlK/SAa/PVsZ0n2rDcTxN5yw==
X-ME-Sender: <xms:8oMRZe6fONCSJJKfe3nIw8LOr-xgU8TGc18H91JBwR_GofC94nL3HQ>
    <xme:8oMRZX4IKqOFV0oEgKKc42TCS7U8uMKO-zgBELUEFjY7VahmkotjYg6qwZWcFNwiC
    PoyTtBK4xFARzp9ktM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:8oMRZdcpD0xDPpQ4eRdKahNmD-VBV6oLDrsmo2WEVgXafFP4zf4X5w>
    <xmx:8oMRZbJmI0sQurK2ydIaVma-u8q93g1qjTB0G8cq0M1GmexG6Mic_Q>
    <xmx:8oMRZSJqshB2blJf-vX7uSGDHolgxklCwYN8EOvMkTCXcNJou-Zdxg>
    <xmx:8oMRZa_c5bKLGCmvIkPRqGBbsZWI1zhjKJrPvm9Uq-UeG_JSWHgk1A>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 31451C6008B; Mon, 25 Sep 2023 08:58:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <4cca22df-c809-493a-a207-9b6095adbbc4@app.fastmail.com>
In-Reply-To: <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
 <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
 <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
 <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
Date:   Mon, 25 Sep 2023 08:58:05 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in platform_profile_show()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On Mon, Sep 25, 2023, at 4:57 AM, Hans de Goede wrote:
<snip>
>
> Mark, can you please take a look at this (it is a thinkpad_acpi dytc issue)?
Ack

<snip>
> Regards,
>
> Hans
>
> p.s.
>
> Mark, maybe should add you to the MAINTAINERS section for thinkpad_acpi ?
Happy to do so if that makes sense and is OK with everyone. 
I assume I just push a patch proposing that change, or is there some nomination process?
