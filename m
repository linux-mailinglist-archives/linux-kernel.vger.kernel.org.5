Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0277FA28F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjK0OXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjK0OXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:23:21 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271135B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:20:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3815203276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701094853; x=1701699653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVX1ZdZzljfmPCYv1WhnlNhNZCpdUFWAqA4zgj/34kc=;
        b=bjcb1Q47mnhyYQZsMO6BA4J6qIEzhtXDoLXcgbFZhFFU+jK/cilyru07Wxtx/rozkE
         +3XDLLMZTyPZOH0xnP6sCaFRFJ07X9dWm/pofKVUq4b10oRcKE3ibSz1i1nT0G9B0udk
         tMOHsEEBnlUxk6wAQrCAboub8iZHviJ9tnuFcrjz4Jb2UOxLsLdHCBvr2MPY58d3B1vk
         udqzk12Gp2CQ8d14l6rlIhBjknDXKV/UU/ui4lMtozOV2Ftjc2l2tE2/6IBYzY2Uu+jK
         D9Ey/T4yFMvCmIBUDSj8UchSQqiFiLwaIR5Wxj0Wkh+fJELbXR/GeCqiRa2iUa2a6gDX
         gdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094853; x=1701699653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVX1ZdZzljfmPCYv1WhnlNhNZCpdUFWAqA4zgj/34kc=;
        b=ukfT58wAT65JEwkrTWp9NxXhxlqAC8viZRRveiLL+EtLxq5o6MR+SQdXRXTzcptajK
         8uickosTW9Hw6EVz4xHwezN/IRMjDp7vy2CDxZSD1S7lxSJ1tTK8r3k+z7OvFSSaAqRn
         T0H7tNlHy5wY07dJgU/RSjgG/dIugwEyncWC9B7QiwGdABzYyV3n8uuUP0HEBOBqZKmn
         2MWVvCVC1GRz8ConECHc08nZwBw6WnSDqne5JyzTA3uhb7LhjIgLcKZwTAI4K48S1ODY
         sskRNBcqsILxsR3pCcjxTKfuw4NRxsttEl3fdpy/4Sbm0FqI0mAk1VhUC7h+lO+IP37I
         jkCw==
X-Gm-Message-State: AOJu0YzQpdwgi/pjPdW+2EyBSdAX0XIDiB02CD0wGlz3Yfvu6H/KsxPF
        +51adD1o4jE+JkLg+oRbrZ5KczQ9o3AeQKdvOtA5Cg==
X-Google-Smtp-Source: AGHT+IHPLnftzFinUokqEwBA0munIRtTDqhYJlD301948Ll5EDt+4sZPM19h7PS/NqDz2lnMSdp/6dzJPxFKf2QKxp8=
X-Received: by 2002:a25:4c81:0:b0:d9a:bddd:f714 with SMTP id
 z123-20020a254c81000000b00d9abdddf714mr9648302yba.9.1701094852552; Mon, 27
 Nov 2023 06:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch> <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
 <CACRpkdZvMRXHKktM-HPZZRCrV0JgErqDOHmkyKAcB36ObwOX7A@mail.gmail.com> <9c1a2484-6631-42e1-a576-10e9d600e8c5@lunn.ch>
In-Reply-To: <9c1a2484-6631-42e1-a576-10e9d600e8c5@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 15:20:40 +0100
Message-ID: <CACRpkdZ4Eqv4TtojQDVDOo8eP=gdeoBsH3_wvJcAbf_z5u6Q5A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
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

On Sun, Nov 26, 2023 at 10:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
> > Shawn is busy I guess, but looking at the activity in arch/arm/boot/dts=
/nxp
> > iIt seems pretty risk-free to apply.
> >
> > An alternative is to simply apply all but patch 4/9 (the NXP patch), be=
cause
> > the rest is Andrew territory.
>
> Could you split it into two patchsets? Gregory and I can deal with all
> the Marvell patches.

OK good idea. Actually three:

1. Bindings only (for netdev/dsa)
2. Marvell cleanups (for DTS files/SoCs)
3. The NXP cleanup patch

Yours,
Linus Walleij
