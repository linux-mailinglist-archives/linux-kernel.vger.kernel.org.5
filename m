Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D207AAC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjIVIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIVIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:21:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864C8F;
        Fri, 22 Sep 2023 01:20:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M8KQbI116649;
        Fri, 22 Sep 2023 03:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695370826;
        bh=/DzZEktjO9kVfpnI+exRh6b65njwoqhvk7patX0JxOQ=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=PG4sI2rrFNS07SPKQBQLdr96Afazkm9Aj0K/tRyDmGkb/Qywl3mEoMVLX/gou8Dlv
         eT2WQmkEzE49Gwm5ysJbQjOyJpiksbHNmwpMSi4ps5kYuMBkeaeaPQb9jiuyRQQoML
         TEia62ATg6DWn4/xjv0Caf+C+GdzQunNLvRLqyZ8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M8KQhn030656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 03:20:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 03:20:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 03:20:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M8KPUa118745;
        Fri, 22 Sep 2023 03:20:26 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Gatien Chevallier" <gatien.chevallier@foss.st.com>
Subject: Re: [EXTERNAL] [PATCH v3 9/9] ARM: dts: stm32: add RNG node for
 STM32MP13x platforms
In-Reply-To: <20230921080301.253563-10-gatien.chevallier@foss.st.com>
References: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
 <20230921080301.253563-10-gatien.chevallier@foss.st.com>
Date:   Fri, 22 Sep 2023 13:50:25 +0530
Message-ID: <8734z6hb5i.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
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

Gatien Chevallier <gatien.chevallier@foss.st.com> writes:

> The RNG on STM32MP13 offers upgrades like customization of its
> configuration and the conditional reset.
>
> The hardware RNG should be managed in the secure world for but it
> is supported on Linux. Therefore, is it not default enabled.
Just curious, will there be concurrent access? If yes, how do you manage
the entropy in that case?

If you allow access to RNG from normal world, can attacker change the
setting to generate more predicatable numbers leading this to secure
world as well.

I understand that you're leaving the enablement part to customer but
you still have to allow RNG access to normal world for that.

-Kamlesh
