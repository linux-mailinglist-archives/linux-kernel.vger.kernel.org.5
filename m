Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734CA7D009E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJSRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjJSRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:33:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BA137;
        Thu, 19 Oct 2023 10:33:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23717C433C8;
        Thu, 19 Oct 2023 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697736791;
        bh=G/SutHOO4zRqJhVoG850CvFRpCRI/P+wACCINZDFK+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA276xJxXrOJnuMXl/1IZjz7b8+xpQbLUNKc0W9/dCl7/WcrdQH3kzeiP+6vIE8Ul
         LP08ZT/p9+sZw6fV/haUYeCrRrJLQAjkbtP7WlmwhPN+R9jZ6OlTs2vj9xE8Wy9W0h
         8dt7ErImTnLK1Fe1a5ehO1grJoi9ICtLKsQdWUdk=
Date:   Thu, 19 Oct 2023 19:33:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: disable KUnit test suites when module support is
 enabled
Message-ID: <2023101924-hunk-conjuror-2d35@gregkh>
References: <20231018163814.100803-1-marpagan@redhat.com>
 <ZTFBi7vfmEpR9TB0@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFBi7vfmEpR9TB0@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:47:39PM +0800, Xu Yilun wrote:
> On Wed, Oct 18, 2023 at 06:38:13PM +0200, Marco Pagani wrote:
> > The fpga core currently assumes that all manager, bridge, and region
> > devices have a parent device associated with a driver that can be used
> > to take the module's refcount. This behavior causes the fpga test suites
> > to crash with a null-ptr-deref since parent fake devices do not have a
> > driver. This patch disables all fpga KUnit test suites when loadable
> > module support is enabled until the fpga core is fixed. Test suites
> > can still be run using the KUnit default UML kernel.
> > 
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> LGTM, I've tested on my machine.
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Hi Greg:
> 
> Could you help review and pull it in for 6.6-final if it's OK.
> 
> https://lore.kernel.org/linux-fpga/2023101825-ligament-undergrad-cc4d@gregkh/

Needs a "Fixes:" tag please, you can provide it here in this email
thread and b4 will pick it up automatically for me.

thanks,

greg k-h
