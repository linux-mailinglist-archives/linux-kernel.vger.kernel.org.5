Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8108F80998E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573034AbjLHCxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573027AbjLHCxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC1171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6A4C433C7;
        Fri,  8 Dec 2023 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004000;
        bh=Pp3+6l4mBzoCUSYvQZ0ii0PbuLNVjGmd2GgZNiGsdUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWaLJ1je6yb1zZLV+16Ws78DspYsmLPOcGmUX5pEW5sIMU7rIim7nDEPUT5EdxZxY
         G/1bDiL0MVWUc7EjHriBvCRyPbnVz7g2ZbQlaurHtmypXgX++eCxMxKXGzWMoBCtPP
         uZ0bthQ/MuLVQvisl8eAFJWCrrJzl7QS7vymnk7Cvw12TtCYvX9RK1UWKhD1+WpZnD
         638wyefQ1ee52eN1pIm4hlXLG7kf2rrqKNM8u8Ei4VCo+/i1qd0EQzvEnUr1x6y5BW
         BuXEyTkap+TQDdm2EeoKw5hlTYgOnybGvMAG043C0zGiqxAjx8vj9keIizASVZdK9J
         3nufbiGkXsY0Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/1] Switch on USB as a wakeup source on sm8250
Date:   Thu,  7 Dec 2023 18:57:25 -0800
Message-ID: <170200426917.2871025.13154424795224581973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109004311.2449566-1-bryan.odonoghue@linaro.org>
References: <20231109004311.2449566-1-bryan.odonoghue@linaro.org>
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


On Thu, 09 Nov 2023 00:43:10 +0000, Bryan O'Donoghue wrote:
> Add in wakeup-source to both USB controllers on sm8250.
> 
> I tested that the rb5 gets into and stays in s2idle, subsequently resuming
> when a key is pressed on an attached USB keyboard for both Type-A USB 3
> ports and via the TCPM controlled Type-C port.
> 
> Bryan O'Donoghue (1):
>   arm64: dts: qcom: sm8250: Add wakeup-source to usb_1 and usb_2
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Add wakeup-source to usb_1 and usb_2
      commit: 48307d83c998db18db6890dccb569146eb12d313

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
