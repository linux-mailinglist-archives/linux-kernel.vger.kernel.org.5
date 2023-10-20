Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033307D0692
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbjJTCni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:43:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE6130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:43:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9fa869a63so2630965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1697769812; x=1698374612; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDoTNufgUg8VIMedry3dGiEENRRb4/cr/7WsD8Tt8Go=;
        b=iVHEBMUeSeqJ/1x2HN+OqCzMQkEBddYTaASjW5NIDZPXEkvuJ5UIgwDfnfHWUVIWRO
         fwxTO5LFBuTmBnebYIMY7iFUjoNid9aBw30gWzO03gmaURU7nbF2cvQqzCvPDA2v8LVp
         uO949UqK0uPN5Gipv7PO/sHTRXzb9GSJ68axsTgUWIEsrSdCrv0znmfh/Hghh5TqG9wa
         ZufmNgaMqHNqYV1Oh6GA/DDS9p5ad/RrdkU1kjRi1enQ2KGcZuSQ4sS4gQhSdzjNHSjt
         C2MgrVFwXiUC8Blv7FvLs6Jzfds+gifeLSZoAn8pkXYj+RvoffgD6NkKbYBrjZAvV5nh
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697769812; x=1698374612;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDoTNufgUg8VIMedry3dGiEENRRb4/cr/7WsD8Tt8Go=;
        b=l8OGGsO5gVF8XCBHoO9IL/RIevtm3B+yPXaolmcYwWZLPW+MPOmjEkz+E4YkEhQ0Mx
         njLwqnhvMzgvo57JNe2r9xb34ZBwqUlaS4sMXvtSBtXCfJEwIfcsT9O5uKBEiuNIXP4n
         CMjGfy2EcmA3kyX8Cem7i7UkkE6N6usfzBziUq0i3Hrag+jnGv4wyhTX/mkw5Kj1xQIf
         FG+DwndFj4CCPXJ96fx7Qp8+KcTjqnISdLGxhiaYH/lQBmtwydXH0xCRPbG/ilvX0I7B
         lShFYB0KC9iL1vITA3Fnu2dydpoxNE1WSpLKiejwv6VPlzljGl/gKdNySnxH3cXpddBB
         19oQ==
X-Gm-Message-State: AOJu0Yx6NQ6bJVLAxcmOX2J1o6qnWrsiJG7Xhfl+SFwj3I/b1TES6+ZQ
        9NGtkrk48j7XV9+qkViVxO3Ytg==
X-Google-Smtp-Source: AGHT+IGXBA72PnmS62ZR4OQ5kEhD/+NqQEwfcdeZ7uNa3mZO/crAV6WwCtdwJk3FS8Io2v66p3iXrA==
X-Received: by 2002:a17:902:ed83:b0:1c5:9c73:c91c with SMTP id e3-20020a170902ed8300b001c59c73c91cmr718957plj.48.1697769812206;
        Thu, 19 Oct 2023 19:43:32 -0700 (PDT)
Received: from ?IPv6:2402:7500:5ce:a18a:15ff:8e1:37b4:22a1? ([2402:7500:5ce:a18a:15ff:8e1:37b4:22a1])
        by smtp.gmail.com with ESMTPSA id jk10-20020a170903330a00b001c3a8b135ebsm392221plb.282.2023.10.19.19.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 19:43:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
Date:   Fri, 20 Oct 2023 10:43:26 +0800
Cc:     Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Reply-To: 7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E30E7352-1FB0-4DB5-94C3-2C6FC2A6F484@sifive.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com>
 <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
To:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2023, at 17:35, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> =
wrote:
> On 18/10/2023 19:26, Evan Green wrote:
>> On Wed, Oct 18, 2023 at 5:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger =
<cleger@rivosinc.com> wrote:
>>>=20
>>> On 18/10/2023 03:45, Jerry Shih wrote:
>>>>=20
>>>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be =
bundled with `Zvbb`.
>>>=20
>>> Hi Jerry,
>>>=20
>>> Thanks for catching this, I think some other extensions will fall in
>>> this category as well then (Zvknha/Zvknhb). I will verify that.
>>=20
>> The bundling mechanism works well when an extension is a pure lasso
>> around other extensions. We'd have to tweak that code if we wanted to
>> support cases like this, where the extension is a superset of others,
>> but also contains loose change not present anywhere else (and
>> therefore also needs to stand as a separate bit).
>=20
> For Zvbb and Zvknhb, I used the following code:
>=20
> static const unsigned int riscv_zvbb_bundled_exts[] =3D {
> 	RISCV_ISA_EXT_ZVKB,
> 	RISCV_ISA_EXT_ZVBB
> };
>=20
> static const unsigned int riscv_zvknhb_bundled_exts[] =3D {
> 	RISCV_ISA_EXT_ZVKNHA,
> 	RISCV_ISA_EXT_ZVKNHB
> };
>=20
> Which correctly results in both extension (superset + base set) being
> enabled when only one is set. Is there something that I'm missing ?

We should not bundle zvknha and zvknhb together. They are exclusive.
Please check:
https://github.com/riscv/riscv-crypto/issues/364#issuecomment-1726782096

-Jerry

