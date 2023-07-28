Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038F767394
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjG1Riy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjG1Riw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:38:52 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB72115
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:38:49 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4865e927e1cso937788e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690565929; x=1691170729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LG1Gfa6H4Ju8YagGXvMG/aVOk0YtK6rDCYKqWpWbiE=;
        b=byHoNPutoYrLIE98/Q3LSSYIt9/9EjLC5OAgk9XOPIRcN6iujxIlnjZXWW53mSoQY0
         SL686qPSocY0IBwdRIS8X63n97zeDfPgokxzDrN/x/kbxhw+ANEK1nc+Ao1L53eTyjRy
         xtpe77UgBorNiVKu1oYesMYBBIs/46z8GThFLkKAO06HfoHrn0GfkxaT99cNaF+l14b3
         ww576gEvhLbeh664WgiJRC8WulcvslOZXxfHhORNDrX/OOwU5hZwdVhg4Y2drusDCRfk
         98o8Avn2Rd4H4mISmmOisKSwBWSMtgsshZaFBfhNJmL/Guum9IljwUBukqaLuOOPbvhE
         3G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565929; x=1691170729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LG1Gfa6H4Ju8YagGXvMG/aVOk0YtK6rDCYKqWpWbiE=;
        b=FUs/GRkUrCMzKxt9HFmhjf4KBMYJkhUPo7hZcnBqhelJNX8NNzZM6MAxOdV7lsLi9i
         WctSQo6jaR7bTs4u5wsdQ9oLN2jgbnroEpufm3QSdjWYIRcX3WlEQs+GXN2wcUkEmJMd
         lWoh6me3PVic6JzzISv+3hRxu3Bg0mifLQBYbzv/+Fnaygeyup5i5QE795GHGtU9zHBh
         /YONSqA4RCajJ3JDfMn2vIkgVyoIAcM9No77xk1QYf71hWL9rF71v7GgXZLN5FDQNdXt
         1fZEwXlLALHwMfQlfrgdXvWuPQ25Etjw/LZyPn8q2UpML43vhkrox5PEVaI0I+wJ/LHs
         L4JQ==
X-Gm-Message-State: ABy/qLbgCaqHjikoNNPk5izsbfts3ZQp2jzgYduA7OlrR4ao6t/A1ltR
        7RwnJi7P1j5KrFF6/jETtKnoLg==
X-Google-Smtp-Source: APBJJlH5ctUuDgs8bBodgyrdtkcY7Y/ga1FcX7g9VRb970/oJ2fH+Ctb97ojNqd+g8Fmk7TeL9WOGA==
X-Received: by 2002:a1f:6087:0:b0:481:2dec:c2e with SMTP id u129-20020a1f6087000000b004812dec0c2emr2653485vkb.12.1690565928988;
        Fri, 28 Jul 2023 10:38:48 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:2688::7a9])
        by smtp.gmail.com with ESMTPSA id u19-20020a0cf1d3000000b00631f40503cbsm1397792qvl.12.2023.07.28.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:38:48 -0700 (PDT)
Message-ID: <873cd232e4bfb3e7a15aa356cc20e2dea554afa6.camel@ndufresne.ca>
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
Date:   Fri, 28 Jul 2023 13:38:47 -0400
In-Reply-To: <b491c17b-75b8-dda2-c70d-3fb8e4dafb73@linaro.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
         <b491c17b-75b8-dda2-c70d-3fb8e4dafb73@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Le vendredi 28 juillet 2023 =C3=A0 16:32 +0300, Dmitry Baryshkov a =C3=A9cr=
it=C2=A0:
> On 28/07/2023 16:23, Vikash Garodia wrote:
> > This patch series introduces support for Qualcomm new video acceleratio=
n
> > hardware architecture, used for video stream decoding/encoding. This dr=
iver
> > is based on new communication protocol between video hardware and appli=
cation
> > processor.
> >=20
> > This driver comes with below capabilities:
> > - V4L2 complaint video driver with M2M and STREAMING capability.
> > - Supports H264, H265, VP9 decoders.
> > - Supports H264, H265 encoders.
> >=20
> > This driver comes with below features:
> > - Centralized resource and memory management.
> > - Centralized management of core and instance states.
> > - Defines platform specific capabilities and features. As a results, it=
 provides
> >    a single point of control to enable/disable a given feature dependin=
g on
> >    specific platform capabilities.
> > - Handles hardware interdependent configurations. For a given configura=
tion from
> >    client, the driver checks for hardware dependent configuration/s and=
 updates
> >    the same.
> > - Handles multiple complex video scenarios involving state transitions =
- DRC,
> >    Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during=
 Seek
