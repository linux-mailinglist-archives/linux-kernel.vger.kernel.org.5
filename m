Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC987CE470
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJRR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B77449C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c515527310so60607911fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650118; x=1698254918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aOTkmKT0/VEUJ6dJSIOtEOBOATm/C2zJujpXbSsYL4=;
        b=J91YWiTpOUljVB0NDiQmiEDOXThof4ceXwip6WNzLVeZp/5HavbZz/+HQfvgcr+doD
         oRjHM/dSSnCZ8WOOn4BsH/inNo8Ot1EbXEAM3D3zg18KLEbOukvKewA4wXez2Iiw56SD
         ciuMaCly+a//9EdYbcUFC+jLQDT4bFwWj43ARCAa5/C5wfqwbo27AGFM+Dv4R3NDOrzv
         h41oCnUUCZDuQmmhEet3f0RVrX63zswaFU+yLKcrrd9gIx7kN/SrV0i7WNRU8RaGF/By
         36P3NBACANBC+bGiEb0q6ggvJ6NH4RIXE+fxCd0fbYbBrCabTTQCnxWdhEBazQSdW/83
         FHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650118; x=1698254918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aOTkmKT0/VEUJ6dJSIOtEOBOATm/C2zJujpXbSsYL4=;
        b=mP3gRgAvcN9KG/MRAy01rPQMpv+dI/J/bIFIBZlPVwvOxA+zwU92GfygM5sYbZB4Pf
         UD33ZmVNZi7XWx0pNmx5YmNwq2TifAVJ2DojSpyyvdrCxY4byxH9xEc0BangI3ohdQf2
         q+6nUhpjZmWJuO2vfm2P9sH7eJk8blUhfVj1AxXLy6bK7cOchEURnvsGcsG2+Cz5lDqQ
         S2PFpXzm0+uSBXtECb1sIxQxWzygLZ3yzz3PqHmUlPEpq/mTLg1j/EAX9aB3aeo3TJ7q
         1fpH53UhXCaiSepwjLpeMOrBAzec00FmRwdhPpT0Y06dlbeMK/uX3YGFGr4bt9sJCH2n
         3veA==
X-Gm-Message-State: AOJu0Yw5YzwKP40HgtZb141jumgHND5+IXBRl25Gr3WN1uQTMdcCGx9f
        QHCG7anQ+oj5HxCRL+Jlmrhy/S1YC1YIKkFITcugSg==
X-Google-Smtp-Source: AGHT+IEH/Te0HHRqLHxWdsHtRpbFbaOYrfrcIubs163vkWTt94hU44lu3W5dGfsp7LfIsZLKmD3tbWcSjooB4Tzx2jI=
X-Received: by 2002:a2e:9916:0:b0:2b9:e831:f16a with SMTP id
 v22-20020a2e9916000000b002b9e831f16amr4058294lji.26.1697650118136; Wed, 18
 Oct 2023 10:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-9-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-9-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:02 -0700
Message-ID: <CALs-HsvDtceutbdNXuBKtnTTKy_qZgzjKAi-XvwbYCYoLVRTxQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/19] riscv: add ISA extension parsing for Zfh/Zfhmin
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add parsing for Zvfh/Zfhmin ISA extensions[1].

Typo: s/Zvfh/Zfh/. Other than that:

Reviewed-by: Evan Green <evan@rivosinc.com>
