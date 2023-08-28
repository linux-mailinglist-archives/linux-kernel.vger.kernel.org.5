Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2574D78B4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjH1Prv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjH1PrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:47:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4A9D;
        Mon, 28 Aug 2023 08:47:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A40BF3200D99;
        Mon, 28 Aug 2023 11:47:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 28 Aug 2023 11:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1693237634; x=1693324034; bh=Ksgm/zu84KcSiZz5BxlGxxG1S
        PevzpBLxTP8pcnPzho=; b=ekMbexukrb/ravvKKRGNtMQWGvtJpoUy0NjD9dDKw
        Lw5sNJQtxV2PbQWUgLsr2eU7Gh075xnw+k+PMqEwHV8G3mr18n+ik9jlOUSk+i3+
        4cbytZf7bdNkRfl21d81FNeSb/B2y/bjnmKP/e49oRXlCu5yE1QvVi94fVXVmJIR
        BImSPBRFVYIRx66Ntznw5knfffJX5XngsJU+AUACe46g0/kJEATPV5OAx/dTIYc+
        5VXMrKP+Hnb4Aobrk3cZuklIg7atgX5RfTLTxsD7vHnHuZksaf1utfflf3cApVMJ
        K/p5kikWOx6YrSuA8gS0t7Q72Atzt3OF3lWB09UMhs21g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693237634; x=1693324034; bh=Ksgm/zu84KcSiZz5BxlGxxG1SPevzpBLxTP
        8pcnPzho=; b=mIGIsK+go6/bw4GhcyR3991+TVb22OUafpGnrJF6Yv9Z2Cjpzs9
        XSQciSaxUVgImHgU4bt1vawWaT4ziLY1p/wf5yTurN9c93+mMCp4cSTZo8KACzrB
        6wWOelDKWIkUjEigTh3RcOYwKIRMQUshnCJCEtUffBbX+XMLnXw5EwZwX42pUNvG
        V5nx5d0QbF93MXbFvnwFWcMap+plIISdpod5viIi6S9mhDeWEMZCva/fPWDp3Mww
        Crgm//BQkzxeE8/vl4znpQZeS+sW6jfjvoNHt2ghzv5abRhunOAetlxwe16S/HCr
        kTNPtmIftSA64Ol5J8oxpfwrl8nn1hBgheA==
X-ME-Sender: <xms:gcHsZCge2uIsNya5wVWMbLJ4DUJyh5l-K2sY4j4ke8wE00jkFi5tLQ>
    <xme:gcHsZDDjzFKGZoCL2kBclX8LCOYgV42GUaLwGGLr7DVxQyavVuiG1qZtHOVAwcbpB
    2n_7Rpzb8k0unUSuGU>
X-ME-Received: <xmr:gcHsZKEz-lxOd_tHinqQYkICSwBYK8--8jfP8wILCfvl0A2yboR2ireqyrTP1IiIDJ5f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhs
    thihucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrg
    htthgvrhhnpedujeehleejheejvdefudelvedvueetfeefvdevtdefieettdduhfejhfei
    ffdvteenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepughushhthiesughushhthihmrggsvgdr
    tghomh
X-ME-Proxy: <xmx:gcHsZLQNOtxFy5TuWk7BwX72AkSxXtWHUfuTDyoJl_lUWU2GnFFJQg>
    <xmx:gcHsZPxRO-Oy34QCFWIC8rvRoFSyPxqu3J0cjVBqG3l9fXk9F5qxSg>
    <xmx:gcHsZJ7sIKn7Jyc-UXOkwoxX_SxcLDyAgXyJQ5VB26ArKmDZkwBIpQ>
    <xmx:gsHsZGlGkYxiJAHipJaMZSBb9IbCRiko5avz7hzA2lOYLNBSIb70_A>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 11:47:13 -0400 (EDT)
Message-ID: <7eaf0f76-5820-e404-905e-892610eaed36@dustymabe.com>
Date:   Mon, 28 Aug 2023 11:47:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com,
        len.brown@intel.com, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>
References: <20230818181516.19167-1-mario.limonciello@amd.com>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20230818181516.19167-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 14:15, Mario Limonciello wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't reply
> at bootup and returns back the command code.
> 
> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, throw
> away the error code to let Intel fTPM continue to work.
> 

FWIW there is a Fedora bug where several people are reporting similar issues:
https://bugzilla.redhat.com/show_bug.cgi?id=2232888

Dusty
