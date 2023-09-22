Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74C7AAFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjIVKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:40:59 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D9AF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:40:52 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 11F3541DB4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695379251;
        bh=M9atEZ8pv97FGsnY/ZWo7vn5sZBlwoU9NTKpTiNkhYY=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QfaPhUydREmq4YdwmKCkJLfZN7K1udPKQrfT376W7C0lpcR0fJxdiCN04/2G0siTQ
         sAHj0fcZpKkt3UmuNZT7JyssfVlVU7+n9TVinKCpZn5oWszgbaN8fYYC/Y4KXvOKsm
         xJ8mKV9Q6ezbn6DDh+g6wA1qzzMr5LgD0p6GCWVerU+KCLAr8wQZ08X/XhJnYMIUtu
         UEYa6831+oZcy7D6pVjJ+JOwaAYuTXJ6GIBEhtBLx7OFWc4jR5nPvrGNTY7/vKgmPL
         BTkF+E+iq2q5gzLc0PP6yNt9vaRdqmWSIcgFV6BaTJWYf3891azn9d/u4gC/YQL1H5
         QkhiYQpUujLew==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-417f9e1def0so6611111cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379250; x=1695984050;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9atEZ8pv97FGsnY/ZWo7vn5sZBlwoU9NTKpTiNkhYY=;
        b=l0+lL0Ced5Y0CMUPoEr+dDsue142SY+sicCSIgaROQ+3BDB+LWj3kOI0cmn2TvqfoL
         i/AdyNA7mDmorVvKkSMV7sUOgRtr+2LcuY2gdot4sblXBofg7qsrXv5YIt5vaTtBwziL
         ixTkep+lEyUsfFUKlTdmicr+y3tvDTlbNvK1T6+WoqPk4Q4X0oYnyC+Tt1OSd3JzsMfj
         D3l3Pb5nZsCqwa1AgoDfqFfdtbcee6hf4yKe6KOMB9EcAVVVfGn/Zi8QLelzyjANW2YS
         hfrsfzF8k85XYR26jPiBa799DQBwdPfXZrzvzgw8ZIYGkfgCGM+73240+QPLc0jrS56i
         /9ZQ==
X-Gm-Message-State: AOJu0Yyrmvo6STZM90Dm9b63PjDKLaXh8jM6xlIBVXt/T7wI88X5MrVE
        13DQ2se939/VVshkqnyuFp7PHpFzjOeWjA4epz9DTdGnQug4n56Yk26/tpOJf2Ysu+ELG8Nby6n
        awILthXd7KX0mOoJX5H/P2lx8rmI5nFpgUL8DTgQc44REfvOLt1e9lDWbrA==
X-Received: by 2002:a05:622a:182:b0:417:a209:c250 with SMTP id s2-20020a05622a018200b00417a209c250mr8885221qtw.36.1695379250042;
        Fri, 22 Sep 2023 03:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPQTZrz7rs3Pmta65dRQOYdSqi6ed3c6QhACApdSCdCSWiGdK7A08VO8v8WV3bKXwpAriTIN7dUIJh1owv9yE=
X-Received: by 2002:a05:622a:182:b0:417:a209:c250 with SMTP id
 s2-20020a05622a018200b00417a209c250mr8885206qtw.36.1695379249804; Fri, 22 Sep
 2023 03:40:49 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 03:40:49 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <bcdc4623-a37e-455b-8f10-c539e2b04554@codethink.co.uk>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
 <bcdc4623-a37e-455b-8f10-c539e2b04554@codethink.co.uk>
Mime-Version: 1.0
Date:   Fri, 22 Sep 2023 03:40:49 -0700
Message-ID: <CAJM55Z_o7Z8HhaUjrSqjxy1cPjud9Q3GrdqjgFThToxxOCrkgw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] serial: 8250_dw: Add Sophgo SG2042 support
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On 20/09/2023 07:40, Chen Wang wrote:
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > Add quirk to skip setting the input clock rate for the uarts on the
> > Sophgo SG2042 SoC similar to the StarFive JH7100.
>
> I'd love an actual explanation of why this is necessary here.

Makes sense. For the JH7100 the commit message is:

  On the StarFive JH7100 RISC-V SoC the UART core clocks can't be set to
  exactly 16 * 115200Hz and many other common bitrates. Trying this will
  only result in a higher input clock, but low enough that the UART's
  internal divisor can't come close enough to the baud rate target.
  So rather than try to set the input clock it's better to skip the
  clk_set_rate call and rely solely on the UART's internal divisor.

@Chen Wang is this also true for the SG2042?

/Emil
