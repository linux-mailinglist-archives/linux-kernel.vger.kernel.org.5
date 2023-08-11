Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49AC7794D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjHKQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjHKQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:37:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8730C4;
        Fri, 11 Aug 2023 09:37:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5236c9ff275so2895956a12.1;
        Fri, 11 Aug 2023 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691771876; x=1692376676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT/SmJhISmZKZXN9VK1TnacIwXyQQJWpUU7uVo+Tn1Y=;
        b=V4G6qJfzXhgLZduK+jHGALXK+pNctrhszcOTkE65wM8+Ux7NuscXIiaTud4WkNTNOa
         TSWsmBFf8A8FWWFHA05pGLL9eB1nCJcjoGlUf+cK76vCXRTPBfFBmlJDPmoJcg+kH2go
         7wpQTMWRxwqux2HgussrxC6lbsWLhTcRzChznxXXsFpc6UQfCL/70yVBijDOpnbj4hXX
         3vqtnePoYbyYGCDOqN7u7YoRUM+ksxaJgCs2R2JeXEg/2ZhS1XEK7asq40PuU/GEg3ai
         9UyxbRgKXNjpDCCDrcSjdlvYZMJD5Kh99Aj70i3IyAqtUL+EI4f1gTV8tbKdIgRwWNm9
         mdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771876; x=1692376676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT/SmJhISmZKZXN9VK1TnacIwXyQQJWpUU7uVo+Tn1Y=;
        b=i3uhZdS/BYfoxoN+MSajt3E5aE0Od/0q3zsjofmo29cmjRQtfC+mAn19NBMbzwLSKw
         lg5TkDCGEz+yR8sVYYZC8TPsGUtHTcf9S5oehB5wVIx2lleJ1z7DelHC/QqcngI5E2ad
         C5VFpuasdfhJ07jLNPBXnVXxHzkPI4sMFubCBdm88vUVn8390mA3XY5aF0t4+QRyMmRA
         GIRyYSjb25Rr9OgFC8LLShmVv+RsCrBlACut38bkF2UVTGaVo0gVq1LPs3efkebO94k2
         Rqp7aJbdgbMh34Z0/ylCIriDOxU73qZB3G5eIHUEhygPy1ODTFaDSqoT04NdMRVGBzEc
         tWsg==
X-Gm-Message-State: AOJu0Yx1wGU8Cjr4Lha6UuYVfe6SQZhMnILymNYhgb/fFszk7HTQOPll
        VaP+RRSJOHtjeFFkfXto1Xea4EIIurlZ1cS4pnI=
X-Google-Smtp-Source: AGHT+IH6+8ONwhE6CktCQhdjK3oK4cF89EDdZADFIS/Q6JElEuvXjVagjwV/Ofm16PJVLXwTcOmzrbpQohWQNuLXMKw=
X-Received: by 2002:a05:6402:799:b0:51d:95f2:ee76 with SMTP id
 d25-20020a056402079900b0051d95f2ee76mr1958836edy.27.1691771875598; Fri, 11
 Aug 2023 09:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230811160505.174574-1-robdclark@gmail.com> <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
 <d400c787-3c81-4e37-b541-371d6096cf7e@linaro.org> <CAF6AEGuHKuW_LGYfC640fBHsf3xzxSiyqL0YVpb5HqE=HSiL4w@mail.gmail.com>
 <39ffcd61-eb56-41c5-ac43-9ace2595c11b@linaro.org>
In-Reply-To: <39ffcd61-eb56-41c5-ac43-9ace2595c11b@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 11 Aug 2023 09:37:43 -0700
Message-ID: <CAF6AEGu+NJ-7zte3Cnfr9SG_EcED0oZQag34exi4W-_u80zzGg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 9:31=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 11.08.2023 18:21, Rob Clark wrote:
> > On Fri, Aug 11, 2023 at 9:11=E2=80=AFAM Konrad Dybcio <konrad.dybcio@li=
naro.org> wrote:
> >>
> >> On 11.08.2023 18:09, Rob Clark wrote:
> >>> On Fri, Aug 11, 2023 at 9:05=E2=80=AFAM Rob Clark <robdclark@gmail.co=
m> wrote:
> >>>>
> >>>> From: Rob Clark <robdclark@chromium.org>
> >>>>
> >>>> There isn't actually a a690_gmu.bin.  But it appears that the normal
> >>>> a660_gmu.bin works fine.  Normally all the devices within a sub-
> >>>> generation (or "family") will use the same fw, and a690 is in the a6=
60
> >>>> family.
> >>>>
> >>>
> >>> possibly this could be considered as:
> >>>
> >>> Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> >> For a lack of a better response, "meh"
> >
> > It would help route the change back to 6.4.y so we can stop explaining
> > to folks that they should create a symlink ;-)
> Ok fair!
>
> >
> >> Other than that:
> >>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
> >> Perhaps we could take this further and do something like
> >>
> >> if (failed to load gmu fw)
> >>         try loading "gmu.bin"
> >
> > that (loading random fw) sounds like a bad idea.. plus gmu.bin doesn't =
exist
> I guess we still should hear from Qualcomm on this one, but I
> do believe that "aXYZ_gmu.bin" is really "gmu firmware, tagged
> at aXYZ release". They're even versioned and adreno-gpulist.h
> downstream contains the minimum version for each SKU.

We definitely can't use a660_gmu.bin as is on a630 family devices, for
example.  Maybe that is just down to sw <-> fw interface changes but
it means linux-firmware would still need to keep separate a630_gmu.bin
and a660_gmu.bin, otherwise new l-f with old kernel would explode.

That doesn't mean they are unrelated.. I think they probably just
branch the fw for each family.

BR,
-R

> Konrad
