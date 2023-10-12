Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A417C6AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbjJLKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjJLKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:21:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE6A9;
        Thu, 12 Oct 2023 03:20:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B4C433C8;
        Thu, 12 Oct 2023 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106059;
        bh=sNpcN8h77VwDHzWVlSJo3LnZLn8IU5toGGZhEpgRMwk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WegMl5mIwP4FjchytD/Ycy5OOoKDZ+f+uVqYsNqsy/whaBLv00KSVsMHCeQeboRgx
         ZuOVaWlgjSOCqBIlhpFHpBVx+phbaW0qxyp79ysH5/vkjDCpVKRuPbKuvHNEdMeFJy
         n5UQT88CUN6snCZ4VVDAysXzllC0SZO9O3ZRmgAF52AafCyBk5zWCG+jGJKO5Pehoy
         NGgfcsfS1mTN4I0v44TTXf+j9okZ+L1/YwTFW8UpksDVSs1N4QMtu36v0MPtlGJ5V+
         gEXGWaRgx9oqJzCqShTPQdQx9kj7axwYFjwj2tTeiCTyNoTH+IxLYOQbBGM2kNQWs2
         Jvl1KuXYdc/9Q==
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
Message-Id: <169710605745.1174112.5043840678154728515.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 11:20:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

[1/5] mfd: qcom-spmi-pmic: fix reference leaks in revid helper
      commit: 365cf70ff33fe20e749227346d7245f7f0dccb58
[2/5] mfd: qcom-spmi-pmic: fix revid implementation
      commit: 7370f9de463b1d21dcdf9480a0a15babecd14ac7
[3/5] mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
      commit: b5cd5e72a71e9d368e20271d3a772dd045ae220e

--
Lee Jones [李琼斯]

