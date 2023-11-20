Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9E7F0AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjKTCz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTCzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:55:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A8129
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:55:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf57430104so5648315ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700448921; x=1701053721; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg0x+T7ON9fvA/nzihMoJz0oESLmev7sCZPefVlmBec=;
        b=XCfQaYGD3kim/PryMxmOLrrxKGGu7Y4LoX3vYagam2aQvIUe0ppG46YC8TpxkAJDjp
         vOjA2FkUyTDlm6ovhnd7CnCcXO+0aieBdEYU1GEcCLSmQ18odyrzTRARE/sy+FG1bQ+x
         44TYvwPQxmW1cEBg1eejTF7JLOkX4bc2bshcws0fstFIycDhTou6d9TS/yR8K5Ud4V70
         hmjfZ27S6wohFeeZ46R0nlgMpBgc/yUH2FNWRa0z2olW8BdChWlmn1+4fI33LEHfVvvS
         Vzh6c6ogfSkaxfmP2URVPLi1gefO0/mDc7o+mC8Y0T9sAUi0WLNzPOscA1ZWA41Ox3xC
         wjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700448921; x=1701053721;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg0x+T7ON9fvA/nzihMoJz0oESLmev7sCZPefVlmBec=;
        b=eRtTN//yZWGZ695GMX9NNityqk3KYZOhb8ApsqK4rtnSAbCcUPUJygtv/kj0H03Yuv
         55JIaYpP0OW2LfzrrHRS3uGj8mSI8C4gVEYdF7Ux5F+48/M2T6o0KDhoS2pwiJmnR63K
         1BnXrObEiAo9NhJqJB/9R3DRTbGs+l0YE/9pCBp5p39CE5FII862cJH/QjQ4RR109+OQ
         8L9NEJ7N+Cij5gnPK5y6oHjnVnQsY82NSorxQl7xv1qa2M7CAw8AJeGDCMcw0BSQciBj
         R0IiPF7mQEXqDhitT1GudegrgSXK5BQnapyOlUjJMvLZ8aI1WgRIU/TwV0Hcj0CUWeK/
         4Vfw==
X-Gm-Message-State: AOJu0YzuzxY4TmQduO12cm4eOStlpsNB0v5QAL5gzbNSMozogjXR8XNW
        EBIe3SMFV1L6T1v7Susz7jRAOw==
X-Google-Smtp-Source: AGHT+IFuUjPi2Oe7rzisQHOcyNkxqx5t2yhJXAk9a4Ri2HQ4FV08v9d3S1jEA/pZSew+J7asN5OR5A==
X-Received: by 2002:a17:902:8b85:b0:1ca:86b:7ed9 with SMTP id ay5-20020a1709028b8500b001ca086b7ed9mr4657249plb.40.1700448920948;
        Sun, 19 Nov 2023 18:55:20 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:bc21:3420:fefa:20d4:2a2f? ([2402:7500:5d5:bc21:3420:fefa:20d4:2a2f])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001cc256ce1besm4928265plb.138.2023.11.19.18.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 18:55:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231102054327.GH1498@sol.localdomain>
Date:   Mon, 20 Nov 2023 10:55:15 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 2, 2023, at 13:43, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:44AM +0800, Jerry Shih wrote:
>> +static struct skcipher_alg riscv64_chacha_alg_zvkb[] = { {
>> +	.base = {
>> +		.cra_name = "chacha20",
>> +		.cra_driver_name = "chacha20-riscv64-zvkb",
>> +		.cra_priority = 300,
>> +		.cra_blocksize = 1,
>> +		.cra_ctxsize = sizeof(struct chacha_ctx),
>> +		.cra_module = THIS_MODULE,
>> +	},
>> +	.min_keysize = CHACHA_KEY_SIZE,
>> +	.max_keysize = CHACHA_KEY_SIZE,
>> +	.ivsize = CHACHA_IV_SIZE,
>> +	.chunksize = CHACHA_BLOCK_SIZE,
>> +	.walksize = CHACHA_BLOCK_SIZE * 4,
>> +	.setkey = chacha20_setkey,
>> +	.encrypt = chacha20_encrypt,
>> +	.decrypt = chacha20_encrypt,
>> +} };
>> +
>> +static inline bool check_chacha20_ext(void)
>> +{
>> +	return riscv_isa_extension_available(NULL, ZVKB) &&
>> +	       riscv_vector_vlen() >= 128;
>> +}
>> +
>> +static int __init riscv64_chacha_mod_init(void)
>> +{
>> +	if (check_chacha20_ext())
>> +		return crypto_register_skciphers(
>> +			riscv64_chacha_alg_zvkb,
>> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static void __exit riscv64_chacha_mod_fini(void)
>> +{
>> +	if (check_chacha20_ext())
>> +		crypto_unregister_skciphers(
>> +			riscv64_chacha_alg_zvkb,
>> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
>> +}
> 
> When there's just one algorithm being registered/unregistered,
> crypto_register_skcipher() and crypto_unregister_skcipher() can be used.

Fixed.

>> +# - RV64I
>> +# - RISC-V Vector ('V') with VLEN >= 128
>> +# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
>> +# - RISC-V Zicclsm(Main memory supports misaligned loads/stores)
> 
> How is the presence of the Zicclsm extension guaranteed?
> 
> - Eric

I have the addition extension parser for `Zicclsm` in the v2 patch set.


-Jerry

