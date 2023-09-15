Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D267A12EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjIOB3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjIOB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:28:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFA2100;
        Thu, 14 Sep 2023 18:28:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc0d39b52cso13957675ad.2;
        Thu, 14 Sep 2023 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694741334; x=1695346134; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njb5nxfBOiRZsqkfkDCdtMn4zV0CHNcc0b53FSbSvDk=;
        b=M1nRHYil2PdhrNp79H50VoXnhIm44DCeOO2CK3FIwgPI4hNHQwKcyQPwWvc5u4agoV
         U1/aqJs0BlRXE70lbpkiZaqvK4dpTYyQOkVk8DOZCfyFi82Xj9JXvpo/5M5oUb9hV8w9
         IWXHj8z0hrHf7sw0DAyq11xPVhBH3+ooR1+Vxf38jIvmwlwAucwm1eLUcfyTR3jESoRe
         YIooab+Mqnkbye0Y1M1/LPdAJsPNb2qFW9ZRkNRxyshN75wMez/S4TgfdF7KEoez1OsC
         LZEVytzZQ4itiC8FdFC3sx5WUdSva5s2oYDTqSBclVt21CroRphWZ5WkUBg/KWTxEEDw
         ULoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694741334; x=1695346134;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Njb5nxfBOiRZsqkfkDCdtMn4zV0CHNcc0b53FSbSvDk=;
        b=Xw3EjkZgzPwScXurxLf50mvgDeuiutB51m+0AZl7gnUNb9sAvM0hOtWz34KzfrA15Y
         hy8Qei/6OdzKyU4GQOTSZppKMygmXjHx5PAXob2+DyFSJRILwzw1uyE/zlCLvEQRGiAq
         Vl4951ibPvX50JJDFHJqLe3GNnpZlrNQjUFcpqerPuxxILWSiiUu4ksNIWuXXEe/1TBm
         dewuOm2gf4vg44Dz3LooOl4YcLhaZC9UKKJt+aXbt/Zb2aTcZ4W2OlD+36Jq/rwVHIKR
         54Da+25In9w8L4pzNruIzTw51W1RR7idGUwi6DXvtADoOR3SbUePflCRLd9LiFR0PK5R
         yAlQ==
X-Gm-Message-State: AOJu0YzSwMcMtjaKZytkWGgvJhJOcMDnbLzyUClAPVZd3heYSOBZ2Lq4
        XA0hVlcV5Y/z384+yRtiLjE=
X-Google-Smtp-Source: AGHT+IHIoKHpNVoOGVVa41JrXrpya9Ksz+fxttZexrHmiutl1tkYeMKrQQqAHf/kcxk0JTqnZKL8qg==
X-Received: by 2002:a17:902:f80d:b0:1bc:382b:6897 with SMTP id ix13-20020a170902f80d00b001bc382b6897mr294837plb.13.1694741334104;
        Thu, 14 Sep 2023 18:28:54 -0700 (PDT)
Received: from ?IPv6:2402:7500:5ce:c546:8426:5e14:d5b7:9128? ([2402:7500:5ce:c546:8426:5e14:d5b7:9128])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709027b9000b001c3a8b135ebsm2192536pll.282.2023.09.14.18.28.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:28:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 10/12] RISC-V: crypto: add Zvkned accelerated AES
 encryption implementation
From:   He-Jie Shih <bignose1007@gmail.com>
In-Reply-To: <1BB805D3-FF47-4A58-8507-CCA72A27DD82@sifive.com>
Date:   Fri, 15 Sep 2023 09:28:49 +0800
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Reply-To: 1BB805D3-FF47-4A58-8507-CCA72A27DD82@sifive.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <481D910C-8D83-4A6D-9D22-3D3A7C4723E6@gmail.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-11-heiko@sntech.de>
 <20230721054036.GD847@sol.localdomain>
 <CCA32056-CCE2-4FB5-8CFC-62444CDDA89F@sifive.com>
 <CAMj1kXEGnZC6nge42WeBML9Vx6K6Lezt8Cc1faP+3gN=TzFgvA@mail.gmail.com>
 <1BB805D3-FF47-4A58-8507-CCA72A27DD82@sifive.com>
To:     CAMj1kXEGnZC6nge42WeBML9Vx6K6Lezt8Cc1faP+3gN=TzFgvA@mail.gmail.com
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 12, 2023, at 15:15, Jerry Shih <jerry.shih@sifive.com> wrote:

>> This pull request doesn't appear to contain any XTS code at all, only =
CBC.
>=20
> We have some license issues for upstream. We will append the =
specialized
> AES modes soon.

We have the XTS and other specialized AES modes in OpenSSL PR[1] now.
The specialized implementations all perform better than generic =
implementation
on FPGA.
We will try to make that implementations happen in kernel.

-Jerry

[1]
https://github.com/openssl/openssl/pull/21923

