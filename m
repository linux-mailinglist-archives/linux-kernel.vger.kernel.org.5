Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132F180A210
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573570AbjLHLVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLHLVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:21:01 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185A10CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:21:08 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2006715276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702034467; x=1702639267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmazC+0qAqQxSPROFc0xc84GbFdhI8sWUlQpFJfzTOs=;
        b=rQ82p9zwU6nbWWZ1nqwXyrUgOMgNkjJ7ZVbyVRXagbyrdFGBVxXDOyz9/IFBoI0Abw
         96wpE1CjrDsdU9wq3rHNL9+sU87W4XZX+uZAQOFlO2G/1KKIJuCataR/wEyKwAnpA5Ia
         4ZZgp8zuKB+d7l4JFTqopeViNmdEAYHmOQeRz58/hqvv2RIrWlbPtKppQswdmOVdwvPA
         09WDL4v6zuMHKE4gDcalQD2XMiH0rYplIN1gkAD+a8gI3LCFvXLj8v7QrOKBih8cemid
         Ci1SImXuVz65rZWoziQKxMObppgHke+A9pHLnMTJgewi8ESHo4dRh1pUmgNdhfI17pim
         A5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034467; x=1702639267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmazC+0qAqQxSPROFc0xc84GbFdhI8sWUlQpFJfzTOs=;
        b=iYXHsiNIQLhR1GF/Ad3smrOiTqQq1TE66PlVeWuntdvkUDSGVDo+7DqKGy1/EKUaM9
         UKhD71fdSjVOLJ1AV60Wppx1KfIFiwWlEufQr9gyRKhSsUhU6wnBcPxpe9YFBNGJGsEc
         d8Aaoqb3hNuFkz+DOzYRmcjtb8/ElXrlOGtITqGGkTABYmTqGzUVFGoPaihdUf/Rqdrw
         uSNMjFkqggQiw2+7/fSPsKtMCkpAsyzp8x1M1VwnuVnzalL0S0jd0iiZiN/iLqMnnJfu
         wojZ0RFkFn7T7OvxQg8K5cjKb4TJAjHT77edmzDFrIBbvmnzEr/XkMtrTu4ofA692LY7
         bu2g==
X-Gm-Message-State: AOJu0YzOz2hglyr8FFpw9tIAx8f11npnW01IofwsOEJzLIx37D+FtoQs
        4o6vznF+EwGreLDiEW2G6LNpbehNoCiLU5xs3Z9QVw==
X-Google-Smtp-Source: AGHT+IHp0377Ybzxt5w6KqA9E+DZI6lyM8tdxkXwFiDkF9togYRg3F/ti2mcvG9rIQBDUE40O7+YuoHQA1vFqx87rvE=
X-Received: by 2002:a25:2f96:0:b0:db7:dacf:4d66 with SMTP id
 v144-20020a252f96000000b00db7dacf4d66mr2502085ybv.98.1702034467396; Fri, 08
 Dec 2023 03:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-7-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-7-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:20:56 +0200
Message-ID: <CAA8EJprAu-4Az07oztew0Nf3SO1yeCcASk2bhXR-938YnzSgMg@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] drm/msm/dpu: add cdm blocks to sm8250 dpu_hw_catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add CDM blocks to the sm8250 dpu_hw_catalog to support
> YUV format output from writeback block.
>
> changes in v2:
>         - re-use the cdm definition from sc7280
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
