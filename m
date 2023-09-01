Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906E790018
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjIAPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjIAPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:44:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE4AC;
        Fri,  1 Sep 2023 08:44:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401d67434daso21790365e9.2;
        Fri, 01 Sep 2023 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693583076; x=1694187876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lsrQVJsYRxlLDD91kBwQmQ2vmq9/hoc5Oclnl+/Wgs=;
        b=EVt85H2wS+NHFE7Cqk6jBWHczJfLd+clAk7Nr7cH1aCQ8vK8fhbBuwcD6obTK8dA2h
         3Kb2dBcNW5EowdlhU9j8KCFdv1oGVAl3I2sx69GGTD7yCcjMHMfczhLRihudj8tTnb7U
         1y7zfqrgIOFdfgjFZ4WtiV9l7KHNUBQKdb4Vn86liETCtVX0SnIxS57y8S0uGgwiOoCK
         Mt54cMw6DqlVi7rOzZhw80rxAiA2evrtbhn+Ves2q10AbDpkEalizImkPBUpC4KgdQgu
         sIIEjBvFFLrQom9Nc3qC5G76iw+jcWLH1wheVIrSXk12J+VAZgWU8QYgAAwaNkC1rL4Z
         oDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583076; x=1694187876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lsrQVJsYRxlLDD91kBwQmQ2vmq9/hoc5Oclnl+/Wgs=;
        b=gNHqT/u3dApgW6RPSICuejOZpGQQMxv7fsgzmXAG1gHKJUVif2YA8BJTzHoVxf0Wdf
         0fsPTTHsxVP5a0ltocygSDSOVfKaP5nQKxEbDu9WZIflDHKaXNy/SH6Nwjh5qA/YH4sC
         ZNgZyj7quU9gkEgQ/+GvEo0f4uVzkj8nu3lRjR17J24gG7p9Z987m70yXaOCv7pE9Jos
         le6t/F4QSXdmPLysRoyqMkkp6tmsqTtrhjnvH7GAC1qvXNn36jdbFWYpqVAW3RARvNaF
         cPpdY+S9h9Zm1QyFH4+8La37f6H/hGZFTkvxr345fmP2JHqsRAhDK+imki6PsiUqtSvL
         2tGg==
X-Gm-Message-State: AOJu0YyTg62rH3LtyTMUPS96y/lFDRJZRT8IerotMiBWoWs0UTHQBXKP
        Z0wHqUjuUPQuwmm3bgWcS28=
X-Google-Smtp-Source: AGHT+IGU4Giofhy7RSb8VpzNRTRMIhpR0XvS2QItBBbG9mdxFWujXu3xQz1BypLpa1yaqJDmzVSbyQ==
X-Received: by 2002:a7b:c455:0:b0:401:b493:f7c1 with SMTP id l21-20020a7bc455000000b00401b493f7c1mr2138642wmi.35.1693583076283;
        Fri, 01 Sep 2023 08:44:36 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72e7:e700:e595:f26a:e77c:3ddd? (dynamic-2a01-0c22-72e7-e700-e595-f26a-e77c-3ddd.c22.pool.telefonica.de. [2a01:c22:72e7:e700:e595:f26a:e77c:3ddd])
        by smtp.googlemail.com with ESMTPSA id m18-20020a7bca52000000b003fe601a7d46sm8430294wml.45.2023.09.01.08.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:44:35 -0700 (PDT)
Message-ID: <d9bd9e24-3e8a-c4b8-8003-903c0038214d@gmail.com>
Date:   Fri, 1 Sep 2023 17:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     Patrick Thompson <ptf@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com, Chun-Hao Lin <hau@realtek.com>
References: <20230606140041.3244713-1-ptf@google.com>
 <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com>
 <20230606142907.456eec7e@kernel.org>
 <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com>
 <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
 <CAJs+hrGmHF4EHsYGVPCosSNOE075CzTsP1d9hppMNXAB1n=JAw@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAJs+hrGmHF4EHsYGVPCosSNOE075CzTsP1d9hppMNXAB1n=JAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2023 16:20, Patrick Thompson wrote:
> Okay sounds good. By the way, here's the patch where the VER_35 logic
> was added. So one question would be are there more chips without
> multicast hardware filters?

There's no public datasheets, therefore nobody but Realtek knows.
Only public reference is their r8168 driver, and interestingly
it uses mc filtering for all chip variants, including what is
version 35 in r8169.

> ------------------
> 
> From: Nathan Walp <faceprint@xxxxxxxxxxxxx>
> 
> commit 0481776b7a70f09acf7d9d97c288c3a8403fbfe4 upstream.
> 
> RTL_GIGA_MAC_VER_35 includes no multicast hardware filter.
> 
> Signed-off-by: Nathan Walp <faceprint@xxxxxxxxxxxxx>
> Suggested-by: Hayes Wang <hayeswang@xxxxxxxxxxx>
> Acked-by: Francois Romieu <romieu@xxxxxxxxxxxxx>
> Signed-off-by: David S. Miller <davem@xxxxxxxxxxxxx>
> Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@xxxxxxxxxxxxx>
> ---
> drivers/net/ethernet/realtek/r8169.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c
> b/drivers/net/ethernet/realtek/r8169.c
> index eb81da4..e19e1f1 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -4271,6 +4271,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
> mc_filter[1] = swab32(data);
> }
> 
> + if (tp->mac_version == RTL_GIGA_MAC_VER_35)
> + mc_filter[1] = mc_filter[0] = 0xffffffff;
> +
> RTL_W32(MAR0 + 4, mc_filter[1]);
> RTL_W32(MAR0 + 0, mc_filter[0]);
> 
> --
> 1.7.9.5
> 
> --
> 
> On Fri, Sep 1, 2023 at 8:48 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 01.09.2023 14:28, Patrick Thompson wrote:
>>> Hello,
>>>
>>> I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
>>> greater than 35 as well.
>>>
>> I *think* the mc filtering issue with version 35 is different from the
>> one you're seeing. So not every chip version may be affected.
>> As there's no public errata information let's wait for a statement
>> from Realtek.
>>
>>> Realtek responded to me but I was slow to get them packet captures
>>> that they needed. I am hoping to restart things and get back to this
>>> over the finish line if it's a valid patch.
>>>
>>> I will add the appropriate tags and annotations once I hear back.
>>>
>>> On Tue, Jun 6, 2023 at 5:29 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
>>>>> Thanks for the report and the patch. I just asked a contact in Realtek
>>>>> whether more chip versions may be affected. Then the patch should be
>>>>> extended accordingly. Let's wait few days for a response.
>>>>>
>>>>> I think we should make this a fix. Add the following as Fixes tag
>>>>> and annotate the patch as "net" (see netdev FAQ).
>>>>>
>>>>> 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>>>>
>>>> Perhaps it's best if you repost with the Fixes tag included once
>>>> Realtek responded.
>>

