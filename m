Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27B7AEDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjIZNNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:13:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D4101;
        Tue, 26 Sep 2023 06:13:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QDDfrW074505;
        Tue, 26 Sep 2023 08:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695734021;
        bh=kTTthXlSUBAhupfVmcCdkV/3LZHpU0fBU0nJVar5vHc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=b4NlryyNrFGGcmJTlo4lUBT+ZpeBJGXWFOGpZXGe3u80onfG0ZGhPgEE7LiPgLaAF
         u7v60OCS6k+I6WuMwvw/Fg95fwlSRM6VHd+i0xYFG1iOI1mDqAN1YOY5ZlxRm051AC
         83B/d2c3ppwG/8JGIfvUCEZSapzIazhVC2uY0VmY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QDDfn1015820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 08:13:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 08:13:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 08:13:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QDDeKe094423;
        Tue, 26 Sep 2023 08:13:40 -0500
Date:   Tue, 26 Sep 2023 18:43:39 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <20230926131339.nigj6gp35r74yban@dhruva>
References: <20230919074658.41666-1-d-gole@ti.com>
 <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
 <20230926114046.5ukretunoud3yv45@dhruva>
 <ZRLHVReL9Bq4PNvS@finisterre.sirena.org.uk>
 <20230926121908.mcyyj42buqr4ov3m@dhruva>
 <ZRLTG4pogXW5FTgJ@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRLTG4pogXW5FTgJ@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2023 at 14:48:27 +0200, Mark Brown wrote:
> On Tue, Sep 26, 2023 at 05:49:08PM +0530, Dhruva Gole wrote:
> 
> > Umm I don't think the commit being fixed is there in 6.6?
> > I am not really sure how I should base/format the patch? Please can you
> > tell me what's expected in such a case ideally?
> 
> Including a full 12 character commit hash would help with matching,

I have given the full 12 chars, else checkpatch would've caught me :)

> there were only 10 there.  Not mix'n'matching Link:/Close: with links in
> the body of the commit message would help as well.

OK, I have fixed the links and sent the patch V3

Again, I have based on your for-next, as I don't see the fixes: commit in
the 6.6 tree.



-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
