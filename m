Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4EF79109D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351888AbjIDEuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjIDEuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:50:01 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A459B;
        Sun,  3 Sep 2023 21:49:58 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a0254de2fdso298536241.1;
        Sun, 03 Sep 2023 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693802997; x=1694407797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iacGK+V2SyI7u62NbaMeNw3cu42K5/MOVGdVpsBcQr4=;
        b=eaQIkP+Bj8DKeudOBnZM4rWwWYme9HVcqV8qEzos/0FQKovM7u3fBGeAwS1zwyoa6s
         4J4Why4DmfFKCK/Pn4OWw/J4Xm9anhOOcHNIQJQ3Axv5qjtP1qZV/4t/C16uYqPiuAR3
         TPjXH9OzwLZouhleTBPWfKkaxny1gnRMVdhBf2V2s6wN+JdmKCRTOHIi+jM/WDBfHyQn
         hLFddyrkegHWOdHJqRdNrBIL6HareTfFPZclk0IDUnAiKGgGVP1bONzuFex0ntRuxFtR
         DwiHYWWQgWCGaE2nZ31Yq8mu6Tzgz5q94JFU8+ZIcd1CL+FW/3eog3XFazNcDqIH2fBm
         ikDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693802997; x=1694407797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iacGK+V2SyI7u62NbaMeNw3cu42K5/MOVGdVpsBcQr4=;
        b=PR4m0m6cKA3Ao5sLqJLkptohwBEnVTa4bgeztk1rh447PkUhiyp+73Tum1Q5PU+v3u
         ITuPWXGezdVsYzVixwRgNM+cWQXIYuh26Vbit9V85z3TC4BQn+Qyj2I70sks6rtITONT
         dygdAd+8IUAwwWfxF+PYHuOQdrJt+l8Sb2tiFrW793XAXWZx67Bp5TEc61L3xGdMPhvT
         qalPz//GSiAfkJx1/V89QbRtQ+pVeNPV76YaAVkg5U3m4o9y/VXGXwCzp81+CuEv+LPU
         qwtRS+wSN8ukW03gaYCcZA1sjyZSVXBkOATH4f7ElcM+Pb0qooIFoL3P9+5xMQLNqwrw
         SoWg==
X-Gm-Message-State: AOJu0Yz9h3BhsjqQV4kZDA0SweZsozjYI21IdPHoIuCOx4Eu0Rb5guHj
        dbEKm5AQ+R1jVc1M1WV4zklwK66KrnMdeGB8nlBreq89
X-Google-Smtp-Source: AGHT+IEzJp2QEDITKv7Z+jdponAfIao6TEeQ9Rfl7fRLOLifmlMjC+/WEbeYvphjh6RikNhq5bcaorABVRljL2aKGqU=
X-Received: by 2002:a05:6102:3a56:b0:44e:b30a:c0da with SMTP id
 c22-20020a0561023a5600b0044eb30ac0damr7596914vsu.26.1693802997437; Sun, 03
 Sep 2023 21:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828091859.3889817-1-milkfafa@gmail.com> <20230828091859.3889817-8-milkfafa@gmail.com>
 <0c91f68d-d172-bd14-9115-b6977ad2d01f@xs4all.nl> <CADnNmFqVbRWs5Uf_tJdrM0AopF_CmSHYwBK8-+1go_K6Hefkcw@mail.gmail.com>
 <ecc13f10-82b9-f99b-8ebf-ff505d65fe2e@xs4all.nl>
In-Reply-To: <ecc13f10-82b9-f99b-8ebf-ff505d65fe2e@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 4 Sep 2023 12:49:46 +0800
Message-ID: <CADnNmFoRjyHghQPA72HUmmCEr81oUBJPDG+QtuTFaem_imNB=Q@mail.gmail.com>
Subject: Re: [PATCH v14 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the reply.

> > When userspace dequeues the 1st buffer (video->list[0]), it needs to
> > know the count of HEXTILE rectangles in the buffer,
> > so after dequeuing the buffer it will call this control to get the
> > rect count (video->rect[0]). And when a buffer is dequeued,
> > npcm_video_buf_finish() will be called, in which the buffer index (in
> > this example, buffer index = 0) will be stored to video->vb_index.
> > Then when userspace calls this control, npcm_video_get_volatile_ctrl()
> > will return the rect count of vb_index = 0.
> > In this way, I think userspace is always reading the correct control's
> > value even if userspace is slow.
> > Does it make sense to you or is there anything I missed?
>
> Ah, I don't think I have ever seen anyone use buf_finish in that way!
>
> Very inventive, and perfectly legal. Actually a very nice idea!
>
> So, with that in mind there are still some things that need to change.
>
> First of all, you can drop the 'VOLATILE' flag from the control, instead
> just call v4l2_ctrl_s_ctrl() from buf_finish() to update the control.
> And in stop_streaming the control value should probably be set to 0.
>
> The use of volatile for a control is a last resort, and in this case it
> is not volatile at all.
>
> Secondly, this behavior has to be documented: in buf_finish add a comment
> along the lines of: "This callback is called when the buffer is dequeued,
> so update this control with the number of rectangles."
>
> And where the control is defined, refer to buf_finish to explain where it
> is set.
>
> Finally the user-facing documentation has to be updated (npcm-video.rst)
> to explain this behavior.

OK. Will drop the VOLATILE flag and update comment/document in the next version.

Regards,
Marvin
