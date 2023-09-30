Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA877B407E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjI3Nbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3Nbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:31:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96EAE6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:31:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A8FC433C8;
        Sat, 30 Sep 2023 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696080705;
        bh=Obhs2CedT2ML1ULT+XIBom7a5rHC33HyXVw1sPI2hKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5V+CbfLPhYkbLK/aAjYFEfMLJneT/JLoFjwTIkYV6XQebhZIysNX6XZ1nkr4TGC8
         wSkWKvwx5hI0qynSplvto6NxEu6lDiq4ezoneEbuMi+nY1adqBFkbNK/RHJBbBM0pi
         GW4u8D3keCsO5TTlM+mV5fmGozHvB924eczAqCFQ=
Date:   Sat, 30 Sep 2023 15:31:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav <singhabhinav9051571833@gmail.com>
Cc:     stern@rowland.harvard.edu, benjamin.tissoires@redhat.com,
        mathias.nyman@linux.intel.com, hdegoede@redhat.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] fixed documentation warning about duplicate symbol
Message-ID: <2023093020-discern-dispersed-7dbe@gregkh>
References: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 06:04:49PM +0530, Abhinav wrote:
> Compiling the documentation in html gives a warning about duplicate symbol
> because same name is used for function usb_string(...) and 
> also for the struct usb_string.Also having a different name can
> be helpful while searching or debugging the code.
> 
> Renaming the function usb_string(...) to utf16le_to_utf8(...) fixes 
> this warning.Reason for choosing this name because 
> this is what the function description says it is doing.

Odd trailing spaces, why?

Anyway, sorry, but that's a horrible function name for a usb core
function, especially just for a documentation warning?  Surely the
documentation tools can determine the difference between a structure
name and a function name?  This can't be the only place this has ever
happened, right?

Try fixing the documentation tools instead?

thanks,

greg k-h
