Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F07D9686
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjJ0LZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0LZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:25:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26194D42
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:25:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2740EC433C7;
        Fri, 27 Oct 2023 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698405902;
        bh=rKwzu2V53xk717u3gOPNPtAEwvK3Ffjl6EeYyEO8Smo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9rBMlOlLLDmm0BsjAIK6goVkvWLLNn5RNLqi99/Kn9wHxEu23vgQQAuAxESvRL4c
         3Mi8sxhaxrTV6UJ/GqEGP97sxJUUJt8YdJ+d/LMEdxbFX0cU3WNnhfrbnxhTZ5FGeL
         DgtPXDgwpFMq17uwvErLOFC91X3fqa7OC+vvpZGU=
Date:   Fri, 27 Oct 2023 13:24:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: set the dma max_seg_size
Message-ID: <2023102734-excitable-acetone-db92@gregkh>
References: <20231026-dwc3-v1-1-643c74771599@chromium.org>
 <2023102753-spirits-aerobics-c2c6@gregkh>
 <CANiDSCtbQkEaSFgFCyWDQGGoTzFfiM7QaO_LfWMjqPZfAYodFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtbQkEaSFgFCyWDQGGoTzFfiM7QaO_LfWMjqPZfAYodFg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:56:49PM +0200, Ricardo Ribalda wrote:
> Hi Greg
> 
> On Fri, 27 Oct 2023 at 12:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > What commit id does this fix?
> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
> 
> Shall I send v2? or you can pick the tag?

Please send a v2 as you now obviously will also have to add a proper
"cc: stable..." tag as well, right?

thanks,

greg k-h
