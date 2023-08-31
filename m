Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC878ED79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjHaMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjHaMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:42:54 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8795D1A4;
        Thu, 31 Aug 2023 05:42:48 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48cfdfa7893so314405e0c.0;
        Thu, 31 Aug 2023 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485767; x=1694090567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1xOciFEJ8HjM2SzGUTsUdShfH1iAQ0wqaSrJGRWK40=;
        b=mE1QwtBSQ1WQFDY4nQpw7W1W8yn5v+Ed8WFK2RbeAfAbAnB2TJPWsWFzt/RJUEYdmn
         q46qHkaKvCJQy8NIZodtkt7X8Lzkzjs3COhYEdMVCD9HjDJUjaF6Lx3Y/7ilM9j0gCS1
         fdr4LqWZyTVf4985UFDlNhxy0RAf5mXA1pj9+uBz6NEBHplXH6A1jS4DEqRnyu431DrA
         Zfov427vofUUOmWVbXMBRk1hF4v3kNu1v847RuozufaYJFGsL2S9xRPbb3ZL8SHOYRF5
         ZTu8tCY2spPA//Fw9hzzfUkGXmhZ0dMvoLsE0wcAOwOXgPKabVhs8TT2Ud9FWM6VsYOe
         c29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485767; x=1694090567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1xOciFEJ8HjM2SzGUTsUdShfH1iAQ0wqaSrJGRWK40=;
        b=YshPyGHqMakygFz8yGoVUZ7X2nYLTwPlNDKEJ0aFd5JA4fiIjd5YUWT2T4SnC+vpu/
         uWyNJuAQqW8dtleF/OsvvtlXupQc6D0U1xPQ8y9Pgu7b/um+OR8n441R4eVOPJrzFB0h
         da6vVEQZPDS5E526fLclFCYVlYuO3oD0zKEHbk3C2YLzmMbd3YERuy/HCvf0GcoNEvAT
         aCCy6in7pQ9uOFf4EsxckzIwcsCTNKCEvdS9V0UtllgXDsRA2aVkJRHIQeH4h26AE2Dv
         ZdGYGh8EAQ9C6bvZhnxSeDREyPX9yyGvcRbuOJ4mVYUZZ6GcUXR89R4ldZPzsEiITp7h
         ibeg==
X-Gm-Message-State: AOJu0YxSWQ50iacODfeBi06HqyKCEhNUgNWOWEne5RnweS4NCGF+2lwC
        tQVg3jKNeLYLwJpCc+bNwYxKAnWN1Q///stAGjw=
X-Google-Smtp-Source: AGHT+IG+ZUnkpRdPLlTVk21k4SpEvZwMjipenH8jcSc0l7Lhd+kc0DKaqOWOz4BxF4hDJ9YB1nhCciRqrK+QcApXhIw=
X-Received: by 2002:a1f:ac54:0:b0:490:a0fb:e08f with SMTP id
 v81-20020a1fac54000000b00490a0fbe08fmr4010195vke.1.1693485767538; Thu, 31 Aug
 2023 05:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230828091859.3889817-1-milkfafa@gmail.com> <20230828091859.3889817-8-milkfafa@gmail.com>
 <0c91f68d-d172-bd14-9115-b6977ad2d01f@xs4all.nl>
In-Reply-To: <0c91f68d-d172-bd14-9115-b6977ad2d01f@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 31 Aug 2023 20:42:38 +0800
Message-ID: <CADnNmFqVbRWs5Uf_tJdrM0AopF_CmSHYwBK8-+1go_K6Hefkcw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the review.

> > +     snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s", DEVICE_NAME);
>
> You can drop this last line, it is already filled in by the V4L2 core for
> platform devices.

> > +static const char * const npcm_ctrl_capture_mode_menu[] = {
> > +     "COMPLETE mode",
> > +     "DIFF mode",
>
> Hmm, I would drop the 'mode' bit, since it is already obvious that
> these are the modes.

OK. Will drop them in the next version.

> > +static const struct v4l2_ctrl_config npcm_ctrl_rect_count = {
> > +     .ops = &npcm_video_ctrl_ops,
> > +     .id = V4L2_CID_NPCM_RECT_COUNT,
> > +     .name = "NPCM Compressed Hextile Rectangle Count",
> > +     .type = V4L2_CTRL_TYPE_INTEGER,
> > +     .flags = V4L2_CTRL_FLAG_VOLATILE,
> > +     .min = 0,
> > +     .max = (MAX_WIDTH / RECT_W) * (MAX_HEIGHT / RECT_H),
> > +     .step = 1,
> > +     .def = 0,
> > +};
>
> Just to confirm: you decided against using an integer array control?
>
> There is a real danger that if userspace isn't reading this control
> quickly enough (i.e. before the next frame arrives at the driver), then
> the control's value is that of that next frame instead of the current
> frame.
>
> It doesn't feel robust to me.

Actually the driver will store the frames and counts for each buffer
index till userspace dequeues them.

Ex. assume that driver has captured 3 frames:
- 1st capture (buffer index = 0):
     video->list[0] => store the list of HEXTILE rects for the 1st frame
     video->rect[0] => store the rect count of video->list[0]
- 2nd capture (buffer index = 1):
     video->list[1] => store the list of HEXTILE rects for the 2nd frame
     video->rect[1] => store the rect count of video->list[1]
- 3rd capture (buffer index = 2):
     video->list[2] => store the list of HEXTILE rects for the 3rd frame
     video->rect[2] => store the rect count of video->list[2]

When userspace dequeues the 1st buffer (video->list[0]), it needs to
know the count of HEXTILE rectangles in the buffer,
so after dequeuing the buffer it will call this control to get the
rect count (video->rect[0]). And when a buffer is dequeued,
npcm_video_buf_finish() will be called, in which the buffer index (in
this example, buffer index = 0) will be stored to video->vb_index.
Then when userspace calls this control, npcm_video_get_volatile_ctrl()
will return the rect count of vb_index = 0.
In this way, I think userspace is always reading the correct control's
value even if userspace is slow.
Does it make sense to you or is there anything I missed?

Regards,
Marvin
