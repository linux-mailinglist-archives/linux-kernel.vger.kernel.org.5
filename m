Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E2766E75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjG1NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjG1NeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:34:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0D3C33
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:33:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so34735201fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690551136; x=1691155936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KdNumUIsNcnj2X0el2BiZUtK43QxcOgdu3ZvlTzlk4=;
        b=MfD6VmjrZ7O20jHnhdbLJuUgeNpLlUIsR7qBW5eo3kp4MJpEfKDqlActRdlzSHeq6h
         OaQQKXAevyiVIPSp50kxHMutjF9JddhoXhmQTbJID7F77YuV8xawEMw/VFy8Sls521OR
         kg4sbvwZWe6fBve4phg2qnHKmbEcblR6oQgzYgesSbl3e2DCsUaeUHzwK+VJUIcLSz3Y
         bvQD10B2gVB2mi24BLANeJD8zJBJsLC9XEDwkqEqRyP38xD8FkVsmdMEo9BYF+ZIenIv
         6xNuJ7MZaSFCgD6SdQx7GxzcW9JL9/0Q1QE9SMQm321iDIJPEWCSBPaiuOh/Z+HiXkVC
         ueqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551136; x=1691155936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KdNumUIsNcnj2X0el2BiZUtK43QxcOgdu3ZvlTzlk4=;
        b=A2NwU2Tsaubr8BBulpRliTq3x1bYkH48x8qFQQMwU8jAJc9DdrkoOi1TB26n7yGVII
         2LA/CTc2QP/ThrTehLn67N2RbQFlc3XE7WPIDxqgF+Ifi7K0aXQ4htQpzpnDm1Tq8oHN
         O4iNrk1Z++Us/M6VTztkEnh+1j7UakigfA8f9Tsqn+8RiR5KvhZtsRKgAxjtlzccDzsE
         tQX9TbGmKlObt/Od6teDbRl9bWKM348D9vHPfePFeiuVWpKDlICkg31RLQyWoNp9igrd
         ZVvvjhhGtW+4+ZTJduzRlaGTSXU72e20THTsQBgjPBeUtshf1QnPvEwoFhgU6Hz/MFg9
         izXw==
X-Gm-Message-State: ABy/qLZQrTRW+LJbLQAoNXgRsR3PzhOL7iXa6tDKkpqz6z52RjLLm8ue
        RN/wvXv8y+beK0QnlZDPHPOA1g==
X-Google-Smtp-Source: APBJJlFvD/h+AmH9WSQfnU2p760u3F9y9LmFXPO0Kp8/Ad8eIQN/JcgP5f+N33Rcsw0Juc3Ru2SzhQ==
X-Received: by 2002:a2e:b0ce:0:b0:2b6:ad79:a4fb with SMTP id g14-20020a2eb0ce000000b002b6ad79a4fbmr1829332ljl.1.1690551136132;
        Fri, 28 Jul 2023 06:32:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e9d51000000b002b8639fe729sm912377ljj.106.2023.07.28.06.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:32:15 -0700 (PDT)
Message-ID: <b491c17b-75b8-dda2-c70d-3fb8e4dafb73@linaro.org>
Date:   Fri, 28 Jul 2023 16:32:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
Content-Language: en-GB
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 16:23, Vikash Garodia wrote:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driver
> is based on new communication protocol between video hardware and application
> processor.
> 
> This driver comes with below capabilities:
> - V4L2 complaint video driver with M2M and STREAMING capability.
> - Supports H264, H265, VP9 decoders.
> - Supports H264, H265 encoders.
> 
> This driver comes with below features:
> - Centralized resource and memory management.
> - Centralized management of core and instance states.
> - Defines platform specific capabilities and features. As a results, it provides
>    a single point of control to enable/disable a given feature depending on
>    specific platform capabilities.
> - Handles hardware interdependent configurations. For a given configuration from
>    client, the driver checks for hardware dependent configuration/s and updates
>    the same.
> - Handles multiple complex video scenarios involving state transitions - DRC,
>    Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>    sequence.
> - Introduces a flexible way for driver to subscribe for any property with
>    hardware. Hardware would inform driver with those subscribed property with any
>    change in value.
> - Introduces performance (clock and bus) model based on new hardware
>    architecture.
> - Introduces multi thread safe design to handle communication between client and
>    hardware.
> - Adapts encoder quality improvements available in new hardware architecture.
> - Implements asynchronous communication with hardware to achieve better
>    experience in low latency usecases.
> - Supports multi stage hardware architecture for encode/decode.
> - Output and capture planes are controlled independently. Thereby providing a
>    way to reconfigure individual plane.
> - Hardware packetization layer supports synchronization between configuration
>    packet and data packet.
> - Introduces a flexibility to receive a hardware response for a given command
>    packet.
> - Native hardware support of LAST flag which is mandatory to align with port
>    reconfiguration and DRAIN sequence as per V4L guidelines.
> - Native hardware support for drain sequence.
> 
> I think that the driver is in good shape for mainline kernel, and I hope the
> review comments will help to improve it, so please do review, and make comments.

