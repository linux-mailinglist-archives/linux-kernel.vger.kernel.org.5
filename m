Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784527AC0D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjIWKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIWKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:50:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF9C2;
        Sat, 23 Sep 2023 03:50:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E49AA3200954;
        Sat, 23 Sep 2023 06:50:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 23 Sep 2023 06:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695466246; x=1695552646; bh=TICNtpwKGUgxCQ7iTQfQcaR5vXfpPMYDb7J
        f6JgV14A=; b=XWlnhkmgQHgmKgpsisrhutdq6dIgyc/1V3kWIT5UIXThPNoigIP
        3QQvMSWPOOv4WB5iph682eHpBd9dI8hs0Be3AuuMAz1zwv7qoQU5wi5aZehGGoVd
        kUnKvZNB5QMOVKSj2mRt0m6z5jpj8ZP0Z439DV7BHOfaIJfXf5UTqCXcm15rqCsC
        a6OElVgbI8rHhk/gdbdh1/G2MnddK376HiAdO17EC1rvT4SvPBZ4dlEBD3Cnbs+D
        r3MTbRuXX+XIm7VAI7FpmQnWsWGOd5/F1lphsPRJJ4K9+qKcw/e4ugzha6bifqOE
        ic2RabdXcVfHJewKEybTwbcjYn+KDImwZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695466246; x=1695552646; bh=TICNtpwKGUgxCQ7iTQfQcaR5vXfpPMYDb7J
        f6JgV14A=; b=Hrl75Tbi4sE232GuHp+S0m01NJYPQTR3+zCnPys0DpjEurQ3Jgt
        V8UCky0tryJZG4whaKA9Scn8LMSSQsHRyC+4EGRcLqWxCho6m7+ZLixr/OMoz4qz
        t7eoSggD6cul4ppNdf08ntaNHNSZe+WiZ5X98aCPIn/Yll6bME6VwqRTXvbJRPNy
        blR0cfS1qS1q+86ezJGNFdO2ZBCCYJwLYZZhinR/Q8dUWNrA4wr3SWp3A47/Qj/o
        LMSHfONN0dPZxgrctvlDXzNq12XaqRCAamr8Y6+8mksewhtyhUoG4i8vlSjfJOnv
        W7Y1iIWCP5iXZLdRKqI6kVcwB/oAHQrGOrg==
X-ME-Sender: <xms:BcMOZQ_21gbJieAZ1dxlkXBhCP43aVbXknzoR4bKNvF9xFcPcBK74A>
    <xme:BcMOZYtaYipIPauuau8HDGV9Jr4U7vtS-hCq4-qsxQ21cvIL6WQ2HIZaPURWOhV1n
    6DSK_nCshUF2-rn-r0>
X-ME-Received: <xmr:BcMOZWDHvWKPhkLq1dkyYFm02swUAjzQsAmo4coiJ3EH4qbwRQCv_4tnxYtZheUZWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeltddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftrghf
    rggvlhcuuegvihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtth
    gvrhhnpeejieejvdelgeduveejgeeltdevieefteejleeiieejgeeihfelleehtdegudei
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrg
    hfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:BcMOZQeQUd0sMqzWxgHplh28NXZOnWwGK2vSAeFcGae0LOrdSBwmVQ>
    <xmx:BcMOZVNh2JdJg-zrcRkiIHFZp6zbU377_n0cxfb7Xj2Sn7REayz0Ow>
    <xmx:BcMOZame_EHsKC-m8YMBTTKMDMg_QqnyYTgbPah4D8BWBGJRT-q4aw>
    <xmx:BsMOZYrAFtW1XMYK3ZkleZQX7ZQDDXKqW_RUjQmTTrd4gHSdtbvumQ>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Sep 2023 06:50:43 -0400 (EDT)
Message-ID: <95066dfb-67dc-4d32-85fe-de2c429d8546@beims.me>
Date:   Sat, 23 Sep 2023 07:50:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
Content-Language: pt-BR
To:     Greg KH <gregkh@linuxfoundation.org>, Bean Huo <beanhuo@iokpp.de>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rafael@beims.me
References: <20230921203426.638262-1-beanhuo@iokpp.de>
 <2023092253-suffice-mulled-b8fa@gregkh>
From:   Rafael Beims <rafael@beims.me>
In-Reply-To: <2023092253-suffice-mulled-b8fa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 06:29, Greg KH wrote:
> On Thu, Sep 21, 2023 at 10:34:26PM +0200, Bean Huo wrote:
>> From: Bean Huo <beanhuo@micron.com>
>>
>> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
>> operation be allowed only after a write has occurred. Otherwise, the
>> cache flush command or subsequent commands will time out.
>>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>> Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
> Then Rafael also has to sign off on this, right?
>
Correct,


Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Thanks,
Rafael
