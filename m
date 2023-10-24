Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198327D4CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjJXJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjJXJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BE192;
        Tue, 24 Oct 2023 02:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5480C433C8;
        Tue, 24 Oct 2023 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698141008;
        bh=bf8MUUv/mURmaYRQm4dbKVtxt0dhZrJBf80WgzxGMyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/E3CjWsR1/u9qsRzXr7KguZXMkZHQcoTz4tB3Go5D9dWup+icYxKI9vfnpmXl4lz
         UJgbLFMMAabXUOhkNQgi/eNT4/sIUbOS7YrAJFB4UvsHu8jXdq3BLXn5mbDYsWdTDw
         uSs0YHrCyghF2qCGxrZ+G+2DLxq9LG09Ewk0TBHg=
Date:   Tue, 24 Oct 2023 11:50:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Cameron Williams <cang1@live.co.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 06/11] tty: 8250: Fix port count of PX-257
Message-ID: <2023102453-startup-corrosive-4b7d@gregkh>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
 <DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <f21a942c-5f1e-3c1a-945c-358632edb188@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21a942c-5f1e-3c1a-945c-358632edb188@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:42:28PM +0300, Ilpo Järvinen wrote:
> On Fri, 20 Oct 2023, Cameron Williams wrote:
> 
> > The port count of the PX-257 Rev3 is actually 2, not 4.
> > 
> > Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> 
> Please arrange your series such that the patches with Fixes are first, 
> not in the middle of your series.

Almost all of these are going to stable, so this was ok.

thanks,

greg k-h
