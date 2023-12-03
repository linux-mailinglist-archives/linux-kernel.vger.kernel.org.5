Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA38020FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjLCExM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjLCEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470D1BCF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52632C433D9;
        Sun,  3 Dec 2023 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579120;
        bh=+8e4OFe3EdKH9blpRAMonn88ZGbTlQ39Lhkc8fVoJI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmupR+rswIhDNwX/r0GAt9uEm9pAUUKLFhV0BNzQTpsPZnvCrjLleG5tHRZEb8uhD
         KU0Ha7FwM2r8c9y/f6xaFPHeeTGxlTywOmoywo70vRXsdpEWQquM8tc9SZ2zH8NQr4
         0gMY8h5jlYvn7EjkZLHwOXEgsqPg7+PmMWCeX9x7YsvqX3hIF/7EHS3RpfCIe6CNrR
         8MuPW4JGYcMPRHtMC83m/rGEJWM26wY4ig4KQV2TxvV1zrK3w5iKcOO7coESP2wiH8
         vZ/iqwQHOucrFu8CXHl5IxKeMtZpYYMb8yURwZfNizzRgHMfoJvEf9I+81i7lzwLtP
         IWiAEqXhpnJHw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com
Subject: Re: (subset) [PATCH v7 0/5] UFS: Add OPP support
Date:   Sat,  2 Dec 2023 20:54:46 -0800
Message-ID: <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Oct 2023 22:51:24 +0530, Manivannan Sadhasivam wrote:
> This series adds OPP (Operating Points) support to UFSHCD driver.
> 
> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
      commit: ec987b5efd59fdea4178d824d8ec4bbdf3019bdf
[5/5] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
      commit: 725be1d6318e4ea7e3947fd4242a14cf589cfebf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
