Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3827D6B14
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjJYMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjJYMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F07184;
        Wed, 25 Oct 2023 05:17:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0B6C433C7;
        Wed, 25 Oct 2023 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236227;
        bh=eomEepdMdt0TCy17x4G8Gl1XMsjx8AJpR54YD2G0zP8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mzeLCCD5RWgGr3w4wP5Gn40L/gBRUVKXFJRg7/aocUDZwaw7vWae/accwsX3bHv4E
         p75DFAM1IifwwnLYWUwTefXFmVR4Mp97Gcrn+TxuthcOqfbgDzJzUb90m+HQmKWjyj
         31XE597tGZ7g01PfpQjNywm9LehJOL1qt/NPW3bNuFbmzCmjTJyiirCZ77jkxeDiZo
         gFonFqdxZ69Mgj8O0Bk5wDlil5Sj3PUi8xBylVQshHEu8duFgn4a8b+laQHEUp8O4I
         +rtLFofc16W0j7PnX9TrOsfpaXklI6yMD2+Ddh6zLrH3IRAoIKiHO2nImAT2c1KFBU
         GYDN9619n1Mhw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid
 implementation
Message-Id: <169823622555.724579.17090745891924053957.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 13:17:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:
> The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> that can lead to resource leaks and crashes. This series reworks the
> implementation so that can be used safely.
> 
> Included is also a rename of the SPMI device lookup helper which can
> hopefully help prevent similar leaks from being reintroduced.
> 
> [...]

Applied, thanks!

[4/5] spmi: document spmi_device_from_of() refcounting
      commit: 7db72c01ae2359dbab29f4a60cda49757cf84516
[5/5] spmi: rename spmi device lookup helper
      (no commit info)

--
Lee Jones [李琼斯]

