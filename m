Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C07E62DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjKIEfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjKIEf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:35:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED183269F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:35:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so565583a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 20:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699504525; x=1700109325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTb319PKi1K5hE3fGXAxhdTNxkLrwLwVOwF53ZkG1AY=;
        b=A+CqDKRlVQF8xCSk4e89jU+FPYnOj7ChazdRTzIaEpb5Y+b/kaCNp9WjmfZyxFmN0a
         /cnbFhxFBK7GROBZtCJ10DROUkbeJffw61KxfjQU29OXb88VlnFVItFCq/fAf1qzE/A2
         /gpLyuY6WY1zKyoUKQ5WuNHi1SRlXsR5CSy8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699504525; x=1700109325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTb319PKi1K5hE3fGXAxhdTNxkLrwLwVOwF53ZkG1AY=;
        b=VtKF3jICGWtdENvxwmK17FLaUhrBjZ92AzdvcovHoj05rg0ufYGcURnL7ZTDHF6xym
         2qdCozcLucg+WJMn9ubPYUDiD4iytc/hWQ6YAW3f5scH0i5fsqsk7MuFwFSnanZSvdKi
         iC6Q0W/TMxe4GVzfqYQV7JvkvQianmQ61LMWWa9DGEZr/e8NpxWkN8WbvubF7v5MoB7n
         vSvadhBQxiebIeh9jp/+yvXWHByzoL3DWpUUrrYzwXjD09ltgTrOVN+XQpGqfhsY0LKq
         lWkOjl2O8pWbETpsF2SQ/dDNEOuEZQb/D9tL46RAYdlxPwWnyBqPw5irL7s9Y/upfJ/T
         ADxg==
X-Gm-Message-State: AOJu0YziHwcJYHUMP71elTDThXvsppgM01hEVQkV71ePWayeCbQvRcpg
        zmegTFNN+5DvikJ1mpFD+NZHr95A2PC9s26x5zm86AjJiCQ=
X-Google-Smtp-Source: AGHT+IGA2OndrTmtlqt71ZuDAqiaDkL48pUi3+Rw6x1g/63SyQ2Jd68r59/guxTE3AX0Z+YHPI6DFw==
X-Received: by 2002:a17:907:60c9:b0:9be:b41d:4f7e with SMTP id hv9-20020a17090760c900b009beb41d4f7emr3272624ejc.17.1699504525269;
        Wed, 08 Nov 2023 20:35:25 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090606d400b009930042510csm2009304ejb.222.2023.11.08.20.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 20:35:25 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9d242846194so73037166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 20:35:25 -0800 (PST)
X-Received: by 2002:a05:600c:4ecd:b0:405:7400:1e3d with SMTP id
 g13-20020a05600c4ecd00b0040574001e3dmr3298654wmq.32.1699504062425; Wed, 08
 Nov 2023 20:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-6-benjamin.gaignard@collabora.com> <20231108085016.3kmhmdroh4qs53f5@chromium.org>
 <795ef94f-23d3-433e-b5a3-0a2e0ab7a18c@collabora.com>
In-Reply-To: <795ef94f-23d3-433e-b5a3-0a2e0ab7a18c@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Nov 2023 13:27:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dd_w50ppjy1_wQ2yX+Qj0mOMWbhJKsJ7Cq6zYsQ+GwyQ@mail.gmail.com>
Message-ID: <CAAFQd5Dd_w50ppjy1_wQ2yX+Qj0mOMWbhJKsJ7Cq6zYsQ+GwyQ@mail.gmail.com>
Subject: Re: [PATCH v14 05/56] media: videobuf2: Access vb2_queue bufs array
 through helper functions
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 7:24=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 08/11/2023 =C3=A0 09:50, Tomasz Figa a =C3=A9crit :
> > On Tue, Oct 31, 2023 at 05:30:13PM +0100, Benjamin Gaignard wrote:
> >> This patch adds 2 helpers functions to add and remove vb2 buffers
> >> from a queue. With these 2 and vb2_get_buffer(), bufs field of
> >> struct vb2_queue becomes like a private member of the structure.
> >>
> >> After each call to vb2_get_buffer() we need to be sure that we get
> >> a valid pointer in preparation for when buffers can be deleted.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   .../media/common/videobuf2/videobuf2-core.c   | 151 +++++++++++++---=
--
> >>   .../media/common/videobuf2/videobuf2-v4l2.c   |  50 ++++--
> >>   2 files changed, 149 insertions(+), 52 deletions(-)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers=
/media/common/videobuf2/videobuf2-core.c
> >> index 968b7c0e7934..b406a30a9b35 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >> @@ -408,6 +408,31 @@ static void init_buffer_cache_hints(struct vb2_qu=
eue *q, struct vb2_buffer *vb)
> >>              vb->skip_cache_sync_on_finish =3D 1;
> >>   }
> >>
> >> +/**
> >> + * vb2_queue_add_buffer() - add a buffer to a queue
> >> + * @q:      pointer to &struct vb2_queue with videobuf2 queue.
> >> + * @vb:     pointer to &struct vb2_buffer to be added to the queue.
> >> + * @index: index where add vb2_buffer in the queue
> >> + */
> >> +static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buff=
er *vb, unsigned int index)
> >> +{
> >> +    WARN_ON(index >=3D VB2_MAX_FRAME || q->bufs[index]);
> > nit: Would it make sense to also ensure that vb->vb2_queue is NULL?
>
> Since vb->vb2_queue and q->bufs[index] are always set and clear in the sa=
me
> functions I don't think it is useful to test the both here.
>

Well, they are if the caller is not buggy. But I suppose the check is
to detect buggy callers?

For example, an m2m driver could accidentally call this on a buffer
that was already added to another queue.

Best regards,
Tomasz
