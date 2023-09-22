Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00D7AB30D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjIVNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjIVNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:49:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DA692;
        Fri, 22 Sep 2023 06:48:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A4CC433C7;
        Fri, 22 Sep 2023 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695390538;
        bh=vRCbkEXIvOVzJ7swhkJO0btDmEHy+5q5YjVm6regUx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Chs2Lf7os26nn4NItjpwhFYawkL+UhOpp2+HnwwXOYtEGMTyG8+By+eyiD8SUiVKK
         nUqB6xZABCUqxtKLJvXSCJs4lfwAmPoRwlT806VKHu+wwp7UnPZfL2qyFAX5lWP4zS
         unUmQtXqltjUjdFZTKmd6DQeIVEwmjhnmld7Fl3nDN/ueGnAx5EdejxSDCCVGg92cl
         G08f0w6W2FRvGjGDZQ1DRXyaOnONfHVNmWEMxN9XHvh+yaLkH+TdtVgucaJ4/G4DTf
         F4ZYyYGDUmWMqYFzc/0+4owxGRybwII5oKU75jL1kYacRWBA5LAGYFD/fMLoVobh/k
         AGOUTnN0jGDqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raman <vignesh.raman@collabora.com>
Cc:     guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        daniels@collabora.com, emma@anholt.net, robdclark@gmail.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        David Heidelberg <david.heidelberg@collabora.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add overlay for usb host mode
Date:   Fri, 22 Sep 2023 06:53:02 -0700
Message-ID: <169539077994.4014786.12440074307606036817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911161518.650726-1-vignesh.raman@collabora.com>
References: <20230911161518.650726-1-vignesh.raman@collabora.com>
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


On Mon, 11 Sep 2023 21:45:18 +0530, Vignesh Raman wrote:
> Due to the presence of the fastboot micro cable in the CI farm,
> it causes the hardware to remain in gadget mode instead of host mode.
> So it doesn't find the network, which results in failure to mount root
> fs via NFS.
> 
> Add an overlay dtso file that sets the dr_mode to host, allowing the
> USB controllers to work in host mode. With commit 15d16d6dadf6
> ("kbuild: Add generic rule to apply fdtoverlay"), overlay target can
> be used to simplify the build of DTB overlays. It uses fdtoverlay to
> merge base device tree with the overlay dtso. apq8016-sbc-usb-host.dtb
> file can be used by drm-ci, mesa-ci.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: apq8016-sbc: Add overlay for usb host mode
      commit: bdc4d17e1627e3b44f25b8f87509023dc2b438a2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
