Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B17E9D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjKMNcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjKMNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:32:53 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044CD4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:32:50 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7b3d33663so51441167b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699882369; x=1700487169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51Od5EM9M9kxK8o/tsuK7C1l6kkfgPjMKUkgQFFnMJY=;
        b=rsoCBDo//KyKu1BMMZtHOEo6+MvfduoiXZCjmIzZDRS39h0RuTw68sRYSa5bTN5N9K
         pV56mc1PbaukXOCYkcVRoVBCueaYa6na5gKHTIJvP6eVzbRMtgK6aCYpCqkceuQP6kLJ
         ZRFnLBUqwbFvdECcArd5xJGVkEGy9CClqxiP+8UqqIp7f/ePBOS1+QrEG0UiBuRjhql9
         DAniUvnXyH2uMWNdJYeGTALiE6HNmpXt7CFm7kXI73zUL9g2jKwqJPEGWYqQEAX8jpgP
         fJenzlbcmmxdsg1pkgblrOG4NzgAnVdHhb5/FUxhvOsF9hlknafw5uySbFIYqc1+fnsd
         ilfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882369; x=1700487169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51Od5EM9M9kxK8o/tsuK7C1l6kkfgPjMKUkgQFFnMJY=;
        b=ZJy3xGoEf2n5pg/Z5l+OhH5wYhocmZbaVS3ux2MH7zYlJfQJjm7/GLKQPfLo/PTEMI
         6o+l3eZR1un3RIJ4+goe8Dn6yrODUS0EECt4MbBrHB2Hj5OjV0FnZozNKgb2Qd+q8IFl
         Kl0i7NOiqFS++jjMA2nXp45E5VgF/kDaMuM9tw5w8P+H7HPwHsPw0eZBNsRBaNhiTUlV
         qaQSPv9A21JwwrLXfW+EYLjDGDHCi0VEWhewHJSNo6XbT93LfPYmFRjNCj9088SHxIBu
         scIxkiq/MUEiMinBcy8INjkeOd2Ur8fEObbMYujVRDhwAzTZc4DyKpJ8etQsttOgz+L0
         HGXA==
X-Gm-Message-State: AOJu0YxHwgsT3loPRSihXsnAJ1eHQTEEdkxLoFtGsUxt4fp6XQCPyCjK
        TEMcqFOLtdZlrQ6ofatH91zkm7pMoAzNg/IJmQ1jeQ==
X-Google-Smtp-Source: AGHT+IEcrZQBeFOb4euJmRzuZwg9WYuU+oxlHvKGRjeWu8+ZL96qLOxwzMOxWh30qliOeOQQpep9pM3wzfFrkZxC12g=
X-Received: by 2002:a81:4a46:0:b0:5a8:286d:339e with SMTP id
 x67-20020a814a46000000b005a8286d339emr6148836ywa.4.1699882369436; Mon, 13 Nov
 2023 05:32:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
 <ZU2AP7leDcIZIN+b@octopus> <ZU5LFC23JaEidEGZ@pluto> <2535571d-6fea-4064-8325-0f47d031c85f@arm.com>
In-Reply-To: <2535571d-6fea-4064-8325-0f47d031c85f@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 14:32:35 +0100
Message-ID: <CACRpkdaRY+rU+md-r5gVyFH5ATt3Pqp9=M4=+WArYkfVLAFdpw@mail.gmail.com>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
To:     Souvik Chakravarty <souvik.chakravarty@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
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

Hi Souvik,

thanks for looking into this!

On Mon, Nov 13, 2023 at 1:56=E2=80=AFPM Souvik Chakravarty
<souvik.chakravarty@arm.com> wrote:

> The initial assumption always was that GPIOs can be considered as a
> specific function. Note that the spec does not define the types of
> function and leaves it to the DT binding (or driver) to figure out the
> function descriptions/names.

Does this mean that each system using pinctrl-SCMI will need
to specify the available pins, groups and functions in a device tree
binding? For e.g. DT validation using schema?

This creates the problem of where to put it since
Documentation/devicetree/bindings/firmware/arm,scmi.yaml
is all we have, and for schemas to be applicable the implicit
assumption is that this is done per-compatible.

If we want to use device tree validation of the strings put into
the pinctrl node we need to allow for a per-soc compatible
under the pinctrl node like:

protocol@19 {
    compatible =3D "vendor,soc-scmi-pinctrl";
(...)

Then a DT schema can be made to match that and check it.

I'm uncertain about that because the SCMI binding has nothing
like this at the moment, all the protocol nodes are pretty
self-describing and don't seem to need any further configuration
to be used, but pin control may be the first instance where we
have to add some per-soc configuration into the protocol nodes :/

It's easy to do:

+  protocol@19:
+    type: object
+    allOf:
+      - $ref: "#/$defs/protocol-node"
+      - $ref: "../pinctrl/pinctrl.yaml"
+    unevaluatedProperties: false
+
+    properties:

        compatible:
            items:
              - enum:
                   - vendor1,soc1-scmi-pinctrl
                   - vendor2,soc2-scmi-pinctrl
                   - vendor3,soc3-scmi-pinctrl

This should be enough for just establishing the different
pin control configurations we can have in the device tree.

We are then able to put a more detailed schema for the
specific SoC pin control, such as a list of valid groups and
functions etc under the ordinary pinctrl bindings such as
Documentation/devicetree/bindings/pinctrl/vendor1,soc1-scmi-pinctrl.yaml
etc.

We should preferably put some pattern like this in place from
day 1 so developers know what is expected here. A mock
SoC is fine for the time being (we can delete it later when there
are some serious ones).

I'm uncertain because it feels like a first thing, but I can't really
think how it would work otherwise, part of me don't want to
pollute the SCMI binding with any per-soc compatibles, but
yet since these group and function strings will be per-soc I don't
see any other way, if they are supposed to be validated
with schema.

Yours,
Linus Walleij
