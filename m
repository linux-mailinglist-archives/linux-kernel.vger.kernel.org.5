Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2177B6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHNKmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHNKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:42:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE711A;
        Mon, 14 Aug 2023 03:42:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EAfurr085836;
        Mon, 14 Aug 2023 05:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692009716;
        bh=Lz356dlYT0Q7fdpMmgsrqqZokIAx9+np94XnpNO5Wt4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Kk9N6XcN5y6wkTH+BugUixyqNL4LzPx5i3PfOKafcOnesY3N5nAun95wz73+8ZA8O
         a3mjIRJ3DHq9POKbLqHsSX1cJjxv1G0z+X9dsD3u7veUejTinXUUb/QgIXOfV1WpIV
         uf/wtOY80VCE2S/hciOzf3BzfkF1dGI9ir1gB3i0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EAfuk6012941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 05:41:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 05:41:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 05:41:56 -0500
Received: from [172.24.227.132] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EAfnDv018660;
        Mon, 14 Aug 2023 05:41:49 -0500
Message-ID: <8fd9c745-cb42-8d4d-8307-e428a491bfe1@ti.com>
Date:   Mon, 14 Aug 2023 16:11:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 0/6] arm64: ti: k3-am62: Add display support
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230809084559.17322-1-a-bhatia1@ti.com>
 <169179274928.1340235.2380026214492639228.b4-ty@ti.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <169179274928.1340235.2380026214492639228.b4-ty@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12-Aug-23 04:02, Nishanth Menon wrote:
> Hi Aradhya Bhatia,
> 
> On Wed, 09 Aug 2023 14:15:53 +0530, Aradhya Bhatia wrote:
>> The patch series adds DT nodes for Display SubSystem (DSS) and other
>> peripherals required to enable the HDMI audio and video on the AM625 SK,
>> AM62-LP SK, as well as the AM625 based Beagle-Play platforms. An HDMI
>> monitor can be connected to the boards for the audio/video outputs.
>>
>> The series adding the compatible and basic driver support[0] is in the
>> drm-misc-next and linux-next queues and is expected to be in the
>> mainline by v6.6-rc1. Patch 5/6 also requires Nishanth Menon's patch[1]
>> that introduces debounce select mux macros. This patch too is not in
>> v6.5-rc1 but has been picked up in ti-next[2] and hence, is present in
>> linux-next.
>>
>> [...]
> 
> NOTE: This series creates checkpatch warnings against v6.5-rc1 and
> complains that it cannot find ti,am625-dss which has been merged in
> drm tree for next. This is clean in linux-next for a few weeks now.
> Given the number of people who would really like to see it in v6.6-rc1
> to keep the display support working in the tree without carried
> patches and work on next set of features on display and graphics, and
> given the real low risk of this NOT making to linus-master, we are
> making an specific exception here for this time around. So, please
> keep a watch on drm-next and if for any reason the support is dropped
> going to linus's tre in the merge window or before, let this chain
> know with appropriate maintainers so that we can take corrective
> actions. PS: Thanks Arnd for taking time to give me some private
> guidance. Fingers crossed that this will go through smooth.

Nishanth, Vignesh, Arnd,

Thank you for making an exception here, and allowing these patches in!
=)

I will keep an eye on drm-next and will make sure to let you all know if
the AM62 base DSS support patches get dropped for any reason.

Regards
Aradhya

> 
> Thank you!
> 
> I have applied the following to branch ti-k3-dts-next on [1]:
> 
> [1/6] arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
>       commit: 73387da70f9c26b6fba4f62371d013cce14663d9
> [2/6] arm64: dts: ti: k3-am62-main: Add node for DSS
>       commit: 8ccc1073c7bb2ae9654529a75f85ef23b7215c9b
> [3/6] arm64: dts: ti: k3-am62x-sk-common: Add HDMI support
>       commit: db6e8237cf5435e972ea47632e5d8ac3e356f210
> [4/6] arm64: dts: ti: am62x-sk: Add overlay for HDMI audio
>       commit: b50ccab9e07ca19d49a0d629dfbe184e6975be22
> [5/6] arm64: dts: ti: k3-am625-beagleplay: Add HDMI support
>       commit: 1f7226a5e52cb8b90771cefc29077f9ce13a3c90
> 
> I have applied the following to branch ti-k3-config-next on [1]:
> 
> [6/6] arm64: defconfig: Enable ITE_IT66121 HDMI transmitter
>       commit: d5c988b43746de250bed33c17116e879f032ff12
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent up the chain during
> the next merge window (or sooner if it is a relevant bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git

