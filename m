Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334CD78E3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbjHaAPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbjHaAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:15:23 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30856CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:15:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7485d37283so100113276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693440918; x=1694045718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyQ3QNWscfTpdGqgBgms3LPZL8sWGyfgTmegeYl8UhY=;
        b=GG3pOEwqw1NYXBGv2mXfWOs3cxuhLLhkaHvDbAzQnSYX+dSgN/UfhgM0LXr+8/9X5F
         vFSLggDwM8DmMK5lPJVfmu7LWcOtboS3E7a0FPVb0RjbsROVqFEZ+LWnhbS9vqzcwTCO
         hnpC9LWARV2GJHAhwe7okFSHp25ttdROCJbGcNYJY/kBcZ9OGS/QpxEmvjhY/rc+lyVR
         P85I7hxufh3HolAImPToyHO3FKRWCgnBuAm0I5ydVEY8ncD8vF/rE6PYGLmKafGN6sw2
         vW6TyUTPToZnfASf5XAdiSDBo+av59md4+CBvxi65gY9CtkVjbK9OEu/j5xtCo8EXpjY
         FJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440918; x=1694045718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyQ3QNWscfTpdGqgBgms3LPZL8sWGyfgTmegeYl8UhY=;
        b=B1e0k/Tk+9b8vjsRkcNpziSM4Xqe5cIoeUgrPs0yAYSgo6R8Jt2LxbTzKX6uLnax3p
         dfUym+aKeq6jwA7etwJ4/w4vLbcbN+Drj4Kesd4wf6q1aA2Rc9anjwOFkX3IPf58u9qo
         vbYxZeoFt3IMQKJLcf1hdfUD2vjAv2/wTiCWMvAbZ+Ju13aVQ2VxNT739zEWLNo43vKp
         Cof3xj3DbtwpdTb4yzT9QU5QCBpeuw5PnbchQznAKXH2asFYvXLDW5yRcchzoQvHFOHU
         lAt7qoZfaE5qyn6qMR59TxuqJb75+ke0OFq/TcG57l3jWoxOj+Z/Dp97oLa8sjgseEKC
         W4uA==
X-Gm-Message-State: AOJu0YwADlhyxGAD6/HcC/78q2T+agXfyK1i6mshF0iZtEJ6z0OWLb3h
        85hc6rhWatOPV3HQjIa4WHtraRr41vc3ppd9WnCvLw==
X-Google-Smtp-Source: AGHT+IEUgQBvI0sgINcVEP1+dB/cEnSbvMnPVtijtfAwJ3hr2IQuJhXns221D7jxzg+csWS71CBxDjIx0awK1xuN964=
X-Received: by 2002:a25:db42:0:b0:c60:982f:680c with SMTP id
 g63-20020a25db42000000b00c60982f680cmr3449214ybf.63.1693440918412; Wed, 30
 Aug 2023 17:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-13-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-13-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 03:15:07 +0300
Message-ID: <CAA8EJppJe-tvfFT7fO5c_Fyv1aAtniVcAk5wdWpp8FPwwki9Rg@mail.gmail.com>
Subject: Re: [PATCH 12/16] drm/msm/dpu: plug-in the cdm related bits to
 writeback setup
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> To setup and enable CDM block for the writeback pipeline, lets
> add the pieces together to set the active bits and the flush
> bits for the CDM block.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)


-- 
With best wishes
Dmitry
