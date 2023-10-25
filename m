Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA42D7D6AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJYMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJYMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD4B0;
        Wed, 25 Oct 2023 05:13:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D37C433C8;
        Wed, 25 Oct 2023 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698235982;
        bh=4+xwe367k3YeGIMrExzUgwgVoVE6QX1MvS5Q6KetWyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emXY/bJnZ6TI8CxNbrMekyo38I5pF6dXpoLNZxXDhO21G9HLiHXpB8Kql49N6+aDZ
         nHsPyJkrXdoZNYfiOoMkPipCiO++hdtS5yfcbQKrcFdlEiNDMZHtNzs/UyS7n/yWHQ
         Pxy/OVIGSSPfFxZO0vGjr/3MV/Z9jKYo6fHFG4Oag1nqS4xW4ylaMr6nfbD1lZCi5q
         SJqS6zGjboPBgEFuIzBzTokukJn8HePbfKgBVFm8LkbFloKzNWZhmd6C0uuAK0X607
         9uaKapWvKiAyNk6/my4ZtbAmoDj9yuAumCAks15RpaYiiL2DR0b7Ul6WhttlnqYtTc
         D/WDMWLfVgUnA==
Date:   Wed, 25 Oct 2023 13:12:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <20231025121255.GM8909@google.com>
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
 <20231020182218.22217-4-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020182218.22217-4-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Anjelique Melendez wrote:

> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig          |   9 ++
>  drivers/soc/qcom/Makefile         |   1 +
>  drivers/soc/qcom/qcom-pbs.c       | 243 ++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/qcom-pbs.h |  30 ++++
>  4 files changed, 283 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h

The LED patches look good to go.

What's the plan for the SoC driver?

  * Who will review it?
  * Shall I take it via LED with an Ack?

-- 
Lee Jones [李琼斯]
