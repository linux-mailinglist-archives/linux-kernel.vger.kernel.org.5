Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564DC79EADF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbjIMOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbjIMOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:19:31 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32699E;
        Wed, 13 Sep 2023 07:19:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-655cee6f752so28400496d6.0;
        Wed, 13 Sep 2023 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694614767; x=1695219567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccpm8M63tUVRb8cHltFDbsSiHscuT20er3PFEGjsiBE=;
        b=ZcViTpCrbhEJrmj5DkK7Hozt4KfzX97S3Ldjy2g/abgY1E9H4ra2Dy3PbQTG3yRArZ
         ZEUsSEVtddGb8MZqEohfLmBYvR+2HKqFslo5BAvEwFgPH6HOrN2hvb8bdDIxN1+osJpZ
         GN0XP+ohVg1OwREXZScyhL4Omuk+oxkcymxFyCthKMXV6pXCt0Y6VzWZrhN4amXPDtGN
         gk7r5OBSO70ZZeSIiV/LFtTGOVy0qS6VH58JWv/VoWbuG313eaeUglZH8S+fRYx0vclw
         nrlmFa2x/XJnak3cT9zo9ZjwEwY9i/AdK/BWFqa/iGWO8GQBEnpej6XEtMztKJWan7X9
         nACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614767; x=1695219567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccpm8M63tUVRb8cHltFDbsSiHscuT20er3PFEGjsiBE=;
        b=kR90jlnm8xFry6LoIhrQ3NFhVZG80n7ABufj749rWfBMv8HIeSppwriv2FmTuTu5BT
         CKrKMuawGCSJAdNMrPv6P2XF/+/ZlXkTTaQeSE6Dw/2cZ/7L9vYNcY40P3Hz90oQVDw4
         t1dxHnAtLnXIkY9UjqeG6oAXyhBlLUfBJddOGoUpjgnFBACW3ygADlp1DdGf7swddlqV
         hsE4w9Wk5NNldO+7cROPdtjpq/nAx5kunwmwgq6SkAWr3pbBFb/EwJAcplmSiqDOdgsF
         bG2ZpneTL1M1TjCiz2WEHl2/0Fknz3GeZSOF3QAGGDY5UrvCxsVGwRvLXe+B2d1y3sOw
         XDtg==
X-Gm-Message-State: AOJu0YxGzUIzUXjdfCI+vfvsY0AmV0GtaIXVEjvNlNcFBgJmuupQdtjL
        UWzxwPthdIsnF72zu+ciUcC0qbVJbuAwt/bxZ4k=
X-Google-Smtp-Source: AGHT+IFo1VDju5+RiN1hu/MS6i6AKwAXlvWCwJjHPS8cruvNNP/FSBt27kTgEjJDuN5FKtcGF2oBBFdq/A3wg7SPo8I=
X-Received: by 2002:a05:6214:5c06:b0:655:dc84:d744 with SMTP id
 ly6-20020a0562145c0600b00655dc84d744mr2477721qvb.25.1694614766962; Wed, 13
 Sep 2023 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-2-yangchen.openbmc@gmail.com> <26a53f62-d8d0-9583-e675-a3db99c60c8a@linaro.org>
 <CALFa7M_Gov4jd3wxrXWhxuPKbDr+cp8xmuWJCQH_N=a+q03M1A@mail.gmail.com> <605e4577-1e01-cd0b-9d42-34401bd7f3a7@linaro.org>
In-Reply-To: <605e4577-1e01-cd0b-9d42-34401bd7f3a7@linaro.org>
From:   Yang Chen <yangchen.openbmc@gmail.com>
Date:   Wed, 13 Sep 2023 22:19:15 +0800
Message-ID: <CALFa7M9uaFuX4OEy9XdRa7xtKECOvJvg=MH_jkJ+jrfRe4M_SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 13/09/2023 11:52, Yang Chen wrote:
> > Hi Krzysztof,
> >
> > Thanks for your reply, Minerva is a project of Facebook server that
> > includes two types of boards. One is the motherboard that includes a BMC
> > and another is the Chassis Management Board that includes a CMC and both
> > use the Aspeed SoC (AST2600). These patches are for the CMC and the link
> > you provided is for the BMC and they need to use different DTS.
>
> Are they similar? Maybe you should share board DTSI?
>
> Best regards,
> Krzysztof
>

No, they are not similar. They just use the same SoC but they are on
different system boards with different electronic schematic.

Thanks,
Yang Chen
