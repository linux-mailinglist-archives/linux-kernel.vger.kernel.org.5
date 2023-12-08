Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD288099EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573130AbjLHCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573127AbjLHCyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A581BE8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC0C433C7;
        Fri,  8 Dec 2023 02:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004027;
        bh=fCU91NRDGUv9xh9unCDOKnEWr9bjeIP2qmnEa73L4rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7wC/aRqs3mYByXvTkRkgRbWcl/WlmQqSeZhhGqxXRYHQmAN4+lcWSMfq526OM8rV
         3FRn0I9Bn2Ss/LLdf97E9DvhxzVs13bAn3jj65ZlH3xYVrnFPZ3/kdAnTdf7qHIhKe
         6Vxgc5VnOXZrBwxuXhfrYsYkTv5MwMjTeYK4lU6SAvKI8LJaSaU0b1ZqEX0BsY9Sz/
         od+GdXL/E/2nfISkBjdIWFDMMOOmLxE5fKPMKfxrdrcc8tvp1Hwe6FD9fbFOee5ApR
         u5WJCpH/P0turZAyMwNnmBAOHid37hgeUB3M6BpWxT4x6+4swDqaJ7MzFltwvkn4Gv
         xMeKVPhIQshIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Add devicetree support of Interconnects and USB for SDX75
Date:   Thu,  7 Dec 2023 18:57:51 -0800
Message-ID: <170200426925.2871025.11709635276060964808.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117080737.606687-1-quic_rohiagar@quicinc.com>
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com>
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


On Fri, 17 Nov 2023 13:37:34 +0530, Rohit Agarwal wrote:
> Changes in v5:
>  - Rebased on 6.7-rc1.
>  - Collected the Ack tag.
> 
> Changes in v4:
>  - Reordered the interconnect to keep it in sorted order in patch 1/3.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
      commit: ea72a527bd205283db08287cd49737e889788065
[2/3] arm64: dts: qcom: Add USB3 and PHY support on SDX75
      commit: f47303a8d0b50e762930d4d09ea883fd741394ea
[3/3] arm64: dts: qcom: sdx75-idp: Enable USB3 and PHY support
      commit: a8db1c061f8b4d6881253640119f651031eb3786

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
