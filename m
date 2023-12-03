Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A7802107
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjLCEyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjLCExm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08E269A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBDAC433CC;
        Sun,  3 Dec 2023 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579128;
        bh=/JIJeJzuxeJJ1m3C+LL4Awa3Szm2BbtZgt962q8P8W8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oabxSzuTpg7EPUTh4mYPRrzf8f803JrCuDC6Fd+TM7osPWEXIyPwBgc/lT8nr5cVK
         tOzgljsD1U8YwqD2xXQCq85ONuca72sefG5P3b9QG4IXtgDUZ1VdKVEkY5x08FqIFv
         ZyEdi4EW7cudTKzIgwT/LZzVLCAM1gI3z2vPe2mEaWNfNKeINbr8FnLcsg1qPDOT/E
         nOq0Bwc+aMLP6Mfj+RZju5YDDfrnorFxv6bmn78jmRVa71CW9HRS4n25kw2jzkiEpE
         yPeUvocZTIhBIwLrdsZzLGrv2yi+3BAPLHkoYAMV3dSGY0GHk9C3kbRggqL1pEmhQ6
         Ieq7+4QDWa5Mg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
Date:   Sat,  2 Dec 2023 20:54:54 -0800
Message-ID: <170157925830.1717511.5547305071355382777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021120048.231239-1-robimarko@gmail.com>
References: <20231021120048.231239-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Oct 2023 14:00:07 +0200, Robert Marko wrote:
> IPQ6018 comes in multiple SKU-s and some of them dont support all of the
> OPP-s that are current set, so lets utilize CPUFreq NVMEM to allow only
> supported OPP-s based on the SoC dynamically.
> 
> As an example, IPQ6018 is generaly rated at 1.8GHz but some silicon only
> goes up to 1.5GHz and is marked as such via an eFuse.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
      commit: 83afcf14edb9217e58837eb119da96d734a4b3b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
