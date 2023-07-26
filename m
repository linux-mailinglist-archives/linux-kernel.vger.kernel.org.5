Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9134F76388C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjGZOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjGZOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3635BC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QE8xSU097527;
        Wed, 26 Jul 2023 09:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690380539;
        bh=+f3waBhCs1Fbv/oJomGks9SD8myxCQnRXrm4zYMldHs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wqxceb5MbLaHBaltr1mz7dM+6BNf8hmZXNE/EL0Si11Ao2Hu/6h5wGVedMVmUZjCQ
         McCEAn5Kfy4Y+dv3SYkYH9UeunA+ZAlS7bXSF2BjqxwB7R590h4v04BH0s7wY3e8UO
         sVQhwZUkSGxus6mlF8Vb1st7LrDuFa2Mq5u/gkOo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QE8xYd025615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 09:08:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 09:08:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 09:08:59 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QE8qJJ020333;
        Wed, 26 Jul 2023 09:08:52 -0500
Message-ID: <ace112fe-978c-a518-2be5-3f3d1f7fd29c@ti.com>
Date:   Wed, 26 Jul 2023 19:38:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable various configs for TI
 platforms
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Judith Mendez <jm@ti.com>, <u-kumar1@ti.com>
References: <20230726133049.2074105-1-u-kumar1@ti.com>
 <20230726134322.gepflrrdcpx6uxvu@colony>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230726134322.gepflrrdcpx6uxvu@colony>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nishanth

On 7/26/2023 7:13 PM, Nishanth Menon wrote:
> on $subject: I think mentioning K3 will help narrow things down a bit.
>
> On 19:00-20230726, Udit Kumar wrote:
>> Enable TI ECAP, DP83869 driver, TI OMAP2, K3 remote proc
> I think you mean to state TI mailbox and not omap2 :)

Not really :)

This driver TI OMAP2, (CONFIG_OMAP2PLUS_MBOX) is used in

TI K3 platforms as well for communications with remote processors.

Rest comments will address in v3.


>
>> SND_SOC_J721E_EVM, MCAN, UFS and RTI driver to be built
>> as module.
>> These are needed on different TI platforms.
> Please elaborate the list of boards this benefits TI platforms are a
> big variant list. TI Platforms is too generic a term that scales
> architectures.. that is not the point you are trying to make.
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> If the various contributers are ok, just my 2 cents:
> Could you drop all other sign-offs other than yours? I understand the
> contributions from various members on the TI SDK tree, but I'vent seen
> them attempt to upstream and you took the effort in ensuring the new
> squashed patch contains all the relevant components.
>
> [..]
