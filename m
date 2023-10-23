Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8477F7D3AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjJWPZI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:25:06 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09291DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:25:04 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 4292C14017E;
        Mon, 23 Oct 2023 15:25:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 76D6220016;
        Mon, 23 Oct 2023 15:25:00 +0000 (UTC)
Message-ID: <15f45bbde3f4289b012db7adb8166cf0d45e4fec.camel@perches.com>
Subject: Re: [PATCH 2/5] staging: media: av7110: Fix various whitespace
 checkpatch errors
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Oct 2023 08:24:58 -0700
In-Reply-To: <b301c9a1-7536-46c5-878e-7cd79e3a4742@kadam.mountain>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
         <20231020232332.55024-3-bergh.jonathan@gmail.com>
         <b301c9a1-7536-46c5-878e-7cd79e3a4742@kadam.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 76D6220016
X-Stat-Signature: uso4t8asunecfddpd7xeyg65ftr14cyg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+VkWPLyvgXZZWw+/cT5gjzEt416nU2p+8=
X-HE-Tag: 1698074700-308232
X-HE-Meta: U2FsdGVkX19fOFgBMW+1i6LvtS8bVOiijCHMn6WgWz8Hz2LBWy2SGm/KH4KlWZY5Tjj9fn5jVr9T7rjtmAXNl0J+d4kYioCx7/gyh/4mJ3+vUGI6Z/3y4W/7bFnTs3LRuhJvaYLvefim2tJalYxzyUSf1mg+Qgn1lGyGQOOlOiMuXDXC17h9ZHbB5/C1Kz0vysWKzUPnbpbbzlyYQdYbaXYZ/SJsyqjQi6ZCbx0b6+NMxUTeBuKL+RBdYdGRhYNAW9a6+v6i+6Ju2Mi4Od0m7Jsc6VIW/PKE8v/yEXmtTqY3p0eVBunu7/Ty6sGwxNLQ2MoCpl1eP+JZT7UkWD9gv4rAKocc6Y6M
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 17:26 +0300, Dan Carpenter wrote:
> On Sat, Oct 21, 2023 at 01:23:29AM +0200, Jonathan Bergh wrote:
[]
> > diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
[]
> > @@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
> >  		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
> >  		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
> >  
> > -		if (((sync &~ 0x0f) == 0x000001e0) ||
> > -		    ((sync &~ 0x1f) == 0x000001c0) ||
> > +		if (((sync &~0x0f) == 0x000001e0) ||
> > +		    ((sync &~0x1f) == 0x000001c0) ||
> 
> These should be:
> 
> 	if (((sync & ~0x0f) == 0x000001e0) ||
> 	    ((sync & ~0x1f) == 0x000001c0) ||

Generally, I believe it would be better to avoid '& ~constant'
and use the positive form instead

	if ((sync & 0xfffffff0) == 0x000001e0) ||
	    (sync & 0xffffffe0) == 0x000001c0)


