Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F7811C37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjLMSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjLMSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6041AB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:20:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ACDC433C8;
        Wed, 13 Dec 2023 18:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702491628;
        bh=E7gw62n1LDAJ7vitrWM+l8KMqj5eHgf90P0t36MY0qI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=mw0teAqiVeqH6qo2z0IwO3wiu/K7o8qi0urNuTjzFFVZpBUO/kmOqFYQ5LazNq7OY
         tNSrinvTT5bosg6isbrg/KqhCPdehaSUPlGrmuDDiFlFrwNgp4o9PMkKR5Cnh+NmAX
         6bzV4YnQjvoL0Wb3+vF6e/wSy9c4bVWozF0Aw2l5UerkpvDjg+Od8WviNBFMz7ClzL
         OfrTpBihUhQ+rLvoSqRgh4TU4DQ/JgyEFrUrGiAvreQtB2i2//MeCI5Tqerh+nXMiC
         K2h4JPEOgOUfDoGTOX7f+zrTtMHpWNiPBH13Zpty7mK+D1XKYiN3MQGEq6xQd2Lt3f
         ZF6DZz3j3/EFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Dec 2023 20:20:20 +0200
Message-Id: <CXNEWTC7G66C.8KM5X4BWMK7P@suppilovahvero>
Cc:     <patrick.rudolph@9elements.com>, <vincent@vtremblay.dev>,
        <peteryin.openbmc@gmail.com>, <lakshmiy@us.ibm.com>,
        <bhelgaas@google.com>, <naresh.solanki@9elements.com>,
        <alexander.stein@ew.tq-group.com>, <festevam@denx.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <geissonator@yahoo.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ninad Palsule" <ninad@linux.ibm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <johannes.holland@infineon.com>, <linux@roeck-us.net>,
        <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
>
> Add a dt schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
>
> This includes descriptions for the Nuvoton and Infineon devices.
>
> OpenBMC-Staging-Count: 3

Please don't invent your own tags.

> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-ti=
s-i2c.yaml
>
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.y=
aml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..de1e34065748
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Devices
> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> +
> +properties:
> +  $nodename:
> +    pattern: "^tpm(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    oneOf:
> +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> +        items:
> +          - const: infineon,slb9673
> +          - const: tcg,tpm-tis-i2c
> +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> +        items:
> +          - const: nuvoton,npct75x
> +          - const: tcg,tpm-tis-i2c
> +      - const: tcg,tpm-tis-i2c
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      tpm@2e {
> +        compatible =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg =3D <0x2e>;
> +      };
> +    };
> +...


BR, Jarkko
