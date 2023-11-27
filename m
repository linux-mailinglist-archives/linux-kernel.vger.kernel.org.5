Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A034B7FA26B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjK0OT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjK0OSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105803C10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359FDC433C9;
        Mon, 27 Nov 2023 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701094588;
        bh=hLHjKJzz8IdTK+ucHC/mbOa5ERIt+OH27L69qBoQ2xk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zd0+u8SNJtgR+IDLZNKBjj8S5xHR+n/l92lz/sdgcAgyPBHN3gYUhpJvDL5syOXe9
         /1kdSNfj3KZQjzOzyVFXFScgPgMMYnhNac6QT+vHr4FK5lvepEXOo0EhXZvfUlJT0r
         CYIlyorzvdpZsmRlnyjZnCBXXuopc1R9YG/yhFiTXpkEXa6UPH3imZqFpmU4CXyiZo
         BRyUyywllkDN+C/4r5sil2gSKXp5yg3ZkzylY24/gX2FvdyyvFOMzyrZ3g6E7Necg2
         +jNRq53AMyRDLQb0FxU/nvcVq1qUtZ57AQOqZhWoLn0XcvPSjNEXTh8kvWOUcywJwf
         Shk6Nw48jv4Qg==
Message-ID: <1356b1fc-fcdb-42af-a8df-0f7c2e2be9f3@kernel.org>
Date:   Mon, 27 Nov 2023 16:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] interconnect: qcom: Introduce interconnect drivers
 for X1E80100
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20231123135028.29433-1-quic_sibis@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231123135028.29433-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 15:50, Sibi Sankar wrote:
> This series adds interconnect support for the Qualcomm X1E80100 platform,
> aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> V3:
> * Fix the index numbers of pcie_center_anoc nodes. [Georgi]

Thanks for updating the patches, Sibi! Now LGTM.

Hi Bjorn,

Here is a stable branch with the DT header in case you need it:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-x1e80100

Thanks,
Georgi

> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Fixup required property ordering [Krzysztof]
> * Pickup Rbs.
> 
> Dependencies: None
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 
> 
> Rajendra Nayak (2):
>    dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
>    interconnect: qcom: Add X1E80100 interconnect provider driver
> 
>   .../interconnect/qcom,x1e80100-rpmh.yaml      |   83 +
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/x1e80100.c          | 2328 +++++++++++++++++
>   drivers/interconnect/qcom/x1e80100.h          |  192 ++
>   .../interconnect/qcom,x1e80100-rpmh.h         |  207 ++
>   6 files changed, 2821 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
>   create mode 100644 drivers/interconnect/qcom/x1e80100.c
>   create mode 100644 drivers/interconnect/qcom/x1e80100.h
>   create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
> 

