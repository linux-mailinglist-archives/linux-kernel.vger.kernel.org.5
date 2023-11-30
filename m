Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FF7FF86D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbjK3Rh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:37:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91675197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:37:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CADC433C9;
        Thu, 30 Nov 2023 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365851;
        bh=I/RwekvEm5QIDGRUyxy7iKY4DFgOKjlEGNrv2EFM96M=;
        h=From:To:Cc:Subject:Date:From;
        b=lLpwMnO+XqPA54AmQ3tVbECUgmOZAfG8lfMvXi5Dn/U1HnTG2+Rjwf6gt1yeTbiIR
         /OQsKbX7sfiFDCjnu9AgGbl+1kMMmE6kY3b639B2JV85o8AvIewaNmXnkOdADM8g8a
         xsfnh2QYj+TlQJSwMO7rdzSroQuJuPsA71KuBWU5yv0Iyl6ufEPP5f6uWK1y6n5tbq
         znDvNhWWCYR8UwrLha683/ewXkAGBLmnH5XEd8uQvuR0sIMEF1m2EDbj779oR3rJhC
         oYwDQggOh+l2TuSNMCu1D8nrSgTS6quCtSzocycMQCd4Z11rJZF95DLaITq4YBatz2
         l9dPg2DvUZJ1A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kzE-0003O6-0K;
        Thu, 30 Nov 2023 18:38:04 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] dt-bindings: spmi: clean up hisilicon binding
Date:   Thu, 30 Nov 2023 18:37:55 +0100
Message-ID: <20231130173757.13011-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series addresses the related hisilicon SPMI controller binding.

Johan


Johan Hovold (2):
  dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding
    references
  dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example

 .../spmi/hisilicon,hisi-spmi-controller.yaml    | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.41.0

