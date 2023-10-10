Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1387BF329
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442301AbjJJGeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442284AbjJJGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:34:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC0E9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:34:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2F8C433C8;
        Tue, 10 Oct 2023 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696919656;
        bh=dQkrwgbVocyStNG+wztd+ijksIIgK9fPEm9nKavB/1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPs+1DpzEHlU66F/axWpFTLecuCC/Fi5sZlVCJpVmIHvmfYXq64FESX6r7xbqo7yC
         JY+68qFve2kFyyd+5cHEiG/ByNxM2cTYp95VDitXWHTDB7T7P+nGEWODCIggjU74YD
         w/kxlDmVn88KsJtkcZlpGy5yQfl7JFdivd7njL68=
Date:   Tue, 10 Oct 2023 08:34:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dafna Hirschfeld <dhirschfeld@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Koby Elbaz <kelbaz@habana.ai>, Ofir Bitton <obitton@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Tal Cohen <talcohen@habana.ai>, Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH] accel/habanalabs: make hl_class constant
Message-ID: <2023101053-clambake-mollusk-2953@gregkh>
References: <2023100654-pointless-stem-5ee1@gregkh>
 <CAFCwf10o8J2JYue9Spc0qmSnH671ySuDeUggJ3J6mhXVTc7kTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFCwf10o8J2JYue9Spc0qmSnH671ySuDeUggJ3J6mhXVTc7kTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:07:53AM +0300, Oded Gabbay wrote:
> On Fri, Oct 6, 2023 at 4:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> >
> > This requires some passing of const struct class * around in the common
> > habanalabs code as well as converting the structure itself.
> 
> Hi Greg,
> Thanks for the patch but if you look at our tip of habanalabs-next
> branch (to be merged in 6.7), you will see the hl_class related code
> no longer exists, as we moved completely to the new accel char device
> class.
> So, I'm dropping this patch.

Ah, no code is better, thanks!

greg k-h
