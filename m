Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807DD7BF9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjJJLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:32:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C9794
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64275C433C7;
        Tue, 10 Oct 2023 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696937563;
        bh=S6vg6B0owOxuhRIz3K54PdpODPyrrdelfDwVY2ETUUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NosGlgOc8JdgYELaYQbxmMTy+D2lQQPOa41A8u026daK3HOjZEMsj/rc7sAmonkVz
         KcTarBHZkILB+2qy2d6bmEVr4Lg0uXpKHRjfZ6LMt18atbH3AKFpGDiKeelp8GcC3I
         7Xg+oMgFspH0NxflM2SYiq5plSFnMrM79Ad1vaWI=
Date:   Tue, 10 Oct 2023 13:32:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: extend gl3510 reset duration
Message-ID: <2023101033-spool-silver-cfa8@gregkh>
References: <20231006101028.1973730-1-jbrunet@baylibre.com>
 <2023101036-ambiance-precision-657c@gregkh>
 <1jv8bex4lq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jv8bex4lq.fsf@starbuckisacylon.baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:27:32AM +0200, Jerome Brunet wrote:
> 
> On Tue 10 Oct 2023 at 08:56, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 06, 2023 at 12:10:28PM +0200, Jerome Brunet wrote:
> >> Initial tests with the gl3510 has been done on libretech aml-a311d-cc.
> >> A 50us reset was fine as long as the hub node was under the usb phy node it
> >> DT. DT schema does not allow that. Moving the hub under the dwc3 controller
> >> caused issues, such as:
> >> 
> >> onboard-usb-hub 1-1: Failed to suspend device, error -32
> >> onboard-usb-hub 1-1: can't set config #1, error -71
> >> onboard-usb-hub 1-1: Failed to suspend device, error -32
> >> onboard-usb-hub 1-1: USB disconnect, device number 2
> >> 
> >> Extending the reset duration solves the problem.
> >> Since there is no documentation available for this hub, it is difficult to
> >> know the actual required reset duration. 200us seems to work fine so far.
> >> 
> >> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> Fixes: 65009ccf7e8f ("usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support")
> >
> > I can't find this git id, what tree is it in?
> 
> Silly mistake. I must have taken the git id I had before you merged it. Sorry.
> The correct tag with usb-next is
> 
> Fixes: b447e9efe50a ("usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support")
> 
> Should I resend it ?

Please do.
