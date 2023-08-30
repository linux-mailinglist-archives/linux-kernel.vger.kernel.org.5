Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0EE78E04B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbjH3TJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbjH3NtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:49:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08A9E8;
        Wed, 30 Aug 2023 06:49:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UDmsSH069738;
        Wed, 30 Aug 2023 08:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693403334;
        bh=k3G+QCd0qq+SmUmXwQ1w+6uf1+2cGUO++sEcK3YjTPM=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=iz8aBw26EMlFJ3f4qOvXvi5WCcONePsIYPOQ75mdUaRjlqzKVcBpjiB17nxzgktvq
         0+sKBr1nJV3xEyNPx43OCQyCcum61cZeOIvnRjplbzQVdDRgJkLOQI6bKDwFr7n7HU
         8ojsmayw0NReO5596uAOaoeVnn+vpuX/mtnrIxDg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UDmssS019352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 08:48:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 08:48:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 08:48:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UDmrha038381;
        Wed, 30 Aug 2023 08:48:54 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kamlesh@ti.com>
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v2 0/6] Add support for
 Texas Instruments MCRC64 engine
In-Reply-To: <20230822051710.GC1661@sol.localdomain>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230812030116.GF971@sol.localdomain>
 <87h6owen39.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20230822051710.GC1661@sol.localdomain>
Date:   Wed, 30 Aug 2023 19:18:53 +0530
Message-ID: <87v8cwd4je.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Aug 18, 2023 at 02:36:34PM +0530, Kamlesh Gurudasani wrote:
>> Hi Eric,
>> 
>> We are more interested in offload than performance, with splice system
>> call and DMA mode in driver(will be implemented after this series gets
>> merged), good amount of cpu cycles will be saved.
>
> So it's for power usage, then?  Or freeing up CPU for other tasks?
>

It's for freeing up CPU for other tasks

>> There is one more mode(auto mode) in mcrc64 which helps to verify crc64
>> values against pre calculated crc64, saving the efforts of comparing in
>> userspace.
>
> Is there any path forward to actually support this?
>
>> 
>> Current generic implementation of crc64-iso(part of this series)
>> gives 173 Mb/s of speed as opposed to mcrc64 which gives speed of 812
>> Mb/s when tested with tcrypt.
>
> This doesn't answer my question, which to reiterate was:
>
>     How does performance compare to a properly optimized software CRC
>     implementation on your platform, i.e. an implementation using carryless
>     multiplication instructions (e.g. ARMv8 CE) if available on your platform,
>     otherwise an implementation using the slice-by-8 or slice-by-16 method?
>
> The implementation you tested was slice-by-1.  Compared to that, it's common for
> slice-by-8 to speed up CRCs by about 4 times and for folding with carryless
> multiplication to speed up CRCs by 10-30 times, sometimes limited only by memory
> bandwidth.  I don't know what specific results you would get on your specific
> CPU and for this specific CRC, and you could certainly see something different
> if you e.g. have some low-end embedded CPU.  But those are the typical results
> I've seen for other CRCs on different CPUs.  So, a software implementation may
> be more attractive than you realize.  It could very well be the case that a
> PMULL based CRC implementation actually ends up with less CPU load than your
> "hardware offload", when taking into syscall, algif_hash, and driver overhead...
>
> - Eric

Hi Eric, thanks for your detailed and valuable inputs.

As per your suggestion, we did some profiling. 

Use case is to calculate crc32/crc64 for file input from user space.

Instead of directly implementing PMULL based CRC64, we made first comparison between 
Case 1.
CRC32 (splice() + kernel space SW driver) 
https://gist.github.com/ti-kamlesh/5be75dbde292e122135ddf795fad9f21

Case 2.
CRC32(mmap() + userspace armv8 crc32 instruction implementation)
(tried read() as well to get contents of file, but that lost to mmap() so not mentioning number here)
https://gist.github.com/ti-kamlesh/002df094dd522422c6cb62069e15c40d

Case 3.
CRC64 (splice() + MCRC64 HW)
https://gist.github.com/ti-kamlesh/98b1fc36c9a7c3defcc2dced4136b8a0


Overall, overhead of userspace + af_alg + driver in (Case 1) and ( Case 3) is ~0.025s, which is constant for any file size.
This is calculated using real time to calculate crc  - driver time (time spend inside init() + update() +final()) = overhead ~0.025s    

Here, if we consider similar numbers for crc64 PMULL implementation as crc32 (case 2) , we save good number of cpu cycles using mcrc64
in case of files bigger than 5-10mb as most of the time is being spent in HW offload.

+-------------------+-----------------------------+-----------------------+------------------------+------------------------+
|                   |                             |                       |                        |                        |
| File size         | 120mb(ideal size for us)    | 20mb                  | 15mb                   | 5mb                    |
+===================+=============================+=======================+========================+========================+
|                   |                             |                       |                        |                        |
| CRC32 (Case 1)    | Driver time 0.155s          | Driver time 0.0325s   | Driver time 0.019s     | Driver time 0.0062s    |
|                   |    real time 0.18s          |    real time 0.06s    |    real time 0.04s     |    real time 0.03s     |
|                   |    overhead 0.025s          |    overhead 0.025s    |    overhead 0.021s     |    overhead ~0.023s    |
+-------------------+-----------------------------+-----------------------+------------------------+------------------------+
|                   |                             |                       |                        |                        |
| CRC32 (Case 2)    | Real time 0.30s             | Real time 0.05s       | Real time 0.04s        | Real time 0.02s        |
+-------------------+-----------------------------+-----------------------+------------------------+------------------------+
|                   |                             |                       |                        |                        |
| CRC64 (Case 3)    | Driver time   0.385s        | Driver time 0.0665s   | Driver time 0.0515s    | Driver time 0.019s     |
|                   |    real time 0.41s          |    real time 0.09s    |    real time 0.08s     |    real time 0.04s     |
|                   |    overhead 0.025s          |    overhead 0.025s    |    overhead ~0.025s    |    overhead ~0.021s    |
+-------------------+-----------------------------+-----------------------+------------------------+------------------------+
