Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA277BEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHNRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHNRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:25:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68330E7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:25:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 031051C55C;
        Mon, 14 Aug 2023 13:25:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=teq8KsZePKUOo629R2xCTDjE8hepgr7j39dsdTE
        7lS4=; b=bcCyzRRSxnHXszA3sXNETOPfZV0Ydy9PNZANvKcuITMNM/qpYGqjKOZ
        mBJOWiVNRjQmzSC7VfmmGZ69LcUj+c04MHTN7K30Tnw5lYPmesCiu3DRZCV/6Q2h
        Cu1diEqByRDZOGY0eYS16wjdDbkY8QEQXGZp8mG7sUuHuXSHJvsI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF0F01C55B;
        Mon, 14 Aug 2023 13:25:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=teq8KsZePKUOo629R2xCTDjE8hepgr7j39dsdTE7lS4=; b=GS0R6+2m7/drj50hV/GGjAnke/cJAMAmFQtIXu6KAbY2W2nFtvmTM14kJZNVbQcIEq7zCFv+KcziY0PhbhW+JwwJUbKNZaJVhrQcu37n2tdgdWaJIVIeFS3WRTTuoMgRGb6+9PUTWUIQRJW9+BKz6BO0dTJXCBmb3dM9MYMeoww=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21EC41C55A;
        Mon, 14 Aug 2023 13:25:02 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 14 Aug 2023 10:27:17 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nam Cao <namcaov@gmail.com>, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
Message-ID: <ZNpj9RDhm3Q0sSmO@basil>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
 <ZNf2FJNPF6A4jwcX@nam-dell>
 <ZNgRub125FKvIPXa@basil>
 <ZNggk9M5Xbg27Uq6@basil>
 <2023081310-unearth-buddhist-4caf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081310-unearth-buddhist-4caf@gregkh>
X-Pobox-Relay-ID: 8101C354-3AC7-11EE-B335-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 08:30:02AM +0200, Greg KH wrote:
> On Sat, Aug 12, 2023 at 05:15:15PM -0700, Tree Davies wrote:
> > On Sat, Aug 12, 2023 at 04:11:53PM -0700, Tree Davies wrote:
> > > On Sat, Aug 12, 2023 at 11:13:56PM +0200, Nam Cao wrote:
> > > > On Sat, Aug 12, 2023 at 01:16:46PM -0700, Tree Davies wrote:
> > > > > This patch series fixes checkpatch warning Avoid CamelCase, for all references
> > > > > of struct rx_ts_record, and renames them to rx_ts for consistency and 
> > > > > readability. Each patch renames references for a single function.
> > > > > 
> > > > > Thank you in advance to the reviewers
> > > > > ~ Tree 
> > > > > 
> > > > > Tree Davies (16):
> > > > 
> > > > Here it says there are 16 patches, but you have only sent 6 patches. Are some
> > > > of them missing?
> > > > 
> > > > Best regards,
> > > > Nam
> > > > 
> > > Thanks Nam,
> > > 
> > > Yes they are missing. git send-email errored during submition. 
> > > I will resend. 
> > > Question: In this case do I need to send it as a v2?
> > > 
> > > Tree
> > > 
> > 
> > OK, I know what happened. I was rate limited by my email provider.
> > I've requested a limit increase.
> 
> Your email provider does not allow you to send more than 7 emails at
> once?  You might want to switch companies if that's the case.

From what I understand it is 7 email-recipients x 16 patches in the set
violates their 50 email per 5 minute policy.

> 
> > I suppose I could break up the patch-set into multiple series and label
> > them as series A, B, and C?
> 
> No, series are not labeled that way, sorry.
> 
> greg k-h
