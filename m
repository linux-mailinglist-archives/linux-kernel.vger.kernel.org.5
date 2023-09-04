Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13B791ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351482AbjIDPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIDPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:39:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D11AD;
        Mon,  4 Sep 2023 08:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC4D0CE0F02;
        Mon,  4 Sep 2023 15:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C24C433C7;
        Mon,  4 Sep 2023 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693841985;
        bh=biK94lBbgt1pnt3KPbgjV2mjHY/WPTUANiaYAFj3hnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tk0DR0TJA8XaoYlsyz7s3yTLGRb8OPMGbQQ9R4Ab0qT1Mw1mF0bRVm/VULSyVHsnb
         +ipBAL0t2lfIzxyS6rZCHYVv5vyV1ShhPRqsaaz069pu/jqcxp1Ku6KjUeryHIYEdH
         hWH+KUp2xRkNf26zT/Ldkt0kkw0TgMYKeZ3q9OIe4GzQTEvr0A1XVWAnMC549adr9o
         C4VtbhrNg8doUP6AgEcmMh34fGSI/JjWQf2GEqaH0UygW0lt25QhyWrEbhMQw/znjA
         a8KDp6P6XqLiZcDqzC3Q6pSuLLi8bowdOSwE0pnKzGlAcjy7hrTG7FmHE5yMZiSgQf
         WaSBEqZnGYKuw==
Date:   Mon, 4 Sep 2023 08:42:00 -0700
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
Subject: Re: [RFC PATCH v1 06/12] soc: qcom: pmic_glink_altmode: fix DRM
 connector type
Message-ID: <u5jciyc42wbclgcznuyxrub6lfhkqixpcsgx656afmqmx5m7er@xktdvhzwbuzu>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903214150.2877023-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:41:44AM +0300, Dmitry Baryshkov wrote:
> During discussions regarding USB-C vs native DisplayPort it was pointed
> out that other implementations (i915, AMD) are using
> DRM_MODE_CONNECTOR_DisplayPort for both native and USB-C-wrapped DP
> output. Follow this example and make the pmic_glink_altmode driver also
> report DipslayPort connector rather than the USB one.

I started off with this, but on devices with both USB Type-C and
(native) DisplayPort, it seemed much more reasonable to make the
distinction; and thereby get the outputs named "USB-n".

Similarly, it looks quite reasonable that the output on my laptop are
eDP-1, USB-1 and USB-2.


But, if this is not the way its intended to be used, feel free to pick
this together with the other patches.

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
