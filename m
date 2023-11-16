Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83907EE916
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbjKPWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:01:07 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888418D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:01:04 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5c5b9c142e8so5965027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700172063; x=1700776863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrDfTqC4kCNkXvqk06JZuMHZ8F1CQgx8Er0ge2sMlCI=;
        b=c39vk3Ppa/Xp2qoue6gSrPT67//d/E4aLL6kB2wSCktzXrWuxTdvFJhV5MG/Cnc6Zb
         Xdtuu9a4PfSQRmDS+EXhRV8iQ/XaY9J9xBcCVw4gLVuH5vjIMcgqWFaQOHrQb31JifOa
         GUbdCGxulOkPTZL+0Aamq0OkBVMsdHb/E/AXlFnnCVH9SxYaxaEzp6mtDLjljzMC9VHS
         MXrtjqIsYcBE050De9MCnZ7bpcBl1E05DhiQL/RZr/YMnz9TcI2zjQ8LTy4PtVV15AGp
         kJkD67hvGxQHuG1dOf8Eh5h/F2fEaIOD8Md2i98+uMRdJMjT/SOWu6mnXjdvIe/AgUjU
         TQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700172063; x=1700776863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrDfTqC4kCNkXvqk06JZuMHZ8F1CQgx8Er0ge2sMlCI=;
        b=QAMuYGDXMdnCcBBoPw0jmIyJUFohwNWQ4J7HGFLcOKEzWXhkOa9C1in2dV+vDkTyZ4
         3EXDHOUnNKSW2VoZMi6hGes+58DCYfwed/dtZ7GLRdd3IylF34azA8+R6wbmeelLBCrV
         lVTZ3CCM+LFrjfwamfL7pCckzQ7+sCG2JfE/Bepc5P9UHtrdgIyE9mzSYU/DVzQKfdYH
         RuIeXlCL9YkUi9PkWf3L+o9farlo6MmqaNi0u08I8/qN8IEV+R2yt2uvIdScpv3HAhFh
         IU7yihmh4kDpLkNSMIRlK/En8mmALNgp1GE38ZbYfP8bXeXgNHioHA2iWV2Gpv/yXq1t
         EpfA==
X-Gm-Message-State: AOJu0YxpG7ITs+WzY6vPhLCUN8UE3LXEDtdVXmANwQB/yafcBmiS+Wp5
        7ex0FOhGlBUn+KawxKtfFjkwY5cyetud8t58UaWvcA==
X-Google-Smtp-Source: AGHT+IFar8dbn8tWGRc5Du9nzxi2agmew03+it+BDi75j3YNagGC4edoDYvKPdFZlty1Nzek7YOPn3SS7ZFTZyvb9QY=
X-Received: by 2002:a05:690c:a87:b0:5c1:8075:5a7d with SMTP id
 ci7-20020a05690c0a8700b005c180755a7dmr18665864ywb.39.1700172063677; Thu, 16
 Nov 2023 14:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115224409.240935-1-robdclark@gmail.com> <6107757c-1217-1759-8bcf-7dbce6f2e730@quicinc.com>
In-Reply-To: <6107757c-1217-1759-8bcf-7dbce6f2e730@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 00:00:52 +0200
Message-ID: <CAA8EJpqUBTMnkcR_dmvRCaBGNCn6x-mvnna4qVkzCVqQKBFyJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Move gpu devcore's to gpu device
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 00:58, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 11/15/2023 2:44 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The dpu devcore's are already associated with the dpu device.  So we
> > should associate the gpu devcore's with the gpu device, for easier
> > classification.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
