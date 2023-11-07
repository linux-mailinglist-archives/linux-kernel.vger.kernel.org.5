Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064937E36F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjKGIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjKGIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:53:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F12125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:53:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc5b7057d5so49309335ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699347199; x=1699951999; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp3uon/3Fyp4maghAodzXPtq76RuAivTg8nwoG+3C0c=;
        b=DlNK8ewekQtl7fW68gVX24qcDIoAJkkk372sd31JyRlwxmOuLvlJrzBsw+AjCbhM1z
         QGx/Bsm9R2L8T2MtnPPUrplwhuydXCbW/PDxSgPztvAY6Alms6QRspzzsL7tugV20n48
         ehRGFujL63Yx1kQiWHuvssEKJJyLSbbmZDMpXshnAx+3d6bKXb3xyDGxu8PCv+eHYKCE
         3kBFUxZlgJ+Lyj/vsPREkVrT5vOm73c7Tbii+hvV2KNG4Jni2AeAm4XvkytU0Bq4G0OI
         HZfbgcv3pfhlll7oz/nfYQG7hmQuOKjJG160yC38MsUghsHMSY0/SMcMBhLDZCTWlkeh
         mPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699347199; x=1699951999;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp3uon/3Fyp4maghAodzXPtq76RuAivTg8nwoG+3C0c=;
        b=A5e9Fiz2HgChy97+7B3M+EjpQFwK9uWm0q2t64GW1Ud1wukaJIp4NAUZmuVWhy5sXT
         PDqhMGRh/8TP1SFUUquOsodTrrZ5zsy9I/1ugLjGTspsjhbfOGVpFHCKkiekUzWO//sM
         lbfCj4n3rXtH+imZgOC5Fm/ILx2Y/tvrbR/jHG3j9M7MmEuYQB42q35ABNv5QmiyfygY
         4+jB+zkECivKeUQ3kmlCONIBAlDC4KuvmCpugk5NKYm3XMSCjxbHxat6tCrXtWvXCxSO
         iuX/1wFVqD1g/nMa/plg86N9tGT1dmsxxGyZk7CTfRrRUbbR+cb4DlrhQBhDMz2RrvOV
         CLEw==
X-Gm-Message-State: AOJu0YzobkLbkhSmaiN/HuwjwwK9KIge6W8szBG8ktvXNdmVkIwBBNJX
        q+1RhIPXSFS65Xcy7Nu24va0Sw==
X-Google-Smtp-Source: AGHT+IHL7EnzEs9/TsQ0th1iANW9oVAkCWSJCyHyWJvnKsiTXsDOfMf5GeqEirhaJ/X//VBTrJhfPA==
X-Received: by 2002:a17:902:f392:b0:1cc:64bc:ecf3 with SMTP id f18-20020a170902f39200b001cc64bcecf3mr17796493ple.34.1699347199308;
        Tue, 07 Nov 2023 00:53:19 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:8d0c:a813:4d0:7247:8a5e? ([2402:7500:4ce:8d0c:a813:4d0:7247:8a5e])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001c625d6ffccsm7136099plq.129.2023.11.07.00.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2023 00:53:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS
 implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231102051639.GF1498@sol.localdomain>
Date:   Tue, 7 Nov 2023 16:53:13 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Reply-To: 20231102051639.GF1498@sol.localdomain
Content-Transfer-Encoding: quoted-printable
Message-Id: <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
>> +static int ecb_encrypt(struct skcipher_request *req)
>> +{
>> +	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
>> +	const struct riscv64_aes_ctx *ctx =3D crypto_skcipher_ctx(tfm);
>> +	struct skcipher_walk walk;
>> +	unsigned int nbytes;
>> +	int err;
>> +
>> +	/* If we have error here, the `nbytes` will be zero. */
>> +	err =3D skcipher_walk_virt(&walk, req, false);
>> +	while ((nbytes =3D walk.nbytes)) {
>> +		kernel_vector_begin();
>> +		rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, =
walk.dst.virt.addr,
>> +					 nbytes & =
AES_BLOCK_VALID_SIZE_MASK,
>> +					 &ctx->key);
>> +		kernel_vector_end();
>> +		err =3D skcipher_walk_done(
>> +			&walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK);
>> +	}
>> +
>> +	return err;
>> +}
>=20
> There's no fallback for !crypto_simd_usable() here.  I really like it =
this way.
> However, for it to work (for skciphers and aeads), RISC-V needs to =
allow the
> vector registers to be used in softirq context.  Is that already the =
case?

The kernel-mode-vector could be enabled in softirq, but we don't have =
nesting
vector contexts. Will we have the case that kernel needs to jump to =
softirq for
encryptions during the regular crypto function? If yes, we need to have =
fallbacks
for all algorithms.

-Jerry=