> >    sequence.
> > - Introduces a flexible way for driver to subscribe for any property wi=
th
> >    hardware. Hardware would inform driver with those subscribed propert=
y with any
> >    change in value.
> > - Introduces performance (clock and bus) model based on new hardware
> >    architecture.
> > - Introduces multi thread safe design to handle communication between c=
lient and
> >    hardware.
> > - Adapts encoder quality improvements available in new hardware archite=
cture.
> > - Implements asynchronous communication with hardware to achieve better
> >    experience in low latency usecases.
> > - Supports multi stage hardware architecture for encode/decode.
> > - Output and capture planes are controlled independently. Thereby provi=
ding a
> >    way to reconfigure individual plane.
> > - Hardware packetization layer supports synchronization between configu=
ration
> >    packet and data packet.
> > - Introduces a flexibility to receive a hardware response for a given c=
ommand
> >    packet.
> > - Native hardware support of LAST flag which is mandatory to align with=
 port
> >    reconfiguration and DRAIN sequence as per V4L guidelines.
> > - Native hardware support for drain sequence.
> >=20
> > I think that the driver is in good shape for mainline kernel, and I hop=
e the
> > review comments will help to improve it, so please do review, and make =
comments.
>=20
> No bindings, no driver. Please post start the series from the bindings.

In your next iteration, make sure to include full v4l2-compliance report in=
 your
cover letter since we cannot assume maintainers.

In addition to this, we now ask for fluster scores for each of your support=
ed
decoders. We expect the results to have no timeout, and ideally the
error/failure explained (aka unsupported resolution, profile, subsampling, =
bit
depth, etc.). Note that inter-resolution change is not possible with V4L2 t=
oday,
so no need to explain why these VP9 tests fails. Fluster supports V4L2 deco=
ding
through GStreamer (gst-launch + video4linux plugin) and FFMPEG at the momen=
t. It
will run through ITU conformance vectors for HEVC and H.264, and run throug=
h
libvpx and and chromium test vectors for VP9.

https://github.com/fluendo/fluster

regards,
Nicolas

