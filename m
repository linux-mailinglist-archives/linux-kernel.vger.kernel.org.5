Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC0763063
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjGZIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjGZIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:46:30 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A354ECD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:39:05 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63d30554eefso899066d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690360744; x=1690965544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMVJEruV9LE4C75mlWS0Nb+yQQsemXUAAUYYCpPIuI=;
        b=IWf8UxJcTVihLcsA4TFlENhD7ULcH/J8QQvz3LpIPT+291r2x7X2mEcDMRu9rsFS2i
         uzAnseQ77kIMUJOuq/KpVpxIyPOGu3YdRD1Iu/ZYlMrzJes8Sfp+GTFkWCrulEKCtSZH
         GX9ss5XhkbuJTiMFgnHboaZiC/ocPQNc3rvRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360744; x=1690965544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFMVJEruV9LE4C75mlWS0Nb+yQQsemXUAAUYYCpPIuI=;
        b=AQKHOL5zumfiedkIekz75GJBdPVwmhnYinFafp8jAHJQIUMQX9inPNbgSn+V8A7z0v
         jlOPk9A6mAdiKgfEdn+JUvICMr2AXt+IIqn0fdHm0IJdNWtA5A2K8Hfqgqx/7y+Pa586
         38Hwx4R8gFX3iq3f9Xb/JK+IrLK1/QieoDpTnNFKCX8LusWue+gGeOPhPH9nmNLyChoW
         wvfJnByZ4OtRhAjdv89smuaDkrla40W8ELImCrI45Y38sDPLmHgHOB6gHYNLARcnW2np
         /Z7V56L7f6naPfjQczFoKFDWiIzFoLLWks0+RKuZqcW5umgrg4a7XK2xx7aTDdKCCyHA
         B+FA==
X-Gm-Message-State: ABy/qLY/g6XRjCMNKEpIi4U4/YR4iBoBB0GO+vq5wiRv+70czEAxc1Am
        StacN3lArJPlKOTSi7lPhEahDv41q1OgrglyoblZ8A==
X-Google-Smtp-Source: APBJJlEGiaUywGCmaNYszPALFU773pTdtso8TsiY/u4+zHIYqBgpCQpkfhscxyazpu1MT1uTBaytyQ==
X-Received: by 2002:a0c:f294:0:b0:63c:f0af:14f6 with SMTP id k20-20020a0cf294000000b0063cf0af14f6mr1194642qvl.65.1690360744400;
        Wed, 26 Jul 2023 01:39:04 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id t27-20020a0cb39b000000b0063cdeac3419sm4093780qve.110.2023.07.26.01.38.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:38:58 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-63cf3dcffe0so25051076d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:38:53 -0700 (PDT)
X-Received: by 2002:a05:6214:16cc:b0:62f:f2f0:2af3 with SMTP id
 d12-20020a05621416cc00b0062ff2f02af3mr1247360qvz.41.1690360732250; Wed, 26
 Jul 2023 01:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
 <20230725213451.GU31069@pendragon.ideasonboard.com> <CANiDSCttkqows7PZS823Jpk-CqK9Gz2rujF_R4SPDi=wcPJ2LA@mail.gmail.com>
 <20230726080753.GX31069@pendragon.ideasonboard.com> <952fb983-d1e0-2c4b-a7e8-81c33473c727@leemhuis.info>
In-Reply-To: <952fb983-d1e0-2c4b-a7e8-81c33473c727@leemhuis.info>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Jul 2023 10:38:40 +0200
X-Gmail-Original-Message-ID: <CANiDSCvVag+sW5JDTKAPuML_-+6xHWgF+NeKoBKSd5MMr1Yiag@mail.gmail.com>
Message-ID: <CANiDSCvVag+sW5JDTKAPuML_-+6xHWgF+NeKoBKSd5MMr1Yiag@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix OOB read
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>,
        =?UTF-8?Q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten

On Wed, 26 Jul 2023 at 10:33, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 26.07.23 10:07, Laurent Pinchart wrote:
> > (CC'ing Kai and Thorsten who have added the check to checkpatch)
> >
> > On Wed, Jul 26, 2023 at 08:24:50AM +0200, Ricardo Ribalda wrote:
> >> On Tue, 25 Jul 2023 at 23:34, Laurent Pinchart wrote:
> >>> On Thu, Jul 20, 2023 at 05:46:54PM +0000, Ricardo Ribalda wrote:
> >>>> If the index provided by the user is bigger than the mask size, we might do an
> >>>> out of bound read.
> >>>>
> >>>> CC: stable@kernel.org
> >>>> Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
> >>>> Reported-by: Zubin Mithra <zsm@chromium.org>
> >>>
> >>> checkpatch now requests a Reported-by tag to be immediately followed by
> >>> a Closes
>
> Not that it matters, the changes I performed only required a Link: tag,
> which is how things should have been done for many years already. It
> later became Closes: due to patches from Matthieu. But whatever. :-D
>

I prefer to leave the Reported-by and remove the Closes, that way we
credit the reporter (assuming they approved to be referred).

But if that is not possible, just remove the reported-by. A private
link is pretty much noise on the tree.

Thanks!

> >>> tag that contains the URL to the report. Could you please
> >>> provide that ?
> >> I saw that, but the URL is kind of private:
> >> Closes: http://issuetracker.google.com/issues/289975230
> > Ah :-S I wonder if we should drop the Reported-by tag then ?
>
> That's what I do, unless the reporter granted his permission. To quote
> Documentation/process/5.Posting.rst : ```Be careful in the addition of
> tags to your patches, as only Cc: is appropriate for addition without
> the explicit permission of the person named; using Reported-by: is fine
> most of the time as well, but ask for permission if the bug was reported
> in private.```
>
> I heard of on instance where a GDPR complaint was filed due to a
> Reported-by: tag. So maybe that part should be even revisited reg. the
> Cc: aspect. :-/
>
> Ciao, Thorsten



-- 
Ricardo Ribalda
