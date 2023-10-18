Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA487CE4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjJRRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjJRRdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:33:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2F3251
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so88035141fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650174; x=1698254974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DTiAxqcwOSstlD5TGw90ppzIalLYVarQh5g8chQIFI=;
        b=LC2W0kv3He9ixkVdJahVxqyepw4kQo1nQlU+Dz37sccX2pykoqE3pklbdSjAXoPHqQ
         4c97Uv776iSsICQ9RufuReQ6FXNleI0z7U5LP4cF7CcyWKIRoTBYP64wUA9RDMmygqN/
         rptId2uWXWBkPHxRgqgvhUaObAWutngijx46cvMj2kqi2YhACc5BMvq/TbN8uWQaa5F/
         3GuGRsYogFIQy/sxJyIHf2Oy23zb25k/3OoNE8qlKhR/vP8PzTK0PCV3RHfvfWgLvhOl
         OiVUx6SDmZYo27+1yPwB74JS13gkbS8yQstqbIu0faDSTJJ3pRuRrPNljaMVZ7HJBVwE
         4Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650174; x=1698254974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DTiAxqcwOSstlD5TGw90ppzIalLYVarQh5g8chQIFI=;
        b=BOCHRFkDjZGJDeo5JleueBW1gjSYVz3r3ktST0FEluSsp7BI/7TPQEDRPu3alBUevp
         sO33WjW/OkgRoN+KZ+/PfIzzi558onwSQXjZKsrlAfG2sS4IZwkVu6xvsyN9cwTCaJXx
         238leHVg91mDIuWAGkF46P2kpqodQ39AaEmfxYCkD3Ax2mynu5wbXueEh8vCpBB/TZse
         p4R6uWt3pXubzz/t5VH8RPgW2sT3YD+vgCG76nx9JstW/Wk2/OTiBwIKosP86E0ZEBg7
         vc4zmYqdFC6D7LcaiD9nVriq1cPfWFvkfNDzvyuwx1QpqXiM8Z7hnSIka+1B0OP39rN3
         6r9Q==
X-Gm-Message-State: AOJu0YwpU/aOY/zdhqbbfis8pWBib4PKZYOd4sw3er/Hi2fmGH8mplPP
        DksR5WoONY7H1QidhdQkO2E3edOcUhdnXVBNVzaN8Q==
X-Google-Smtp-Source: AGHT+IGSl/5M58lXn2uBdcMT7VrLiD0NX9sllCftagoL7/hlmkByal0UjqyOgJPJ8Ej/Z6HotqR68XE40MStcyvyXu8=
X-Received: by 2002:a2e:be03:0:b0:2c4:feef:84d with SMTP id
 z3-20020a2ebe03000000b002c4feef084dmr5219935ljq.43.1697650174385; Wed, 18 Oct
 2023 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-19-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-19-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:58 -0700
Message-ID: <CALs-HsufTbyShzXmUoczRJikjaHJ5se3Yfcp=fNAGydibZw4Aw@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] riscv: hwprobe: export Zfa ISA extension
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
> Export Zfa ISA extension[1] through hwprobe.
>
> Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/v=
iew [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
