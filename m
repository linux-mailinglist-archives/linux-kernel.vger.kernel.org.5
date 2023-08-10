Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83E777C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjHJP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjHJP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:28:47 -0400
X-Greylist: delayed 132 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 08:28:46 PDT
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653D10F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1691681322; bh=s6980iRFYFhljGIDmJ2gYCZUpSgxcLWMQ6gc8L/xTn4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=YMqEnNEpJ2YOl1EIpXYE6301oWw7whljyM4T2itjPlbGYJ6+I88G13zKZATyFZYqi
         udcEfBAEaMxWI+4Sg1Z7qwa3Oyaz8CZWFmqY7PwlrU7r0ieZJAUkRREH+iMeUyCSKj
         dEjkl0EVLiRs0ZpO1JdxUaQu27R3yiWNMn+/nEHA=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 10 Aug 2023 17:28:41 +0200 (CEST)
X-EA-Auth: p8ndnxxUr5lG6O586wocNfHpv24hbRfuQMOjmPjlABDsjCxaYc2Q/OxfMV0gG7oiwrMWd3JqERNmcvQOqfpUgznVLsely7zB
Date:   Thu, 10 Aug 2023 20:58:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v3 6/6] gfs2: Replace kmap_atomic() by kmap_local_page()
 in gfs2_write_buf_to_page
Message-ID: <ZNUCJV7uKHjgijwh@EBC2204>
References: <cover.1688073459.git.drv@mailo.com>
 <4bed561513ba76486ea3fc87f97e6c646f98cbe7.1688073459.git.drv@mailo.com>
 <2235268.iZASKD2KPV@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2235268.iZASKD2KPV@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 03:54:06PM +0200, Fabio M. De Francesco wrote:
> On giovedì 29 giugno 2023 23:52:27 CEST Deepak R Varma wrote:
> > kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
>
> Deepak,
>
> Again please refer to documentation and/or Ira's deprecation patch. The
> reasons why are in one of my previous messages.

Hi Fabio,
This change was already added by Andreas. So my patchset can be dropped.
However, your feedback on the individual patches is agreed to and accepted. I
will keep your suggestions in mind when I submit next patches.

Thank you :)

Deepak.

>
> > Therefore, replace kmap_atomic() with kmap_local_page() in
> > --
> > 2.34.1
>
>
>
>


