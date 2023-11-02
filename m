Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF27DFC2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjKBWKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBWKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:10:18 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB4C191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:10:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5b35579f475so17557227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698963012; x=1699567812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlv1B7XXwhStizLmYC3q5QyPpoGJxIV5oA/dcG7ZtIs=;
        b=mWjFO2g5wJdwpu746Un8zS1DlY199XDUqgzXgc1oz+mhO9PWmfhGaM7645dn9gnXWV
         cM8aSrcUI3tTaIXt6hz4i1sgs5aExwUnqCFKus411djGllYxvjVTNLlotqJh6Pdr8p+W
         zwz6S6CznyK8I9Y4Wy3uovaRsHmnFq+2CufbjmPhh3bhgBSaJeKpFkmF2X6OqQMhJDQ3
         AOi++kQ15HBzH6j1QB5V1F1UuZZcN5uTkd936w8sD7znEkoSO2sPgvX8G3pQ/oH5aL2B
         SJgUDpWiyDngWzKCDiRPDkvQGEPuZilA/pL9IuPhHA2kiLTwYW4FbpkAIArXoLLYw7lW
         MiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963012; x=1699567812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlv1B7XXwhStizLmYC3q5QyPpoGJxIV5oA/dcG7ZtIs=;
        b=AbYgQMczbRr6Dh2nkSlttdWQavzovu9YJQXPEfQLqc9u0U4HNGPoUZQD+fvVOqp+JN
         Ha/Bgsm/VdluXQBapIOc2JsFhe8EXgiM24yzN4gwTQuVx+XI7TOg/9zU8khTCjNpRauG
         UoRzrrKx3etev6gVa/P6J0Yl+EUJ3S6MqljWEX0FObDrO56eACzgTz/3vqroRC/KFQ6t
         +HlqSiKVR0O2qP5KW586Q4HRHCBqc88IOyO02YNcNkP47vCdepczXCQuEqBA2Xxc5ZPB
         J6aeHA1t+CJiFsMo3D6/VsSFxVoTNAHZ18f8Jtu1NX48clGqBf3ZP5pSyBiixqTjqIlF
         2ruA==
X-Gm-Message-State: AOJu0Yy57w8I8fShkG7sM2PH/H0vezA/iihZzvRTA5Kde0H09ju64PtH
        AfGtuMT1GB/Su86q0m0jzdpT6VpljNytFQ/s0LbUcQ==
X-Google-Smtp-Source: AGHT+IHlg3mpohF9G0EMdD8fmE7UgMQ6+wyv4TfkPfT0jY0DK7RzJ7yHRtYfN2bsl20NnqM06aa5UDWie/DuMQZ1NhI=
X-Received: by 2002:a81:9290:0:b0:5a7:aaac:2bce with SMTP id
 j138-20020a819290000000b005a7aaac2bcemr1117873ywg.35.1698963011965; Thu, 02
 Nov 2023 15:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com> <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
In-Reply-To: <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 23:09:59 +0100
Message-ID: <CACRpkdY2UiFyTvF=zuk-rSZBi+yH6cP-QRkegMgc3wf=9JD_Wg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 7:43=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.c=
om> wrote:

> Looking at drivers/net/ethernet/cortina/gemini.c, should not we account
> for when the MAC is used as a conduit and include the right amount of
> "MTU" bytes? Something like this (compile tested only):

The DSA core already fixes this by adding the tag size to the MTU
of the conduit interface, so netdev->mtu is already 1504 for this
switch.

I found other oddities though so I'm digging into the driver!

Thanks,
Linus Walleij
