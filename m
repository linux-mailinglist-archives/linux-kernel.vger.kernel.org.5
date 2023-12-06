Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45050807B49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377555AbjLFWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:24:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B552D46
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:24:08 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db8892a5f96so348989276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701901447; x=1702506247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFW1BtHzKKyWMjTKsTgJeCE0JqHRAauG27klyOmROjc=;
        b=EiNEaH+nkoYet3Y1uEYehpX7ztPyB34baspR8MWcbGpKz+Jf4Z3aMHEAIyQJEEQWJq
         SuA9gotQKR4pEOzRK6c5GOZs0fZcwqK/RzE6EYfCOwQlw6yWBeR66JGHQcwx53qx/R5t
         F8oGrgNiRxoUs0y3Hn94TOz+miA8w5P0yfDnJ8XYDKvnix4X7vaYq33OO/bx3115xBba
         cTk+DOPrJc7nYV4QePjjmeKwYIuosYmm1konXwaZmrUmASEzLKhcSocnyMG+2FA5mOA8
         S9/fm26Ov4bObukAWKqmC09MtNsd8dn7Z9FJDg6q5jaNLgzYo9MVikb1bhxbnBCWWNBH
         uGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901447; x=1702506247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFW1BtHzKKyWMjTKsTgJeCE0JqHRAauG27klyOmROjc=;
        b=EqeLEzcMk+U/QwoSlUYUhU+tnykHAw0hX35JY6FUfLGkM7FQgDNuRheFbEwH8Pab8I
         UzgRgOKgwudqUWJ8ptzHh1WhWzZYGRDQdeXgHo29238kZX0vQH0ap4m+8xbXZSerO2Q5
         qiPdohBs0p7jyXdOXdsE1+Qar+gTR4+xAscdZy1d34VTV+atoqbzcp7Xzppyd1GZhksY
         Q18rLpXS+gvPmuKOhBsfTlY0pEAS3jyIlrT0xNQcUFWo06bzTRDPF7/5mnpn2VHbo7Ey
         mvW2S2wlZDjxXlfL4O/Ji1Ebx9dForNPNmZCA6+gLNe0j8x4whpxNiiF6z4tnpGf1rxZ
         2sUw==
X-Gm-Message-State: AOJu0YyfVlqg7WRXlk/YDEGh7rqDSeyJT8aIeIlN3CmFJN+zq1QryG1i
        7mHXCQyStoiChE6X8gbGdhg9XKEFGlM0pAFkMWqxww==
X-Google-Smtp-Source: AGHT+IEHcerkxXFp1Wf9mkkpYSruKLDzVFs7vUbnsFJMGyrEWX2GOTzqPWBuAvK/kL7CD3Fu11efxf1XOn9R17miGKI=
X-Received: by 2002:a25:8102:0:b0:db5:3f84:25f4 with SMTP id
 o2-20020a258102000000b00db53f8425f4mr1484992ybk.65.1701901447301; Wed, 06 Dec
 2023 14:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com>
 <20230830224910.8091-8-quic_abhinavk@quicinc.com> <CAA8EJpoRcdHtyp3mym5HB2A=O6V4qUNTpnMkvm+OiSt7nHuXJw@mail.gmail.com>
 <5bcbb092-1d29-f795-3be4-5ab1c708cba0@quicinc.com> <27074b58-25ed-dbcc-1048-dbd9ba3135c9@quicinc.com>
In-Reply-To: <27074b58-25ed-dbcc-1048-dbd9ba3135c9@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 00:23:56 +0200
Message-ID: <CAA8EJppKG=Jxd1rh3UB4qUhrVW2SYOiwBiXum-RD-10T63yPmg@mail.gmail.com>
Subject: Re: [PATCH 07/16] drm/msm/dpu: add cdm blocks to RM
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        quic_khsieh@quicinc.com, quic_parellan@quicinc.com,
        quic_jesszhan@quicinc.com,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>
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

