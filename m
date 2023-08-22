Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995647843BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjHVOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjHVOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:16:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F5E47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:16:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-529c706ba0aso1005536a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1692713770; x=1693318570;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+SKjmXyjgW8f0jHgaxs5wpqMPdIa4R/pbZOYFHEPPA=;
        b=SpnoVaRonUjrgyDJXIvwvFu13QgmHtL/ixGxOgt80D1bodvpJetwRJQx4BWvNcGCq4
         aefsFgsXAIZlZ1QZIPoDATj2xL21rgM8MXxFxymaqAbFkJGEfAuWGg+IV5m6zOxhyD+c
         B+63hHB9SZHpsDpaFr7tiepBRRWAMnlkwGP6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713770; x=1693318570;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+SKjmXyjgW8f0jHgaxs5wpqMPdIa4R/pbZOYFHEPPA=;
        b=ZJ42KbFW7WPuyr2KllEQQ3icBkGeOF81n92Oemcph82aMKY5tGr8uZqY1aPXMp6MZs
         spmyuY4bANMlPWVKt8WNyjx22gKQN9q53cB3HYU6bt6R1VJhmEXkAaboktowmbhrDYwj
         oeILntxpXfZVoOY3wqONRMx+oZF50obaeQCNymMRBk19TrgByVkpBwznzz1d4E8K6v/5
         OcIPdnk9tJUJl3tD+cPsPiVLsxyONKuMIqg0JqgUIujKsznouDgmv0Gl43KbbKNf4JJT
         X8UyyavInELn5EzNurrdN3aiE4ASnzjZ13z98hYd320TuLz1eD11RZbFFoSAgp6HziRk
         +OCQ==
X-Gm-Message-State: AOJu0YzU8e7EE1wKF3yDVDyCHodW9hO9jcnieyLjlRmZowizMJqbgeL0
        gtvTEXIl5VPu8T9TgOocx5/v/g==
X-Google-Smtp-Source: AGHT+IFtzxGQWngpXbT1IIq1urWfPMwb8J4VPPTf913Ygr9DTCR03kQ4lnOqbph9Vi8HtttHNrZ3Qw==
X-Received: by 2002:a05:6402:518f:b0:523:4069:182c with SMTP id q15-20020a056402518f00b005234069182cmr6322721edd.2.1692713770660;
        Tue, 22 Aug 2023 07:16:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q1-20020aa7da81000000b0052237dfa82fsm7627876eds.64.2023.08.22.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:16:10 -0700 (PDT)
Date:   Tue, 22 Aug 2023 16:16:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 00/13] drm/connector: Create HDMI Connector
 infrastructure
Message-ID: <ZOTDKHxn2bOg+Xmg@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:56:12PM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here's a series that creates a subclass of drm_connector specifically
> targeted at HDMI controllers.
> 
> The idea behind this series came from a recent discussion on IRC during
> which we discussed infoframes generation of i915 vs everything else. 
> 
> Infoframes generation code still requires some decent boilerplate, with
> each driver doing some variation of it.
> 
> In parallel, while working on vc4, we ended up converting a lot of i915
> logic (mostly around format / bpc selection, and scrambler setup) to
> apply on top of a driver that relies only on helpers.
> 
> While currently sitting in the vc4 driver, none of that logic actually
> relies on any driver or hardware-specific behaviour.
> 
> The only missing piec to make it shareable are a bunch of extra
> variables stored in a state (current bpc, format, RGB range selection,
> etc.).
> 
> Thus, I decided to create some generic subclass of drm_connector to
> address HDMI connectors, with a bunch of helpers that will take care of
> all the "HDMI Spec" related code. Scrambler setup is missing at the
> moment but can easily be plugged in.
> 
> Last week, Hans Verkuil also expressed interest in retrieving the
> infoframes generated from userspace to create an infoframe-decode tool.
> This series thus leverages the infoframe generation code to expose it
> through debugfs.
> 
> This entire series is only build-tested at the moment. Let me know what
> you think,
> Maxime

I think the idea overall makes sense, we we probably need it to roll out
actual hdmi support to all the hdmi drivers we have. But there's the
eternal issue of "C sucks at multiple inheritance".

Which means if you have a driver that subclasses drm_connector already for
it's driver needs it defacto cannot, or only under some serious pains, use
this. Which is kinda why in practice we tend to not subclass, but stuff
subclass fields into a name sub-structure. So essentially struct
drm_connector.hdmi and struct drm_connector_state.hdmi instead of
drm_hdmi_connector and drm_hdmi_connector_state. The helper functions to
set it all up would all still be the same roughly. It's less typesafe but
I think the gain in practical use (like you could make i915 use the
helpers probably, which with this approach here is practically
impossible).

The only other nit is that we probably want to put some of the hdmi
properties into struct drm_mode_config because there's no reason to have
per-connector valid values.

Also, it might be really good if you can find a co-conspirator who also
wants to use this in their driver, then with some i915 extracting we'd
have three, which should ensure the helper api is solid.

Cheers, Sima


> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Maxime Ripard (13):
>       drm/connector: Introduce an HDMI connector
>       drm/connector: hdmi: Create a custom state
>       drm/connector: hdmi: Add Broadcast RGB property
>       drm/connector: hdmi: Add helper to get the RGB range
>       drm/connector: hdmi: Add output BPC to the connector state
>       drm/connector: hdmi: Add support for output format
>       drm/connector: hdmi: Calculate TMDS character rate
>       drm/connector: hdmi: Add custom hook to filter TMDS character rate
>       drm/connector: hdmi: Compute bpc and format automatically
>       drm/connector: hdmi: Add Infoframes generation
>       drm/connector: hdmi: Create Infoframe DebugFS entries
>       drm/vc4: hdmi: Create destroy state implementation
>       drm/vc4: hdmi: Switch to HDMI connector
> 
>  drivers/gpu/drm/Makefile             |    1 +
>  drivers/gpu/drm/drm_hdmi_connector.c | 1112 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi.c       |  720 ++++------------------
>  drivers/gpu/drm/vc4/vc4_hdmi.h       |   37 +-
>  drivers/gpu/drm/vc4/vc4_hdmi_phy.c   |    4 +-
>  include/drm/drm_connector.h          |  256 ++++++++
>  6 files changed, 1508 insertions(+), 622 deletions(-)
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230814-kms-hdmi-connector-state-616787e67927
> 
> Best regards,
> -- 
> Maxime Ripard <mripard@kernel.org>
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
