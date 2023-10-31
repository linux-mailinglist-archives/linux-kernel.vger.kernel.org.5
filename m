Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A17DD69D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjJaTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:16:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A71F4;
        Tue, 31 Oct 2023 12:16:31 -0700 (PDT)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87088660739C;
        Tue, 31 Oct 2023 19:16:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698779789;
        bh=/gTUn35pxMVNvhON2z5RDIeqdGQZeEsVkG1xfnFFQu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UWkapJHFI0QYA0BZgDKo7pkdKSfFUwRupE33rQsOG/HwaQdLomOj5pA3pua3dlPdO
         H0tXuKf0U2/4B6lQeLgvLnjlEfOG4t2z0p4MH1isl4fuO5fvFG5gkFgRi8URHiYKpX
         bs8HbD5ChMP3FIDNjmni5IDoGVQ1y5+uq7gH5TpsxHVzcec9UEy8xXtmRWncwfaeEK
         aErXYgvGzEDLuNlVKog3f+cHiJxt3+6KrSqAC5uVAerQD+M9meZ/jjt+XUcbyXoXwH
         o7rd5eyc4hnmvwGFUDLz+yOGxYcQeR0IO0XyJxRaqb/tFm+OpQy1mDdx7C1oNMDFtw
         FTOFXjIqtPDyw==
Message-ID: <4f661818-1585-41d8-a305-96fd359bc8b8@collabora.com>
Date:   Tue, 31 Oct 2023 21:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
 <CAJM55Z_2hdsvw8gdYLs2kZbRrH6xcM6+xCZn8BCf5zsWYyhY3w@mail.gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z_2hdsvw8gdYLs2kZbRrH6xcM6+xCZn8BCf5zsWYyhY3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 16:40, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>
>> The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
>> expect to be able to allocate coherent memory for DMA descriptors and
>> such. However on the JH7100 DDR memory appears twice in the physical
>> memory map, once cached and once uncached:
>>
>>   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
>>   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
>>
>> To use this uncached region we create a global DMA memory pool there and
>> reserve the corresponding area in the cached region.
>>
>> However the uncached region is fully above the 32bit address limit, so add
>> a dma-ranges map so the DMA address used for peripherals is still in the
>> regular cached region below the limit.
> 
> Adding these nodes to the device tree won't actually do anything without
> enabling CONFIG_DMA_GLOBAL_POOL as is done here:
> 
> https://github.com/esmil/linux/commit/e14ad9ff67fd51dcc76415d4cc7f3a30ffcba379

Should I pick this up for v3 or maybe it would be better to be handled
as part of your ccache series?

Thanks,
Cristian

>>
>> Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> index b93ce351a90f..504c73f01f14 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> @@ -39,6 +39,30 @@ led-ack {
>>  			label = "ack";
>>  		};
>>  	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		dma-reserved {
>> +			reg = <0x0 0xfa000000 0x0 0x1000000>;
>> +			no-map;
>> +		};
>> +
>> +		linux,dma {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x10 0x7a000000 0x0 0x1000000>;
>> +			no-map;
>> +			linux,dma-default;
>> +		};
>> +	};
>> +
>> +	soc {
>> +		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
>> +			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
>> +			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
>> +	};
>>  };
>>
>>  &gpio {
>> --
>> 2.42.0
>>
