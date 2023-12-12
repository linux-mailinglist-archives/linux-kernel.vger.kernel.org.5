Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3180EF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbjLLPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376468AbjLLPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:06:51 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D8E8;
        Tue, 12 Dec 2023 07:06:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCF6YPH107768;
        Tue, 12 Dec 2023 09:06:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702393594;
        bh=Fs5RaAnS2wvnZwD9IHWpksznjB8waKCTXyO3Fxt+6RM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=M54V/x/6cvtsOPCEvDIQdi7Xs3DIEHoPmEVXlBbkAiuGv6xU7Jiow2gWJZX5QJbqB
         psfVFap7oPAZwZyV2qTsdaOondWv54HNi46YNaQ+88tb5MVqjmLCKBCDj6C6lnxBXr
         heRHfVwBaGc0WND29dpbNq0PZkf+6nF0Q2h8lxEw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCF6YI4075470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 09:06:34 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 09:06:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 09:06:34 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCF6YcN021290;
        Tue, 12 Dec 2023 09:06:34 -0600
Date:   Tue, 12 Dec 2023 09:06:34 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Brandon Brnich <b-brnich@ti.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: media: Remove K3 Family Prefix from
 Compatible
Message-ID: <20231212150634.7235jjsusngzta3z@tingly>
References: <20231211205920.698939-1-b-brnich@ti.com>
 <20231211205920.698939-2-b-brnich@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211205920.698939-2-b-brnich@ti.com>
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

On 14:59-20231211, Brandon Brnich wrote:
> K3 family prefix is not included in other TI compatible strings. Remove
> this prefix to keep naming convention consistent.
> 
> Fixes: de4b9f7e371a ("dt-bindings: media: wave5: add yaml devicetree bindings")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com/
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>  V2 -> V3: Update compatible in example
> 
>  Bindings currently reside in linux-next, meaning that the ABI will not be
>  broken with the removal of K3 prefix. Important to get this merged in
>  prior to being moved to master so that K3 prefix does not need to be
>  permanately included.
> 
>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> index 6d5569e77b7a..6a11c1d11fb5 100644
> --- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -17,7 +17,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - ti,k3-j721s2-wave521c
> +          - ti,j721s2-wave521c
>        - const: cnm,wave521c
>  
>    reg:
> @@ -53,7 +53,7 @@ additionalProperties: false
>  examples:
>    - |
>      vpu: video-codec@12345678 {
> -        compatible = "ti,k3-j721s2-wave521c", "cnm,wave521c";
> +        compatible = "ti,j721s2-wave521c", "cnm,wave521c";
>          reg = <0x12345678 0x1000>;
>          clocks = <&clks 42>;
>          interrupts = <42>;
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
