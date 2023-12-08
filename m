Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAD80A20B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573558AbjLHLUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjLHLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:20:08 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181210F8;
        Fri,  8 Dec 2023 03:20:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b8952b8066so1438234b6e.1;
        Fri, 08 Dec 2023 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702034414; x=1702639214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PEUKU4RsP0giZMZ/KrfzmNAgaL4v7lal6pj/aFK5ok=;
        b=bo39MrV6ixg+FyNnNatPV6NNiRPj8FY6U9wk69IqZqiKiKTVRXOc9iWxzuu0LAiDxa
         61jX8cOAUwSAzudeNE6tyTeLikODrbgACAw5PC+sP+StFTi2OdH0vDVeQWYG7N2K32Iv
         VJuc+g8teUJx5q6oPbPJ78uU9TXQUTz4d1zyEgNsGUoZx8TYyTBRFqroOZi22PEzNBql
         woqj0epjWK0eUQX+bXq9rnEJGZVclv7MyUVd7zIxelInqhTcRIqFDGd9jc0xfR+f/Q13
         bskZ5chgEUMk6ipVQyo8nwq9KbA4GjhqfqeKmml8i2R9gKLXZPIaD5PSSSM3x+Bjjf54
         LhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034414; x=1702639214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PEUKU4RsP0giZMZ/KrfzmNAgaL4v7lal6pj/aFK5ok=;
        b=i1tLc/eaB1saYnzJNEqcSv646MDw10fF8LBBtdeoKhh6nuhnFqtSW2Em88W/ryalXA
         +YRt00E0mvZFBHnKM+09jjV+6lWO1AlNSpBcUczGZElaJdvfMMpKUg5pmCfuRDqr6UqR
         Nd62V5xCfwf9AkRHmrIRDsDiYkrntC3zFyDIvsWRkclVo2TaaVRSqz+VhQaG0JrNAgX8
         gBnKXMP2Ei9LRe/3kciMEJ5nWLBSU5siJ2uis4U0Xph6EbkTZMhDzyW0vAZidT8NN11/
         sr8gMTrywTJd8HSKRcdrLYc31DE2bRfJrqCn59UeGQXE40utWE9ebLZg6cfF/FSZjZwd
         JHTg==
X-Gm-Message-State: AOJu0YwBTVOIZFbiRZC5eBd9d3aGQKP+S7FThhu/HcKbDXY7zYpylA2I
        o/gF/xx008Jnlu090fnXvR1Jniko3xy5ZkPOoHg=
X-Google-Smtp-Source: AGHT+IHKfgOJJkGUVNVFohMebN1Pi1RObECe1iqnsd4pbG5YaF8nQXN5FgdG0fJYIqAU9y4NJPN/aM1KEVAfQ33/aHk=
X-Received: by 2002:a05:6808:640c:b0:3b9:d2ea:4d2 with SMTP id
 fg12-20020a056808640c00b003b9d2ea04d2mr327428oib.22.1702034413856; Fri, 08
 Dec 2023 03:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org> <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org> <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org> <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org>
In-Reply-To: <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 8 Dec 2023 16:49:57 +0530
Message-ID: <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 8 Dec 2023 at 13:14, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/12/2023 01:24, Anand Moon wrote:
> >>>>>
> >>>>> If I move reset-gpios to required, I observe the below warning.
> >>>>>
> >>>>>   DTC_CHK Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb
> >>>>> /home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> >>>>> hub@1: 'reset-gpio' is a required property
> >>>>>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> >>>>
> >>>> Where are the properties defined? If you open the binding you see:
> >>>> nowhere. You cannot define properties in some variant with "true".
> >>>> Please define all of them in top-level and only narrow/constrain when
> >>>> applicable.
> >>>>
> >>> What I meant is the example below, required meant applicable for both
> >>> the binding
> >>> But it shows me the above warning.
> >>
> >> My explanation stands... So again:
> >>
> >>>> Please define all of them in top-level and only narrow/constrain when
> >>>> applicable.
> >>
> > Apologies, But I have tried this multiple times but have not been able
> > to fix the device tree warning
>
> Did you document all properties in top-level "properties:" block?
>
Yes, I have,

Can you suggest a couple of examples to follow?
I looked at some of the YAML files but could not fix my issue.

Thanks
-Anand
