Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A817E1EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjKFKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjKFKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:51:24 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686FFBD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:51:21 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d76904928so26836126d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699267880; x=1699872680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtgWayheqWQmTYOTZT45BG+Q8huUdU08T1m1VskhD48=;
        b=jFuFIAdQJ6qrUx8xbUKbPzWtf8ymFp7C+8MajKhunWTGPv0mHU3KJUM67Jyym4WnhS
         ZrQL6MxVmzezAYtsmWl3Rmr4j+u07ZVKSUeS9GWP/XUqLZxGuW6iXEYWsaVlYapzUVqU
         g9Jzq3psBUhq+G195Zi4Iru0Q6EQp1pQ5b6qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267880; x=1699872680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtgWayheqWQmTYOTZT45BG+Q8huUdU08T1m1VskhD48=;
        b=iwLN9163/GIuu//Ic08/DVIFGH2TcatdiCSxI9qUo2tkf5ZQoY+jOjr03WpGQxgBP/
         pbWbwkNSv8bezY+DPiod73pkTIHPWM1ZdkW+x0B8E0S0XpNlRCOPnKG/LslXcxGLiltt
         4NReDi4YvYZ/sUQ7poa3uKX7KmdyIgppvMeK653+2iiPxZxji7MBjqEMlUHtMdPzzy83
         5qI3XQCqosTjHGaAGLpFoM1C4fv84rzRoBVYJhRA4XUPz9STWLDB5tjfG9rHEDjEz/hW
         kqMNpRhqsnCq5e6Vs91bJVfCrembHAPxT19OTN4vCD88NSdyfj3lYiSj/E4aHwksYsRr
         RH9g==
X-Gm-Message-State: AOJu0YxltTNsi2sQxG7ZTSpZBo92nfGhOB7pZPq5pgKmUbRXzbJRrX7m
        24gn5yQl0HC87QmeDhCxCSw8EyJdniBgjstacA8wpA==
X-Google-Smtp-Source: AGHT+IFD6mG9VAoazDt5OY1JTHKyqa/1AMLXOIroQPMKDBGm/ZFueCf43334c2+ajJOe2uC9TnOp/g==
X-Received: by 2002:a05:6214:3007:b0:66d:62a2:3281 with SMTP id ke7-20020a056214300700b0066d62a23281mr31069720qvb.39.1699267880112;
        Mon, 06 Nov 2023 02:51:20 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id j6-20020a056214032600b0066d32666a27sm3309882qvu.66.2023.11.06.02.51.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 02:51:19 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d2f3bb312so27017626d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:51:19 -0800 (PST)
X-Received: by 2002:a05:6214:3007:b0:66d:62a2:3281 with SMTP id
 ke7-20020a056214300700b0066d62a23281mr31069686qvb.39.1699267879046; Mon, 06
 Nov 2023 02:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org>
 <20231106103925.GA19272@pendragon.ideasonboard.com> <20231106104245.GB19272@pendragon.ideasonboard.com>
In-Reply-To: <20231106104245.GB19272@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 6 Nov 2023 11:51:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCsnrb5a3XTnHRrUjttcV6aAw7yC6RtUApvsK5CBhFGJyQ@mail.gmail.com>
Message-ID: <CANiDSCsnrb5a3XTnHRrUjttcV6aAw7yC6RtUApvsK5CBhFGJyQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Mon, 6 Nov 2023 at 11:42, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 06, 2023 at 12:39:26PM +0200, Laurent Pinchart wrote:
> > On Fri, Oct 20, 2023 at 06:41:45AM +0000, Ricardo Ribalda wrote:
> > > Add support for the frame_sync event, so user-space can become aware
> > > earlier of new frames.
> > >
> > > Suggested-by: Esker Wong <esker@chromium.org>
> > > Tested-by: Esker Wong <esker@chromium.org>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > We have measured a latency of around 30msecs between frame sync
> > > and dqbuf.
> >
> > Not surprising, especially for large resolutions. I'm curious though,
> > what do you use this event for ?

I think Esker is using it to get more accurate power measurements of
the camera stack.

> > It's easy to miss the ++ there when reading the code, would the
> > following be more readable ?

Actually that was my original code, but I thought you would like this better :)

Thanks for the review, a v2 is on its way.

> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
