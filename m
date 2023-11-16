Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97577EDCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjKPIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:22:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87C1A1;
        Thu, 16 Nov 2023 00:22:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF7DC433C7;
        Thu, 16 Nov 2023 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700122964;
        bh=gS8VWlvt+EbxksnEGUZohKLfR580uh60rnAxbfZfgCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLCiHuXitSNnOHynfl1TikO2n4fkPy1lTMuHAQsagac+05mF8d5tNMFcu0UN7xVEJ
         JHlIO674lBqfSNQtS/rO4JXeby5LkkY1wyAAtDQnjYxiS25w/lLLKG2GCQ3vECHvMr
         Kl993lcBKNpDTfEc4D6HLyS4ekQjRS5jrr/BLBaE5xsogf/D35JgRyW6AIVl/AFfiu
         vjm0vx5pve1M+sjANGQvUVnWnRLfjW7ASxsvQ3PEBemZYJtta7IDztI0gtJLzFbXuA
         U5n4T17vORItBU3X8uKk4Xo8r4SPiJjQJtGuH5puvFsmw/GqynOqkiGInzICJotYdf
         zP5o0FhFHdc7A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3Xe7-0008Ls-1z;
        Thu, 16 Nov 2023 09:22:43 +0100
Date:   Thu, 16 Nov 2023 09:22:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, swboyd@chromium.org,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: sc8280xp: Make watchdog bark
 interrupt edge triggered
Message-ID: <ZVXRUzoTpZ3JNvDT@hovoldconsulting.com>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231106144335.v2.7.I1c8ab71570f6906fd020decb80675f05fbe1fe74@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106144335.v2.7.I1c8ab71570f6906fd020decb80675f05fbe1fe74@changeid>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:43:34PM -0800, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.

Please always make sure that the commit message is self-contained, and
especially when you're referring to patch which has not yet been applied
(e.g. consider someone doing git blame on this line some time down the
road).

Johan
