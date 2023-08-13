Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E777A450
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHMANG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHMANF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:13:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954A13E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:13:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 831052F21D;
        Sat, 12 Aug 2023 20:13:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=RQs00HUeD33qhp3HMkv3YKtlQJ7Ps9xBsaEa55z
        1fds=; b=mVr0aYpMcHrsC0ALH5Q8IHqThR7AsjzGkEokZle7andtQnlftebn/x3
        6U3T8ljteDzMau/ns4Qsa9jQA0VviDm5dQr2WYUSa0GDeCCQpnJsTlZTTJYWpWQL
        4/9AzMR9KCVbVXpc6KzSqH+cz1kHJDNsdmcWdmU/3gCG1xLqwXOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BDA72F21C;
        Sat, 12 Aug 2023 20:13:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=RQs00HUeD33qhp3HMkv3YKtlQJ7Ps9xBsaEa55z1fds=; b=biPoSJE0VIyQP35Xlpis20iHKKnHuGKdvCl43c5QR0gq2YMvqXmOgSW5jyrvvurCWti1Md50P53qeE3KFZ8CPBJQoadVmC411QAW9AlM09Q35mpC0BdWsIkEgyLzVVsiC7YiNTrbwUyS+aQ3kpOGpfNteqJU8H7a05rRV3wDg8Q=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A95FC2F21B;
        Sat, 12 Aug 2023 20:13:03 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sat, 12 Aug 2023 17:15:15 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
Message-ID: <ZNggk9M5Xbg27Uq6@basil>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
 <ZNf2FJNPF6A4jwcX@nam-dell>
 <ZNgRub125FKvIPXa@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNgRub125FKvIPXa@basil>
X-Pobox-Relay-ID: 2BBA7210-396E-11EE-9159-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 04:11:53PM -0700, Tree Davies wrote:
> On Sat, Aug 12, 2023 at 11:13:56PM +0200, Nam Cao wrote:
> > On Sat, Aug 12, 2023 at 01:16:46PM -0700, Tree Davies wrote:
> > > This patch series fixes checkpatch warning Avoid CamelCase, for all references
> > > of struct rx_ts_record, and renames them to rx_ts for consistency and 
> > > readability. Each patch renames references for a single function.
> > > 
> > > Thank you in advance to the reviewers
> > > ~ Tree 
> > > 
> > > Tree Davies (16):
> > 
> > Here it says there are 16 patches, but you have only sent 6 patches. Are some
> > of them missing?
> > 
> > Best regards,
> > Nam
> > 
> Thanks Nam,
> 
> Yes they are missing. git send-email errored during submition. 
> I will resend. 
> Question: In this case do I need to send it as a v2?
> 
> Tree
> 

OK, I know what happened. I was rate limited by my email provider.
I've requested a limit increase.

I suppose I could break up the patch-set into multiple series and label
them as series A, B, and C?

Tree

 
