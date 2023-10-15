Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A387C99EE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjJOQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJOQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:11:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61372AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:11:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74986C433C7;
        Sun, 15 Oct 2023 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697386312;
        bh=kh47zeV8BevKahv3TvF3zc8GSSoYvtunS04s+XptG+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmrTE11JvzkGEHH8D9HCrXo6+6l4J6TSv61ATDuI2iQ2ggeYFL0+9576JHa698+tf
         8jimV6zmDDG+Sj8ogQYn0lA8yt6uiRN9WfWbj0SgGO5HnpK0jfuluQcgDX6OfhNDRu
         FqIE+rcgWmK+A3Lx3pvk+H0hWqPvZPfJY2WrrwNA=
Date:   Sun, 15 Oct 2023 18:11:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <2023101537-repair-natural-3218@gregkh>
References: <ZSkg7y2Y2T3midXB@lab-ubuntu>
 <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
 <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 07:04:56PM +0300, Calvince Otieno wrote:
> On Fri, Oct 13, 2023 at 3:12 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Fri, Oct 13, 2023 at 01:50:23PM +0300, Calvince Otieno wrote:
> > > prism2sta_inf_handover() function basically calls pr_debug() to print
> > > a literal string. This can be done by the parent function directly.
> > >
> > > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > > ---
> > > Patch version v2:
> > >       - Replace pr_debug() utility function with the module specific netdev_dbg()
> >
> > This isn't a v2 patch, right?  This patch assumes that we applied the
> > v1 patch...
> >
> > This patch is not white space damaged though so that's good.
> >
> > regards,
> > dan carpenter
> >
> >
> 
> Hello Dan,
> Does this response mean that the patch was accepted?

No, sorry.