No bindings, no driver. Please post start the series from the bindings.

> 
> Dikshita Agarwal (17):
>    iris: vidc: add core functions
>    iris: add vidc wrapper file
>    iris: vidc: add vb2 ops
>    iris: vidc: add helpers for memory management
>    iris: vidc: add helper functions for resource management
>    iris: vidc: add helper functions for power management
>    iris: add helpers for media format
>    iris: vidc: add PIL functionality for video firmware
>    iris: platform: add platform files
>    iris: platform: sm8550: add capability file for sm8550
>    iris: variant: add helper functions for register handling
>    iris: variant: iris3: add iris3 specific ops
>    iris: variant: iris3: add helpers for buffer size calculations
>    iris: variant: iris3: add helper for bus and clock calculation
>    iris: variant: iris: implement the logic to compute bus bandwidth
>    iris: variant: iris3: implement logic to compute clock frequency
>    iris: enable building of iris video driver
> 
> Vikash Garodia (16):
>    MAINTAINERS: Add Qualcomm Iris video accelerator driver
>    iris: vidc: add v4l2 wrapper file
>    iris: vidc: define video core and instance context
>    iris: iris: add video encoder files
>    iris: vidc: add video decoder files
>    iris: vidc: add control files
>    iris: vidc: add helper functions
>    iris: vidc: add helpers for state management
>    iris: add vidc buffer files
>    iris: vidc: define various structures and enum
>    iris: vidc: hfi: add Host Firmware Interface (HFI)
>    iris: vidc: hfi: add Host Firmware Interface (HFI) response handling
>    iris: vidc: hfi: add helpers for handling shared queues
>    iris: vidc: hfi: Add packetization layer
>    iris: vidc: hfi: defines HFI properties and enums
>    iris: vidc: add debug files
> 
>   MAINTAINERS                                        |   10 +
>   drivers/media/platform/qcom/Kconfig                |    1 +
>   drivers/media/platform/qcom/Makefile               |    1 +
>   drivers/media/platform/qcom/iris/Kconfig           |   15 +
>   drivers/media/platform/qcom/iris/Makefile          |   46 +
>   .../iris/platform/common/inc/msm_vidc_platform.h   |  305 ++
>   .../iris/platform/common/src/msm_vidc_platform.c   | 2499 ++++++++++++
>   .../iris/platform/sm8550/inc/msm_vidc_sm8550.h     |   14 +
>   .../iris/platform/sm8550/src/msm_vidc_sm8550.c     | 1727 ++++++++
>   .../iris/variant/common/inc/msm_vidc_variant.h     |   22 +
>   .../iris/variant/common/src/msm_vidc_variant.c     |  163 +
>   .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481 +++++++
>   .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
>   .../qcom/iris/variant/iris3/inc/msm_vidc_iris3.h   |   15 +
>   .../iris/variant/iris3/inc/msm_vidc_power_iris3.h  |   17 +
>   .../iris/variant/iris3/inc/perf_static_model.h     |  229 ++
>   .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 +++
>   .../iris/variant/iris3/src/msm_vidc_bus_iris3.c    |  884 ++++
>   .../iris/variant/iris3/src/msm_vidc_clock_iris3.c  |  627 +++
>   .../qcom/iris/variant/iris3/src/msm_vidc_iris3.c   |  954 +++++
>   .../iris/variant/iris3/src/msm_vidc_power_iris3.c  |  345 ++
>   .../media/platform/qcom/iris/vidc/inc/firmware.h   |   18 +
>   .../platform/qcom/iris/vidc/inc/hfi_command.h      |  190 +
>   .../media/platform/qcom/iris/vidc/inc/hfi_packet.h |   52 +
>   .../platform/qcom/iris/vidc/inc/hfi_property.h     |  666 +++
>   .../platform/qcom/iris/vidc/inc/msm_media_info.h   |  599 +++
>   .../media/platform/qcom/iris/vidc/inc/msm_vdec.h   |   40 +
>   .../media/platform/qcom/iris/vidc/inc/msm_venc.h   |   34 +
>   .../media/platform/qcom/iris/vidc/inc/msm_vidc.h   |   60 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_buffer.h  |   32 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_control.h |   26 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_core.h    |  165 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_debug.h   |  186 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_driver.h  |  352 ++
>   .../platform/qcom/iris/vidc/inc/msm_vidc_inst.h    |  207 +
>   .../qcom/iris/vidc/inc/msm_vidc_internal.h         |  787 ++++
>   .../platform/qcom/iris/vidc/inc/msm_vidc_memory.h  |   83 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_power.h   |   94 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_state.h   |  102 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |   77 +
>   .../platform/qcom/iris/vidc/inc/msm_vidc_vb2.h     |   39 +
>   .../media/platform/qcom/iris/vidc/inc/resources.h  |  259 ++
>   .../media/platform/qcom/iris/vidc/inc/venus_hfi.h  |   66 +
>   .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |   89 +
>   .../qcom/iris/vidc/inc/venus_hfi_response.h        |   26 +
>   .../media/platform/qcom/iris/vidc/src/firmware.c   |  294 ++
>   .../media/platform/qcom/iris/vidc/src/hfi_packet.c |  657 +++
>   .../media/platform/qcom/iris/vidc/src/msm_vdec.c   | 2091 ++++++++++
>   .../media/platform/qcom/iris/vidc/src/msm_venc.c   | 1484 +++++++
>   .../media/platform/qcom/iris/vidc/src/msm_vidc.c   |  841 ++++
>   .../platform/qcom/iris/vidc/src/msm_vidc_buffer.c  |  290 ++
>   .../platform/qcom/iris/vidc/src/msm_vidc_control.c |  824 ++++
>   .../platform/qcom/iris/vidc/src/msm_vidc_debug.c   |  581 +++
>   .../platform/qcom/iris/vidc/src/msm_vidc_driver.c  | 4276 ++++++++++++++++++++
>   .../platform/qcom/iris/vidc/src/msm_vidc_memory.c  |  448 ++
>   .../platform/qcom/iris/vidc/src/msm_vidc_power.c   |  560 +++
>   .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   |  660 +++
>   .../platform/qcom/iris/vidc/src/msm_vidc_state.c   | 1607 ++++++++
>   .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    |  953 +++++
>   .../platform/qcom/iris/vidc/src/msm_vidc_vb2.c     |  605 +++
>   .../media/platform/qcom/iris/vidc/src/resources.c  | 1321 ++++++
>   .../media/platform/qcom/iris/vidc/src/venus_hfi.c  | 1503 +++++++
>   .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  |  537 +++
>   .../qcom/iris/vidc/src/venus_hfi_response.c        | 1607 ++++++++
>   64 files changed, 35357 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/iris/Kconfig
>   create mode 100644 drivers/media/platform/qcom/iris/Makefile
>   create mode 100644 drivers/media/platform/qcom/iris/platform/common/inc/msm_vidc_platform.h
>   create mode 100644 drivers/media/platform/qcom/iris/platform/common/src/msm_vidc_platform.c
>   create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/inc/msm_vidc_sm8550.h
>   create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/src/msm_vidc_sm8550.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_buffer_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_power_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_buffer_iris3.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_iris3.c
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_power_iris3.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/firmware.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_property.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vdec.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_venc.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_control.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_driver.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_internal.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_state.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb2.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/resources.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_response.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/firmware.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vdec.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_venc.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_control.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_driver.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_state.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb2.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/resources.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_response.c
> 

-- 
With best wishes
Dmitry

