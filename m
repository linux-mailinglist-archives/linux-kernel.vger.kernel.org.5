Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3007DFC52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377479AbjKBWVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBWVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:21:53 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99D138;
        Thu,  2 Nov 2023 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=W67Q+ocST212snQ+6u1nGmsoUqf/Gk6b3ey7lpHRMWo=; b=oI1fvdL8GCPZikoCy/gdEYKKCD
        gxgCDL7Ul5sYDOEVq8SopsC1DWtDWpLhPHBEAIik2fN9s7Ety0Ude1CnBRIciQlB7DmPhdtB5i7nS
        6T0VJXvSfqkMrDzclvvf1kwGt4DKTnDaLNLXuvbxS/N4SC2kmHuTe0vkg/Sr5MohFR6M=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43552 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qyg4E-0006a3-Ba; Thu, 02 Nov 2023 18:21:39 -0400
Date:   Thu, 2 Nov 2023 18:21:33 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        leoyang.li@nxp.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20231102182133.092e3cedfa80561477b646bb@hugovil.com>
In-Reply-To: <13357eac-7616-4e3f-965b-52ecae01ab92@linaro.org>
References: <20231102193121.1676000-1-hugo@hugovil.com>
        <20231102193121.1676000-3-hugo@hugovil.com>
        <13357eac-7616-4e3f-965b-52ecae01ab92@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: fsl: add RVE gateway board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 22:14:41 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 02/11/2023 20:31, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add DT compatible string for RVE gateway board based on a Variscite
> > VAR-SOM-NANO with a NXP MX8MN nano CPU.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 32b195852a75..4cef18e46312 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1018,6 +1018,7 @@ properties:
> >                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
> >                - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
> >                - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
> > +              - rve,rve-gateway           # i.MX8MN RVE Gateway Board
> 
> Eh, now it does not match your DTS.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

Hi,
for the millionth time, make dtbs_check stopped working for me:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret |= check_doc(f)
           ^^^^^^^^^^^^
  File "/usr/local/bin/dt-doc-validate", line 32, in check_doc
    for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py",
line 125, in iter_errors self.annotate_error(scherr, meta_schema,
scherr.schema_path) File
"/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line 104,
in annotate_error schema = schema[p] ~~~~~~^^^

After a few hours of searching and troubleshooting, I am unable to fix
the problem.

But even with this error, I can still see the warnings, which I
discarded as garbage initally because of that Traceback error.

I now see the problem, and I moved "rve,rve-gateway" to the proper
section, in "Variscite VAR-SOM-MX8MN based boards".

After the move, I still have an error, but now I understand that I must
slightly convert the "Variscite VAR-SOM-MX8MN based boards" to support
more than one board like this:

       - description: Variscite VAR-SOM-MX8MN based boards
         items:
-          - const: variscite,var-som-mx8mn-symphony
+          - enum:
+              - rve,rve-gateway # i.MX8MN RVE Gateway Board
+              - variscite,var-som-mx8mn-symphony
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn

With these changes, everything looks good now.

I Will send a V4 with these changes.

Thank you,
Hugo.
