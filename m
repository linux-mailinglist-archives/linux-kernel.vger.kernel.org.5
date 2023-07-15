Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C197546EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGOFZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 01:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOFZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 01:25:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D53A9D;
        Fri, 14 Jul 2023 22:25:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36F5PIhO013304;
        Sat, 15 Jul 2023 00:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689398718;
        bh=3S2X2tz6GMb/LEBYroRqxU/r/eV423Lk4Fh4pKxefnw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tc4+KoWdoUtVFHL9N+ZC03JGG8QCcQ8aF2njTe9lq4puv5HL7ZYKSRbFp7xVFKWy1
         XnI3pG68uwyauRrfCIitqLDuu1IlCXx9AIxbzBbOzdXPsEPzx6uBoYgX6hpo3l0FPy
         cfy188fzWuOOtX2FUgBzoiRsgyG+3eXq3Sqlg9Nw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36F5PISJ024632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Jul 2023 00:25:18 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jul 2023 00:25:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jul 2023 00:25:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36F5PHiI012539;
        Sat, 15 Jul 2023 00:25:17 -0500
Date:   Sat, 15 Jul 2023 00:25:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <huaqian.li@siemens.com>, <wim@linux-watchdog.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <huaqianlee@gmail.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jan.kiszka@siemens.com>,
        <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Message-ID: <20230715052517.dinbn25ivsg4ocx2@subtitle>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-3-huaqian.li@siemens.com>
 <20230714225240.dvlwqaodp2l3cczm@disfigure>
 <0b0e6961-1211-4765-2a63-4b69789dbbb3@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b0e6961-1211-4765-2a63-4b69789dbbb3@roeck-us.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:27-20230714, Guenter Roeck wrote:
> On 7/14/23 15:52, Nishanth Menon wrote:
> > On 17:51-20230713, huaqian.li@siemens.com wrote:
> > > From: Li Hua Qian <huaqian.li@siemens.com>
> > 
> > I guess I should be explicit about this: Lets keep this dts patch as
> > "DONOTMERGE" in subject line for driver subsystem maintainer (I don't
> > want a repeat of cpufreq maintainers picking up dts and associated
> > warnings that are now pending fixes), resubmit at next rc1 and I can
> > queue up the dts once the maintainers pick up the driver and bindings.
> > 
> 
> FWIW, I never pick up patches outside drivers/hwmon without explicit Ack
> from responsible maintainers (and most definitely not dts patches unless
> a maintainer responsible for the file(s) specifically asks me to do it
> (which I think never happened).

Oops Guenter, didn't mean to indicate your tree :( -> just wanted
to ensure that developers are clearly aware of what happens with
cross posting series involving multiple maintainers and level set
their expectations. Saves a bunch of private pings later on :)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
