Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB478003E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbjLAGd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377614AbjLAGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:33:25 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51DDE;
        Thu, 30 Nov 2023 22:33:31 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B16XAPa046868;
        Fri, 1 Dec 2023 00:33:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701412390;
        bh=R3JOMs+GLcTvTmXuGQ+uZWSEdM5pv0lZocvcKZHDUSY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yNkbszn6/F7jIaLVqhcX0SwjspqMmcnD/VB+kCC6iGtV3l64BIVvBDdvnaSprN/k1
         D5nFt/F8uioG9/TU7eoMTdPtsb39NVv6GXZsYbqvDn3QtdAAmcNSIqefXpne0KkoAF
         R4bzE1sRH+xUmR54Nj0rK4BqcwG8TuRs+eszBTB4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B16XAIt004605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 00:33:10 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 00:33:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 00:33:10 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B16X9SM105901;
        Fri, 1 Dec 2023 00:33:09 -0600
Date:   Fri, 1 Dec 2023 00:33:09 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        <devicetree@vger.kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        "R, Vignesh" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v14 6/8] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20231201063309.tingjc3cjhsqb6r7@confusing>
References: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
 <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
 <CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:27-20231128, Geert Uytterhoeven wrote:
> Hi Sebastian,
> 
> CC TI K3

Thanks for looping us in Geert.


[...]
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - ti,k3-j721s2-wave521c
> 
> This is the only compatible value defined which contains both "k3"
> and "j72*".  I assume the "k3-" part should be dropped?

Correct - we have not been using architecture prefix such as k3- in
compatibles for any other peripheral and that lines up with DT spec[1]

$ git grep ti, Documentation/|grep compatible|grep yaml|cut -d ':' -f2|grep k3-
is empty.

I have for asked this to be cleared up[2] before I can pick the dts changes
corresponding to the binding.. I will wait for the bindings to hit linus
master prior to looking at the dts changes.

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4
[2] https://lore.kernel.org/all/20231201062427.6fw5gn2zgkkurv4q@shadow/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
