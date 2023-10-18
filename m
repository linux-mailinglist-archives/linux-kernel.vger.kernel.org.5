Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5EC7CE4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJRRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:33:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0A170F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5056059e0so84312551fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650161; x=1698254961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAT+E2Mqww2+Xf9ub965fid4r/e0BGLFO3gBSbvEEyQ=;
        b=WdIVHNn185WrCBxZcxeK6EpHAm663qxgoDNWOTzFmYKl/5CTDaBmjvxkA3ULQrCSPT
         m4vq4bJCAM5g65oDxaw1iCzgMRWE4j7X6L4YXOYPT5Fp7TR3sjoLhh01FmlWcOYEiHpa
         AIm6RaeGuuFoKOL3LoOW88PxgAirIMqJHntp2hRXPF5BajDdKGZCsuha6G5JB8swo5nv
         wd/zfQxQRIPeRvleWn0aPBZv8/VSa3HWyONrSV9vn/OGCCCGAp30/EAJtUC1uAJksVh3
         cpwqP2PFPwYHDvE5Xn30d9AihUBtS6oKHCeZ8XTjKBtmOQGqmcGR8b8eS6ZxbQWVYMT0
         8eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650161; x=1698254961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAT+E2Mqww2+Xf9ub965fid4r/e0BGLFO3gBSbvEEyQ=;
        b=hAbXwFR41we+S6OFL6tB/dhOwuy2QWxrB9iXRFZd6OeUj9Im766CeF5SUpOGvqBKpi
         Qs+UmRS3tbgWXa/5AKt7Ex+CNoSEN5DEHvG/6RuphfiF1YrNojNXSIoBQ52NxCi1K1k3
         6PgHZBaAFAYYKGmJPQWTXuCn/XnTtaLGsEpLEuw6tGDyDrYGn2Pht1WvgmDVjfbw1dpg
         QUKG3m7vF0wai8Al6f1X2fdc3WwCdqTrOwY9KWzhronwJEus+uio0+tG5MgA3/3Wiz9l
         ReAQ1zOqf6I87Pje5GAR2x4K5FTzIiDnpxjIInDITamx1K4Yvv5+w2Do21bEX0+23v2h
         c0Nw==
X-Gm-Message-State: AOJu0YzhBBiSiuc51D6W1mwrIPVP1ngSpE8mWamTG+LB9t8POJMoW5x9
        Uz1oKaQtI//3yvDcli3huv8R13OreLw9NfbQS3QrGg==
X-Google-Smtp-Source: AGHT+IEfrz0unC2GiQPrG2JuKmc9QnUuo5JLCp2+gYk1KnHMA7dr2bOwgXlPjCwKOCgOOnKI1jFbT+XgHxTamtCDl18=
X-Received: by 2002:a2e:b5da:0:b0:2c5:25f3:8e1c with SMTP id
 g26-20020a2eb5da000000b002c525f38e1cmr3998973ljn.21.1697650161325; Wed, 18
 Oct 2023 10:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-16-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-16-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:45 -0700
Message-ID: <CALs-HsuG7FRpbaJaj+q4gEhJnAyVvZv8osDCJ4irrXEJaMd=hQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] riscv: hwprobe: export Zvfh[min] ISA extensions
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
> Export Zvfh[min] ISA extension[1] through hwprobe.
>
> Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/v=
iew [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
