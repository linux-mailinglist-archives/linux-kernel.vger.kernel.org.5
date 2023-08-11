Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D64778792
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHKGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHKGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:40:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9D2694;
        Thu, 10 Aug 2023 23:40:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37B6eBOd021185;
        Fri, 11 Aug 2023 01:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691736011;
        bh=jF7veAJCg7xxofNq8kFXr6on39XUtII8DDbN01UPOg8=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=MhHDCWrW7h5mBgJXO24FHVkVesCB2J1yMupcXIKgKUUEhjv0ANFaSIFdhoq1W+EBh
         riNtETxC2Mrr0SMFPYC2wRJZR0jNszh/ZCbWKD1aapk+XXLq+7HX0+ZOjm0EVuJyBb
         LqskMROLcAzz3aYAD+h86I8WyRXq65Engmxb/tMA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37B6eBpO122620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 01:40:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 01:40:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 01:40:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37B6e914007531;
        Fri, 11 Aug 2023 01:40:09 -0500
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
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/6] crypto: crc64 - add crc64-iso
 framework
In-Reply-To: <20230811042423.GA1295@sol.localdomain>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
 <20230811042423.GA1295@sol.localdomain>
Date:   Fri, 11 Aug 2023 12:10:09 +0530
Message-ID: <87r0oadquu.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Aug 11, 2023 at 12:58:49AM +0530, Kamlesh Gurudasani wrote:
>> diff --git a/lib/crc64-iso.c b/lib/crc64-iso.c
>> new file mode 100644
>> index 000000000000..d6e803124fa0
> [...]
>> +u64 crc64_iso_update(u64 crc, const unsigned char *buffer, size_t len)
>> +{
>> +	struct {
>> +		struct shash_desc shash;
>> +		u64 crc;
>> +	} desc;
>> +	int err;
>> +
>> +	if (static_branch_unlikely(&crc64_iso_fallback))
>> +		return crc64_iso_generic(crc, buffer, len);
>> +
>> +	rcu_read_lock();
>> +	desc.shash.tfm = rcu_dereference(crc64_iso_tfm);
>> +	desc.crc = crc;
>> +	err = crypto_shash_update(&desc.shash, buffer, len);
>> +	rcu_read_unlock();
>> +
>> +	WARN_ON_ONCE(err);
>> +
>> +	return desc.crc;
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_iso_update);
>> +
>> +u64 crc64_iso(const unsigned char *buffer, size_t len)
>> +{
>> +	return crc64_iso_update(0, buffer, len);
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_iso);
>
> These functions are never called.
>
> Why are you trying to add unused code to the kernel?
>
> - Eric
Thanks for the review, Eric.

Will remove this in next revision.

Regards,
Kamlesh
