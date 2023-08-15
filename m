Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B877CC43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjHOMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbjHOMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:02:29 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466CB0;
        Tue, 15 Aug 2023 05:02:25 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-447d394d1ebso4144769137.1;
        Tue, 15 Aug 2023 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692100945; x=1692705745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7VZKftEzDye9TscT4naX9QKoF2fRXcn75T62khYWWQ=;
        b=kHJJ+YQzAjdBTWqM+jTaA28DDuduIOmeVIXpjNAxaIzEhEwvkEd46GjFTqAtrQ/5g6
         EB1vOL2dIeeXoRkOFq8w+Q1Y48BEyCdfsvTG0tKeVS3TPj32zDyikBiLccjWfDKaoH52
         Pv6te7bjbzUzKMMFaeXsD42CVKKjiDVbwRphDPjH8NWOFb8qslNtI2FH+SjFa7EoXAig
         zPgR7OXFYCeSa1vtUPiS3iYru2GL8kK1nEaUqthS+snQ5tpIDtrLHNjgfxSvtQxFMwOF
         ki2VqLZp4f89v4tELG1ksdhDepZGox+b7w+BIA/SNTc08lMTuNlHLkRzzC79vdXWd44j
         gAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100945; x=1692705745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7VZKftEzDye9TscT4naX9QKoF2fRXcn75T62khYWWQ=;
        b=O4ylsPBKQOK4ppjwGHUitruZxFMeVjS0yiQAuCJpnS7TQrFyOIrLVwFdKM9OG0BMwN
         TJNQY+DDsbYWd4g1yD2EXJcjgS7x/F/0C5V6iUn4BWfTzIyhj+1M3L0+RYTq31fUgdte
         mCg8hYSoKwkNJr8SHcQ+DYj6KF3S059MUSEbW51xlinqnSmifgswbp9FP4JliHVokVz7
         eBBR05xk2dtGnKLII3ilkC266L0w9Z7LTWc8xSffqwKvxcKF8Y6+xtJrFu9D+rJkmLsL
         uuyEZtvsAJ/X5tI+x8BdvPjgUbv/wZsjDmgF4ZuTf0vwo+ZhHNxsY9MkqBqhQ0ZznAdj
         dhzA==
X-Gm-Message-State: AOJu0YwA/9Heznpk20LSEoFwBtvQtZtpetgcCgozadBLa/5osS63/lmC
        VehCeF1TrZCD+RcYQRcZJUFpM8UVZnguwrAXuTJMZXgHZpzcSA==
X-Google-Smtp-Source: AGHT+IHlWJSL+v1L2lw9VEENTbd7+FniMTJi4YOpjY9+FnmdrwanOpKWjo5sk5MiM49brs0DzL3buQvWYYu/r6wP7K0=
X-Received: by 2002:a05:6102:418d:b0:445:4a0c:3afb with SMTP id
 cd13-20020a056102418d00b004454a0c3afbmr1843814vsb.8.1692100944625; Tue, 15
 Aug 2023 05:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064412.2145181-1-milkfafa@gmail.com> <20230704064412.2145181-8-milkfafa@gmail.com>
 <d28bd991-5a28-6f0d-a8d6-64169ff7a698@xs4all.nl>
In-Reply-To: <d28bd991-5a28-6f0d-a8d6-64169ff7a698@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Tue, 15 Aug 2023 20:02:13 +0800
Message-ID: <CADnNmFoxgFZi3c9wGoERW4rrPBvMiGyBvUZ7YFu=MpVHbS97pg@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] media: nuvoton: Add driver for NPCM video capture
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

> > can compress the frame data into HEXTITLE format. This driver implements
>
> HEXTITLE -> HEXTILE

> > +       data into HEXTITLE format.
>
> Ditto.

> > +     video->active_timings = video->detected_timings;
>
> Why not let npcm_video_set_resolution() set active_timings?
> And also update pix_fmt? That will also simplify npcm_video_set_dv_timings().

> > +     .type = V4L2_CTRL_TYPE_INTEGER,
>
> This must be of TYPE_MENU. It selects between two
> modes, so that is typically a MENU control. That way you can list
> the possible modes and get a human-readable name for each setting.

These problems will be addressed in v14.


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
> I'm wondering if this shouldn't be an INTEGER array control.
> Either dynamic or just fixed to size VIDEO_MAX_FRAME. That way
> you can set the rectangle count for each buffer index. You wouldn't
> need this to be volatile either in that case.
>
> I don't really like the way it is set up now since if userspace is
> slow in processing a frame the control might have been updated already
> for the next frame and you get the wrong value for the buffer you are
> processing.

When userspace app dequeues a buffer, it needs to know the count of
HEXTILE rectangles in the buffer,
so app will call this control to get the rect count after dequeueing the buffer.

And when a buffer is dequeued, npcm_video_buf_finish() will be called,
in which the buffer index (vb->index) will be stored.
Then when userspace app calls this control,
npcm_video_get_volatile_ctrl() will return the rect count of the
desired buffer index.
In this way, I think the buffer index is always correct even if
userspace is slow.


> > +     if (*num_buffers > VIDEO_MAX_FRAME)
> > +             *num_buffers = VIDEO_MAX_FRAME;
>
> You can drop this test, it's done automatically by the vb2 core.

> > +     for (i = 0; i < *num_buffers; i++)
> > +             INIT_LIST_HEAD(&video->list[i]);
>
> This is incomplete: if VIDIOC_CREATE_BUFS is called additional buffers can be added.
> In that case this function is called with *num_planes already set and *num_buffers
> being the additional buffers you want to add. So in the 'if (*num_planes)' code
> above you need to take care of that.
>
> However, isn't it much easier to just have a fixed 'video->list[VIDEO_MAX_FRAME]' array
> rather than dynamically allocating it? It would simplify the code, and all you need to
> do here is call INIT_LIST_HEAD for all (VIDEO_MAX_FRAME) array elements.

> > +     video->num_buffers = *num_buffers;
>
> You can drop the num_buffers field: just use the num_buffers field of vb2_queue.
>
> This code is incomplete anyway since it doesn't deal with VIDIOC_CREATE_BUFS.
> Much easier to just rely on the vb2_queue information.

Will modify as you suggested. Thanks.

Regards,
Marvin
