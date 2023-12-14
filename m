Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6F812FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572968AbjLNMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572975AbjLNMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:20:02 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30463118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702556407;
        bh=fgHNtNa0Y2jcE1vKuS2Ne5beDsOhCuFBl3Lg2aHl+4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xlbqoQR0RV0QPXK4WqMGjPknbIWw6aufiZvPShpga8C5KvXbB+c+PJzO/7U7h3wxY
         CW9ijg5onWXbhVi2q3MSK4w1oiHQt3B4rjfCsNkosmWOAs0eseC8MoFRPznMn/baxz
         e6943TCudUzRXH8Mf5na3Qh9THcxrvyqcJV0yGD3QLEEsJdKTRvJE6sra2LhSEAV2z
         aq0wbjtT9fJxDH8d4Ls7NRp9IanMpN7IBndP7S46i/XXYsyOQOVJ1eNtKgAZUSl36o
         NGCKkYcAMDbxs1UDWudpAwSbKpy18pyZL6cH7aAjiPHnOASpw+t5e2dQDyC8co2Xqn
         mXG7e7bN9zH0g==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id C0FFC37809D0;
        Thu, 14 Dec 2023 12:20:04 +0000 (UTC)
Message-ID: <e747581b-d5e0-4622-827b-48fb51fa9711@collabora.com>
Date:   Thu, 14 Dec 2023 09:20:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: uprev mesa version: fix kdl commit fetch
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vignesh Raman <vignesh.raman@collabora.com>
Cc:     daniels@collabora.com, emma@anholt.net,
        freedreno@lists.freedesktop.org, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, dri-devel@lists.freedesktop.org,
        quic_abhinavk@quicinc.com, david.heidelberg@collabora.com,
        linux-kernel@vger.kernel.org
References: <20231212160448.883358-1-vignesh.raman@collabora.com>
 <CAA8EJpro5Hb0yRaxPWzBQBikKjw9JnNVkUuPFvWeXjegzCuxHw@mail.gmail.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <CAA8EJpro5Hb0yRaxPWzBQBikKjw9JnNVkUuPFvWeXjegzCuxHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2023 05:00, Dmitry Baryshkov wrote:
> On Tue, 12 Dec 2023 at 18:04, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>>
>> build-kdl.sh was doing a `clone --depth 1` of the default branch,
>> then checking out a commit that might not be the latest of that
>> branch, resulting in container build error.
>>
>> https://gitlab.freedesktop.org/mesa/mesa/-/commit/5efa4d56 fixes
>> kdl commit fetch issue. Uprev mesa in drm-ci to fix this.
>>
>> This commit also updates the kernel tag and adds .never-post-merge-rules
>> due to the mesa uprev.
>>
>> Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> 
>> ---
>>   drivers/gpu/drm/ci/gitlab-ci.yml | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
