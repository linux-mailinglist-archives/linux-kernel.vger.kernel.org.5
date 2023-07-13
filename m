Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5F751ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjGMIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGMICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:02:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D1420C;
        Thu, 13 Jul 2023 01:00:56 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D7NZTv002471;
        Thu, 13 Jul 2023 09:59:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=G/5P+GBYTXDjapoJpeo3kbVedPpgVPQ0maCG9CHv5+Q=;
 b=HWz26JpNsdDJbJQoAb+xal5sc8dUbPMpZmAR/YzfV2icOKFol1B4tnKWHatZblUVB8+h
 uRuScfuCSr4bG0QgV3S8E/DnOY9EC5a3kZl9B91ZbRRPhrk9MDijmBHIhXdm+9DLYEJB
 1/0sCeQUmsVZsiBc9azZcemNaAs3fbScUqJFlmPRoecUmqWfvwdd6EE7BeKV2VI5G9mv
 BOijjoSqYCpU8NnL3CJZJEq2Xmt1SEaizoKqgTd7jd+I7+A4/0q8WpryHJEtR54Id8rB
 v5qU7/jAUzEqZ6LWd17pu4xzRqA/3HIqxlOX0GqHXApIwd2EveX4xIwj5Wipm7Z7vlNb Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rtcud08ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 09:59:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB4FC100058;
        Thu, 13 Jul 2023 09:59:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A3B922138CC;
        Thu, 13 Jul 2023 09:59:49 +0200 (CEST)
Received: from [10.201.22.9] (10.201.22.9) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Jul
 2023 09:59:49 +0200
Message-ID: <050aa1fb-34ab-b9e0-7772-af53ec32d312@foss.st.com>
Date:   Thu, 13 Jul 2023 09:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/7] crypto: stm32 - add new algorithms support
To:     Linus Walleij <linus.walleij@linaro.org>
References: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com>
 <20230706073719.1156288-3-thomas.bourgoin@foss.st.com>
 <CACRpkdaHn8fhZtuhU4sXHK1xoxO3-xYg_Xb=3=bX8i-uJM9KDA@mail.gmail.com>
 <a584c152-329e-9c79-ec62-795485302a55@foss.st.com>
 <CACRpkdYStm_dxo-FMo4Kdw_Lm3iG+xppf7O5W6cxtoiRy1DOsw@mail.gmail.com>
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <CACRpkdYStm_dxo-FMo4Kdw_Lm3iG+xppf7O5W6cxtoiRy1DOsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 7/13/23 00:56, Linus Walleij wrote:
> Yes this fixes the bug and the tests pass fine 😄

Great news

> I wonder why SHA1 was affected? Same codepath?

Yes the number of CSR to save is the same for SHA256 and SHA1. You can 
look at the 'Context swapping' chapter (47.3.3) in the reference manual 
for UX500. There is a note at the end telling that you do not have to 
save all 54 register if you do HASH operation, only 38 are necessary :
  > If the context swap does not involve HMAC operations, registers 
cs_rk0 to cs_rk7 and
> cs_rh0 to cs_rh7 can be ignored
Best regards,

Thomas
