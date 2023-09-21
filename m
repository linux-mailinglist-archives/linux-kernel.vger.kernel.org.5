Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA727A9921
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjIUSLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjIUSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB386134;
        Thu, 21 Sep 2023 10:37:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A633C4E75D;
        Thu, 21 Sep 2023 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306382;
        bh=eSl17G8eK2kQbH10tdoLpn2Y/BOUkqeqUns+HxQ6GpM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DKW5xKYtji0EPafr/mZ3hXEll86eV1FA+bCuhb2A7wt27LFiKmy5+7p8j0AX3tanl
         40kkrPzZVcWEGVymYNoP25R943bXRwMHV5noT/c4yJbmZiSXqVVl2CMjSLlwxpbWaB
         4kwgP/70sqLCXX8x632uZ1cw/Dt8Q+1OUcMq5BZ1/uHUXzvQawjooCnFN42W2EMtE9
         dlBMxw/5NLAMF93wxXCm/rBfdSssuGmmZuSJXU2cWxGJXTmn2xMZTKYfNkxEjeyXoH
         A+WVAVj2uNp9EwWGqaNdF6aTi8lodLVij2dBfmeZZPKbc7q/KzB6U5FAQevwHy72lS
         KThkk2RF/6J0A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>
In-Reply-To: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
References: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
Subject: Re: [PATCH v3 0/2] 8550 USB QMPPHY fixups
Message-Id: <169530637891.106093.4643424421266973935.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:26:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 22:07:13 +0200, Konrad Dybcio wrote:
> Inspired by [1] I went over the 8550 QMPPHY init sequences and found
> some inconsistencies. This series attempts to fix them.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230828152353.16529-1-athierry@redhat.com/
> 
> 

Applied, thanks!

[1/2] phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      commit: 112c23705c6dc59a05290c8e3e597e1b4e9c23fc
[2/2] phy: qcom-qmp-combo: initialize PCS_USB registers
      commit: 76d20290d0c66a84a7a40c6231e73d1ab25994e5

Best regards,
-- 
~Vinod


