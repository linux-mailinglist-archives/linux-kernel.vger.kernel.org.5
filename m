Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573D809AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573138AbjLHEW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:22:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579D171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:23:03 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4649c501c1fso451198137.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702009382; x=1702614182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDZS0haLyzX2rMNjByhL90PK2pxpUuZrfSW8MqJOxn0=;
        b=XtWDFCWbQg0pUopTWDb4SoMrtPlILpOvJMIq1lNgBIx0eBEWTfwU7Gm+fXRKJJVo0l
         zujCcdAl2kImPGqM9EAwtgz04Amk7wiKA5Ydy40WsYdzaHx8695VEzfjJ6ZO9u+ewB4G
         imMKiGL3uIpZHHwS6+vjohj/gEHRdqawJ3/HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702009382; x=1702614182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDZS0haLyzX2rMNjByhL90PK2pxpUuZrfSW8MqJOxn0=;
        b=SktiSX5XEIQ+V8dAyQMjc8hhhWbt+xZ9bQaBvCGS09kJqejI8YnBtdw+wHV57jzmvR
         uxOqoJAAB8eJDM5iq2NwKUffiBjgSTgnrpNlvEu9y4onrQS9i2EKqr8VI+8J5k8GhARF
         0CNooOeIDZPUp5zZncBTkOr1+jDLZi8x4sSK2gvwMp2sBeC43Jo1kUUJl5gDGFy74SKE
         7VbtBL71CgAFiLZRiRCUd9MIGB3mF8fbPkNs6KECRS0QlTRE5p9w0RyVS/dQQteKnfWa
         U7XwVmfu7fcAAWikOQlnVhjxoEGRuxO2Vn5ZzZxZY/7o5nF4iLZr4HWE9fMmeQmDVGUl
         VyIw==
X-Gm-Message-State: AOJu0YwoUnTLStKFC6tpoRcaYF5X6Mo0cZ9dVc05n938hZkN4OLcuCSX
        AYjf0Ev+h9vzsPaeWoocZhKC04iFeLHE1pnLuME=
X-Google-Smtp-Source: AGHT+IEYczmt8n0SMp79RQnkEEltg27a57Islx+CXxzPvBIm+RPRIfstqOtGvw4IAgxHeBYdxAlzdw==
X-Received: by 2002:a05:6102:238e:b0:464:9e20:d51d with SMTP id v14-20020a056102238e00b004649e20d51dmr3804107vsr.11.1702009382361;
        Thu, 07 Dec 2023 20:23:02 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id z14-20020ab0224e000000b007a028f8fffesm84247uan.19.2023.12.07.20.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 20:23:01 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7c5a2b5e77bso399423241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:23:01 -0800 (PST)
X-Received: by 2002:a67:e893:0:b0:464:7c8c:e17d with SMTP id
 x19-20020a67e893000000b004647c8ce17dmr3179679vsn.9.1702009381069; Thu, 07 Dec
 2023 20:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20231113123049.4117280-1-fshao@chromium.org> <20231113123049.4117280-4-fshao@chromium.org>
 <6c693161-0e89-4f9d-9a92-18f3783eefd2@collabora.com> <CAC=S1nhp3HoKGQr1UgKtZJ9SLMqvm-G_YZi9dEWWF3tj2d=OFQ@mail.gmail.com>
 <6046a40b-800c-4bf8-ab45-d7f1015b2d9c@collabora.com>
