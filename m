Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38017CCF50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjJQVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:31:16 -0400
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 14:31:14 PDT
Received: from pulsar.hadrons.org (2.152.192.238.dyn.user.ono.com [2.152.192.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B852FA;
        Tue, 17 Oct 2023 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hadrons.org;
        s=201908; t=1697577790;
        bh=rCrmn9y03CfqjCPi53Ca1ph8YHiUpD5hgaahZbYtSmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pmjaTy459tR1za0fQB1dwq0sKNqW94wrmvEt950rPRUSLFFE3pLumuJJM6CAQD6RX
         XqwyVOjoz420fxDL3PcUIsf03hoqRmRBnbgzLwr2erreFbJlrUENXHdh6hMSAtPElC
         AYIWSWKrcrUTvi+fetC7Y4gHWV+fqkrdCiVX/VvUE0TUXjx+BoRPv7xPGstEierJTA
         CEWJdsu/RXYseQ+wdBODvmad5SFvuBotI/7nWhzRV3PdzfENr+L382NQWYkMWR5FvW
         wW6yqU53bv7z/GakDepw095XbWw5mfWL0b1Ydxw+6YRitigoyW4oYnr3Pr2Luk0C9J
         uuYFrrjIEGU1g==
Received: by pulsar.hadrons.org (Postfix, from userid 1000)
        id 77FAC122CA9; Tue, 17 Oct 2023 23:23:10 +0200 (CEST)
Date:   Tue, 17 Oct 2023 23:23:10 +0200
From:   Guillem Jover <guillem@hadrons.org>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
Message-ID: <ZS77PhZA9q6zQw7_@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@hadrons.org>,
        Alejandro Colomar <alx@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-5-axelrasmussen@google.com>
 <ZSMn-H_BUmJMi9La@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSMn-H_BUmJMi9La@debian>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 2023-10-09 at 00:06:48 +0200, Alejandro Colomar wrote:
> This produces some unwanted space.  Please apply the following fix to
> your patch.
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 6e954e98c..795014794 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -432,11 +432,11 @@ .SS UFFDIO_REGISTER
>  no mapping exists in the given range,
>  or the mapping that exists there is invalid
>  (e.g. unsupported type of memory),
> -or the range values (
> -.I range.start
> +or the range values
> +.IR ( range.start

I think you meant «.RI» here?

>  or
> -.I range.len
> -) are not multiples of the relevant page size,
> +.IR range.len )
> +are not multiples of the relevant page size,
>  or
>  .I range.len
>  is zero.
> 

Regards,
Guillem
