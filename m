Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E97D9A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbjJ0NpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:45:12 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5939D;
        Fri, 27 Oct 2023 06:45:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39RDiaxQ067033;
        Fri, 27 Oct 2023 08:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698414276;
        bh=Qg/1UXJ0dWyMcG/xoLC6gioXtxPaIZUEcHwz2w/f3iQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FY2TUPcjIkGQYB26c3LR0Azc0ZbZAKkFVE7TIkOtzxMvnfFRYQ+X8NKfoVoCSxuWY
         c0uAGGJt+yya5tE9ewgT/9DuTltScgW+1EQL7kMfIzFuFd5EXLLLNmBKabE/kaQzOH
         mdXVHn9Z9HyL0vHhWEJwmnWRqBJqiQ1/mMYLvkPY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39RDiaqO005226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 08:44:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 08:44:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 08:44:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39RDiZWc079480;
        Fri, 27 Oct 2023 08:44:35 -0500
Date:   Fri, 27 Oct 2023 08:44:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH 3/7] arm64: dts: ti: iot2050: Definitions for runtime
 pinmuxing
Message-ID: <20231027134435.xi7lx3kckcqntmrg@giblet>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <4ecdf2fbe8c8a99e95743c78c63205548bb97a04.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4ecdf2fbe8c8a99e95743c78c63205548bb97a04.1698413678.git.jan.kiszka@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:34-20231027, Jan Kiszka wrote:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> Add multiple device tree nodes in order to support
> runtime pinmuxing via debugfs.
> 
> All nodes are added to the pinctrl device node,
> since they are now belonging to multiple interfaces now.
> 
> Note: Pinconf is also handled by debugfs-pinmux. This is possible since
> pinconf and pinmux accessing the same 32-Bit register and setting the
> function mask to 32-Bit allows writes to the whole register.
> 
> Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>

Your sign off is missing here Jan.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
