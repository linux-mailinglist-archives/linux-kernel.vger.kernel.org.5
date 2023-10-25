Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E37D6642
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJYJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:08:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BCE5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:08:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E0C433C7;
        Wed, 25 Oct 2023 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698224930;
        bh=itIf9cOabqYGAHuSf2wNhn6UlBjXi9zaPiiD1oZbPaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUWn8dN1sC+I65NJ5aEhqi/Wy3FJKGK+ODGEgsDFteP1mgyriQetIJhHJpXKFKRf5
         Ll+PVJd9iaDiHDDIpft5kaplhA7xlzt8JRCsd7qVzQ0/+FlKLNGz5sfHcA7Uc3RNFi
         UzCjeD5IAbdrztBh0kkzl9lT8/UCnLm6WmtuUqNY=
Date:   Wed, 25 Oct 2023 11:08:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cxl: make cxl_class constant
Message-ID: <2023102533-anyway-bullish-75be@gregkh>
References: <2023102434-haiku-uphill-0c11@gregkh>
 <9573ec63-a8d6-4c69-a70b-9095838d521d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9573ec63-a8d6-4c69-a70b-9095838d521d@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:16:55AM +0200, Frederic Barrat wrote:
> 
> 
> On 24/10/2023 13:48, Greg Kroah-Hartman wrote:
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> > 
> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> > Cc: Andrew Donnellan <ajd@linux.ibm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Thanks!
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks for the review of these, I'll take them through my char/misc tree
now.

greg k-h
