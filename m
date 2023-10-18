Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276B7CD59C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjJRHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJRHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A177C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:45:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADDCC433C7;
        Wed, 18 Oct 2023 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697615126;
        bh=jN8Gu0zwwTk2T/Rm8uUvwNo07IXv7bqneP/+YCv2VHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D77LelGsNGyGVb9jo8+wvAZ2dDN75xuAR6+LAhtrECuKhbwTICV1u0ZPKXMlFyZ2P
         Zrbk4WK7WUV33L7GsRMnzGpFw9yJfCdtkdne6E6aENB7cKVmGY7hhz8/hyHeJ/Uf/k
         X5vUYRMt/XcmitzIMTFrT1dJVGFZVZqGtk72jkfs=
Date:   Wed, 18 Oct 2023 09:45:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <2023101853-axis-stylist-f1b9@gregkh>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
 <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:32:46AM +0200, Karolina Stolarek wrote:
> On 18.10.2023 09:03, Julia Lawall wrote:
> > 
> > 
> > On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
> > 
> > > Replace udelay() with usleep_range() for more precise delay handling.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK: usleep_range is preferred over udelay
> > 
> > This message is typically not a good candidate for outreachy patches,
> > because you need access to the device to be sure that any change is
> > correct.
> 
> Could we add a paragraph on how to pick good checkpatch.pl error to fix to
> the Outreachyfirstpatch docs? This could go to "Find a driver to clean up"
> section, for example.

The ability to find a "good" error changes over time, so this might be
hard to do.

good luck!

greg k-h
