Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98747AEB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjIZLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:41:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF788F3;
        Tue, 26 Sep 2023 04:40:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBem3j128013;
        Tue, 26 Sep 2023 06:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695728448;
        bh=Wnf2ywES0kx+dypN1caDUu8AVrG46JObdEreRW0gdEA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PnAPLP3+3WvDBp9KJtOXkwv2zVFOdYyAX3W0Dz9F5gANlQP6UTefFUaemkP6GyUyc
         LeUTNQMJ8OXNbY6zcBuu2KYqApdRUVmrQNPpdPWLKJaI7BWxzW6vHitAB5OuzSZgKD
         la2S8aBSGlMJAll8XLbhEhrnMBIzePpkdu/65f/8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBemCa068465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 06:40:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:40:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:40:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBelfX086280;
        Tue, 26 Sep 2023 06:40:48 -0500
Date:   Tue, 26 Sep 2023 17:10:46 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <20230926114046.5ukretunoud3yv45@dhruva>
References: <20230919074658.41666-1-d-gole@ti.com>
 <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2023 at 13:21:04 +0200, Mark Brown wrote:
> On Tue, Sep 19, 2023 at 01:16:59PM +0530, Dhruva Gole wrote:
> > The following smatch warnings [0] were recently introduced:
> > 
> > drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> > unwind goto?
> 
> This doesn't apply against current code, please check and resend.

Pardon, which branch is this being applied on?

I am on the following base and it applies OK:
commit b643e6268c8f466ebb08a594b8ec8a1e2fd275a2 (spi-broonie/for-next)
Merge: 3b4e5194138b da6de6d3ecc1
Author: Mark Brown <broonie@kernel.org>
Date:   Tue Sep 26 13:08:30 2023 +0200

    Merge remote-tracking branch 'spi/for-6.7' into spi-next


origin: spi-broonie https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
