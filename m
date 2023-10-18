Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7BC7CE4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjJRRcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjJRRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8E44A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so81783811fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650130; x=1698254930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlxzenAtGOBBl5FAqiPH6k/I934Jd+ferEyJouIx4OM=;
        b=jRZhIpRLvHx99GWRzosWKHGQA31uO+NHuBTXGM9WDScHZA7wl94szidBj3Qo1JDcAU
         eWmU2ktDFVEbc7mC9J89bTay2mSkl9XYrk1EhglM0gDycQn7dHOKECNlUb35W9Ju9bqJ
         DQhAoU8ZF2R83e4z0LPKTmACqRTB/vYcRVvoxAClPkbA5N5LCD5ZLi0qid5lY1QQ6eMC
         gX75gtTppq9iz9RoAGNw9KUMFDn2bNhjtBJ0nmdSuTXUrgPKWnHpRHzWrAlmVthk8KFU
         BavzRf0mwFWkq8QwnZyfGQzdXevjkfoxdIShIoN0hnU+ExhBBkQ3jjUwmW/S8r29wXKC
         vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650130; x=1698254930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlxzenAtGOBBl5FAqiPH6k/I934Jd+ferEyJouIx4OM=;
        b=Zba703giyMC+yEhnh4RWTmwohKjbsnvgPrN6vX/kuRRyma/R27iqhfi8LxM8NQQlg/
         hXbBIh4AM7y56YgPx2m0YBE/P/jGO7jFV9Mry3cIkL6BgHtHkS9KSan2Zi7fT/FwQKdN
         yak7E7qE7cA/ycqASDqDO0zmmDsIJKyTlPSUAzBYYb3sphsvYVg3RdG2aYsSRDacUTqU
         ZkyTEfN5hlGZOsbOTSUq027QR2Fyoc3CgvD79/dmBKPPsVHdfpTBmh8WaNgO9M7J+CFK
         eC87CosE2dhzxwjnGMDKpWCIQyaP9ydpSlfvgyk/wjWQnvFjT441L5WkD7Q07TFqtwEB
         CJ2g==
X-Gm-Message-State: AOJu0Ywj8LhIdBFOJsKQQQah2L8FbcHZXJ/MaGJ+7M+Gi35nsJP643P4
        djGw3OOosXR3pqPzu4M3u/JoV0Dzj/nSC+oJ39fJtA==
X-Google-Smtp-Source: AGHT+IGHruj4vIi0kef+bVD+gPV4FxwyxPA0I1qw/x4/ZVHhtOHwosRH5M2N+IuPXDxc9LdApCvF7N2Iujro1xmxL7A=
X-Received: by 2002:a2e:9107:0:b0:2c5:1c9d:7f81 with SMTP id
 m7-20020a2e9107000000b002c51c9d7f81mr4392793ljg.32.1697650129601; Wed, 18 Oct
 2023 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-10-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-10-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:13 -0700
Message-ID: <CALs-Hsu4_sJ-qPXdg--p6+u9Zu_+FFZVAPp=D7SEuR-XG_A-nw@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] riscv: hwprobe: export Zfh/Zfhmin ISA extensions
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
> Export Zfh/Zfhmin ISA extensions[1] through hwprobe only if FPU support
> is available.
>
> Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/v=
iew [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
