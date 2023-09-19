Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2517A64E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjISN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjISN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:28:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C7F1;
        Tue, 19 Sep 2023 06:28:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1D5C433C7;
        Tue, 19 Sep 2023 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695130091;
        bh=cgpCq/1XRr4sA5/czdd3pzytIQeVY1Qabe8rnlGEetw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZjTyyCK7kjl9OdIIvMyX53DBnuWzFFOhBDgIdiJtyxuhujEYoXg9ve+t2tYwYOzA
         EPi7jftAKCpfzMLJcCVDyD2mueiG46cV4RwmEzU5LK6wPBCW1uiWiMdQqarD5qbP5j
         zlYkfTCUh2JqIP7pZyFDuysIB+RFwj9obLB27hSqB8e5oduWO1gbk1q0eCQP/vq8Ak
         CowtUWCoslS+GrxT2gzjd8+fi8bpmgBLI/XTMd0wlyT9UZvb2cGvioLPunxwwOMMCW
         QGxbKkXPJDRwB38s7q+MhX6N8FMXblCRoc/okCswY/8pqHpyr8L5ez9bP8YNtfnclE
         PXWxnTlB9jJrA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qiam8-00006U-1U;
        Tue, 19 Sep 2023 15:28:25 +0200
Date:   Tue, 19 Sep 2023 15:28:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZQmh-DaBTwMuOLHe@hovoldconsulting.com>
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
 <ZQjEEt7sB2M5EO53@sashalap>
 <ZQk8aJx268Soy4yH@hovoldconsulting.com>
 <ZQmc7hznPpIh6iwP@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQmc7hznPpIh6iwP@sashalap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:06:54AM -0400, Sasha Levin wrote:
> On Tue, Sep 19, 2023 at 08:15:04AM +0200, Johan Hovold wrote:
> >On Mon, Sep 18, 2023 at 05:41:38PM -0400, Sasha Levin wrote:
> >> On Mon, Sep 11, 2023 at 08:33:02AM +0200, Johan Hovold wrote:
> >> >On Fri, Sep 08, 2023 at 03:28:41PM -0400, Sasha Levin wrote:
> >> >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> >>
> >> >> [ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]
> >> >>
> >> >> Disappointigly, the camera activity LED is implemented in software.
> >> >> Hook it up as a gpio-led and (until we have camera *and* a "camera on"
> >> >> LED trigger) configure it as a panic indicator.
> >> >>
> >> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> >> Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
> >> >> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> >> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> >
> >> >This is a new feature if anything, not a fix. Please drop from all
> >> >autosel queues.
> >>
> >> Not a feature, but hardware enablement.
> >
> >Call it what you will, but please drop it. Otherwise by that logic you'd
> >need to backport all devicetree patches (as well as most driver changes)
> >since they ultimately aim at enabling hardware.
> 
> Not all, only ones that re-use existing kernel driver but enable it for
> new hardware (i.e. adding a new pci-id/usb-id/dts entries).

Again, that's basically all our device-tree patches. And that can break
in all sorts of ways. So again, please drop. This does not belong in
stable.

Johan
