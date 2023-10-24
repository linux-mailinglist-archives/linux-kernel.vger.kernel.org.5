Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC917D4CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjJXJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjJXJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:49:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E9118;
        Tue, 24 Oct 2023 02:49:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA568C433C7;
        Tue, 24 Oct 2023 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698140988;
        bh=AILUFI5SthZfOvpldYO+Ugr/r93cL5Gmg9ip0Jj6h7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZPytcHN9s+zjjMDCwnau5NlR7tQk3RloFXTPxL48iRfbUKVxaEWvcLTgV5xBqixN
         CnkFe++9Xne0NXHQxJ8ikrr4Ze8noq8pTk/RNy0Bs+JXrjJ9WqEJXsLug/F3GO87fa
         UJYTxAE3GIOLCxwyV2V0NZT7cugR+vjPgkMqLryI=
Date:   Tue, 24 Oct 2023 11:49:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Cameron Williams <cang1@live.co.uk>, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 05/11] tty: 8250: Add support for Intashield IS-100
Message-ID: <2023102433-uncoated-gush-edbc@gregkh>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
 <DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <201af1d6-b82b-5588-017-5d8a9050c458@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201af1d6-b82b-5588-017-5d8a9050c458@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:41:38PM +0300, Ilpo Järvinen wrote:
> On Fri, 20 Oct 2023, Cameron Williams wrote:
> 
> > Add support for the Intashield IS-100 1 port serial card.
> > 
> > Cc: stable@vger.kernel.org
> 
> Why is this cc stable? I think it should be dropped.

It's a new device id, those are allowed for stable.

thanks,

greg k-h
