Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE9805578
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjLENIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjLENIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:08:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EE189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:08:07 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADA5A3F1C7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701781685;
        bh=ipAJlSSYX/mAZm4xcMYzeaea4jWciG9PaIDcpgo9ae8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=j41Z+6MsayA4SuWADLsm6SDFjxagvqVWmPvXhzwpd+Cx58ZFb/JFEInbWsna5OOF8
         mI/0NiYoCI0W5yAKdwLvDYJ0Ron/euvmdWnUzUdfaR4G8xtFq6/jE/l38nPjhckaZO
         hawZoRp/kMRZb0h73YJtWSFOozpTZ/KkvAKr8sNkL5rTcRvEBppqBkLOgmkermXDdH
         6PnuB1UZXV+YoBS1m8nCOmQu+MH81ni5b4VFE3I02ILtWbnuxLwP/QJdrkfoXygeic
         zZJg2cTAmyucgsxfM3NIBD1e86PaastxxJWC5ZJi70zP+EQwpUj5vcCORtZt4NP7eJ
         CgAOMpYGRoAFg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-423e480037cso75879701cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701781684; x=1702386484;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipAJlSSYX/mAZm4xcMYzeaea4jWciG9PaIDcpgo9ae8=;
        b=Tz3OfsTFZ6fIq+XsovFb+LzV0QTAv7Ko1tvDPYcaer2uVH4ISH6efpRv+S21KbzHH0
         TRPut4WCF7Zb1uWXLd9gnly2ylUtkIh6eH9yiBCmopO3h8ASRxPf0OyM+G8mYQHIKdJa
         ekIseyOr5IiB8V7vhD67N8sBXAbehEwPsUvpY6vUsVKDzxw2StfSzSxl6NkYPSZgSnTJ
         v6KkQ8JG+tCuJIl9g5oJeHCZs9Tem5Yvuky82oLrTWHu97+OwcrPoiUh2dQSlBSfDX0V
         BgiOjTvdpUQ1v/Pq4xQ81wFbsfeMN+KAW/bA3rLWhwsD/cn24RaDePjUQaadFLW8YPeb
         rH1Q==
X-Gm-Message-State: AOJu0Yx3vwDcjt7cNl61xZt03XpsASE32l5HWkeV6A8ItH6SEROUUTCv
        Cysk2VHGzxDE7776mu7HYSMJcoZuqWaVThI+kR4ISeKZLhgARqnpbIh1b7+vfRPUNpvrCAv9Jzx
        Orxm4SSvjE5BUvY2S9bRWz6z9HlbLVg1d8+tMd6V9h5BUkrXpgH83DBYxUw==
X-Received: by 2002:a05:622a:11d6:b0:425:4043:18ac with SMTP id n22-20020a05622a11d600b00425404318acmr1492009qtk.95.1701781684730;
        Tue, 05 Dec 2023 05:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlXRys+uhq05wTQp5gTIQeRVXtcocRfoOG2IGdr/XS7LnceeqhmOJyi1TFF74GFlFi520WeeSjrG5WeOdwcd4=
X-Received: by 2002:a05:622a:11d6:b0:425:4043:18ac with SMTP id
 n22-20020a05622a11d600b00425404318acmr1491997qtk.95.1701781684479; Tue, 05
 Dec 2023 05:08:04 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Dec 2023 05:08:03 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Mime-Version: 1.0
Date:   Tue, 5 Dec 2023 05:08:03 -0800
Message-ID: <CAJM55Z9WO+0Yb-at6CAR6=UP9j60iQz=s7MK-3qiT=w-8N6+Zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
To:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inochi Amaoto wrote:
> Add clock controller support for the Sophgo CV1800B and CV1812H.
>
> This patch follow this patch series:
> https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/
>
> Changed from v1:
> 1. fix license issues.
>
> Inochi Amaoto (4):
>   dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
>   clk: sophgo: Add CV1800 series clock controller driver
>   riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
>   riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

Hi Inochi,

This series seems to be missing patch 1 and 2. If you did send them, but just
omitted linux-riscv from those patches, please don't do that. Having the whole
series makes it a lot easier to review without having to hunt down all the
missing parts on lore.kernel.org.

scripts/get_maintainer.pl does support muliple patches as input

/Emil
