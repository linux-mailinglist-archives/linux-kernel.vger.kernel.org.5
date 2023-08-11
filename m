Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B47792C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjHKPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjHKPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2766030F3;
        Fri, 11 Aug 2023 08:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9896744C;
        Fri, 11 Aug 2023 15:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C5C433C8;
        Fri, 11 Aug 2023 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767075;
        bh=gOsUT1D5lnLLx3YHPKZqVTrCZZ4+7bFlcFZkl/kjykc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGAFI9ZBNvqX70Z8RGmqSZFnX61GuNBj0335PXKQ/a6jAHLa9xDAmYfWzwurS3nuA
         uW/0uIiFVnfdKLLxubm6kR192KwYmn15+cdZTMCzgQpfxIXIEiICVn817gKKroaBYW
         Z4xrEKvm4LXee+6V6RKrmhPL5RMC5xYC1Is1FwXqJgRZ4w7mCwbiAtyW+oP+P9Mjq7
         T7JT8S36MKavkpg7isEkHqUEmuOi4R+6F/VmjES6EHbAtM10Zs9rtqtJs1HJXka3fO
         CLtKG+dx7wZLpdELOzHq+dQNFpHcxRMcty4fvMyzE6w9zPThrW/xTkq0/NvzBW3GkD
         WouAfaTTGW5dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>
Cc:     luka.perkov@sartura.hr
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
Date:   Fri, 11 Aug 2023 08:20:42 -0700
Message-ID: <169176724024.691796.7369934702328451965.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810132904.367418-1-robert.marko@sartura.hr>
References: <20230810132904.367418-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 15:28:21 +0200, Robert Marko wrote:
> Using GCC_DCD_XO_CLK as the XO clock for SDHCI controller is not correct,
> it seems that I somehow made a mistake of passing it instead of the fixed
> XO clock.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
      commit: 43a0ce827528bdc7f4d38d48d13987db24a4e7b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
