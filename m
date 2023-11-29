Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D517FD80D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjK2N2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjK2N2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04EBE;
        Wed, 29 Nov 2023 05:28:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A8956607323;
        Wed, 29 Nov 2023 13:28:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264508;
        bh=HlqEFTwY2FP70HIxpwXJdIFjuEH7u8FwV+jprgf3CFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jb2RZYuOk8xi1OQ/9R8MGVhR6I/09yX1dkEfwdbQldV0arEJhK8rc3cHSIYTFzmWj
         HrbpWO02iNzsYrRMk/9nhnJnWJ+jLkd/IY+XJcW3crxtWVERdxg5E5SvwWMKorhK3e
         52Fxe5EL0ntXYUfhHEjQZg+qGFYzMRbg7MvzMgZ6GNNGWX9/keWJIKzd7fnk4SWNkP
         qozljNtJRaGXd9MkRjQ6SqMNLX3VcH+B/wCJg3/gAMKP6O01JQMO41UJptoeD6XPQb
         C0rBL3vIJh2Vti2cv3pskRPtVxiiHrOi2e2A2M0EaiAWv04JmsgQ8NBMRzNsgZ1rl4
         SoXTg+7NZeHzQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        matthias.bgg@gmail.com
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        allen-kh.cheng@mediatek.com
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: fix clock names for power domains
Date:   Wed, 29 Nov 2023 14:27:35 +0100
Message-ID: <170126437824.153055.4332552662012984056.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005103041.352478-1-eugen.hristev@collabora.com>
References: <20231005103041.352478-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Oct 2023 13:30:41 +0300, Eugen Hristev wrote:
> Clocks for each power domain are split into big categories: pd clocks
> and subsys clocks.
> According to the binding, all clocks which have a dash '-' in their name
> are treated as subsys clocks, and must be placed at the end of the list.
> The other clocks which are pd clocks must come first.
> Fixed the naming and the placing of all clocks in the power domains.
> For the avoidance of doubt, prefixed all subsys clocks with the 'subsys'
> prefix. The binding does not enforce strict clock names, the driver
> uses them in bulk, only making a difference for pd clocks vs subsys clocks.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: mediatek: mt8186: fix clock names for power domains
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
