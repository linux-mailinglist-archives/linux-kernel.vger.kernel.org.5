Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04877A560
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjHMHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:09:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6167A10FB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 00:09:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 070BB1B2B1A;
        Sun, 13 Aug 2023 03:09:26 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=2iQ48nZI9z1J0dm2McHW26VPiQcbx6Sxd3MpBlo
        1sDI=; b=YzJFq3RwlPWMkApFfZ/0RRq0p1tWlaQeH4J4GqJnm+FYAcQceVDWn0H
        BO9B2POjpLcjqbZaxC0tj4SA8YV/SmH+jdZtsl8U5xySkx8JggJhSt7+WuTlfL36
        xmmA7uBEK7n550EQ56O0B1NS4sfpYvh8I3EVmvRrke2Cttmf8k9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E45211B2B18;
        Sun, 13 Aug 2023 03:09:25 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=2iQ48nZI9z1J0dm2McHW26VPiQcbx6Sxd3MpBlo1sDI=; b=rX7s6N3zBlz/vzlcViWy/nlFPLfW/8nTTwuEOzEMMGvuyV55T6Bz4akKPG638IBelk1MKlmhdrY7JGd0iA1o9gwYU0Dbbs2w8SDAtypaG695R0bnCtDq4lxNYXTcza2i0m/+wtykNPnv15TET9XgJAPlCEl2Ja3BzM8mpNI6Gtk=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E25DA1B2B0C;
        Sun, 13 Aug 2023 03:09:24 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sun, 13 Aug 2023 00:11:37 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Staging: rtl8192e: Rename variable pTS in
 function rtllib_rx_ADDBAReq()
Message-ID: <ZNiCKbAFZ4UOtSn1@basil>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
 <20230813065035.95157-3-tdavies@darkphysics.net>
 <2023081315-grandma-fifth-1e9c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081315-grandma-fifth-1e9c@gregkh>
X-Pobox-Relay-ID: 55D75254-39A8-11EE-88F2-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 08:55:21AM +0200, Greg KH wrote:
> On Sat, Aug 12, 2023 at 11:50:31PM -0700, Tree Davies wrote:
> > Rename variable pTS in function rtllib_rx_ADDBAReq() to rx_ts
> > to fix checkpatch warning Avoid CamelCase.
> > 
> > Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> > ---
> > v2:Resending in smaller patch series
> >  drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> > index 1eff30533f47..2748ab59545c 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> > @@ -220,7 +220,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
> >  	union ba_param_set *pBaParamSet = NULL;
> >  	u16 *pBaTimeoutVal = NULL;
> >  	union sequence_control *pBaStartSeqCtrl = NULL;
> > -	struct rx_ts_record *pTS = NULL;
> > +	struct rx_ts_record *rx_ts = NULL;
> 
> This should just be called "ts" as that's what it is being used for, as
> the original name says.
> 
> I've stopped reviewing the series here, please go through and make sure
> all of your renames make logical sense as that is important when reading
> the code in the future.
> 
> thanks,
> 
> greg k-h

Thanks Greg, will fix.
~Tree


