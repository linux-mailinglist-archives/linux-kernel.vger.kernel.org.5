Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB68E7E0F8B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjKDNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjKDNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:02:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8267D47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:02:54 -0700 (PDT)
Received: from [100.116.205.35] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60DC1660741E;
        Sat,  4 Nov 2023 13:02:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699102972;
        bh=EkRtCSIzLcp5vJ0IcXlrtE4gq3E3Lqmd9C7ZVWJrkPU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G8yvOPlYueM6CsDNgiekG7kfg/N8aaS4t4I3c0V8K1ku04ja035NR93jkM58kXxl2
         4ZFLXouL/QT3z4izg8kHUVchjXilsrfCq+Dd7JJCQ0OJHw0N3BzBGmbkBYogASr90S
         roNLIY/5BsEozs2hGIrf5ZZIuNUw62YmBZIGZ0k3/Qh/geZ5e0W6pU+qgRV2JViTBY
         4mAJEvIHBMSiBktkck7N5xgZMaj/ZP/ffEtuotqGR1Ku6cCLWistj00h/hmetvZIPY
         hQodXwzB2Oa5gYAmoppso21xxClN3h4eY43+lUWOWM/4vjv7V2zg3bcVXOhtvyiyEA
         wRfKRbCtDZ9/w==
Message-ID: <0b0b1065-06e8-44ea-a4a1-395980afac5a@collabora.com>
Date:   Sat, 4 Nov 2023 10:02:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/ci: Add support for SM8250 Gitlab Runner
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20231010-rb5-runner-v1-0-aba1fcc6e3aa@quicinc.com>
Content-Language: en-US
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231010-rb5-runner-v1-0-aba1fcc6e3aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On 10/10/2023 19:25, Jessica Zhang wrote:
> Recently, we've registered a Gitlab runner for a Qualcomm RB5 device that will be
> hosted and maintained in Qualcomm labs.
> 
> This series will add a corresponding CI job for testing SM8250 devices and add the
> skip/fails/flakes list. We were able to complete a successful run [1] with these
> changes.
> 
> For now, we will keep the job as manual trigger only and drop that rule later
> after we stabilize the tests.
> 
> [1] https://gitlab.freedesktop.org/drm/msm/-/jobs/50092719
> 
> ---

Thank you for you patchset.

I'm getting the following error:

"serial.serialutil.SerialException: [Errno 2] could not open port 
/dev/ttyUSB0: [Errno 2] No such file or directory: '/dev/ttyUSB0'"

https://gitlab.freedesktop.org/helen.fornazier/linux/-/jobs/51193215#L146

I'm wondering if I'm missing some configuration.

I tested on top of drm-misc-next.

Also, I'd like to add in the docs an entry about the devices we have, 
which tag they need, which dts they correspond to, which farm they are 
located, who to contact if there is any problem and maybe some comment 
about the device (how it is hooked up, the logs comes from uart or ssh, 
does it use fastboot, etc) if you find it useful.
Would you mind adding an entry in the docs with this information for the 
sm8250? (Than I'll add the info of the other devices after yours).


> Jessica Zhang (3):
>        drm/ci: Add SM8250 job to CI

I would also move this patch to last, so we don't have a commit where 
things shouldn't work properly.
Or maybe squash them all.

Regards,
Helen

>        drm/ci: enable CONFIG_INTERCONNECT_QCOM_SM8250 for arm64 config
>        drm/ci: Add skips, fails and flakes for SM8250
> 
>   drivers/gpu/drm/ci/arm64.config                 |  1 +
>   drivers/gpu/drm/ci/build.sh                     |  1 +
>   drivers/gpu/drm/ci/test.yml                     | 15 +++++++++++++
>   drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt  | 29 +++++++++++++++++++++++++
>   drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt |  3 +++
>   drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt  |  8 +++++++
>   6 files changed, 57 insertions(+)
> ---
> base-commit: dcd88f8c63341ed11a8c5019408f62202cd9d1f2
> change-id: 20230919-rb5-runner-77ec32bd61e7
> 
> Best regards,
