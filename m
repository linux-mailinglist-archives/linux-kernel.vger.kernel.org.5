Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A1797367
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjIGPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjIGPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A171A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2462C32795;
        Thu,  7 Sep 2023 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694097791;
        bh=asy4IRLGIUtIK1mmhq7yfYHWP/QF8/QGkxEZfSNTPHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPMM0bEk8tVedHL2NUUtOQ9dC6b56CJ7hEE+42d3TOxUvhRK0t8P0ak2fkZ5RTlW1
         WKHJii9K08AoG4FKi3q4rUsJlhYXBFaKuE8/RQMkkATjtnAzeKzJrVPG3jkhaIViEm
         8Ilp7Si0q4m/EYU/KgmMfrn6FbRXICzlFGpq5uhA=
Date:   Thu, 7 Sep 2023 15:43:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: array names updated as per kernel
 coding guidelines
Message-ID: <2023090742-urology-relieve-660a@gregkh>
References: <ZPnA0Pra2HK30nBu@ubuntu.myguest.virtualbox.org>
 <f872ed00-f474-b217-ed78-8612242d448b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f872ed00-f474-b217-ed78-8612242d448b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:49:10PM +0200, Philipp Hortmann wrote:
> On 9/7/23 14:23, Pavan Bobba wrote:
> > Below array names updated as per coding guidelines:
> > 
> >     1.byVT3253B0_AGC4_RFMD2959
> >     2.byVT3253B0_AIROHA2230
> >     3.byVT3253B0_UW2451
> >     4.byVT3253B0_AGC
> > 
> >     Conversions performed:
> >     a.type encoding info dropped from names
> >     b.names replaced by snakecase
> > 
> >     Issue found by checkpatch
> > 
> > Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> > ---
> >    v1 -> v2: 1.subject name modified to more meaningful detail
> >              2.name of the tool added in body of explanation,
> > 	      which found this issue
> 
> Hi Pavan,
> 
> you did not fullfil what Greg wrote:
> 
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.
> 
> The issue is that hundreds of patches could have this title: "array names
> updated as per kernel coding guidelines" Make it more unique.
> 
> Rename CamelCase variable starting with byVT3253B0_
> 
> Always consider that Greg reads a lot of patches per day.

Nor is the changelog written properly as per the documentation or the
zillion past changes for this driver :)

thanks,

greg k-h