On Wed, 6 Dec 2023 at 23:02, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 11/30/2023 3:47 PM, Abhinav Kumar wrote:
> >
> >
> > On 8/30/2023 4:48 PM, Dmitry Baryshkov wrote:
> >> On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar
> >> <quic_abhinavk@quicinc.com> wrote:
> >>>
> >>> Add the RM APIs necessary to initialize and allocate CDM
> >>> blocks by the rest of the DPU pipeline.
> >>
> >> ... to be used by the rest?
> >>
> >
> > Yes, thanks.
> >
> >
> >>>
> >>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>> ---
> >>>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++++++
> >>>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
> >>>   2 files changed, 19 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >>> index f9215643c71a..7b6444a3fcb1 100644
> >>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >>> @@ -8,6 +8,7 @@
> >>>   #include "dpu_kms.h"
> >>>   #include "dpu_hw_lm.h"
> >>>   #include "dpu_hw_ctl.h"
> >>> +#include "dpu_hw_cdm.h"
> >>>   #include "dpu_hw_pingpong.h"
> >>>   #include "dpu_hw_sspp.h"
> >>>   #include "dpu_hw_intf.h"
> >>> @@ -90,6 +91,9 @@ int dpu_rm_destroy(struct dpu_rm *rm)
> >>>                  }
> >>>          }
> >>>
> >>> +       if (rm->cdm_blk)
> >>> +               dpu_hw_cdm_destroy(to_dpu_hw_cdm(rm->cdm_blk));
> >>> +
> >>>          for (i = 0; i < ARRAY_SIZE(rm->hw_wb); i++)
> >>>                  dpu_hw_wb_destroy(rm->hw_wb[i]);
> >>>
> >>> @@ -240,6 +244,19 @@ int dpu_rm_init(struct dpu_rm *rm,
> >>>                  rm->hw_sspp[sspp->id - SSPP_NONE] = hw;
> >>>          }
> >>>
> >>> +       if (cat->cdm) {
> >>> +               struct dpu_hw_cdm *hw;
> >>> +
> >>> +               hw = dpu_hw_cdm_init(cat->cdm, mmio);
> >>> +               /* CDM is optional so no need to bail out */
> >>> +               if (IS_ERR(hw)) {
> >>> +                       rc = PTR_ERR(hw);
> >>> +                       DPU_DEBUG("failed cdm object creation: err
> >>> %d\n", rc);
> >>
> >> No. If it is a part of the catalog, we should fail here as we do in
> >> other cases.
> >>
> >
> > I guess, the only reason for not failing here was other hw blocks are
> > needed even for basic display to come up but cdm is only for YUV formats.
> >
> > Thats the only reason to mark this a failure which is "OK" to ignore.
> >
> > But I see your point that if someone is listing this in the catalog but
> > still RM fails thats an error.
> >
> > Hence, ack.
> >
> >>
> >>> +               } else {
> >>> +                       rm->cdm_blk = &hw->base;
> >>> +               }
> >>> +       }
> >>> +
> >>>          return 0;
> >>>
> >>>   fail:
> >>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >>> index 2b551566cbf4..29b221491926 100644
> >>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >>> @@ -22,6 +22,7 @@ struct dpu_global_state;
> >>>    * @hw_wb: array of wb hardware resources
> >>>    * @dspp_blks: array of dspp hardware resources
> >>>    * @hw_sspp: array of sspp hardware resources
> >>> + * @cdm_blk: cdm hardware resource
> >>>    */
> >>>   struct dpu_rm {
> >>>          struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
> >>> @@ -33,6 +34,7 @@ struct dpu_rm {
> >>>          struct dpu_hw_blk *merge_3d_blks[MERGE_3D_MAX - MERGE_3D_0];
> >>>          struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
> >>>          struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
> >>> +       struct dpu_hw_blk *cdm_blk;
> >>
> >> struct dpu_hw_cdm *cdm (or cdm_blk), please.
> >
> > Ack.
> >
>
> I was going through this more. I think its better we leave this as a
> dpu_hw_blk because if you see the other blks in struct dpu_rm, all the
> blocks which are allocated dynamically / can change dynamically are of
> dpu_hw_blk type. That way the dpu_rm_get_assigned_resources() remains
> generic. Hence I would prefer to leave it this way.

Ack

>
> >>
> >>>   };
> >>>
> >>>   /**
> >>> --
> >>> 2.40.1
> >>>
> >>
> >>
> >> --
> >> With best wishes
> >> Dmitry



-- 
With best wishes
Dmitry
