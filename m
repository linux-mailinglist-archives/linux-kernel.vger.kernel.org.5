Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9F7E80CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjKJSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbjKJSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836A4C0C;
        Thu,  9 Nov 2023 22:12:55 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AA4cQJs031287;
        Thu, 9 Nov 2023 22:38:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699591106;
        bh=XY2jeAY1LpjzOcsL0pkL2P4uz433yCKY8ZjAZqFADUY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l2oytYA+pflTdgXbjhZ+iXZOotckdwYHMMuu5oh/qs7a7GH84ebxlR06KB7Dpewgz
         SghEysZbMBHL6Uw2giawqyX4LDm5vQSXWJmKtF9e858HpXXmYOmNyhQvp9tpKDnqjH
         j9r8Nkf5nuS1+PZIyb/LxcQ/kmg8OeOWJ/B0/Lmg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AA4cQGH063995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Nov 2023 22:38:26 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 22:38:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 22:38:25 -0600
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AA4cNQ9007186;
        Thu, 9 Nov 2023 22:38:23 -0600
Message-ID: <81fee24c-47d2-4c2d-8f88-35fd1ea1d639@ti.com>
Date:   Fri, 10 Nov 2023 10:08:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SDHCI AM654 driver delaying boot time
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= 
        <joao.goncalves@toradex.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
 <20231109175159.wylup6z45h7mgxji@clump>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231109175159.wylup6z45h7mgxji@clump>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joao

On 09/11/23 23:21, Nishanth Menon wrote:
> On 18:56-20231108, João Paulo Silva Gonçalves wrote:
>> Hello all, 
>>
>> We are trying to minimize boot time for our AM62 devices. Unfortunately, we have identified a delay of approximately 1.5 seconds caused by the
>> sdhci_am654 driver. This delay is a result of a timeout within the driver (MAX_POWER_ON_TIMEOUT) and was introduced in commit 7ca0f16 ("mmc:
>> sdhci_am654: Add workaround for card detect debounce timer"). This issue arises only when there is no SD card present in the MMC slot.  We tested the
>> driver with a lower timeout value and everything worked. However, as indicated in the commit message, this timeout may be related to the way the sdhci
>> controller hardware IP works. Currently, the driver employs a sort of a "busy loop" to wait for this timeout to pass delaying the boot. Why is
>> need to busy loop for this timeout? Is it possible to wait for it in the backgroud? Am I am missing something here? 

sdhci_am654_write_power_on() does have usleep_range() of 1 to 10ms. If
that isn't sufficient to preempt and allow other drivers to probe, then
probably worth setting sleep_us in read_poll_timeout() call.


> 
> I am not an mmc expert, but, Isn't this sequence part of the programmer
> manual in the TRM[1]? Either way, one additional issue I did end up with
> when I was doing beagleplay[2] was when i booted off emmc and runtime PM
> disabled SD/MMC interface, the MMC IP's CD mode would'nt work since the
> IP isn't clocked. So I switched the mux mode to GPIO to use mmc CD
> there. I haven't timed that approach where
> SDHCI_AM654_QUIRK_FORCE_CDTEST would get set.
> 
> [1] https://www.ti.com/lit/pdf/spruiv7
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts#n835


Above is a good experiment to see if it helps boot time. Can you set
SDCD line to GPIO and hook up using cd-gpios?  You would also need to
set ti,fails-without-test-cd

-- 
Regards
Vignesh
