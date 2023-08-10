Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCA777C61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjHJPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjHJPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:39:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C926BC;
        Thu, 10 Aug 2023 08:39:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AFcoMd017351;
        Thu, 10 Aug 2023 10:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691681930;
        bh=zA5ZpN1MjFwOd0rQ7K2vMV1GizDYUyuPvUbuu66UOjs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PYLRFMhG4jaMYJ+lf0yNtoqbdwXudDiXwuhSFnqbonZVKs8RaUiYOeGgX62X1+ZQ6
         uCu2vLGXI0e97pQ+g8LZTOGOKqdknaXvyyAd9AdxdXG3NuZu5zDlB3sr+aXR6gHIv4
         LmtruE27Bl1RfQl3N7NnkNL75gsYo3CR6vq7CC3o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AFcoIA129278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 10:38:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 10:38:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 10:38:50 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AFcohM033637;
        Thu, 10 Aug 2023 10:38:50 -0500
Message-ID: <2f0e9dde-0c6c-b808-02a0-c4ec659fc622@ti.com>
Date:   Thu, 10 Aug 2023 10:38:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: disable remote proc nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20230810005629.21738-1-hnagalla@ti.com>
 <20230810011046.ta3qapj3oj2oqs7o@value>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230810011046.ta3qapj3oj2oqs7o@value>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 20:10, Nishanth Menon wrote:
>> Disable the dsp and r5f subsystem nodes by default. Proper functioning
>> of remote processors with ipc need mailbox configurations which can
>> vary between board configurations and applications. Hence move enabling
>> the remote processor device nodes to where the required configurations
>> are complete.
>>
>> Signed-off-by: Hari Nagalla<hnagalla@ti.com>
>> ---
>> This patch fixes the remote proc yamllint errors for am69-sk board
> Fixes tag?
As such this yamllint errors for am69-sk.dtb were present in several 
earlier tags of linux-next. Checked with latest tag: next-20230809.

Please let me know if you would need v2 with the tag specified in comments.

/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@64800000: 'mboxes' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@64800000: 'memory-region' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@65800000: 'mboxes' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@65800000: 'memory-region' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@66800000: 'mboxes' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@66800000: 'memory-region' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@67800000: 'mboxes' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
/home/a0868345/git/upstream/linux-next/arch/arm64/boot/dts/ti/k3-am69-sk.dtb: 
dsp@67800000: 'memory-region' is a required property
	from schema $id: 
http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#

