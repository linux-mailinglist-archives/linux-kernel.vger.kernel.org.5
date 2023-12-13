Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C048114C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441984AbjLMOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441980AbjLMOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:36:11 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5473B9;
        Wed, 13 Dec 2023 06:36:17 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5906eac104bso4109579eaf.2;
        Wed, 13 Dec 2023 06:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478177; x=1703082977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+KCX3VeG9RylsCC1YNPXKBKpJf6ejqEflv5vOYcrLY=;
        b=r+/FLdmmzt/1Z6XVbWks0akWA5TDd35FlIEl1ONjBJui+YMxYIvZaLgJM+04J42Yf1
         humYKAHsusXK7oo6cHOFF8wq/TeLbBwt6BmVjAqN56df9+nZOyc80BrDvNdD7FanDgCR
         1UqTPu6IgGtCZtdwfhf2qdKOuEAuVBi2TIhEcA5c4LJH9sBTNWysLh2hr14vdSR9pYau
         USl0g4hBgIH6kZBbtAeU25fyCEwnnDt2hfcU1lzDS21vuC/hXz5kcW0lFL1vgGqjEVPn
         bC7GTccjEMV+bavNNA/sOHDzrZamWT9fSC2CrFBzh0ZcTcS6SndZh3Wo8zKJHh75XGCk
         OHeQ==
X-Gm-Message-State: AOJu0YxcPHZOvQJ+OmovS+cm6EMSJdU+zyLtWFQ0G/rP6bXdqlm5FnJZ
        WkATmNoojuPmXoRbq/OpUA==
X-Google-Smtp-Source: AGHT+IFfbdp0Fk0iljZhPsJrTY/juF09ZOPbQP2s05SHQ+lFCWp9SR9xRORHjmc2ElZiVPN97gPIeg==
X-Received: by 2002:a05:6820:287:b0:590:673c:e284 with SMTP id q7-20020a056820028700b00590673ce284mr3736085ood.10.1702478176998;
        Wed, 13 Dec 2023 06:36:16 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x8-20020a4a6208000000b0057b6ac3922esm3043883ooc.18.2023.12.13.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:36:16 -0800 (PST)
Received: (nullmailer pid 1097845 invoked by uid 1000);
        Wed, 13 Dec 2023 14:36:15 -0000
Date:   Wed, 13 Dec 2023 08:36:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
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
Message-ID: <20231213143615.GA1093782-robh@kernel.org>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
 <20231212224426.GA2948988-robh@kernel.org>
 <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:28:43PM -0500, Frank Li wrote:
> On Tue, Dec 12, 2023 at 04:44:26PM -0600, Rob Herring wrote:
> > On Mon, Dec 11, 2023 at 04:58:37PM -0500, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > 
> > > Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> > > Add "atu" and "serdes" to reg-names.
> > > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v2 to v3
> > >     - Remove krzy's ACK tag
> > >     - Add condition check for imx95, which required more reg-names then old
> > >     platform, so need Krzy review again,
> > >     
> > >     Change from v1 to v2
> > >     - add Krzy's ACK tag
> > > 
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > index 81bbb8728f0f9..b8fcf8258f031 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > @@ -29,6 +29,7 @@ properties:
> > >        - fsl,imx8mq-pcie
> > >        - fsl,imx8mm-pcie
> > >        - fsl,imx8mp-pcie
> > > +      - fsl,imx95-pcie
> > >  
> > >    reg:
> > >      items:
> > > @@ -90,6 +91,22 @@ required:
> > >  allOf:
> > >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > >    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          enum:
> > > +            - fsl,imx95-pcie
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          minItems: 4
> > > +        reg-names:
> > > +          items:
> > > +            - const: dbi
> > > +            - const: serdes
> > 
> > Did you test this? It should fail because 'serdes' would need to be 
> > added to snps,dw-pcie.yaml.
> 
> I run "make dt_binding_check DT_SCHEMA_FILES=/pci/", no error report.

Only because you have no example. What about your actual .dts?

> And PCIe function can work.
> 
> > 
> > Is this really not a separate phy block?
> 
> This is misc block, which included phy and also include some registers
> about SID for each PCI devices. I plan do it later.

Sounds like it should be a separate node and use the phy binding. Do it 
correctly from the start, not later. Later is an ABI break.

What is SID?

Rob
