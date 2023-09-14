Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0657A0E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjINTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjINTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:32:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F826AB;
        Thu, 14 Sep 2023 12:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6B7C433C9;
        Thu, 14 Sep 2023 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694719960;
        bh=Zj/zEGz3WbI5U0fBXmG0sEklTCa6mHF3Wpg6Q0q2m0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoK9BrWWUZMBR58x0HXOK5bx+LE1KbQ0mtw4oS96D60qs8/O8nAxnQyJ6wKHOOvvs
         guW2uVdOjnrX+wY2gwT9X3+jEmPOspSsZjZ/QlzEDq2fQk8iIIG8FoMYNpWkIAW31l
         BXy1CvLsf1EZkG9TDO4LVoBdcfKWdIv6RjQDGvUntBsU8w5nJtEg1EkZLflpHI6JJM
         4JlJBiwviStKmAD5DOUkBbEdkekbJqw6bPEKdYQjkNi9UtjpzpYM/o2DDIHd7ur2ls
         TON6ynk6yzhhX7vhV8rnqG1Wm3YftbBBS8UDA8nRlgHaln7zEAy/b9anyuQSgnwSe7
         Pb6jiS6RiIFzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges
Date:   Thu, 14 Sep 2023 12:36:41 -0700
Message-ID: <169472019837.1902897.16813387384652908882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
References: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2023 15:55:38 +0200, Krzysztof Kozlowski wrote:
> There are several PMICs with GPIO nodes and one of the nodes referenced
> other's in gpio-ranges which could result in deferred-probes like:
> 
>   qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: can't add gpio chip
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges
      commit: f822899c28572a854f2c746da5ed707d752458ab

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
