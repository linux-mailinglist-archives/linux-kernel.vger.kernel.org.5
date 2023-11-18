Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671B7F0399
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKRXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:20:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DA194;
        Sat, 18 Nov 2023 15:20:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so2364019a91.0;
        Sat, 18 Nov 2023 15:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700349605; x=1700954405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeXUxQajKzhtg/3R4Bjp7L/NCc3uEZORLSqU/Ox/kzk=;
        b=hvbEmjYD1ozC3p/8k6m3Q/5H4P5Jre6Z2tvK4BaUO9EPuMnSiQ8lvy0qbj6fUUYPWr
         MJs1Zfgb0jhw2+vuJof/CICoqky1egLwLAr8vBNevt63TQkFVrdPy2uTdnoE21bCMuuM
         /EnELtQXMUTem/gE3+SF3ob5bdiNEWhVo56UNUzXBuTePzwCUiBIA0n13tNbuxMSOGih
         x0XrdZlGvsMJHNgcJZfHDTzkODXRR8QLL143wGq7bK/21N0feMWKy/c/z92KAopa/LOJ
         /VNe1XzAG1dAilwfbkc+ALO6xIZbQS4mMs3C+dSZrKCDNaZ71yuleVP9IYJmFzzy9uX+
         QPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700349605; x=1700954405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeXUxQajKzhtg/3R4Bjp7L/NCc3uEZORLSqU/Ox/kzk=;
        b=mxFy+1g5IR5M6mnrA64FQ/Y9Wkuwo4HHo8KDYhyAUQuFv3jETUjeL0Smpq1sOxCF90
         1xI0nOY89bF8H3P4xmilBi2mfZ2/baOfyhoiZDTQQoCtIIRwdlGf+cOEw6s6SX2tPRZY
         zM4usHVASJde6TOff/deiYP361nxe2ENM2+c/o97wAAQ5hTBN7naG4b+pBZe0HtZVk4A
         wnOD4Z4S+BG/0ki/OJHRBKmazNMU0A2iHI8QeEUBzVmC2FtnNsAMpEjSXoA/XCwUHFw/
         VbBcuJ5xbA2nogoAVsB5xRnjcAOHZbwhrrNlTaZ6CxhlFxsjWbnipbXiCT2SOdPKAj7F
         d1rQ==
X-Gm-Message-State: AOJu0YxMl10QYXq6lZ0nGBPRzkRiKP5Ts2EwwkZeu5z4D1L4B626lzFz
        /nXzo2gBmeFvIqRB7ulKoqfRHiqxgYbApYwWRx4=
X-Google-Smtp-Source: AGHT+IG9EFxZSVyVvL+P3Uqatu2MGbvVpVxdQLWRtHotx8YOUssp+KvNe9mCYPwDBcSga+yC7vRn7f5+wtLBR8s2kMU=
X-Received: by 2002:a17:90b:1bca:b0:27f:fcc8:9196 with SMTP id
 oa10-20020a17090b1bca00b0027ffcc89196mr2689140pjb.32.1700349604660; Sat, 18
 Nov 2023 15:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20231116154816.70959-1-andrzej.p@collabora.com>
In-Reply-To: <20231116154816.70959-1-andrzej.p@collabora.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 18 Nov 2023 17:19:53 -0600
Message-ID: <CAHCN7xK1kS4771rRH=mBoT4VO=cUNX7AmJu6hrraHSNa-ur=kA@mail.gmail.com>
Subject: Re: [RFC 0/6] H.264 stateless encoder RFC 0/6
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 9:48=E2=80=AFAM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Dear All,
>
> This series adds uAPI for stateless H.264 encoding and an
> accompanying driver using it.
>
> It has been tested on an stm32mp25 and there exists
> a gstreamer user:
>
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676
>
> example pipeline:
>
> gst-launch-1.0 videotestsrc num-buffers=3D30 ! video/x-raw, format=3DYUY2=
 !
> v4l2slh264enc ! filesink location=3Dtest.h264
>
> Rebased onto v6.6 with:
>
> - some patches from ST to actually run the hardware
> - my previous VP8 statless encoding series
> - VP8 support for H1 from Hugues Fruchet
>
> In particular, this series depends on the latter, which can be
> found here:
>
> https://patchwork.linuxtv.org/project/linux-media/list/?series=3D11358
>
> Here's a branch which contains everything needed to actually run:
>
> https://gitlab.collabora.com/linux/for-upstream/-/tree/h264-enc-rfc-6.6
>
> I kindly ask for comments.

