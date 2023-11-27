Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B97FA182
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjK0NyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjK0Nx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:53:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7205B19A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32A7C433A9;
        Mon, 27 Nov 2023 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093244;
        bh=ky2aKAKe/DTLRtU5o6/e30Zf24aqeF/l3aPJrk9lnlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKQfL6ZYskF0p5TNuO6zVRFZoQLAG8oNppD1T0vJTxnJhp2SCK5ZatpwvpASOwtJn
         WXbyol5HLd9xEtKT0zNfok1ZEE3K2xCrnbO295QLctRj+PmpZeABwbpbE28rBHwLod
         ZWQ5ryVFlDO6fkvb25d/Ou26A9R+A1+RNHmPqmVY=
Date:   Mon, 27 Nov 2023 13:12:03 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v9 0/4] ledtrig-tty: add additional tty state evaluation
Message-ID: <2023112745-sector-revenge-f821@gregkh>
References: <20231127110311.3583957-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127110311.3583957-1-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:03:07PM +0100, Florian Eckert wrote:
> Changes in v9:
> ==============
> - As requested, I have removed the memory leak fix patch from the previous
>   patch series v8 and have send this patch directly to the stable
>   mailinglist [10].
> - I also have removed the not needed wait for completion code path on
>   sysfs attr store and show, for the new configuration options, as
>   requested by greg k-h [11].
> - Patch v8 3/6 dropped, because the change is not correct as mentiond
>   by greg k-h [12] and this part of the code will be removed anyway
>   in this patch series.
> - Update naming of the function ledtrig_tty_waitforcompletion() to
>   ledtrig_tty_wait_for_completion() which match better with the API call
>   function wait_for_completion_timeout().
> 
> Thanks to all reviewers for the suggestions for improvement :+1: of this
> patch set.

Nice work, thanks for sticking with it:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
