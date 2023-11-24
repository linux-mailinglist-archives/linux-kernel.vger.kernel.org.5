Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248297F6FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjKXJfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:35:00 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77208130
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:35:07 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cc69df1b9aso16228347b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700818506; x=1701423306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SHecEy2reWyVq6gokigk87oNgyZXlFO8Jl47Eo+PHk=;
        b=buo0vSZZ5hj1Jui8YpZAdhxX/XzQPMicygChRbNEkPDy45avRYqRWrc1TrHfQhOPey
         PJ2HXcfvE/jJz7ISsqcP3pCGTPNKfjjJTV8Jsxtt/OqBvSH0mts8q1BccxNkUDCNWaFL
         rWkorTKnbdKB4lqMnqdtkPC9sNC6f3Xf7YnPZVK7boUvZIlcONSD2bX5bz84+F49fTv8
         lteEkkzC3p3aH+JCFU98bliOrBuRPoayVaQt8XAComSYDiYUF44lBvCYMwBdmLERvKKV
         FOMkutOAlWg4xM5YHMzMvrA09lak6S9eWLMWF/4FMVYrnEmUjKshIA5Kr5+ZlQ3ZnTuF
         gzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818506; x=1701423306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SHecEy2reWyVq6gokigk87oNgyZXlFO8Jl47Eo+PHk=;
        b=LEoAKm78MmVl8AFM7Kny6zaeurJmVcaH/c1KRXfcQEW+tjH5pBQ2HiYm2h9p+LQ7pT
         BcRcb8lCDU1ZR9BsRMF7+PvfQpKkO2uvSn8c/N3IfZ/9tEhaT07bczyeiLNkHHLpNRDF
         HexquI2d5B7cSv5M6EOmGGbpvkKhyRAk/CiRBNtXtBJNgzDYjFwYf+zjBvB7zGlC/GcL
         ODTmcJKBtaVB0aKD7ZPSzbLoHWm7VP4R0o+i58IjNpuiqliER5Euj40jzW+nOzXqBv40
         H67KDr3V5xB/Z4ZirTJoOLarkBCDkRymNfiaT+PcT7LHyPU97q0755n7gTF/kaOzz+VC
         LG/g==
X-Gm-Message-State: AOJu0YwYNwSKEiTRReoCOCXaiKkS/jk3SPMp+jiJaGgEa70SR2VPbDF5
        TiLXdXR0tKl5lJUfEWBJsafpIvbIfN04fQ+QlaUtkg==
X-Google-Smtp-Source: AGHT+IHTnq655PO1TC9AIlExkPFnCObiXs+7CC9ZqZj6DdVgSgoNeNgxfsrG5JakHQ6ZBLG9MPDRP/p+13LbIsix33c=
X-Received: by 2002:a81:728a:0:b0:5ca:d5b9:9da3 with SMTP id
 n132-20020a81728a000000b005cad5b99da3mr1868805ywc.41.1700818506693; Fri, 24
 Nov 2023 01:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20231116001913.16121-1-clin@suse.com>
In-Reply-To: <20231116001913.16121-1-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:34:55 +0100
Message-ID: <CACRpkdb_1GLcusRbC6RtprDMu=Sxci9e-ew3gKUcsQQRxT65Fw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: s32g2: change a maintainer email address
To:     Chester Lin <clin@suse.com>
Cc:     Ghennadi.Procopciuc@oss.nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 1:19=E2=80=AFAM Chester Lin <clin@suse.com> wrote:

> I am leaving SUSE so the current email address <clin@suse.com> will be
> disabled soon. <chester62515@gmail.com> will be my new address for handli=
ng
> emails, patches and pull requests from upstream and communities.
>
> Cc: Chester Lin <chester62515@gmail.com>
> Cc: NXP S32 Linux Team <s32@nxp.com>
> Cc: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Chester Lin <clin@suse.com>

Patch applied.

Yours,
Linus Walleij
