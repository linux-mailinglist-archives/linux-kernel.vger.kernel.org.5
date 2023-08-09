Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234EB7769F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjHIUY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjHIUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1330CB;
        Wed,  9 Aug 2023 13:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93144648B5;
        Wed,  9 Aug 2023 20:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3516FC433C8;
        Wed,  9 Aug 2023 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691612662;
        bh=NGfJldleMPQEOD4dY+Bw5JE/lgdc+Wjkye2qJO4ZPTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UKX1YaSFJbmO/yNZBY1fDuqAuCkxzB5YW36C3146+CCP76d9Pja3XHoSZSz5YcN6K
         Ll+RFOA0/BNTPN29Q+65/n7nYqMS6O3tqQ2+r95loV4+wHC20DJMNl7rIy3x2kHiK3
         3UUb5zflslfOLh28sMLOPtMV7lNOI4MyKKOCpJsQvdr5veD9t+I2q0NBMM/lB3728B
         DPIMGa3mozWa6lgg01NXOXaRLKb4FaVOgwWsAMeWeioQ0eBFas5OsTytJuZrOLbDFI
         HM+i9wBg+mw5rrR7hhqfaPVBLWkQCHRlXr3UxvjHepaWgyKXIeNyFm5qvbAJnYrZzh
         RmQdIT5zvRn8g==
Message-ID: <320b1867-dc12-5405-c143-8b71a8172df5@kernel.org>
Date:   Wed, 9 Aug 2023 23:24:16 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] interconnect: qcom: rpmh: sm8550: mask to send as
 vote
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
 <085b3f9f-9e70-4f62-9dbd-4a1ddf1a0c19@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <085b3f9f-9e70-4f62-9dbd-4a1ddf1a0c19@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.08.23 22:23, Konrad Dybcio wrote:
> On 23.06.2023 14:50, neil.armstrong@linaro.org wrote:
>> On the SM8550 SoC, some nodes requires a specific bit mark
>> instead of a bandwidth when voting.
>>
>> Add an enable_mask variable to be used instead of bandwidth.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Georgi,
> 
> please pick this up and I'll fix up the ACV situation mentioned
> by Bjorn as an incremental change.
> 
> Konrad

Thanks Konrad! I had sent it to Greg last week, so it will get into
Torvalds tree most likely this week.

BR,
Georgi

