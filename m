Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4B7FC3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjK1TBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjK1TBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:01:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E119D131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:01:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC1C433C7;
        Tue, 28 Nov 2023 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701198070;
        bh=VKkpuFR72ZkZ7siURjXwuxonkiOvNT0lixSufQC1atU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+OMbSkFz8t98hJg5Lt+DOSCYE4Mn22zIauqXDZMp0veBexAMXcfupxwT3FvUuEM+
         jC6t6PQpMYiv/3i1TOQB7ID5gDu2sHUmbYVdzv+aDQtDcy0LSNGWpBhOpW3nMWgmUU
         HvZakkbAS+sDhxWRWowk3VKAGLK30bFxNmw6Pzp4=
Date:   Tue, 28 Nov 2023 19:01:08 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: gadget: core: adjust uevent timing on gadget
 unbind
Message-ID: <2023112835-sediment-subsidy-7e99@gregkh>
References: <20231127220047.2199234-1-royluo@google.com>
 <2023112827-repent-broadband-e557@gregkh>
 <CA+zupgxfxaB_bO51ZXW+5T3-FMF94=Tm+mqZ92LCYBZtwiQd3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zupgxfxaB_bO51ZXW+5T3-FMF94=Tm+mqZ92LCYBZtwiQd3A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:52:49AM -0800, Roy Luo wrote:
> On Tue, Nov 28, 2023 at 12:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >   older released kernel, yet you do not have a cc: stable line in the
> >   signed-off-by area at all, which means that the patch will not be
> >   applied to any older kernel releases.  To properly fix this, please
> >   follow the documented rules in the
> >   Documentation/process/stable-kernel-rules.rst file for how to resolve
> >   this.
> 
> I don't see a need for this patch to go into stable kernels after
> reviewing Documentation/process/stable-kernel-rules.rst, please let me
> know if you think otherwise.

If you think this fixes a bug in the existing code, why wouldn't it be
needed?

Also, this implies that you will not be wanting it backported to any
chromeos or android kernels?

thanks,

greg k-h
