Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25319802F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjLDKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjLDKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:01:33 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CADF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:01:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b8b4670c78so1204159b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684099; x=1702288899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd61zuTaGvBLC3sGbDHe9BWUJ17pWi39qwJjhflG3lY=;
        b=U26kuNsDVQE6rWtgetWeAYl4V44DRcukkTomR22YFI2kG/1vHa1IYXNxLAfvWQViuo
         +x2sPJB13lKHAyOnRpSySztUeDF75S5LcPLcmFPljnld4Y9VoQUBLS8yW6JumDOfiyzV
         Kd2uHZ24mkPvPb6nVCssQMEPuhFtUkNX/NkSGLLDWcPI+q4XM8/7A438k+psrMcLAJlQ
         3Y1viFQ0jAOSIoqZuMJy6FQiDOCA4++hnfSHLI8cGEsZixKwWBk8p0kyAIKEnszA3HPZ
         yu8LdYtkvJh7LxlKINz5tGiwTxh1AYEqcurX5oXKuschG2VtIQCg3SSVnLQ3Q56UDGCI
         iseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684099; x=1702288899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd61zuTaGvBLC3sGbDHe9BWUJ17pWi39qwJjhflG3lY=;
        b=tyNEPlzFOkB9qARQcl3CzRdFB7VxYhmsucDt4MJ/Z3zuDpWF86Y5vxGNPfSrOnpTEB
         z/kL/cNxWuiMMhaUa9FepfU50ZEB92f8fpu+kFGmvZuwSAaOUEGWidPOG4czeyY20LBz
         Eb5Z675KFh/hZDE8lo85nS/lyftRjX3dVQzvL9rQLP7x+IwFMIr2HPIyXJAQ2oUHnk2c
         WdacmAX6v1wvnrr/XY+JFTQFa8k/pcjjEE7LDb5aWx4jKxRcB7gx21qOtlZcHBNtBZcw
         BEpzvCx6Rtvnh1GUfURUZMnwTq4IDrDAxiLTm2L4RqO8ivYjbKYON3LeDM7qDJmre5pB
         wp/g==
X-Gm-Message-State: AOJu0YwLvqYh3FGjH0sMkSxnAK4jOpwLWuqopWj9yETXGDjcpIQL0gpR
        DUEYACddsEVTaUesQriYftm3rSo/2+lBiGYzp4CBGA==
X-Google-Smtp-Source: AGHT+IF7r0Ew0FWzUYhYODnnkZcYZ8yWrhC1tVSYd1MacR7tHoeJD8aD9lTa8JZZzrosDW7LN+dpVK+r3E10uu7dWcQ=
X-Received: by 2002:aca:1a0d:0:b0:3b8:9674:ff7e with SMTP id
 a13-20020aca1a0d000000b003b89674ff7emr2941595oia.37.1701684099001; Mon, 04
 Dec 2023 02:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-9-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-9-6566703a04b5@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:01:28 +0100
Message-ID: <CACRpkdZBLP86A2r=WLiD3eoXiXK2EKW2H=QAeN5ZqYx-bgM72g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] tty: serial: amba-pl011: factor QDF2400 SoC
 erratum 44 out of probe
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 3:07=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> On this platform, different vendor data is used. That requires a
> compile-time check as we access (1) a global boolean & (2) our local
> vendor data. Both symbols are accessible only when
> CONFIG_ACPI_SPCR_TABLE is enabled.
>
> Factor the vendor data overriding to a separate function that is empty
> when CONFIG_ACPI_SPCR_TABLE is not defined.
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
