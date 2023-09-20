Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040B27A8BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjITS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjITS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4510CA;
        Wed, 20 Sep 2023 11:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2158C433C8;
        Wed, 20 Sep 2023 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695234366;
        bh=PE75NYjmQVobATPo4V3+LF6HiqjEzfsGddCxmXSEr60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6Yfo7agYCmjL+bWnB39wMEUypQbfAQ+kp2viYl3yEKNfeBr9baIHqzEsMpLGFy7h
         moJaQl8Yje2nySFn0EPczEP1fyAWAUjrEjG5+XzAUpYavn6vN1aQcQZmF/eqzHs4MI
         Zq4/0SEnqxe3TNX3DesxNQw40lsUthpzJFhBKL0FWHBQlTXUFRawo1FjTInU6//KRF
         w5YDgPaQlDNgPDfQopiQ8EKeJHRGm4iTnA3Xjkh5VcaGr6cQHOEuGfWfOqacs7nAkf
         QxAxqaom6O8iXr2P9oyhVJuLchXqlSqie6/Pk7qeb/szK/LQXIkdtWXpaVX0faWbqE
         LwgebLp7L1qDw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 00/14] Clean up RPM bus clocks remnants
Date:   Wed, 20 Sep 2023 11:30:12 -0700
Message-ID: <169523460861.3191956.15228997966255141519.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 15:31:38 +0200, Konrad Dybcio wrote:
> After the recent cleanups ([1], [2]) some in-tree abusers that directly
> accessed the RPM bus clocks, effectively circumventing and working
> against the efforts of the interconnect framework, were found.
> 
> Patches 1-5 drop deprecated references and the rest attempt to stop
> direct bus clock abuses.
> 
> [...]

Applied, thanks!

[08/14] dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2 clock
        commit: c4c5b47958529bc1de10260df0c583710853b516
[09/14] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Remove PNoC clock
        commit: e7781901449cbcff129d80a5d9021e9e96084ec4
[10/14] remoteproc: qcom: q6v5-mss: Remove PNoC clock from 8996 MSS
        commit: e1592981c51bac38ea2041b642777b3ba30606a8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
