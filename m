Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C237F70A2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjKXJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjKXJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:58:16 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA71B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:58:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7781bc3783fso88005185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700819901; x=1701424701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDs9+RNzkaGONqEPfv8Zgh88yWUl9hGvpYieCjYXUM=;
        b=gBr5SEzLB+UWXCgmNyPMlQgN7GADh4SUjx83T+XqjWS+tkt/PpLdl0Se/9pFSl6ffF
         UPFrR+3xzvauhP4peIGOCz1L4krNcU3GlX7z2ZvK2Xe0WTeWp9k4FkfKedUtJ4ASfiGP
         ODqWGZZo7UzAd8dGNY/qtPTU9VgOWCeS1P1l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819901; x=1701424701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKDs9+RNzkaGONqEPfv8Zgh88yWUl9hGvpYieCjYXUM=;
        b=s7+5vqp6+Y2ggMZ0JE6ebhRS1Bzvte7VuzHZWFU/JciVOIM7TGoA6DDBznEO6r8Uqk
         j1Vg9HnxmoqTy06O6KaUin8yI5jUuCgIkpf9X8bEY3/7cRIUzJfS7eGPoLNhFdHSv6ET
         mUv1EC5KDUqNT4Ba1TWKHaRFjBKICGP2cufV5JdTdOOAM2X7Ve4UpQDPxMGrKaPX1xX+
         LMzxLKkj6FOqSTVV6NavYcHncWihbod9E+FyM8Y9LLYKi8irqpRYCsGNnrQgwgh1micK
         jCJlI3wVg5N0Ug0qZ+0GEadXZU+EgO21djNNI13+ZbyweO4lf4VbjJVNGfk6vb0O3Kcj
         iyKw==
X-Gm-Message-State: AOJu0Ywcl4fEj6AOn/w6xFnkwObO/X71Kjo0IboxDEQw4cIq3iyp+L9N
        zkJLIgTsEj31PiFzTnkb/RyJB8Lfl1oT/V/SU2dJKw==
X-Google-Smtp-Source: AGHT+IEuBiXHgGufmT6WcbGIRQMZ0RSwFGYGMXh0LgingWJwQnrDEl0ZwT4DmjyKOvyWltWvhsPWvQ==
X-Received: by 2002:a05:620a:618b:b0:775:69b4:b4e6 with SMTP id or11-20020a05620a618b00b0077569b4b4e6mr2182185qkn.7.1700819900842;
        Fri, 24 Nov 2023 01:58:20 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id qp10-20020a05620a388a00b0077d6443ae82sm1107285qkn.83.2023.11.24.01.58.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 01:58:18 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77d631aab99so87420785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:58:18 -0800 (PST)
X-Received: by 2002:a0c:e98f:0:b0:658:23a5:e062 with SMTP id
 z15-20020a0ce98f000000b0065823a5e062mr2481527qvn.31.1700819897531; Fri, 24
 Nov 2023 01:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu> <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
 <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
 <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
 <20231109000327.GE21616@pendragon.ideasonboard.com> <CANiDSCuD=Z2FVaSnejCfLnRJXUSE99GQkK=4tRAXBbxpUqEVHg@mail.gmail.com>
 <ded0b788f5896621cffd8f64c679ef375231b6d1.camel@ndufresne.ca>
In-Reply-To: <ded0b788f5896621cffd8f64c679ef375231b6d1.camel@ndufresne.ca>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 24 Nov 2023 10:58:01 +0100
X-Gmail-Original-Message-ID: <CANiDSCsctSyfgXxH3iroJPOE7R_9jB7todiEMBCU_5OG3EOCKQ@mail.gmail.com>
Message-ID: <CANiDSCsctSyfgXxH3iroJPOE7R_9jB7todiEMBCU_5OG3EOCKQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

> >
> > For bulk devices this is a maximum of 0.05 msec (32KiB/600MBps)
>
> I lack a bit of knowledge on how to scale this to different devices, with
> different speed/framesize. My only bulk device is:
>
> https://inogeni.com/product/4k2usb3/
>
> Which is USB 3.0, and have raw (NV12) resolution from 640x480 (max 60pfs) to 4K
> (max 30fps). What would the error look like with that ?

For bulk devices the maximum delay from packing multiple packets into
a urb is 0.05 msec (32KiB/600MBps)

Laurent's message <20231109000327.GE21616@pendragon.ideasonboard.com>
explains where those numbers come from :).

Regards!

>
> > For 1MiB transfer isoc devices (which is the biggest we have seen),
> > that is 1.8 msec.
> > In both cases, this is smaller than the jitter to process the event
> > itself by userspace.
> >
> > The time from V4L2_EVENT_FRAME_SYNC to DQBUF is around 30 msec.
> >
> > I do not know how much delay is considered acceptable... but if we
> > take the delay argument to the extreme, we could say that
> > V4L2_EVENT_FRAME_SYNC can never be implemented, because the event will
> > always be delayed by something.
>
> We have v4l2_event.timestamp for all events, so the jitter to process the event
> by userpace can be removed reliably already.
>
> Nicolas
>
> p.s. missed it earlier
>
> >
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
> >
> >
> >
>


--
Ricardo Ribalda
