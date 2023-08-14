Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966AE77BC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHNPAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjHNPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:00:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E6E6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:00:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d43930354bcso3098851276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025215; x=1692630015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+a164Lo/xnprShByrSc9v2/KWRvgiRosUcq4zImKgk=;
        b=jGPGgviFdfRHR1RB7ogSGrhVlh9dgstF8M/lqAgP92B9OoZHUismmpwroR9vYrUOIr
         cZAT7fOYY9Q0QQWAstMVpZPTwJMfhUGWpjndreP6meso8qz71becKD8MgTTpoTsvaljW
         3xWQWqXjlBmkjCr6R/Q4Au+jI7pMm2sN/d1kD8i57SU30HS5t/68afFVCfBCvdF7Bipr
         LQe0ZmYDiYfo+yKRwFwZpRbbxYO+V8nm2s/Fz2fh4BqcmdU0CFi+TSOdF38RkQmZMQZ4
         GcAF4FMtHzyvuBdKiG5edblCTsM4R2+bb//4ODxk5CAuMvfP6pxDjB7ZIJKqnBEXxtRM
         F/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025215; x=1692630015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+a164Lo/xnprShByrSc9v2/KWRvgiRosUcq4zImKgk=;
        b=e9dlbBoiWpytRSz+AKf8rU7rmBMACcYbyzkNhO3mB4b9AqYYq64t1SICyXFt0u9dSg
         5viOsN17DHDDVRIzQtaDmXnClrzXJx/Wh+yRI5w7AYQpGBCQm1IAr+rNCRHZjFTW5Hes
         CdEO58d+/yX1pCyOxT5qd03LB3NuSbChqSXw/ae/NMPEx1EiIZtBe4NCHBni8/kk9NSd
         I2cqddHB66RRV901XWo8YlECje1JVlHE2qbarec9kBB31eNtI9BjY/VijMeImtTbaQ69
         SUoDhdfUCIZYknJWqWqQcHOFU7SqhfD+pNHIpcpcDLDnxP9PcLm1fxhuoK5lTHYRekTl
         tQ7Q==
X-Gm-Message-State: AOJu0Yx96w7Ci5mD2lGyquhl2DjejgboZg0dwFuQhigFVgyVVRYo5/OP
        bABFQsNnBCGLS4YAzQuQQexzpDN0YTfZC8EwiTyS7LMlCV7k6RI9
X-Google-Smtp-Source: AGHT+IFcDjGY5t1TUEHJGqfbRGCrBRK0ocLIGx+5jH3QxiqiM4XdKAspdv5ouADbx68wpvwKtwPgEzDBxLTXcNycy88=
X-Received: by 2002:a25:4291:0:b0:d21:fa08:d683 with SMTP id
 p139-20020a254291000000b00d21fa08d683mr7550886yba.35.1692025215074; Mon, 14
 Aug 2023 08:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <e18b951e-7f15-2c67-9099-c45ea7f67daa@linaro.org> <d80b5338-2eca-0223-d2a7-d6f7d39a28ba@gmail.com>
In-Reply-To: <d80b5338-2eca-0223-d2a7-d6f7d39a28ba@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Aug 2023 18:00:03 +0300
Message-ID: <CAA8EJpqArfMcxvJV2zxea8_C4VHY06MsU-Jw3pPXbu5Gxw-ccg@mail.gmail.com>
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_dikshita@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,

On Mon, 14 Aug 2023 at 15:58, Stanimir Varbanov
<stanimir.k.varbanov@gmail.com> wrote:
>
> Hi Dmitry,
>
> On 28.07.23 =D0=B3. 17:01 =D1=87., Dmitry Baryshkov wrote:
> > On 28/07/2023 16:23, Vikash Garodia wrote:
> >> This patch series introduces support for Qualcomm new video accelerati=
on
> >> hardware architecture, used for video stream decoding/encoding. This
> >> driver
> >> is based on new communication protocol between video hardware and
> >> application
> >> processor.
> >>
> >> This driver comes with below capabilities:
> >> - V4L2 complaint video driver with M2M and STREAMING capability.
> >> - Supports H264, H265, VP9 decoders.
> >> - Supports H264, H265 encoders.
> >
> > Please describe, why is it impossible to support this hardware in the
> > venus driver. We do not usually add new drivers for the new generations
> > of the hardware, unless it is fully incompatible with the previous
> > generations. Let me point you to camss or drm/msm drivers. They have
> > successfully solved the issue of supporting multiple generations of the
> > hardware in the same driver.
> >
> > Unless the "iris3" is completely different from all the previous
> > generations, I strongly suggest spending time on restructuring existing
> > venus driver and then adding support for the new hardware there instead
> > of dumping out something completely new.
>
> AFAIK the major differences are HW IP and firmware interface (by
> firmware interface I mean a protocol, API and API behavior). The
> firmware and its interface has been re-written to align closely with the
> current v4l2 specs for encoders/decoders state machines [1][2]. On the
> other side current mainline Venus driver firmware is following interface
> similar to OpenMAX.
>
> There are incompatibilities between both firmware interfaces which
> cannot easily combined in a common driver. Even if there is a
> possibility to do that it will lead us to a unreadable driver source
> code and maintenance burden.

Thank you for your explanation!

If the hardware is more or less the same, then the existing venus
driver should be refactored and split into hardware driver and the
firmware interface. Then iris3 can come up as a second driver
implementing support for new firmware interface but utilising common
hardware-related code.

> Vikash, could elaborate more on firmware interface differences.

Do we have any details on firmware versions that implement older
(OpenMAX-like) interface vs versions implementing new (v4l2-like)
interface?

> [1]
> https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-decode=
r.html
>
> [2]
> https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-encode=
r.html

--=20
With best wishes
Dmitry
