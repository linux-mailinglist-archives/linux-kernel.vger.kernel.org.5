Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE57E1896
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKFC0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFC0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:26:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52805D6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 18:26:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28099d11c49so1297559a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 18:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699237577; x=1699842377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+zjHfcFj8TqUlH84WYwsqc/8Y29BbFUby3pKruCyyo=;
        b=ByT/Wdw8UiJKQFJ8L2fbJIKApIh/PJcgdYD9GkG37Rx/iqC+uPXVB99IpXfzZdh9J3
         rdfbWs9zVKXZZrIhiayi/GMPJv0w8VqHLLSogiYELRaMY2MlnG3gZ4uhck89cfYP0h0F
         8VvruuSrW+YeMIJpXkHpCFFAtqaDJH0ue8lS0t7GfmiybLqKFql6riuXaZdEXVBx/lU0
         sbLO1p+1EPzXx/vcwJjT2zzKQN3QLou9Zbi7R5EAg2iNwcfaF6WJ7W42NtWg7Jocuhjo
         7gPAuuCQfCTnZ2XvbB+wkQkoC5bk2I+tWDwWIKpQjmv+cZ0VnAPD02wS01mcauyh5yVz
         zw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699237577; x=1699842377;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+zjHfcFj8TqUlH84WYwsqc/8Y29BbFUby3pKruCyyo=;
        b=n/4xp7KS4rxP/QH7RsxXOyJ2xQUlUT5yc3xfzUQX7ZtFeTSK7Tnb4yTKa4g2dFvpyq
         5C4pPAi35lnEQVTs8OyEpEw6HNDEozOCsYWHhUPbsuA02h+L492baQbC/QCRL4C3MVjY
         dhDlCEjE+CwVx3v1CGgceUYmyK1U3LRQ7y328ehsi0eumucyKk9QQRflh50NceTh2jWF
         Z7WhLleX5yXKhokVqRvU+vLoUbbnnWMY60qd2rCkIgNDM6PkTeW9iWIdIo3F6GztiKS8
         mREfSwqEyl6PgrH2dnK0VvMtEIgjCByuMwLLjV6ApFKLWNADHnbzJ7zqhluxXLevPCtB
         xoWg==
X-Gm-Message-State: AOJu0YwskymvJghneo6z0x1b27eNICvfXFHedPbYEgTVzB5iQxjOQpoT
        j5s0W0e/Tc/j/4j+AAnJNrRBig==
X-Google-Smtp-Source: AGHT+IGXh2OTE0HtTz18uLoZnkxoWT3Ir57Kp8XxMeM0i7FeY+b193kXNd3C1M/38jDoZnuejggAsQ==
X-Received: by 2002:a17:90b:3781:b0:27d:15e3:3aa9 with SMTP id mz1-20020a17090b378100b0027d15e33aa9mr26980182pjb.3.1699237576750;
        Sun, 05 Nov 2023 18:26:16 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:44eb:593c:2134:f5ea])
        by smtp.gmail.com with ESMTPSA id cq13-20020a17090af98d00b00280c285f878sm4447627pjb.55.2023.11.05.18.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 18:26:16 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:26:11 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 3/5] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZUhOw0+HVcJYmvp6@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <7300b8804396075d2ae565f46de51a980ce846e6.1698353854.git.oleksii_moisieiev@epam.com>
 <ZUNYkRtXUPeM4ppS@pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUNYkRtXUPeM4ppS@pluto>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:06:41AM +0000, Cristian Marussi wrote:
> On Fri, Oct 27, 2023 at 06:28:10AM +0000, Oleksii Moisieiev wrote:
> > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> > 
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> 
> Hi Oleksii,
> 
> the new get/set v3.2 implementation seems finer to me at first sight.
> I'll try to test this next days and give you more feedback.

I don't think that this version addresses my comment yet:

https://lkml.iu.edu//hypermail/linux/kernel/2308.2/07483.html

I hope that it will be fixed in your *final* v5.

-Takahiro Akashi

> Thanks,
> Cristian
