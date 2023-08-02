Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED776C49F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjHBFJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjHBFJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:09:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C81736
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:09:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37259aoe020444;
        Wed, 2 Aug 2023 00:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952976;
        bh=e7Iq4Durm4YxMvhvdMcwDP0cFg0Kkyo0+Oht9+0mLHs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vkvbLT+lOsKyaNFCZff/fPRoVSUlPwsyfGT0VDkGfVl+/jtuYwfLQI690kITJ12y5
         9SNbrmG611jhE33YXaBgypPnTyB4aaBTbJuBPzilYPgCTIc3p1ILwz31NJHjvI7jQU
         1UkYatOyZ7tLSOamRmQQwhEgwpm8VF765YwqAkAY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37259aOn050825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:09:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:09:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:09:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37259adk039400;
        Wed, 2 Aug 2023 00:09:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] soc: ti: k3-ringacc: remove non-fatal probe deferral log
Date:   Wed, 2 Aug 2023 00:09:35 -0500
Message-ID: <169095296427.2814779.3390886320997107617.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230728053356.31044-1-j-choudhary@ti.com>
References: <20230728053356.31044-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Fri, 28 Jul 2023 11:03:56 +0530, Jayesh Choudhary wrote:
> Drop the non-fatal probe deferral log for getting MSI domain.
> This makes the kernel log clean and we do not get recurring logs
> stating: "Failed to get MSI domain".
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-ringacc: remove non-fatal probe deferral log
      commit: e50a76355c1d8581673bda987688d59e7da33928

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