In-Reply-To: <6046a40b-800c-4bf8-ab45-d7f1015b2d9c@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 8 Dec 2023 12:22:24 +0800
X-Gmail-Original-Message-ID: <CAC=S1niMVxoryzg6X+vFcDpMRuO6YCzUFj4A+2yex+mfOBALRg@mail.gmail.com>
Message-ID: <CAC=S1niMVxoryzg6X+vFcDpMRuO6YCzUFj4A+2yex+mfOBALRg@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: mediatek: vcodec: Fix mtk_vcodec_mem_free()
 error log criteria
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:55=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/12/23 12:17, Fei Shao ha scritto:
> > Hi Angelo,
> >
> > On Wed, Dec 6, 2023 at 6:19=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 13/11/23 13:26, Fei Shao ha scritto:
> >>> mtk_vcodec_mem_free() shouldn't print error if the target DMA buffer =
has
> >>> never been allocated or was freed properly in the previous call. That
> >>> makes log confusing.
> >>>
> >>> Update the error path to print log only when the caller attempts to f=
ree
> >>> nonzero-size buffer with VA being NULL, which indicates something ind=
eed
> >>> went wrong.
> >>>
> >>> This brings another benefit that the callers no more need to check
> >>> mem->va explicitly to avoid the error, which can make the code more
> >>> compact and neat.
> >>>
> >>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>
> >> I think that this error is supposed to catch two issues in one:
> >>    - We're called to free no memory (something that does make no sense=
),
> >>      this may happen for example when calling xxx_free() twice, and it
> >>      is a mistake that *must* be fixed;
> > When I made the change, I was thinking of kfree() that doesn't warn
> > against a NULL pointer.
> > I imagine mtk_vcodec_mem_free() calls with NULL VA and mem size 0
> > probably have the similar nuance (if the buffer exists, free it; never
> > mind otherwise), but I could have missed some important differences
> > specific to the MTK vcodec driver.
> >
> > Looking at the mtk_vcodec_mem_free() usages, almost every one of those
> > checks VA beforehand, but nothing else - they don't warn or do
> > anything special when they encounter a NULL VA, and they should if
> > that's a concern.
> > Some even don't check at all (and I think that's why I ended up seeing
> > the errors mentioned in the cover letter). As for that, I think
> > there's nothing else we can fix except prepending "if (mem->va)".
> > So from all this, I feel perhaps we don't need to worry much about
> > those NULL VA, and we can further remove the checks (or at least move
> > it into mtk_vcodec_mem_free()) to trim the lines in the driver. That's
> > the reason for patch [4/4].
> >
> > Not sure if that makes sense to you.
>
> What you say does make sense - and a lot - but still, I think that freein=
g
> a NULL VA (=3D freeing nothing) is something that shouldn't happen...
>
> >
> >>    - We're failing to free memory for real (which you covered)
> >>
> >> ....that said, I think that if you want to clarify the error messages
> >> in this function, it should look something like this:
> >>
> >> if (!mem->va) {
> >>          mtk_v4l2_err(plat_dev, "%s: Tried to free a NULL VA", __func_=
_);
> >>          if (mem->size)
> >>                  mtk_v4l2_err(plat_dev, "Failed to free %lu bytes", me=
m->size);
> >>          return;
> >> }
> > Sure, I can revise the patch with this, but I also want to make sure
> > if the NULL VA print needs to be an error.
> > If you still think it should, I guess I'll drop the current patch
> > [4/4] and instead add the check before every mtk_vcodec_mem_free()
> > calls. This should also work for the issue I want to address in the
> > first place.
> >
>
> ... because if you notice, some of the calls to mtk_vcodec_mem_free() are=
 not
> checked with `if (something->va)` beforehand, so I think that those are c=
ases
> in which freeing with a NULL VA would actually be an indication of someth=
ing
> going wrong and/or not as expected anyway (checking beforehand =3D error =
won't
> get printed from mtk_vcodec_mem_free(), not checking =3D print error if v=
a=3D=3DNULL)
>
> It's an easy check:
> cd drivers/media/platform/mediatek/vcodec
> grep -rb1 mtk_vcodec_mem_free
>
> P.S.: h264_if, av1_req_lat :-)
Yes, these are exactly what I wanted to imply in ">> Some even don't
check at all", and I should have pointed them out to avoid
ambiguity...
And I understand your concern. Presuming the NULL VA case is and will
always be safe to ignore can be too assertive, and getting explicit
error logs is always better than lurking bugs.

>
> That's why I think that you should drop your [4/4] - unless MediaTek come=
s in
> stating that the missed checks are something unintended, and that every i=
nstance
> of VA=3D=3DNULL should print an error.
>
> I honestly wouldn't be surprised if they did so, because anyway this occu=
rs only
> in two decoders...
Agree, it would be nice if Yunfei can share some thoughts here, or I
can reach out to him through other channels for alignment first, and
adjust this series based on the response.
The h264_if part was written a while ago (2016) and the av1_req_lat
part is relatively new (mid 2023), I hope it won't be too hard to
reach a conclusion for those.

Regards,
Fei

>
> Regards,
> Angelo
