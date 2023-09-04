Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A5791ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbjIDPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIDPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327383;
        Mon,  4 Sep 2023 08:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB9866147A;
        Mon,  4 Sep 2023 15:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FDFC433C8;
        Mon,  4 Sep 2023 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693842265;
        bh=qdTA8V0KXUZLUrgT6HNemfUGewlGYuqtThrUKMyrcZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dH13EUrJ64qj61MXG8wG386P+QT4XaAFmRFAw2/w72eMe0857orK3vQj6JAk6cgVn
         iJPLJFgL4Xi2O2SNHeIBZpMEIWf4FuRG3eNTendu87z3KgGSqv9O8Xgvzm8PGCWnza
         H4LOYfFM8wDC1Gx6gyv2CLr/GHaVHs5C72QJc28/WX0sK+r7ChVixP1RvWUSyzHQUR
         1OnGvXh+m8TFv2dKEJ+GqWDrV/0kR0v9oG0AIVXpdl1T3EesqgAxQ/qiYHwwlKMqA0
         Bg3WOp7I6xyGVbCc6xi+MYgY1igO4ezDYIoR+KdjLtiT/IAIgZP1ObXexiiQuvWyAw
         HpNYGylUAzweg==
Date:   Mon, 4 Sep 2023 08:46:40 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 00/12] drm,usb/typec: uABI for USB-C DisplayPort
 connectors
Message-ID: <tsvdc6jm7rtnqjcygn7lhzspheomqbwjejoastr7kcfs22btdr@gy2s57cuwsxy>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:41:38AM +0300, Dmitry Baryshkov wrote:
> During the discussion regarding DisplayPort wrapped in the USB-C
> connectors (via the USB-C altmode) it was pointed out that currently
> there is no good way to let userspace know if the DRM connector in
> question is the 'native' DP connector or if it is the USB-C connector.
> 
> An attempt to use DRM_MODE_CONNECTOR_USB for such connectors was
> declined, as existing DP drivers (i915, AMD) use
> DRM_MODE_CONNECTOR_DisplayPort. New drivers should behave in the same
> way.
> 

Sorry, didn't see the commit message before posting my complaint about
USB -> DisplayPort.

> An attempt to use subconnector property was also declined. It is defined
> to the type of the DP dongle connector rather than the host connector.
> 
> This attempt targets reusing the connector's PATH property. Currently
> this property is only used for the DP MST connectors. This patchset
> reuses it to point out to the corresponding registered typec port
> device.
> 

Still interested in understanding how the path string should look like.

Is the path expected to be consumed by machine, or is it only there for
human convenience?

Regards,
Bjorn
