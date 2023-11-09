Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9B7E6278
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjKIC6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKIC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:58:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571892590
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:58:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc329ce84cso3253545ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 18:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699498727; x=1700103527; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DppDE93uNSB4OmZjw8tLCue7p/imeYMCzu6NlobepZ8=;
        b=QWt2lO6zuHTDi57JkXBHKz8ANyMR6CcJlEUsLGyDQ2zkXdpj5EgAvuJHKfbT0Q+NRe
         x02fwDnXGSIo/ay8S1TBbHgUrWOQVh9Z9P6VikzpSEIelUzZ2RuIOIVwLLam6T9Rhhkx
         Mbv11mtYL9K0Y6Lp9rbfg41XL5ng9l6zISuYunDvIUPsPEvfQZ/beygwF4Av/3lGAfst
         KIMIFdPJMr/Dz4Upv0IPUotDN08YKAC5YYNrGUqfnuPAEtlAlulMHltNpX+WgAmCDqkC
         /OhWStF59Zj/bwY7iB5ZLli0W9KHrOauH9siUc5/dUr7dEjx+5a454KWbBWvqf9JnUdr
         oBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699498727; x=1700103527;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DppDE93uNSB4OmZjw8tLCue7p/imeYMCzu6NlobepZ8=;
        b=oF40PkRK45+/efU8mZTF5R0/0KAnaJHtbtGJyZ4/pHVqBPLvboz2ORjrVKerv9m06+
         sjTXDstmIeHiAjeE8PIW4OMPxe790amsEMNaDoFA6O8mNhj7Xv5kCiMCjbuAe/ua/REm
         te+pFSpC4wmgG+JChK1rP/spMufn49rDA+NrSmYYFboofaw/IQYUCNgtZhFwdcfSCkgu
         dxM9lCkZxZcRDHJGXJhq/VQ6CP94g67at6VOS17lquWhJwpUsNlV7kV/D+G8zpY/1Yol
         8Sfqg3DEpla6g06PVnEOIyj+5jVXxQE2WbhFK9DspTbKq77iqfLd/HKn6ysVI9aHX6w7
         bIxA==
X-Gm-Message-State: AOJu0YyJWYGMgY4+2ZjWtgU6vTJ4HH+GncFALD7yNFWWxHo1S5dnjSm6
        LGZuASmmr5r5FKJBr8NjvLjMSByIR7X/h4xRE4Xq5A==
X-Google-Smtp-Source: AGHT+IHn09W1cRZDEkkvIH3Oo47/42K6T4xkwgAHBTl4aY/xkO5ybUHzFNH6lbK8MUVDkJ0h6qQGkQ==
X-Received: by 2002:a17:903:2341:b0:1c9:e508:ad54 with SMTP id c1-20020a170903234100b001c9e508ad54mr4317917plh.13.1699498726815;
        Wed, 08 Nov 2023 18:58:46 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:aeef:31cf:49a7:c:20d4? ([2402:7500:4ce:aeef:31cf:49a7:c:20d4])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902740400b001c465bedaccsm2383368pll.83.2023.11.08.18.58.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2023 18:58:46 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v3 06/20] riscv: add ISA extension parsing for vector
 crypto
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231107105556.517187-7-cleger@rivosinc.com>
Date:   Thu, 9 Nov 2023 10:58:41 +0800
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Reply-To: 20231107105556.517187-7-cleger@rivosinc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EF129A2-195B-4207-A2F6-DBA1FBB9F65D@sifive.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
 <20231107105556.517187-7-cleger@rivosinc.com>
To:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 7, 2023, at 18:55, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> =
wrote:
> +static const unsigned int riscv_zvknhb_exts[] =3D {
> +	RISCV_ISA_EXT_ZVKNHA
> +};
> +

> +	__RISCV_ISA_EXT_SUPERSET(zvknhb, RISCV_ISA_EXT_ZVKNHB, =
riscv_zvknhb_exts),
> +	__RISCV_ISA_EXT_BUNDLE(zvks, riscv_zvks_bundled_exts),

The Zvknha and Zvknhb are exclusive. It's not the superset relationship.

Please check:
https://github.com/riscv/riscv-crypto/issues/364#issuecomment-1726782096

-Jerry=
