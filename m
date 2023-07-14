Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28A75314A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjGNFbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjGNFay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305482D78;
        Thu, 13 Jul 2023 22:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB47E61C0A;
        Fri, 14 Jul 2023 05:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA97C433C8;
        Fri, 14 Jul 2023 05:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312650;
        bh=0p6TOtFq3eOq1+ueMOV54oBonIFAvO+hOosLaT4eTNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH/VQWx08tWFU8wjhX7dOwArW/p8x/OO/uX1Cm8D1LKQV5/fbkIpR3XY/KaBhje/W
         jM3/5CDuEXcTGC941mB3ywk0n37rJLxjVwhdY9uHmBfdRPbarQ/QQWnyhSXkgtuN70
         YIKtDkK03NvNWQ/ZDWa3Mcgh8Z6rdzv6LHk9CUeK/NnmzfdT2NXcD1qWENHcwJV6+p
         IzA/csX6JEzktMXQBrE67QMo7iFWFt4x7csiGI5IIsTKpiIK9U49VnL9RRimfQODu5
         +gCI94jZzDKQ98WtIEk/1+Bq1XYTpD+dNx/k/Ih24nCa+SoMzXtwOiWiEBZIVFoiEu
         ZHj2JNmOTrv9A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 00/13] Add dedicated device tree node for RPM processor/subsystem
Date:   Thu, 13 Jul 2023 22:34:05 -0700
Message-ID: <168931284129.1538684.15537187886743646347.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 18:50:33 +0200, Stephan Gerhold wrote:
> The Resource Power Manager (RPM) currently does not have a dedicated
> device tree node that represents the remoteproc/subsystem. The
> functionality exposed through the SMD/GLINK channels is described in
> top-level nodes of the device tree. This makes it hard to group other
> functionality provided by the RPM together in the device tree. This
> series adds a single top-level remoteproc-rpm/rpm-proc device tree node
> that groups all RPM functionality together.
> 
> [...]

Applied, thanks!

[12/13] ARM: dts: qcom: Add rpm-proc node for SMD platforms
        commit: b471a1bc797429f905b97edd727f4678d7b20ec8
[13/13] ARM: dts: qcom: apq8064: Drop redundant /smd node
        commit: 3f30509ff561453ea0c4de1716ab72125f8bf83c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
