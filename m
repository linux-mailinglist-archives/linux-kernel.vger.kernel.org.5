Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA10E76FDBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHDJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjHDJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:46:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF230EB;
        Fri,  4 Aug 2023 02:46:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3749jpWa045691;
        Fri, 4 Aug 2023 04:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691142351;
        bh=j3outbqF3n0j34Bjwkt+GPyn1jRs072Kiuc9MbhIqbA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dRq5j9nSsByHHBcNWZcrMdHgHp+id/9SIeD7UZfjrfILlGN51eAX8IhEa2ycTVcTD
         Dj2hy+MQnw9plXBC5/qYdbJiSk4hh0NzqrgZ2lBxGRKNA+H0wzEbW/jndA4X2BjhVf
         vBh7AKzb3bqyClEsPGnhiCwIuaZ5saLm2dpgOQpo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3749jpvu070545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 04:45:51 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 04:45:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 04:45:50 -0500
Received: from [172.24.21.32] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3749jilx025112;
        Fri, 4 Aug 2023 04:45:45 -0500
Message-ID: <a5578fc7-04f9-9d9c-ebf1-3d788075bbcd@ti.com>
Date:   Fri, 4 Aug 2023 15:15:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable PRUSS as module
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <srk@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
References: <20230804061811.3999129-1-danishanwar@ti.com>
 <5ade5d29-5d9d-0d68-c3d8-de61ca90bb81@linaro.org>
 <ae2ad056-96de-41b7-8df4-1d9c0f5c469b@app.fastmail.com>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <ae2ad056-96de-41b7-8df4-1d9c0f5c469b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2023 2:50 PM, Arnd Bergmann wrote:
> On Fri, Aug 4, 2023, at 11:11, Konrad Dybcio wrote:
>> On 4.08.2023 08:18, MD Danish Anwar wrote:
>>> Enables PRUSS as kernel module for TI SoCs.
>>>
>>> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>> As an outsider, I have no idea what this does, and the Kconfig help
>> message doesn't say much more either.
>>
>> Could you please add a short summary about what sort of hardware
>> is driven by this driver?
> 
> Any additional information would also help, but more importantly,
> Danish please use a recipient list that has only the people on 'To:'
> that would actually apply the patch (Nishanth and Vignesh) and
> ask them to merge it, while having everyone else on Cc.
> 

Sure Arnd, I will only keep Nishant and Vignesh in to and move everyone 
else to Cc.

> The problem with addressing a trivial patch to a dozen people
> is that often everyone will think that someone else will take
> care of it. If you address a patch to just one or two maintainers,
> they are more likely to either apply it or tell you if you got
> the wrong person instead of ignoring.
> 
> For defconfig patches adding platform specific lines, there are
> two ways this can be handled:
> 
> a) the K3 maintainers pick it up into a branch and send a
>     pull request to soc@kernel.org with all the defconfig
>     changes, from where I pick that up. This usually works
>     best.
> 
> b) you send it to soc@kernel.org yourself and I wait for
>     an Ack from the K3 maintainers so I know they agree with
>     the contents as well as being bypassed as maintainers on
>     this occasion.
> 
>       Arnd

-- 
Thanks and Regards,
Md Danish Anwar
