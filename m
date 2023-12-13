Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC27811134
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378374AbjLMMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjLMMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:39:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DDA4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:39:15 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6304C3F287
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702471153;
        bh=RVX7Hkci1GalSOV+ggHHM2J9QrW4mGKi5xvBhDtdXC4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=f9szzBr3ADMAHhCsWCszBvUGzG1Hfw/V+cX8IlK8N3Jlj07oGhVS1/OWHUrvr/Rst
         uBca6wkaw635mfxDExVlne3g2O4KPvLqyFufAdnSWb3mneSVCSnTBvvU5MZRsIy5EM
         MVUiMFWCiUtdycsEFj18WtPVLnfe3hlMI4zUZebnU2nqjlw7BAYK9C12wSPzIKdi9Z
         G3imHwl+NYcxa1hCVOUV8TreIC6mM6RGwV8K0XwzvEZkaEFzWRv/yu7Ixho9RiZDmN
         cBGoeHF03hF7m0lgt6jdpFugAFzvdicfrNMS+uHjR2MQ1ZLlt1hddeMYpQCmgTK4RS
         /NIUKjD4zUIjg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-425a6272642so78307051cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471152; x=1703075952;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVX7Hkci1GalSOV+ggHHM2J9QrW4mGKi5xvBhDtdXC4=;
        b=scLUc2HoGNN+emgL6v/x72tdhSgOKMoesKLZ85Nb5ke0K8/e24zZNjRWYLMinVYTN5
         GVN2JPeBB6piVGiK1skr9ans0ug2M2jppaG7w673J7y5zmh32gdnZ8y9wAhSOuLUvXQw
         sEO4AAASOLAuT+HjwO+6sXzNmIGNhUkXHg8rtft5UEPhFCFLqDbpTWsK6yz683Q+Heen
         FvFCSt9w2g8MYAAjU20zJwcguJB9wube5oFdO+ef+hK/yOS4dqVRGpDW2r/DkQ5nT85t
         16baEjWkCb6Q6dMGdAG0bL++DkHduaBJS2yncv90vVbHwJfvfAPuDUZtItSY1yTziIdZ
         v0Ww==
X-Gm-Message-State: AOJu0YyZunwnRceDA9MEPsx0ry6J6D4VdZBj+Nh96kigVYvDe13aE2cb
        VFdId+AJVosyponKYCYRLxtH1HGstYYONAD92U+Kc4rvw8kWlTuR0p3Xxp8ti4420skn/vJQbZi
        hYd34ztHSkxiQL/fIgX3xnPLsY8I75/vUXjW8jzBwCPoW5tfpvS/cYhPILQ==
X-Received: by 2002:a05:622a:28f:b0:425:4043:96c5 with SMTP id z15-20020a05622a028f00b00425404396c5mr12063931qtw.82.1702471152389;
        Wed, 13 Dec 2023 04:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIeVXeXX7w4KcjeNOZNUYxmPvYFuILxSBmeeP5KBI6qOM2DYJi1AyFB9Hnx/wH7nuTyyjZHzceB4Cl8ASZSCc=
X-Received: by 2002:a05:622a:28f:b0:425:4043:96c5 with SMTP id
 z15-20020a05622a028f00b00425404396c5mr12063906qtw.82.1702471152113; Wed, 13
 Dec 2023 04:39:12 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 04:39:11 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z831ucY4QqPTR_0zJVB05UUT4W-3M0CGzvtyPo=AMD=Vw@mail.gmail.com>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-7-jeeheng.sia@starfivetech.com> <CAJM55Z831ucY4QqPTR_0zJVB05UUT4W-3M0CGzvtyPo=AMD=Vw@mail.gmail.com>
Mime-Version: 1.0
Date:   Wed, 13 Dec 2023 04:39:11 -0800
Message-ID: <CAJM55Z-BJMi=rbe8op5EQ-efwo-9AbmavVE1BVJ9_xuHQzMhLQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzk@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de, conor@kernel.org,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, michal.simek@amd.com,
        michael.zhu@starfivetech.com, drew@beagleboard.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Renner Berthing wrote:
> Sia Jee Heng wrote:
> > Add initial device tree for the StarFive JH8100 RISC-V SoC.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>
> Looks good to me, thanks.
>
> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

I just learned that this JH8100 is not actually a real SoC yet but just an FPGA
implementation, and no indication that that's actually a product that will be
mass produced. Hence a lot of details may change before it becomes a real
SoC/product people can buy, so let's not add this device tree yet before
everything is set in silicon.

Please consider my Acked-by abeve revoked.

Sia Jee Heng: With that said I still think it's super awesome that you're
beginning upstreaming support for your new SoCs early. I wish more SoC vendors
would follow your example.

/Emil
