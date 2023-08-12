Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61D577A42C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 01:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjHLXJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 19:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjHLXJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 19:09:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FADA198B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 16:09:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E9F91C701;
        Sat, 12 Aug 2023 19:09:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=KFyphwoIPZdIpJLNdp5MvhAMZEpyZkawV/jUxxP
        Su/w=; b=SRip1gOx/LtBKKvn+CgcKd49ZzidMbD1r3uXqSu860lD+2dRL5qUyuQ
        QmgYOEJogtM1By/BOpoPCjwdvaxbuBLozbQmXjmeqgjw0a+im6efe539QVTnQFCU
        3Z+MuqUPBof4FxN6hVhwLA2XDUgW/ECdx/gQs1c7xvMYOgz8RPOg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36A9D1C700;
        Sat, 12 Aug 2023 19:09:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=KFyphwoIPZdIpJLNdp5MvhAMZEpyZkawV/jUxxPSu/w=; b=HC3b1r2I8uQlrqSRAPOMV06uGm7Ia4WzrCbPDreiQ53WWggSeAVXsEAhGNFjxQ8B3CUIKYFRy2mZ8SxRQ/x9mnkIamyTIEa9IaaUhBDJwPkiUAE3AXo43bpf8qxYe/1fzywHTv0ivj+bQCuGg4Nu7/izBI9FijvEVUSmdwkVi3w=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B52651C6FC;
        Sat, 12 Aug 2023 19:09:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sat, 12 Aug 2023 16:11:53 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
Message-ID: <ZNgRub125FKvIPXa@basil>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
 <ZNf2FJNPF6A4jwcX@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNf2FJNPF6A4jwcX@nam-dell>
X-Pobox-Relay-ID: 52C8D990-3965-11EE-9AE0-C2DA088D43B2-45285927!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:13:56PM +0200, Nam Cao wrote:
> On Sat, Aug 12, 2023 at 01:16:46PM -0700, Tree Davies wrote:
> > This patch series fixes checkpatch warning Avoid CamelCase, for all references
> > of struct rx_ts_record, and renames them to rx_ts for consistency and 
> > readability. Each patch renames references for a single function.
> > 
> > Thank you in advance to the reviewers
> > ~ Tree 
> > 
> > Tree Davies (16):
> 
> Here it says there are 16 patches, but you have only sent 6 patches. Are some
> of them missing?
> 
> Best regards,
> Nam
> 
Thanks Nam,

Yes they are missing. git send-email errored during submition. 
I will resend. 
Question: In this case do I need to send it as a v2?

Tree


