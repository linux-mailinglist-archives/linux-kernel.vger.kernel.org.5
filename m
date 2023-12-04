Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AFD80328D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbjLDM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:26:21 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C41CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:26:27 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so2609265276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701692786; x=1702297586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFWyFPjADp1Fc6HbLi6uPiaZmfeg0/fMint0EXwMSxg=;
        b=vlgUHoGqnwXZdK6T8Z6RUseeI1b4WsYrEI1RMwtuyvmTMCBamhw/n5ZPTRyDdK7tl8
         Z1/7gzd1rY9RQVOHAzYkc+HF3MsAQo0eFVFrYaKtXdNtfNIHCGHO2lOr1BbCfkUghrq8
         wl1LELn6SSlbp1Gwzux7u8JrK86yAH+tNWvhqHV8WTjSK3l9Tz4lUbv5KQDCGxqoCNRT
         TawHEtdXdRUcyzRzluKwpR//57BgMfny/A/M4lmAxcu/lXGRp8b9MIIQDR3Y97sXwKAy
         Uct57Hdu/81z8SAw/jm7erNq6gkR35sF5kug6zYsrw2DFcZgwZX72ssLHsvAi8q5sgxd
         bSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701692786; x=1702297586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFWyFPjADp1Fc6HbLi6uPiaZmfeg0/fMint0EXwMSxg=;
        b=lNH3lrGbLJeVixqmb4/svYtb+6irwdyJV3fxtJFsRc7nxuDHlJ6j+mF45VG0pq2syh
         dT8m62qRWGjixKTbKwpEfbmMtrmeBCYgQR0cAgz+4P8MQ+AhXU1Cvng6U+PfdI1PsQPB
         uh4zqFkYbdc1CUroMMHsVhckonltrDjlrGPyIQnak8Luatm3z8sqYT4PQnOd8yfyr6yO
         R+n5CtHs3/tr/t6Vac8cy3+MNoBfMwkevr0c3SmKuSl5Zxb7KY1lYQcL0RbSDBq++d67
         iFM6sC5rkbC57PDM0sFuhGAjDcrq+HO14EjwhunR6FbvjtgB97QvVWXFsODC5+KgFQif
         4dQA==
X-Gm-Message-State: AOJu0Yz7dMCwPqFWkaaLlJduv9UULmiupc8B9TD851Jvf81yc4GMtFpZ
        6TdG8SjSbI2LBt6/+WzVRKN2IE7VKFQdo349rwlImw==
X-Google-Smtp-Source: AGHT+IE+L1664SYHtY+cUpFkqq4X1I85OOyU1mq606IScbstXyiJjcP/Vfcc7mySBINjIKn/y2Cz19SvoVwqk/DjCeM=
X-Received: by 2002:a25:d85:0:b0:db5:4d4f:b3bb with SMTP id
 127-20020a250d85000000b00db54d4fb3bbmr1816647ybn.18.1701692786300; Mon, 04
 Dec 2023 04:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org> <2023120426-frosting-manliness-14bd@gregkh>
In-Reply-To: <2023120426-frosting-manliness-14bd@gregkh>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 14:26:15 +0200
Message-ID: <CAA8EJpriJ-Y0Gb+PW7f5p4Sh_BXsDpeDckgnGZ+eKmWTQBegaA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/6] drm: simplify support for transparent DRM bridges
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 14:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 03, 2023 at 02:43:27PM +0300, Dmitry Baryshkov wrote:
> > Greg, could you please ack the last patch to be merged through the
> > drm-misc tree? You have acked patch 3, but since that time I've added
> > patches 4-6.
>
> That is up to the typec maintainer to ack, not me!

Hmm, true. I didn't notice supporter vs maintainer.

Heikki, then we should bug you about that patch.

-- 
With best wishes
Dmitry
