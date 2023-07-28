Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E25766D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjG1MfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjG1MfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:35:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BCE75
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:35:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b89cfb4571so16264855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690547711; x=1691152511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGcqxjwyY3pQ4csT4f4ZYFzUgFaDBasoFzgth4FA/MQ=;
        b=Ayqc4/V4xCizMpmDFZrNnLTheMd/dzztR+ZfbaALYbnKWyd1UUFRzSS2w31dkd3zb2
         gwRpSajc5oIiKbKk1/ap8bGKCB+oyif9jhi+zD1qdtAftb62WVTjkXSo1MdbtB+zRBT5
         Fu3zGPAXEF0P38GF6Y0X0r79yC3+xQJhWbulItJtQnlJATpr8wSpbF+Aztf1AapQs27/
         aG0xnZXIfvCmAhH2OBAawztFT/tQ8Cign6cGhMFqWstCob14Gi+Y6t4sVsUcZGMae5u2
         DVbrfb6LJoQRgXx9hSxlGF6CvjbOS64rUlf/BRwdmlT+1WEL2akThtv20+bH/lF9/1zb
         EoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547711; x=1691152511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGcqxjwyY3pQ4csT4f4ZYFzUgFaDBasoFzgth4FA/MQ=;
        b=VPhxUTg8PnH+nQQdn1ch4OeHxyaeSF4K9ckF+3QRqNsJXT3BefxpSVAEgFAPJnP7Ff
         q32qe9SC038esw9FjREdKWO3aBElkaOtXdmp32IlfnubMRUf6/2N2dAnl0S4b1r3nnV6
         0olHLe6/8Tko2WQSduaovmD5mh0PJt3Pn9BzLUgl/LQlN9dOiopTDWJaC7AFY7mYj2ea
         Hb26CBpT7nAFV4nK9JLwKW5SLTDyR7OrqvaWEIdT4yKjtUeyJ+p76aP8sRUQtnPizlxl
         hq/fOpgFHhYb28TSKfuJrGjRDZ4K6IR6vBE+0eSs8hVwztLVBHMXzJZq9uNQHnALjNDT
         9oJA==
X-Gm-Message-State: ABy/qLZ512tJ9ifMM70JnoaAVsMXGpyEFZUju9Iij3GubogCGJWsrS3o
        kvJs+P5aSjY6IEH+3gv+2cwTrNaYJJ8HPUzllqfhGg==
X-Google-Smtp-Source: APBJJlG+md8nV+Q9MCGNmsY6Cl5UKO3sLRcVzXdaRiluSPg7b4tpcWZWbV3MxDY9ynKpupQ65y3JYRyqDlXWn8w5NLU=
X-Received: by 2002:a17:902:830b:b0:1bb:90d7:5e01 with SMTP id
 bd11-20020a170902830b00b001bb90d75e01mr1329459plb.63.1690547711217; Fri, 28
 Jul 2023 05:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch> <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
In-Reply-To: <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Fri, 28 Jul 2023 21:35:00 +0900
Message-ID: <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 20:43, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 28, 2023 at 10:41:40AM +0200, Andrew Lunn wrote:
> > > Wouldn't this break SynQuacers booting with firmware that lacks a
> > > network driver? (I.e., u-boot?)
>
> > > I am not sure why, but quite some effort has gone into porting u-boot
> > > to this SoC as well.
>
> > Agreed, Rather than PHY_INTERFACE_MODE_NA, please use the correct
> > value.
>
> Does anyone know off hand what the correct value is?  I only have access
> to one of these in a remote test lab which makes everything more
> painful.

"rgmii-id" is correct, configured by board level.
The latest EDK2 firmware was already modified to use the correct value
for DT(Thank you, Ard).
http://snapshots.linaro.org/components/kernel/leg-96boards-developerbox-edk2/100/

Thanks,
Masahisa Kojima
