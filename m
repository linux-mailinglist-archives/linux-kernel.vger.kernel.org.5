Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B937766D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHISAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjHISAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:00:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A81FC2;
        Wed,  9 Aug 2023 11:00:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HxkPq057101;
        Wed, 9 Aug 2023 12:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691603986;
        bh=x3Lw2e2OwZVE9pdQ22Uc5zXYbecSVQLCL10RrkSHckg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=w/c+ampC23zG0DT1CZFYiscSoYLy8S9ff6ySVcDgdOAdRlktLYsmoEvrWsFuNK0qq
         wHUJquQwGukRTwXn5SbFS+g2zFFGUYfSqoLWzdTFfIqd3p9tGokMp13H5gAQr1QhA5
         RV5CXzgaqAeCiGWUjCRYjoBgHIwcexSlh8NiXfV4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HxkLp108600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:59:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:59:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:59:46 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379HxkGB097144;
        Wed, 9 Aug 2023 12:59:46 -0500
Date:   Wed, 9 Aug 2023 12:59:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v5 0/6] arm64: ti: k3-am62: Add display support
Message-ID: <20230809175946.odehsydpgqvqbsin@comfort>
References: <20230809084559.17322-1-a-bhatia1@ti.com>
 <20230809144005.n3uq5yjusrrtjhqz@churn>
 <c0798225-3d99-4c45-5637-55bfbf7b0c8b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0798225-3d99-4c45-5637-55bfbf7b0c8b@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:01-20230809, Andrew Davis wrote:
[...]
> > Can you help cleanup the following before we start introducing new oldi
> > and dss support? I am not sure if these were introduced due to yaml
> > updates or something pre-existing.
> 
> This is a pre-existing issue. Lets not fault Aradhya nor hold back this
> series for an issue we caused way back when initially adding AM65 support.
> 
> Just to help this along, I've gone and added the fix for these warnings
> here[0][1].
> 
> Andrew
> 
> [0] https://lkml.org/lkml/2023/8/9/889
> [1] https://lkml.org/lkml/2023/8/9/888
> 

I am tempted to plagiarize Lt. Aldo Raine "I want my fixes", but quips
aside, exactly why not picking up patches without fixes is the last
knob I have to force long standing issue resolution :). unfortunate to
need to use it, happy to see it still work.

That said, the patches will have to wait a cycle anyways (cant take
checkpatch warnings with rc1) for the binding to hit 6.6-rc1. In the
meanwhile lets see about getting that fix series merged..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
