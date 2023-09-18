Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A57A552D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjIRVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIRVlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:41:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5590;
        Mon, 18 Sep 2023 14:41:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C7DC433C9;
        Mon, 18 Sep 2023 21:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695073300;
        bh=V73nY87sAUP0s1VV3p5Xs8gRGMRBWjjwisJY9Axkhtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+V2W2V2R7xh2q8vD7s/3b9X+EeWgzacET/c0gn2eDnB9H9VwmZUW/9oR6dKBo3fX
         qRXTs8+Q9yyRp6v31I4A978mX50y7kfd6rPqB6krd7XGZtFgmS6ccOdmotPQP9CGdN
         +VpvRxMEGNgqf1i8V760VaLT/N3IC4Fahog9IjdaXKvNnekUgR2nP51z91ADzBiSFH
         n+0VARy7IR7da8XAMNNTazbGztC//eCUOHRaX+Ut7BRw9QmGEBmh8SJqrIBwI01Gv6
         V65i+Yiek7G07x4GJ0qCid11ybVvLZc4BPhoU3wiJbxIUfhWHeXSucQyOUL/sYNPTB
         QC1r+aujqRblA==
Date:   Mon, 18 Sep 2023 17:41:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZQjEEt7sB2M5EO53@sashalap>
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:33:02AM +0200, Johan Hovold wrote:
>On Fri, Sep 08, 2023 at 03:28:41PM -0400, Sasha Levin wrote:
>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> [ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]
>>
>> Disappointigly, the camera activity LED is implemented in software.
>> Hook it up as a gpio-led and (until we have camera *and* a "camera on"
>> LED trigger) configure it as a panic indicator.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is a new feature if anything, not a fix. Please drop from all
>autosel queues.

Not a feature, but hardware enablement.

-- 
Thanks,
Sasha
