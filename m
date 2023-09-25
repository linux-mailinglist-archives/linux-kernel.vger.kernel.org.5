Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77137AD489
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjIYJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIYJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:32:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB8E3;
        Mon, 25 Sep 2023 02:32:32 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38P5uba5003009;
        Mon, 25 Sep 2023 11:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=L9Mnpa4+g7dTSm97b0VFVROey4sO9ITBMYDsUb3JsoQ=; b=uQ
        BeX3r2oK6VRXJjfwWadu2QotZlQNii8Gwrx2fcJDHF/6O/DMrWwZ5u2xP7CgggHQ
        1MZPtvm+u3XRo5dBoIiWaeHdwjx9IAE10eJj7vv3OOboCVWsWDCRjKgaciuwZyL+
        CxL6RHw1iYqyJVBAXvdUcWACyDQ/hXB+NH7pNl57Z7szvmlSG7Ve4LQrsvTcBtB8
        GNo5CdK0mEnnK6zj2+92RvDpNPoqsD7EojxPpyrzL5N+jti3a6+AC7PQv1+ISptX
        BZNG2USai80ICO3rQJgYHi3emwBowkmRnVF9Naxsd5z89fiEweSTyXASrk6LNXxr
        Ib7mVYQRwrOsZlPKyVXA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9nefetsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:32:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D981B10005C;
        Mon, 25 Sep 2023 11:31:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0F3421ED4C;
        Mon, 25 Sep 2023 11:31:54 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 11:31:54 +0200
Message-ID: <9b81c8aa-e43d-18db-bc0c-4ae05c4d22bb@foss.st.com>
Date:   Mon, 25 Sep 2023 11:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXTERNAL] [PATCH v3 9/9] ARM: dts: stm32: add RNG node for
 STM32MP13x platforms
To:     Kamlesh Gurudasani <kamlesh@ti.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
 <20230921080301.253563-10-gatien.chevallier@foss.st.com>
 <8734z6hb5i.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <8734z6hb5i.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamlesh,

On 9/22/23 10:20, Kamlesh Gurudasani wrote:
> Gatien Chevallier <gatien.chevallier@foss.st.com> writes:
> 
>> The RNG on STM32MP13 offers upgrades like customization of its
>> configuration and the conditional reset.
>>
>> The hardware RNG should be managed in the secure world for but it
>> is supported on Linux. Therefore, is it not default enabled.
> Just curious, will there be concurrent access? If yes, how do you manage
> the entropy in that case?
> 

Any read on the data register leads to its refreshment. There can be
only one access at a time at the bus level. The rest (FIFO is empty
after request, etc...) is managed by the code in this patchset.

> If you allow access to RNG from normal world, can attacker change the
> setting to generate more predicatable numbers leading this to secure
> world as well.
> 
> I understand that you're leaving the enablement part to customer but
> you still have to allow RNG access to normal world for that.
> 
> -Kamlesh

If RNG is secure, then it should be managed by the secure world and
accessed via some interface. Ours is OP-TEE RNG PTA. The secure level
of the peripheral is managed by the ETZPC, which manages the security
configuration of the board's peripherals.

If the RNG is assigned to the non-secure world, then yes, the non-secure
world can access the RNG configuration. Now, your question is: what
happens to the secure world in such case? The answer is that it should
run on a pseudo-random software RNG seeded at boot by the hardware RNG.
So there's no link anymore if non-secure world deteriorates the
hardware RNG configuration.

Of course, if such choice is made, it's up to the customer to see the
whole picture.

Best regards,
Gatien
