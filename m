Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D5757D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGRNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGRNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BCCA;
        Tue, 18 Jul 2023 06:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F9161562;
        Tue, 18 Jul 2023 13:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D40C433C8;
        Tue, 18 Jul 2023 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686288;
        bh=hlEuayYTGOrVxjn/L9tOZYF6W7MQqb0nZJDM6TZ8IY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJKmw96HzRQLAF9c82YI5dnguD3erNNU4kXJADkA9c1Gbc5Pe6uqZlz2CZiZ+BuYg
         EHXeybUtLHj4k72yH77EeRDP+2hMABc/4CvRxM0AY3new3AWzZX6vDfs3DjQU6RBWW
         ltqkqqijVl/N0WYWakgNddxnOq8Y2M1Q9JUkZO8ZiJobi0PeJlekepqPgsNUS5Oh1j
         BoRxXtxsNiyCH/BCKKCVrXu6u0ahVtVmXOKV2hepFvL7l2NpA7lag+eie+VP0UpMLp
         uIi1YQc3zUP7GMLkwbRgBQzQq1lCkQrqs1I2iMu4LJi908k+3CsZh9pMr14HuZOxeG
         lHIxEU50MksTQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLkan-0005W1-2V;
        Tue, 18 Jul 2023 15:18:17 +0200
Date:   Tue, 18 Jul 2023 15:18:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/15] clk: qcom: Use qcom_branch_set_clk_en()
Message-ID: <ZLaRGT_TnFPKfpTl@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-2-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-2-27784d27a4f4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:09PM +0200, Konrad Dybcio wrote:
> Instead of magically poking at the bit0 of branch clocks' CBCR, use
> the newly introduced helper.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Nice cleanup.

Acked-by: Johan Hovold <johan+linaro@kernel.org>
