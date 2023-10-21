Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369C47D1BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJUJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:05:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE92DD
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EB9C433C8;
        Sat, 21 Oct 2023 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697879141;
        bh=UUPHbRL9hzVZTQ/GEAG/vZWDDvjseJWneH2KZDRKhUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GziCnu4ok7S8zjJ7FYHD1tcAAk4WYU9lNVfWW9FsR66Qfdrhu8GZQJ8X5QvY7N2kC
         eYVYyzmWWRsgE2P2oXHQQ+Zg5Yml+n3p+7QGrR/VHo0/gBWxikWZn/0P2V17De2K+Y
         zlWAOvqCs7RyQ7tiVfVfGLqpdQNlc06MFEFa8YgU=
Date:   Sat, 21 Oct 2023 11:05:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Fix warnings due to introduction of new
 typedefs
Message-ID: <2023102108-trend-unfeeling-9b15@gregkh>
References: <20231021081409.67570-1-bergh.jonathan@gmail.com>
 <2023102111-sneak-abreast-8061@gregkh>
 <ZTOS6eaygOA6nRKD@HP-ENVY-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTOS6eaygOA6nRKD@HP-ENVY-Notebook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:59:21AM +0200, Jonathan Bergh wrote:
> On Sat, Oct 21, 2023 at 10:32:29AM +0200, Greg KH wrote:
> 
> Hi
> 
> >  This looks like a new version of a previously submitted patch, but you
> >  did not list below the --- line any changes from the previous version.
> 
> This patch is a *new* patch which replaced a previous *series* of patches
> so it was considered a *new* standalone patch, rather than a new version 
> of the original series. 

Not really, it's a version 2 as you are doing the same thing.

> > - Your patch did many different things all at once, making it difficult
> >   to review.  All Linux kernel patches need to only do one thing at a
> >   time.  If you need to do multiple things (such as clean up all coding
> >   style issues in a file/driver), do it in a sequence of patches, each
> >   one doing only one thing.
> 
> This patch only addresses removal of typedefs from the declarations 
> and fixes up the implmentations that relied on those typedefs. The previous
> advice was to not make breaking changes across patches, so this patch 
> represents code changes which are as atomic as possible in a single patch
> without breaking the build. It does not mix formatting / other changes
> with the code change. 

Please fix up one typedef at a time.

thanks,

greg k-h
