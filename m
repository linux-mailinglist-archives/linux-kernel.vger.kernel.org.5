Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE07A0A19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbjINQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjINQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690881FDD;
        Thu, 14 Sep 2023 09:00:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE769C433B6;
        Thu, 14 Sep 2023 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707243;
        bh=f2D1KJ3G20fQHFUTIyD1SsNidi043orZ//0JAIezb+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOkiMmyFXU5u+UgP7/kW6xApq5eB3donlHM+Eve8nWIVnGjWj6CXCtisbB80QooXn
         /VysJwh8d3FwooQ1Gn55LroUq6egGXmFmXe3RKEJKGPSAiQ2Ue+7/FnC69tsqxCMMR
         sju9KBmz1avdOZrIES+ecuFug69VNXhdk3b0p+7LYFxve+Vcn14/MJ3rSABVm4mp1C
         tPW3Dd5VLUxNt8zmbNg3Lz9l0+y6ixRyq7PhKMHEO6D0Oza958pnkX0RGRiFVaul+t
         4tcSVPIekcp6KTksYSV9QRqnJWVqZXUDUwpXMn1F7TrNrEDWM3wq7IkR0d91A+ZcYa
         bFzNydZ12c97w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ulf.hansson@linaro.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Subject: Re: (subset) [RESEND v4 0/3] Use PSCI OS initiated mode for sc7280
Date:   Thu, 14 Sep 2023 09:04:31 -0700
Message-ID: <169470744889.681825.1107443833473958545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230703085555.30285-1-quic_mkshah@quicinc.com>
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 14:25:52 +0530, Maulik Shah wrote:
> This is resend of v4 with patch1 and patch2 Cced to stable kernel.
> 
> Changes in v4:
> - Add missing s-o-b line and reviewed by in patch 1
> - Address ulf's comments for error handling in patch 2
> 
> Changes in v3:
> - Add new change to provide helper function dt_idle_pd_remove_topology()
> - Address ulf's comments for error handling
> - Add reviewed by ulf for devicetree change
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
      commit: 7925ca85e956191a6a522e0a31a877b98cb5096c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
