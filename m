Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF299808687
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378950AbjLGLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378884AbjLGLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:18:32 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F520A3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:18:38 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4b2d64a368aso325774e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701947917; x=1702552717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtRAp/Zuzq7fGbpcbPcumzgHdraAjC7L39RpTXDHPvw=;
        b=cKUQhQTJ32lgveuo8CgQWvVy6nSpDP4PuSKt/CDSEvtPirm+8NxIPCfoSFUOcaGXwz
         PChLiRWSZVcR+VXujHkLVOv/IJd19b2+dcBaL/H1CuCtE1hQrq8t/A5xN/aPkjtdjBIT
         Y28yV7ByOW9Y3wlREo8j8cilqnD5vCWEH0MOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947917; x=1702552717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtRAp/Zuzq7fGbpcbPcumzgHdraAjC7L39RpTXDHPvw=;
        b=ojerlnOSg/fMzKUETBrdNaUQ1RXFP9g8rhjFgKzl3VRpfcxINmYXB0Nu9bvA26x1VG
         75meTfWhmKTHW5eWjLfZRB/Oy4rq6S3UgXyyBcP35LJKka2hWW9UT4OaFZ2LmThX3nOP
         tXsxUobv1+8Ng6kcMYSp1IQNhjvkEvNI3xCR9KaeI8If8wG0nEPHztFsvCwzVG7lEAwQ
         q3EyamjqhLj4bYgA02maGQHMfnaF7VosKGhaNlj6kFjXxUVWUm5tpMzmUIOMI269oX7a
         /5p+K4jJmDdC2Ctfp7+bRplh0NqW9Y78VtaQE74NF/wD8Ndo4qiWKRIH1z+SHAH5PmxK
         sS2A==
X-Gm-Message-State: AOJu0Yx2QQDyAyFwUouAIlrb5Sl8r0Z+TSTN1xqh/yBpMvmLiANHB5Hd
        ng+zqoPMeWtGSwv6FViORxb9MG3u1XQphBu8s+c=
X-Google-Smtp-Source: AGHT+IHnVoOiOebaKyusQjNHe2qAtYlvFLD3dT3rjix30RrDMyEx0nSZZWE9Mw6dar6WCAe6VW0Egg==
X-Received: by 2002:a05:6122:3685:b0:4b2:d8c3:981c with SMTP id ec5-20020a056122368500b004b2d8c3981cmr4442918vkb.1.1701947917254;
        Thu, 07 Dec 2023 03:18:37 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id x23-20020a056122119700b004b28dec2935sm51321vkn.20.2023.12.07.03.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:18:35 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b2ceee07e5so329186e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:18:35 -0800 (PST)
X-Received: by 2002:a1f:c401:0:b0:4b2:c554:ccfd with SMTP id
 u1-20020a1fc401000000b004b2c554ccfdmr1880286vkf.9.1701947914936; Thu, 07 Dec
 2023 03:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20231113123049.4117280-1-fshao@chromium.org> <20231113123049.4117280-4-fshao@chromium.org>
 <6c693161-0e89-4f9d-9a92-18f3783eefd2@collabora.com>
In-Reply-To: <6c693161-0e89-4f9d-9a92-18f3783eefd2@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 7 Dec 2023 19:17:58 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhp3HoKGQr1UgKtZJ9SLMqvm-G_YZi9dEWWF3tj2d=OFQ@mail.gmail.com>
Message-ID: <CAC=S1nhp3HoKGQr1UgKtZJ9SLMqvm-G_YZi9dEWWF3tj2d=OFQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: mediatek: vcodec: Fix mtk_vcodec_mem_free()
 error log criteria
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Dec 6, 2023 at 6:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/11/23 13:26, Fei Shao ha scritto:
> > mtk_vcodec_mem_free() shouldn't print error if the target DMA buffer ha=
s
> > never been allocated or was freed properly in the previous call. That
> > makes log confusing.
> >
> > Update the error path to print log only when the caller attempts to fre=
e
> > nonzero-size buffer with VA being NULL, which indicates something indee=
d
> > went wrong.
> >
> > This brings another benefit that the callers no more need to check
> > mem->va explicitly to avoid the error, which can make the code more
> > compact and neat.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
>
> I think that this error is supposed to catch two issues in one:
>   - We're called to free no memory (something that does make no sense),
>     this may happen for example when calling xxx_free() twice, and it
>     is a mistake that *must* be fixed;
When I made the change, I was thinking of kfree() that doesn't warn
against a NULL pointer.
I imagine mtk_vcodec_mem_free() calls with NULL VA and mem size 0
probably have the similar nuance (if the buffer exists, free it; never
mind otherwise), but I could have missed some important differences
specific to the MTK vcodec driver.

Looking at the mtk_vcodec_mem_free() usages, almost every one of those
checks VA beforehand, but nothing else - they don't warn or do
anything special when they encounter a NULL VA, and they should if
that's a concern.
Some even don't check at all (and I think that's why I ended up seeing
the errors mentioned in the cover letter). As for that, I think
there's nothing else we can fix except prepending "if (mem->va)".
So from all this, I feel perhaps we don't need to worry much about
those NULL VA, and we can further remove the checks (or at least move
it into mtk_vcodec_mem_free()) to trim the lines in the driver. That's
the reason for patch [4/4].

Not sure if that makes sense to you.

>   - We're failing to free memory for real (which you covered)
>
> ....that said, I think that if you want to clarify the error messages
> in this function, it should look something like this:
>
> if (!mem->va) {
>         mtk_v4l2_err(plat_dev, "%s: Tried to free a NULL VA", __func__);
>         if (mem->size)
>                 mtk_v4l2_err(plat_dev, "Failed to free %lu bytes", mem->s=
ize);
>         return;
> }
Sure, I can revise the patch with this, but I also want to make sure
if the NULL VA print needs to be an error.
If you still think it should, I guess I'll drop the current patch
[4/4] and instead add the check before every mtk_vcodec_mem_free()
calls. This should also work for the issue I want to address in the
first place.

And thanks for the review.  :)

Regards,
Fei

> Cheers,
> Angelo
>
