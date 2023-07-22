Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949375DA04
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGVFOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGVFON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5B3586;
        Fri, 21 Jul 2023 22:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212CB60B00;
        Sat, 22 Jul 2023 05:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A489C433CD;
        Sat, 22 Jul 2023 05:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002851;
        bh=LaPqss/OQuhVsZMHk7MPCB1SZyTSSjvmYOQH84K5LuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irpMSb6irRz6FpliuvBamfJRa4uZDLvVhShuOoeYZccVxXOcYL/eA0fUVKg680xNV
         wcu6yVyZ6/dWl8VFub2+9YQnZ1SrrvLX44Y5/qACHxshnCMThx77asPM+XDRW83EAv
         x2nQYGbtq1MZzsNlTWpmC0tLSX2dcpDC99/UKS34liHLUMW5oC01dV8tCu1duLDMgR
         doJsy/982VwNR9WhwMTWgSl7RrcAcvqJwIisV+2G5Q3XMLOTfn4xBks/fReTSd1zUP
         ymevB06gLYv3MkfqAfDn0K+JspNFmThmo6IMXVIsef7EVTFgD3iyIegR/hVhSnt7hm
         uLGAw91i0eHJA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Drop useless compatibles from the SCM driver
Date:   Fri, 21 Jul 2023 22:17:10 -0700
Message-ID: <169000304216.3611206.18342866201634034324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
References: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Sat, 24 Jun 2023 14:23:44 +0200, Konrad Dybcio wrote:
> The compatibles, apart from some ancient ones kept for backwards compat
> due to no generic fallback, are largely useless and we can easily remove
> them. This series attempts to do that with hopefully no harm.
> 
> 

Applied, thanks!

[1/3] firmware: qcom_scm: Always try to consume all three clocks
      commit: f14459df6721cd23feb4618e8bbe3778d0d0a552
[2/3] firmware: qcom_scm: Always return devm_clk_get_optional errors
      commit: f8e27cdc8833dee56f43e767dd16c97488d3af11
[3/3] firmware: qcom_scm: Drop useless compatibles
      commit: b1d48e61d8068304fda215880ca021c22b00a19a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
