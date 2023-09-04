Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745C791AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353251AbjIDPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIDPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:41:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C5BCC7;
        Mon,  4 Sep 2023 08:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4FCD3CE0F0B;
        Mon,  4 Sep 2023 15:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5FDC433C8;
        Mon,  4 Sep 2023 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693842075;
        bh=6AHoLhPAyb0kZxC+vtd1mmVBPDeqBePGOJk9DUiE0G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5NuA4etrWKvpIRNGsV4jkYCm2uMrcQcHBgXfVXZWFgm4dC6ueiUkQrVGm0V918Mn
         cfc7i2J6fX6VJtROHdDeVNu+/PJaD6q8ZPF8/ijy7StB7BGTf+zEMNH68vzzvcuI6T
         pEY5ozwRg9yGMh6iUry8OSeJkv1W2/5EUGeHHxuzIOU+vq1Of42SzWuQp481fGBeOf
         7S+NrUubMBv9etx0hv3Yk9CDYjOnmv41SqWW5j+7am8GF272eHPbEAb6gRLM4Y7xfs
         qd9A3PEOfkTw3FEwTQ4rW/GGdGjZbijxMdBzS/dxUuI1uW5yTwjmss6DDEH22juDJI
         IMR6cME1sVkDg==
Date:   Mon, 4 Sep 2023 08:43:31 -0700
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
Subject: Re: [RFC PATCH v1 07/12] soc: qcom: pmic_glink_altmode: report that
 this is a Type-C connector
Message-ID: <skpvgxdkyciuijkv55uh4ircrrarqhdoiocqc6h5gs4dw6c2rj@zv4fwdri4mwz>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903214150.2877023-8-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:41:45AM +0300, Dmitry Baryshkov wrote:
> Set the bridge's path property to point out that this connector is
> wrapped into the Type-C port.
> 
> We can not really identify the exact Type-C port because it is
> registered separately, by another driver, which is not mandatory and the
> corresponding device is not even present on some of platforms, like
> sc8180x or sm8350. Thus we use the shortened version of the PATH, which
> includes just the 'typec:' part.

How would a properly resolved path look like?

As with the other patch, I'm okay with this going through the USB tree.

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
