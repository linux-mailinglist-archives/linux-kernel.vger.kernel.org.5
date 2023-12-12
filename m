Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A380FA82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjLLWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjLLWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:44:22 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE61592;
        Tue, 12 Dec 2023 14:44:28 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b844357f7cso4750041b6e.1;
        Tue, 12 Dec 2023 14:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421068; x=1703025868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMphJ493+DciN8lLws8RSRlMD94qy0SoU2WP5DJOjj4=;
        b=kwQylEoU8SK+V8fU2+QG8mF3SIhcOplIlJX2Yx5KYzCmKiICY9DVMYb2TdWlTN+FKs
         OmQkbGvAHe6pTFFIYsVIIggVV6OQr87kU/qZkr9KuF7Iv4yiUDzlyFoBdSUME+ddYwT5
         uk8Yd5BXp1JT7Uy9PmmGa3OAhwYnaOa8fGV9IY5AowDl3ex5IcTgecfAY5cfDn1I7+74
         wuyJgVD7HLSeFXxJGGKXYfIUWXfuUDvaHQ8Q3e0GPyqT5jWyABymAKvQK7IVLE+fDeW1
         Fd1rFjVR1j/MV+pafjeq9oowg/7ks5Kl01BJTn3o0LG2htTE2BeR92qeH3h4SntkP6r2
         4VDQ==
X-Gm-Message-State: AOJu0YySHBo7hzq3x5WAxwiuwHJeO1Z8YtP6EsrBN/h2pHHquM6jDZMq
        MZxdyQyR0+1IaWfl6aCnqQ==
X-Google-Smtp-Source: AGHT+IFjb8zyZy6HgbNr/jID6qfej7EjNW9FQEisDXKCGMer4Y5UYOBAfKHQdPfu1aEWyVUhGqcagQ==
X-Received: by 2002:a05:6808:148a:b0:3b9:ca51:5186 with SMTP id e10-20020a056808148a00b003b9ca515186mr7781124oiw.42.1702421068119;
        Tue, 12 Dec 2023 14:44:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ct7-20020a056808360700b003b9fd2af1f1sm1970848oib.32.2023.12.12.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:44:27 -0800 (PST)
Received: (nullmailer pid 2966246 invoked by uid 1000);
        Tue, 12 Dec 2023 22:44:26 -0000
Date:   Tue, 12 Dec 2023 16:44:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
        hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 08/13] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <20231212224426.GA2948988-robh@kernel.org>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211215842.134823-9-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:58:37PM -0500, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> Add "atu" and "serdes" to reg-names.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - Remove krzy's ACK tag
>     - Add condition check for imx95, which required more reg-names then old
>     platform, so need Krzy review again,
>     
>     Change from v1 to v2
>     - add Krzy's ACK tag
> 
>  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f9..b8fcf8258f031 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -29,6 +29,7 @@ properties:
>        - fsl,imx8mq-pcie
>        - fsl,imx8mm-pcie
>        - fsl,imx8mp-pcie
> +      - fsl,imx95-pcie
>  
>    reg:
>      items:
> @@ -90,6 +91,22 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx95-pcie
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: serdes

Did you test this? It should fail because 'serdes' would need to be 
added to snps,dw-pcie.yaml.

Is this really not a separate phy block? A separate node would be 
ideal. If not, there's already a 'phy' name you can use here. We don't 
want more random names.

Rob
