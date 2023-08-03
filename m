Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FD76DFFE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjHCGBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjHCGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:01:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDDE6F;
        Wed,  2 Aug 2023 23:01:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37361bNw091891;
        Thu, 3 Aug 2023 01:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691042497;
        bh=Eq3fAhTV5YV3oUQ6BBvL8m3xQDKMmG4eYt87dBmZskM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BWBOQzbfwI/tP0jfhhO+BFyd+4h3QYnjnlbRx082FdlcvxnfNJnTNvhj1TwcqXeiQ
         r0YHV+DLzADY5MvQm0iOGl294vyO/AFnoXdB0tuTgkz5JQUM+7B9VO/wYQSfy0CB6T
         nIV6YIWuRVQos+ubIn83Xt8/x4N45YSSEe6FAv70=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37361bsj002604
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:01:37 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:01:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:01:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37361a3o015863;
        Thu, 3 Aug 2023 01:01:36 -0500
Date:   Thu, 3 Aug 2023 11:31:35 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json
 schema
Message-ID: <20230803060135.cichqctmjhajt2hq@dhruva>
References: <20230801233341.1416552-1-nm@ti.com>
 <20230801233341.1416552-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801233341.1416552-3-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 01, 2023 at 18:33:41 -0500, Nishanth Menon wrote:
> Move the ti-cpufreq binding over to opp and convert convert the free

Minor nitpik, maybe can be fixed while applying the patch. Checkpatch caught this,
Possible repeated word: 'convert'

> text binding to json-schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Otherwise, LGTM

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> Changes since V1:
> - Fixup $subject of the patch to indicate json schema rather than yaml.
> - Change filename to matchup with binding compatible
> - Dropped un-used labels
> - Dropped "|" in "description"
> 
> V1: https://lore.kernel.org/all/20230724153911.1376830-6-nm@ti.com/
> 
> Side note: cleanups in dt is picked up on Tony's tree:
> https://lore.kernel.org/all/20230731062551.GH5194@atomide.com/
> 
>  .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
>  .../opp/operating-points-v2-ti-cpu.yaml       |  88 ++++++++++++
>  2 files changed, 88 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
> deleted file mode 100644
[..snip..]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
