Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90ED80A906
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574081AbjLHQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjLHQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:33:31 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1F1986;
        Fri,  8 Dec 2023 08:33:37 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9e9b72ecfso513501a34.3;
        Fri, 08 Dec 2023 08:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053216; x=1702658016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GKuWGx0JJFRVK4jl2gAQwDPO2YGwHUxaXRf8Tzo4vI=;
        b=RmxJ/cCTzJYadFzbKUbf2k2pakS7hocVV+iTCmXH2HpPHb9uaYyUUgWF3TzmSsukcl
         nMVhM/waBvizuntcL7AzJ5YlrlEYI5BlxedozrA8UcAwMckPmCQunCfEUkDW6i0KbArB
         VvvXcVwgTJ6V2SD2f6TwzzWFhUKdMuWTLjehDtLDhMfmOCxzgjLCnsxpZhdd8HXwWgoN
         OB/cpy/9K21A4MmZZMALljyY0PxbgG1dAeNAU8ozLJs964KuWG13VZ3ZgwkuGoBZQvh0
         jAmnrqS/KB2YSQIkobRmzxEN6vO2OF83PT6KYHvIM+uJdkbV35bC/7/xG61sA/0Ak2/j
         bP/g==
X-Gm-Message-State: AOJu0YwPXw62mdLveNPAHZ5x0tWrj8yC13OWSB8kBbTk5m122itJy0NK
        JXPwBkpuSzut1CJX4Tt1Hw==
X-Google-Smtp-Source: AGHT+IGJgyPhFszyyuv/ahTq9jCGY/uMbNvjsmemLXOK2SmMafrlPlw/OCBI/pVSJYLPRtpk1/ZBmQ==
X-Received: by 2002:a05:6830:1e75:b0:6bc:8930:a1d4 with SMTP id m21-20020a0568301e7500b006bc8930a1d4mr300120otr.15.1702053216777;
        Fri, 08 Dec 2023 08:33:36 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i2-20020a9d68c2000000b006d3161e612dsm346476oto.30.2023.12.08.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:33:36 -0800 (PST)
Received: (nullmailer pid 1696654 invoked by uid 1000);
        Fri, 08 Dec 2023 16:33:35 -0000
Date:   Fri, 8 Dec 2023 10:33:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, tzimmermann@suse.de,
        paul.walmsley@sifive.com, mripard@kernel.org,
        xingyu.wu@starfivetech.com, jack.zhu@starfivetech.com,
        palmer@dabbelt.com, krzysztof.kozlowski+dt@linaro.org,
        william.qiu@starfivetech.com, shengyang.chen@starfivetech.com,
        changhuang.liang@starfivetech.com
Subject: Re: [v3 1/6] dt-bindings: display: Add yamls for JH7110 display
 system
Message-ID: <20231208163335.GB1659919-robh@kernel.org>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-2-keith.zhao@starfivetech.com>
 <46ad8c2b-5be2-4cfd-b771-a8d95a5b5d8f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ad8c2b-5be2-4cfd-b771-a8d95a5b5d8f@linux.dev>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:50:29PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> 
> On 2023/12/4 20:33, Keith Zhao wrote:
> > StarFive SoCs JH7110 display system:
> > dc controller, hdmi controller,
> > encoder, vout syscon.

[...]

> > +description:
> > +  The StarFive JH7110 SoC uses the HDMI signal transmiter based on innosilicon IP
> 
> 'transmiter' -> 'transmitter'


Thank you for reviewing, but please trim your replies especially when it 
is only 1 line reply in the middle of 100s of lines.

Rob
