Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739BD7FEA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjK3I1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjK3I1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:27:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D610EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:27:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E76C433C8;
        Thu, 30 Nov 2023 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701332858;
        bh=LdjNKOLHbMhRShAwFebAAZRIVcHBzVh9Y/dtmWC97qA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T8Qm7sIY6gw2R8rh3tADIiIBNUsRxau6g0HY+bBy27PL1WMKFxbi/9i8Rcd4OgTm8
         aU7zulW30HDJbeXOWbAiQeH2iSvXZBzYxzMhM5vn7IeJGz8lXaqU7cOJa6ELd32qbf
         aYgKvCkuEA/NduZ42Rtd+1HQahVNtg0NvgJfFkA6IZMxOrYEqI91lGdGGKUmw5O4+d
         TBbZM+LRf/DChu/dAn9hfATiiYRkTXEz9tcw6lVBHydfCgHtCQttrovv8ZfAH0h1kS
         F3xK8SFlrHWmr0WHzMZTOo1R+U4NkAnOVAMWI9O5+rimzUNQVgzKLtopl2TtdwMLqe
         Ac0hp0iRYE/5A==
Date:   Thu, 30 Nov 2023 09:27:33 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Raise the minimum Sphinx requirement to 2.4.4
Message-ID: <20231130092733.26f0b7c4@coco.lan>
In-Reply-To: <c3accd5b-c8d9-4eb9-86a1-054e89893a8f@gmail.com>
References: <87sf4qvkmc.fsf@meer.lwn.net>
        <20231128023015.0e446a06@coco.lan>
        <877cm2uegr.fsf@meer.lwn.net>
        <20231128165645.2dbe416c@coco.lan>
        <c3accd5b-c8d9-4eb9-86a1-054e89893a8f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 30 Nov 2023 16:33:56 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi,
> 
> On 2023/11/29 0:56, Mauro Carvalho Chehab wrote:
> [snip]
> 
> > While I didn't make any benchmarks, I remember people reported
> > poor performance with newer versions, so, without thinking to
> > much, 3.1 or 3.2 seems a good candidate for the recommended
> > version.  
> 
> Well, I have different impressions on the performance of Sphinx >=3.1
> and have done some quick benchmarks.
> Here are results on a not-so-performant machine.
> 
> Benchmark of building htmldocs on Ubuntu 22.04 (after "make cleandocs"):
> 
> Sphinx   elapesed   maxresident (k)
> ======== ========== ===============
>  2.4.5     7m44.57     2806152      (parallel slot = 3)
>  3.1.2    11m25.28     1036264      (parallel slot = 4)
>  3.4.3    10m22.26     1067100      (ditto.)
>  4.2.0    10m16.53     1151220
>  4.3.2    10m06.07     1123432      (distro pkg of Ubuntu 22.04LTS)
>  5.3.0    10m18.73     1145524
>  7.2.6     9m53.80     1261736
> 
> python3: Python 3.10.12
> 
> Sidenotes:
> 
>   1: Sphinx 4.3.0 officially added Python 3.10 support.
>      Sphinx 4.2.0 also works with Python 3.10.
>      Sphinx <3.5.0 happen to work with Python 3.10.
>   2: Sphinx 7.2.0 obsoleted Python 3.8.
>   3: Sphinx 6.0.0 obsoleted Python 3.6 and 3.7.
> 
> 
> And here is a table of distro Sphinx packages:
> 
>           As of 2023.11.30
> 
> ----------------------------------
> Distro              Sphinx Python3
> =================== ====== =======
> Ubuntu 22.04 LTS    4.3.2  3.10.12
> Debian 11           3.4.3  3.9.2
> Debian 12           5.3.0  3.11.2
> Fedora 39           6.2.1  3.12.0
> RHEL 9              3.4.3  3.9.18
> Mageia 9            6.1.3  3.10.11
> openSUSE Leap 15.5  4.2.0  3.6.15  (provided as python3-Sphinx_4_2_0)
> ----------------------------------
> 
> So, I think Sphinx 3.4.3 would be a reasonable choice for
> recommending.

Works for me.

Regards,
Mauro
