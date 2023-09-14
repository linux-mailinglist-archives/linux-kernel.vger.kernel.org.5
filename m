Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C777A0E60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjINTcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbjINTcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:32:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E5326AB;
        Thu, 14 Sep 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9ABC433C7;
        Thu, 14 Sep 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694719958;
        bh=fKyYS2g33geFkbUD2j4K3fVgYEq20z/18T1pFUnsuP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pxnentepc2SbybFP7Hkgd2xQwe7Qacd6E6aJgOfmOwEeb/qctw6zrPzQacJFqG3sc
         ku89qhMijGWki0kIwERCgIInqr1Vdu1d3qvLOJC6TVRigI98zfhhuFj34z8jglKgK4
         /72xPv6BapxAteLUPAQuaYuSF/uBdnOh+ZVJ3CYuuqCoTjH+6orX2b2mX2RhLP2ee0
         IXmdkmdJEYz6lf3dyOJiDqtfHilaFRLPdsh4fOVnS9aQ3iNLvsuBjS8g5MufoY5q/3
         D6BzbZcmWt5rNL+gPE7Aafwv5z039Cgj+eBpMAQFYUs9/upE48ump4rCPXvjiGbTUT
         MYpdzsYzuAfFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 00/11] arm64: qcom: add and enable SHM Bridge support
Date:   Thu, 14 Sep 2023 12:36:39 -0700
Message-ID: <169472019836.1902897.1391606385902193970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2023 21:24:56 +0200, Bartosz Golaszewski wrote:
> SHM Bridge is a mechanism allowing to map limited areas of kernel's
> virtual memory to physical addresses and share those with the
> trustzone in order to not expose the entire RAM for SMC calls.
> 
> This series adds support for Qualcomm SHM Bridge in form of a platform
> driver and library functions available to users. It enables SHM Bridge
> support for three platforms and contains a bunch of cleanups for
> qcom-scm.
> 
> [...]

Applied, thanks!

[01/11] firmware: qcom-scm: drop unneeded 'extern' specifiers
        commit: 2758ac3a11d78af56e6969af04dec611806a62de
[02/11] firmware: qcom-scm: order includes alphabetically
        commit: bc7fbb5ea701b22c09c0fa5acbc122207283366a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