I attempted to port this to an i.MX8M Mini without much success.  I
get the driver to enumerate, and the gst-inspect of the v4l2codecs
detects the device for the encoder, but I get t a bunch of errors.

Pipeline is PREROLLING ...
[  141.946608] f->type =3D 10
[  141.951595] f->type =3D 10
[  141.954331] f->type =3D 10
[  141.957027] f->type =3D 9
[  141.959512] trying format S264
[  141.962583] trying format NV12
[  141.965639] OUTPUT codec mode: -1
[  141.968962] fmt - w: 640, h: 480
[  141.972202] CAPTURE codec mode: 8
[  141.975529] fmt - w: 640, h: 480
[  141.978778] f->type =3D 10
[  141.981316] trying format YUYV
[  141.984384] OUTPUT codec mode: -1
[  141.987707] fmt - w: 640, h: 480
[  141.998500] Codec mode =3D 8
[  142.018876] plane 0 size: 4194304, sizeimage: 4194304
[  142.023986] plane 0 size: 614400, sizeimage: 614400
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...[  142.035697] plane 0 size: 4194304,
sizeimage: 4194304

Redistribute latency...
New cl[  142.042146] plane 0 size: 614400, sizeimage: 614400
ock: GstSystemClock
ERROR: from element
/GstPipeline:pipeline0/v4l2slh264enc:v4l2slh264enc0: Driver did not
ack the request.
Additional debug info:
../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codech264enc.c(1002):
gst_v4l2_codec_h264_enc_encode_frame ():
/GstPipeline:pipeline0/v4l2slh264enc:v4l2slh264enc0
Execution ended after 0:00:01.019990114
Setting pipeline to NULL ...
ERROR: from element
/GstPipeline:pipeline0/GstVideoTestSrc:videotestsrc0: Internal data
stream error.
Additional debug info:
../subprojects/gstreamer/libs/gst/base/gstbasesrc.c(3153):
gst_base_src_loop ():
/GstPipeline:pipeline0/GstVideoTestSrc:videotestsrc0:
streaming stopped, reason error (-5)
ERROR: from element /GstPipeline:pipeline0/GstFileSink:filesink0:
Error while writing to file "test.h264".
Additional debug info:
../subprojects/gstreamer/plugins/elements/gstfilesink.c(716):
gst_file_sink_event (): /GstPipeline:pipeline0/GstFileSink:filesink0
[  144.058389] hantro_watchdog:127: frame processing timed out!
Freeing pipeline ...
[h264-enc-st-dev] root@localhost:~/gstreamer#


If I can get this working, I can do more testing.  I don't know how
similar the H1 is on the STM32 vs the i.MX8M Mini.  I don't have a
datasheet for the STM32, but the registers that I checked seemed like
they matched, but I don't know enough about how this all works, so I'm
a bit at a loss.  I can post my own RFC if people are open to
reviewing it too.  I'll go through and review what I can.



adam
>
> Regards,
>
> Andrzej Pietrasiewicz (6):
>   media: verisilicon Correct a typo in
>     H1_REG_ENC_CTRL2_DEBLOCKING_FILTER_MODE
>   media: verisilicon: Correct a typo in H1_REG_MAD_CTRL_MAD_THRESHOLD
>   media: verisilicon: Improve constant's name
>   media: verisilicon: Update H1 register definitions
>   media: uapi: Add H.264 stateless encoding uAPI
>   media: verisilicon: Add H.264 stateless encoder
>
>  drivers/media/platform/verisilicon/Makefile   |   1 +
>  drivers/media/platform/verisilicon/hantro.h   |   3 +
>  .../media/platform/verisilicon/hantro_drv.c   |  10 +
>  .../platform/verisilicon/hantro_h1_h264_enc.c | 493 +++++++++++
>  .../platform/verisilicon/hantro_h1_regs.h     |  20 +-
>  .../platform/verisilicon/hantro_h1_vp8_enc.c  |   2 +-
>  .../media/platform/verisilicon/hantro_h264.c  | 777 ++++++++++++++++++
>  .../media/platform/verisilicon/hantro_hw.h    |  23 +
>  .../platform/verisilicon/stm32mp25_venc_hw.c  |  22 +-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |  54 ++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   9 +
>  include/uapi/linux/v4l2-controls.h            |  85 ++
>  include/uapi/linux/videodev2.h                |   2 +
>  13 files changed, 1496 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/hantro_h1_h264_enc=
.c
>
> --
> 2.25.1
>
>
