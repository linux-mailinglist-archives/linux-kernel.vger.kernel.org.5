Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2257D1E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJUPzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjJUPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:55:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA5188;
        Sat, 21 Oct 2023 08:54:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D76C4339A;
        Sat, 21 Oct 2023 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903699;
        bh=A1QUgrd3OsdENbfTvplDpjaXD+YmKnrUIv9psTLBxP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxT5vDFapMQxxWfnemY7w8QlzZbqAtS8Ke9vVU/3+QWcaqEVO5JcoMv5h9g+aQ5Q/
         ClP2sbaQIaLM0CDrGmU+vmrth2pYB3BMPuueKJkNx5rhehbdoAO7fyWdfLJG9s5ope
         +MVEBTYytCb/2+WkuUrqhHhSlNnaRwgr+avNoXYKcpy8EgjINhWDnqKHAfHIu3jhOl
         /oLX72rRoWHZGnFQe+aMypjnVZxmh7TaMYQ4VHSid1e6+6Qp7zXbPcFLs2Ge6ZRFfq
         W1F/RpYhiaYnjOrU97Yn61D3d7HnTlwwf51wtlhVgUxocmCEFVx8ByPkKyymy6bbXR
         j7hXsBSBUsxqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Replace of_device.h with explicit includes
Date:   Sat, 21 Oct 2023 08:58:34 -0700
Message-ID: <169790390708.1690547.16215620319051514906.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010205710.1585232-1-robh@kernel.org>
References: <20231010205710.1585232-1-robh@kernel.org>
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


On Tue, 10 Oct 2023 15:57:10 -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other and pull in various other headers. In
> preparation to fix this, adjust the includes for what is actually needed.
> 
> of_device.h isn't needed, but mod_devicetable.h and platform_device.h were
> implicitly included by it.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: Replace of_device.h with explicit includes
      commit: bff482ace43eebc5b4394cc9a7c7723f08413f80

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
