Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28492757D19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGRNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGRNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E91D1;
        Tue, 18 Jul 2023 06:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8884161575;
        Tue, 18 Jul 2023 13:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A9C433C8;
        Tue, 18 Jul 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686232;
        bh=qiZEsBLuyn7ftK0cVXK4PBiVHo7kAZkPBubS+oSwY4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOSxNOBzd2L8ywiaU0Ah+j3nqB0ZucdARCkZNofstHevNu1vx6O4qDfXSoCm9JIyP
         hoWOberHUqN8FSV55Q3IN/lG/sf0KtIAK0kj0jFkjaPIJuXwlpFgb1AADc3YC5kiZD
         UnrWY+mk7JD0Dpq0UsfVehxPYQLq3vw48AYQPiFwavywQE7gesluKeeIJJ9KG/74y9
         utZX+QDLbUlYzdjgU5wIm5cLGxvmbi1N0Ep0EDnQfM4YcDSM3KieTp3K5779B0c1YB
         g5x8Y6KXOAuYpuHiVH4PRvsbZWTaGREP5FR3FkFH1oxcYYtCy33wwwzX2ebbOEgl//
         ghfrzWh6wwPfQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLkZt-0005Vk-1W;
        Tue, 18 Jul 2023 15:17:22 +0200
Date:   Tue, 18 Jul 2023 15:17:21 +0200
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
Subject: Re: [PATCH 01/15] clk: qcom: branch: Add a helper for setting the
 enable bit
Message-ID: <ZLaQ4ShWwZLAACAI@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-1-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-1-27784d27a4f4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:08PM +0200, Konrad Dybcio wrote:
> We harcode some clocks to be always-on, as they're essential to the

typo: hardcode

> functioning of the SoC / some peripherals. Add a helper to do so
> to make the writes less magic.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
