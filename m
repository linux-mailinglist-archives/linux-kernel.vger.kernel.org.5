Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890167A6F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjISXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjISXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAFFF7;
        Tue, 19 Sep 2023 16:03:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF8FC433CA;
        Tue, 19 Sep 2023 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164627;
        bh=ZJ5bSMT5jCsxu8M3Q1hZGO35QQ7j76m8759+yAGYr4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVkWN61UMSFd4IHqxg5pFn6ry7UYJPAu3BO+PewAbAbE60nkg6yjSoxiavak0G7b9
         cqnVq01SJl/nBr5x0O/xIyWj/uUWNZG4/LOy3IAHdjK8YUFyN38wHOAetCAGWVLVKV
         DozNPZzekPwBcMYTN62e0LOxycOZdHYp1C7JpmJUlVv9pggcrTsjAbJLjzKbnFT/1e
         6cZ6yiGnLZXl5uB/QEtZ77xrBJaCNetx/jUzOAlUHX340R+sFQam+huBIp+riGtRhl
         UbNZ56vdg2OzFbr95LVwpx1sF0ieKliRtoisJBJ/UJNNW13RrlQjJT+sv1yk2GGUbh
         +GbeyVlZ6mggQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-hdk: add other analogue microphones
Date:   Tue, 19 Sep 2023 16:07:36 -0700
Message-ID: <169516485982.787935.5219372367347199671.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
References: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jul 2023 16:38:24 +0200, Krzysztof Kozlowski wrote:
> Add proper audio routes for onboard analogue microphones: AMIC[1345].
> Use also new DAPM input widget (TX SWR_INPUTn) for them, not the
> deprecated ADC one.  Change is not compatible with older kernels not
> having the new SWR_INPUTn input widget.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450-hdk: add other analogue microphones
      commit: f20cf2bc3f770a4f8ce098effbcae5ef5a0912a7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
