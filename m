Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9E808791
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjLGMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjLGMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:21:14 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83211FE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:20:57 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cbcfdeaff3so6686607b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951656; x=1702556456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vxesrth8s8TsUil/IZI30r3j8BETP24ApfVOZLfa+WY=;
        b=tNefz4OLJrUyiP5nJd/lfLwW4L9O+58Q8DYnqM6cafic/Bdt0D+sh/QyS54kosE6jP
         pblp0ZlnpH1fpjXvxabo8wNOEpmXzo/HitdkCNacZrA6Z8LZS6aynTfyqSRqXu0gX0EW
         WxDq8dPWJ0vSFHoQimXtN0kRXdLKeBYjxE+6XFlSHzTQnag+hH4KVxZZdWxLRECfZflq
         lyu/pIgsUTp9cilge8kPmxOIJn3q9XF8HG6SNL5w+Qh0YXBH4rBidBmpYFxAGrj4U/7M
         kty1WAgQsYQCsEHPA1OKY+zn4bXledlmVyWRT9ysYupfO9xleSPhRr0bdOU2xfDGD3DO
         GrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951656; x=1702556456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vxesrth8s8TsUil/IZI30r3j8BETP24ApfVOZLfa+WY=;
        b=w/isEZKN57YP2qDDDZhJpofeSIhZ1g2Sx/WMi39+0+BoYQD7W8Qacg1XC3h8QVKlAV
         mfJ/gMtH1UgfDMp0elHtg7tCMEeMYJTYvsIMblIZv965H0BIALRyhbK/Sqo7NZSk0jS4
         wjUSZq7WHZypybxrENVABBe7rE+IbcFjJULsmGfW7aIGFlU48Zj2yaawx54cDQygRDxX
         OZdcINrT9BP5p6PJ6KH6ivpJHCxKF5EEDhdL2LpXVq7JEJUqIn3o0vYiLAX7a4WQf4Yy
         wWuGRF+r4QQwtqoKQdevSbfmq3FKNGardtXHwl3WdUyvrDPxuiw4bn8LHP3y95O4Kfzz
         Nb5Q==
X-Gm-Message-State: AOJu0YxNDaWztJV2HDX7YxmL/qP1oNcdfThSRxCL6kaaMkeMDT9FZ0J5
        7rrEnuXJD26dpPfDY5ScGcwv8ZZF07PmlKxmE69vYg==
X-Google-Smtp-Source: AGHT+IFSH8O9li6V3TJLdm5dV/ZcvmVepEH/GR3IkQOy57yY2as3FaTPwqRlHm+Jr3s69hHIwWn4V4W2okIkzgzXBdE=
X-Received: by 2002:a05:690c:988:b0:5d7:1940:f3f2 with SMTP id
 ce8-20020a05690c098800b005d71940f3f2mr1874505ywb.90.1701951656381; Thu, 07
 Dec 2023 04:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20231206123828.587065-1-arnd@kernel.org> <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
 <CAA8EJprV3O24V0+MnPK1OdQZQ_7F2aMfN1Um13eH9ux4J+ucMw@mail.gmail.com>
 <ZXGzJlv9C3Z9lMeI@kuha.fi.intel.com> <c1df6dc4-ad3f-41ba-b024-1b432dac7af1@app.fastmail.com>
 <CAA8EJpp+ikpFZ1BL4PZJG_kK3n_u3mTTGZjd8A+=20gPm_SOyA@mail.gmail.com> <a6232a15-a7e6-47fd-ad4b-07319932a6f8@app.fastmail.com>
In-Reply-To: <a6232a15-a7e6-47fd-ad4b-07319932a6f8@app.fastmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 14:20:45 +0200
Message-ID: <CAA8EJpqo7Ty-kyFs-94ddUNWNoDe6efghAfHbVYjQoYAP-PPxw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 14:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 7, 2023, at 13:12, Dmitry Baryshkov wrote:
> > On Thu, 7 Dec 2023 at 14:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Thu, Dec 7, 2023, at 12:57, Heikki Krogerus wrote:
> >> > On Thu, Dec 07, 2023 at 01:55:06PM +0200, Dmitry Baryshkov wrote:
> >>
> >> > Okay, so this probable should also be
> >> >
> >> >         select DRM_AUX_BRIDGE if DRM_BRIDGE and OF
> >> >
> >> > No?
> >>
> >> I think that fails if CONFIG_OF is disabled and
> >> CONFIG_DRM_AUX_BRIDGE, since drm_aux_bridge_register()
> >> will still be called from a built-in driver in that
> >> case but can't be linked against.
> >
> > If DRM_AUX_BRIDGE is not enabled, then the stubs from
> > include/drm/bridge/aux-bridge will be used instead.
>
> Sorry, I meant to write CONFIG_DRM_AUX_BRIDGE=m here.

Like having NB7VPQ904M=y, OF=n and DRM_AUX_BRIDGE=m? And the select
will not work, since the condition is not fulfilled. Good question.

-- 
With best wishes
Dmitry