>=20
> >=20
> > Dikshita Agarwal (17):
> >    iris: vidc: add core functions
> >    iris: add vidc wrapper file
> >    iris: vidc: add vb2 ops
> >    iris: vidc: add helpers for memory management
> >    iris: vidc: add helper functions for resource management
> >    iris: vidc: add helper functions for power management
> >    iris: add helpers for media format
> >    iris: vidc: add PIL functionality for video firmware
> >    iris: platform: add platform files
> >    iris: platform: sm8550: add capability file for sm8550
> >    iris: variant: add helper functions for register handling
> >    iris: variant: iris3: add iris3 specific ops
> >    iris: variant: iris3: add helpers for buffer size calculations
> >    iris: variant: iris3: add helper for bus and clock calculation
> >    iris: variant: iris: implement the logic to compute bus bandwidth
> >    iris: variant: iris3: implement logic to compute clock frequency
> >    iris: enable building of iris video driver
> >=20
> > Vikash Garodia (16):
> >    MAINTAINERS: Add Qualcomm Iris video accelerator driver
> >    iris: vidc: add v4l2 wrapper file
> >    iris: vidc: define video core and instance context
> >    iris: iris: add video encoder files
> >    iris: vidc: add video decoder files
> >    iris: vidc: add control files
> >    iris: vidc: add helper functions
> >    iris: vidc: add helpers for state management
> >    iris: add vidc buffer files
> >    iris: vidc: define various structures and enum
> >    iris: vidc: hfi: add Host Firmware Interface (HFI)
> >    iris: vidc: hfi: add Host Firmware Interface (HFI) response handling
> >    iris: vidc: hfi: add helpers for handling shared queues
> >    iris: vidc: hfi: Add packetization layer
> >    iris: vidc: hfi: defines HFI properties and enums
> >    iris: vidc: add debug files
> >=20
> >   MAINTAINERS                                        |   10 +
> >   drivers/media/platform/qcom/Kconfig                |    1 +
> >   drivers/media/platform/qcom/Makefile               |    1 +
> >   drivers/media/platform/qcom/iris/Kconfig           |   15 +
> >   drivers/media/platform/qcom/iris/Makefile          |   46 +
> >   .../iris/platform/common/inc/msm_vidc_platform.h   |  305 ++
> >   .../iris/platform/common/src/msm_vidc_platform.c   | 2499 +++++++++++=
+
> >   .../iris/platform/sm8550/inc/msm_vidc_sm8550.h     |   14 +
> >   .../iris/platform/sm8550/src/msm_vidc_sm8550.c     | 1727 ++++++++
> >   .../iris/variant/common/inc/msm_vidc_variant.h     |   22 +
> >   .../iris/variant/common/src/msm_vidc_variant.c     |  163 +
> >   .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481 +++++++
> >   .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
> >   .../qcom/iris/variant/iris3/inc/msm_vidc_iris3.h   |   15 +
> >   .../iris/variant/iris3/inc/msm_vidc_power_iris3.h  |   17 +
> >   .../iris/variant/iris3/inc/perf_static_model.h     |  229 ++
> >   .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 +++
> >   .../iris/variant/iris3/src/msm_vidc_bus_iris3.c    |  884 ++++
> >   .../iris/variant/iris3/src/msm_vidc_clock_iris3.c  |  627 +++
> >   .../qcom/iris/variant/iris3/src/msm_vidc_iris3.c   |  954 +++++
> >   .../iris/variant/iris3/src/msm_vidc_power_iris3.c  |  345 ++
> >   .../media/platform/qcom/iris/vidc/inc/firmware.h   |   18 +
> >   .../platform/qcom/iris/vidc/inc/hfi_command.h      |  190 +
> >   .../media/platform/qcom/iris/vidc/inc/hfi_packet.h |   52 +
> >   .../platform/qcom/iris/vidc/inc/hfi_property.h     |  666 +++
> >   .../platform/qcom/iris/vidc/inc/msm_media_info.h   |  599 +++
> >   .../media/platform/qcom/iris/vidc/inc/msm_vdec.h   |   40 +
> >   .../media/platform/qcom/iris/vidc/inc/msm_venc.h   |   34 +
> >   .../media/platform/qcom/iris/vidc/inc/msm_vidc.h   |   60 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_buffer.h  |   32 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_control.h |   26 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_core.h    |  165 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_debug.h   |  186 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_driver.h  |  352 ++
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_inst.h    |  207 +
> >   .../qcom/iris/vidc/inc/msm_vidc_internal.h         |  787 ++++
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_memory.h  |   83 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_power.h   |   94 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_state.h   |  102 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |   77 +
> >   .../platform/qcom/iris/vidc/inc/msm_vidc_vb2.h     |   39 +
> >   .../media/platform/qcom/iris/vidc/inc/resources.h  |  259 ++
> >   .../media/platform/qcom/iris/vidc/inc/venus_hfi.h  |   66 +
> >   .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |   89 +
> >   .../qcom/iris/vidc/inc/venus_hfi_response.h        |   26 +
> >   .../media/platform/qcom/iris/vidc/src/firmware.c   |  294 ++
> >   .../media/platform/qcom/iris/vidc/src/hfi_packet.c |  657 +++
> >   .../media/platform/qcom/iris/vidc/src/msm_vdec.c   | 2091 ++++++++++
> >   .../media/platform/qcom/iris/vidc/src/msm_venc.c   | 1484 +++++++
> >   .../media/platform/qcom/iris/vidc/src/msm_vidc.c   |  841 ++++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_buffer.c  |  290 ++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_control.c |  824 ++++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_debug.c   |  581 +++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_driver.c  | 4276 +++++++++++=
+++++++++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_memory.c  |  448 ++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_power.c   |  560 +++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   |  660 +++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_state.c   | 1607 ++++++++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    |  953 +++++
> >   .../platform/qcom/iris/vidc/src/msm_vidc_vb2.c     |  605 +++
> >   .../media/platform/qcom/iris/vidc/src/resources.c  | 1321 ++++++
> >   .../media/platform/qcom/iris/vidc/src/venus_hfi.c  | 1503 +++++++
> >   .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  |  537 +++
> >   .../qcom/iris/vidc/src/venus_hfi_response.c        | 1607 ++++++++
> >   64 files changed, 35357 insertions(+)
> >   create mode 100644 drivers/media/platform/qcom/iris/Kconfig
> >   create mode 100644 drivers/media/platform/qcom/iris/Makefile
> >   create mode 100644 drivers/media/platform/qcom/iris/platform/common/i=
nc/msm_vidc_platform.h
> >   create mode 100644 drivers/media/platform/qcom/iris/platform/common/s=
rc/msm_vidc_platform.c
> >   create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/i=
nc/msm_vidc_sm8550.h
> >   create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/s=
rc/msm_vidc_sm8550.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/common/in=
c/msm_vidc_variant.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/common/sr=
c/msm_vidc_variant.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc=
/hfi_buffer_iris3.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc=
/msm_vidc_buffer_iris3.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc=
/msm_vidc_iris3.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc=
/msm_vidc_power_iris3.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc=
/perf_static_model.h
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src=
/msm_vidc_buffer_iris3.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src=
/msm_vidc_bus_iris3.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src=
/msm_vidc_clock_iris3.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src=
/msm_vidc_iris3.c
> >   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src=
/msm_vidc_power_iris3.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/firmware=
.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_comm=
and.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_pack=
et.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_prop=
erty.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_medi=
a_info.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vdec=
.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_venc=
.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_buffer.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_control.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_core.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_debug.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_driver.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_inst.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_internal.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_memory.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_power.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_state.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_v4l2.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc=
_vb2.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/resource=
s.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hf=
i.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hf=
i_queue.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hf=
i_response.h
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/firmware=
.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/hfi_pack=
et.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vdec=
.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_venc=
.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_buffer.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_control.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_debug.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_driver.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_memory.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_power.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_probe.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_state.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_v4l2.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc=
_vb2.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/resource=
s.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hf=
i.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hf=
i_queue.c
> >   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hf=
i_response.c
> >=20
>=20

