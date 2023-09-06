Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE0793CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjIFMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjIFMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:48:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85C1730
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:48:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7f0048b042so2785555276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694004527; x=1694609327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92om2bQSNnR9D1DHhKVFZqGrlhplU+xlpPXmIDI9/fQ=;
        b=eAl63feLAN+pM+7zZF69uNUhBuAMmDysKSpk39m0sh8b1uGAyXbxg5/DXt3fnceklW
         h/1ZgBVNdUqkFaGOVRSXONHfvS50M3InlwiRqhNufroI5uLhTku9nnmUV9MF89bDI9mv
         CfMmHECSCnYZacelP8GrGS5jerMm/RP3qbAKC+5f5N/NMMQJbmuJo+JpFGXjuRLJ8RWD
         mlxdjvaJq7/XSPC7hZEporV8NOdYqytfSUEb1tydM69m0mH55g5ZGmOkyUtewGJyrdWP
         R4k8JM/snhaKIFITilynq5Fyi0ocZqI33tFB4BWC3Ds5rrBlmINwl1bmdwhGayu8TEU3
         Kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004527; x=1694609327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92om2bQSNnR9D1DHhKVFZqGrlhplU+xlpPXmIDI9/fQ=;
        b=bUb+w2F5MdWLNvghp35KUcuARrSqg7WXJYxpMCxpaUC3FB3TMyLzsWXHBKO+dXC3CE
         ajS+8hfBaw403izsmA/HSUgTVDgVD6fdrfVAoYRYMsQpdI58c8jluEhDujcXx5Ricji5
         CCuqm14rWnpIAZjKwzMUomDuZOhdC7QIsMGumKEi3ATa0q/5Z01ghPF46YrQsMZHNGim
         tac8TkOjyu0MTcmrbLBBfwhdC+xX1oS8SZNYKar0RFdcS5J220SSXCSGaRH3a0R4FLUP
         GVn5Z4XpvNYyo1Z2Ni3hYjsXK9OZNOxqBl2X4FRl3jropJUspx8sWO7VjgSPX1cQ1bEM
         ropA==
X-Gm-Message-State: AOJu0YynSMBCTOsJ+Z5jGgeJqjxDsNRMkBxat3zVasx/W0SkEHn01Lp4
        1XYUokwRka8fRvpKkdPJ0ldJPRhDvh6Emy/XrvnFDg==
X-Google-Smtp-Source: AGHT+IG22IPQGRrf8eEKph8YYMyYOGggoX0BSU0gnlm3GqlA+rCxg8GxZJknwqypa88MgH+7q+/GwfJRCMq11nNuXqM=
X-Received: by 2002:a25:81d2:0:b0:d74:5f61:15b1 with SMTP id
 n18-20020a2581d2000000b00d745f6115b1mr15250331ybm.26.1694004526735; Wed, 06
 Sep 2023 05:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org> <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com> <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
In-Reply-To: <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Sep 2023 15:48:35 +0300
Message-ID: <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/12] Revert "drm/sysfs: Link DRM connectors to
 corresponding Type-C connectors"
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 15:44, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
> > Hi Heikki,
> >
> > On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> > > > The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
> > > > dev_fwnode() checks never succeed, making the respective commit NOP.
> > >
> > > That's not true. The dev->fwnode is assigned when the device is
> > > created on ACPI platforms automatically. If the drm_connector fwnode
> > > member is assigned before the device is registered, then that fwnode
> > > is assigned also to the device - see drm_connector_acpi_find_companion().
> > >
> > > But please note that even if drm_connector does not have anything in
> > > its fwnode member, the device may still be assigned fwnode, just based
> > > on some other logic (maybe in drivers/acpi/acpi_video.c?).
> > >
> > > > And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
> > > > breaks drivers already using components (as it was pointed at [1]),
> > > > resulting in a deadlock. Lockdep trace is provided below.
> > > >
> > > > Granted these two issues, it seems impractical to fix this commit in any
> > > > sane way. Revert it instead.
> > >
> > > I think there is already user space stuff that relies on these links,
> > > so I'm not sure you can just remove them like that. If the component
> > > framework is not the correct tool here, then I think you need to
> > > suggest some other way of creating them.
> >
> > The issue (that was pointed out during review) is that having a
> > component code in the framework code can lead to lockups. With the
> > patch #2 in place (which is the only logical way to set kdev->fwnode
> > for non-ACPI systems) probing of drivers which use components and set
> > drm_connector::fwnode breaks immediately.
> >
> > Can we move the component part to the respective drivers? With the
> > patch 2 in place, connector->fwnode will be copied to the created
> > kdev's fwnode pointer.
> >
> > Another option might be to make this drm_sysfs component registration optional.
>
> You don't need to use the component framework at all if there is
> a better way of determining the connection between the DP and its
> Type-C connector (I'm assuming that that's what this series is about).
> You just need the symlinks, not the component.

The problem is that right now this component registration has become
mandatory. And if I set the kdev->fwnode manually (like in the patch
2), the kernel hangs inside the component code.
That's why I proposed to move the components to the place where they
are really necessary, e.g. i915 and amd drivers.

-- 
With best wishes
Dmitry
