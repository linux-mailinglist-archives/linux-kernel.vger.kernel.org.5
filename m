Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CEF7BD160
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjJIAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbjJIAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:09:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47B9DB;
        Sun,  8 Oct 2023 17:09:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-534659061afso6592285a12.3;
        Sun, 08 Oct 2023 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696810148; x=1697414948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OeAouwbiIW3oa603x3NICDHKjYzU+b9TyziED7iPnQ=;
        b=hdsOkWMvZSLQh05K23+96pq8i7m2JeDvadGLLmvLkO2eBRNFRuUh8GdHOk036MUVNs
         qGOnSTIevt30ummmuvQVR/zKq5IbhaP2SxUQZD+oXmmmQ9+TqHr7d375HINTNWwB/G+f
         9CXUuqAjKmeXBD1rIkMCWVgHmhoWG5herx/29F+wF+DMqGUf/25CPdriCXzD3U6wHeoL
         +qhjtXySm8DnDuEsT1ROZlYTM4vk9yb2brY7+bkGBhA8QDVEjRLlKK3ZHgIL7A0jobm1
         NiZ2CVkPovo5RqslmwC/43wDzeVCyGu4YsW4E+kC4fOdrbsudtKjklTcqvNVQbHLkCq6
         Dl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696810148; x=1697414948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OeAouwbiIW3oa603x3NICDHKjYzU+b9TyziED7iPnQ=;
        b=E21uTxhaX9irUpsRxHHgqYj+wc39VIboj6NAPZe/5xsOV17XRf+L1TnxB/sNkcSx5E
         jFd/RvUYkYSlMi9ATcGKl4qovIbKJAGqRXxFwC7p5uexaW9Kt6sqMqtf0aoVl/26IgC/
         9G27SQZuOYUEhs9x4OxxM0XR1v+QE1faYHDoqjvw6TcLy1R4sKQcpgd4KNImoF8X758I
         EFxyMraM2NyOx0f9MCZIC2FzJFdmtxtNs6vcZFXCrdNeh5YK5JrmgYtF7Q1UlwK/WCTk
         3ruhOW81G1kwYNrphnpIMW/glwpiaccot2Uprzt2FZfVRRVE/0ITWssv4SYbCjMD6Prs
         Pexw==
X-Gm-Message-State: AOJu0YwKNae6swZ/kJ8O083fzVxrRZVYnItri7IJNcMRqayMIe8z210i
        V0tnI5pY/xy0UI2365YS6YAIoqATlrcNPs9RmHA=
X-Google-Smtp-Source: AGHT+IEmRGETHMC0oZivK2NW82/PXGmCkgOWv6RewoLXm/o/GSIZ8n2ZVNbmKSZMKbASRhS9km/BFJ9w09k2uM9DQC8=
X-Received: by 2002:aa7:da44:0:b0:532:aaca:d39d with SMTP id
 w4-20020aa7da44000000b00532aacad39dmr11921076eds.6.1696810147764; Sun, 08 Oct
 2023 17:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231008175615.413497-1-robdclark@gmail.com> <CAA8EJppgUmkLrhTw779tq5wkgXfu4sypGrQbJFYtrnCrbwa3=Q@mail.gmail.com>
 <526457dd-37f2-467d-b583-b710a5e84b97@collabora.com>
In-Reply-To: <526457dd-37f2-467d-b583-b710a5e84b97@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 8 Oct 2023 17:08:55 -0700
Message-ID: <CAF6AEGukUgPfa2h17oNt9QEP7b6AqUWR5EwK3bP3W9tj6yX2Lg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Use the encoder for default CRC source
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Stone <daniels@collabora.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 4:21=E2=80=AFPM Helen Koike <helen.koike@collabora.c=
om> wrote:
>
>
>
> On 08/10/2023 16:59, Dmitry Baryshkov wrote:
> > On Sun, 8 Oct 2023 at 20:56, Rob Clark <robdclark@gmail.com> wrote:
> >>
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> i-g-t expects the CRC to reflect any applied CTM.  But the layer mixer
> >> source is upstream of the DSPP, so it is before the CTM is applied.
> >>
> >> Switch the default source to 'encoder' instead so that the CRC is
> >> captured downstream of the DSPP.
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>   drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt |  4 ----
> >>   drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt |  5 -----
> >>   drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt | 11 +----------
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  6 +++---
> >
> > I'm not sure, if updating the CI skip list together with the
> > functional changs is a good idea, my preference would be towards two
> > separate patches.
>
> On the other hand, having both together in the same patch documents
> which tests this PATCH is fixing.

on the mesa side of things, where we have more experience with CI,
I've found updating expectations in same patch as code change to be
hugely useful.  I *might* end up dropping the xfails changes when I
apply this patch (because there are some dependencies on igt uprev and
I'm not sure we have enough CI runs to be confident about flakes) but
I definitely believe that we should be updating expectations along
with code changes.

BR,
-R

> Regards,
> Helen
>
> >
> > Nevertheless:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >>   4 files changed, 4 insertions(+), 22 deletions(-)
> >
> >
