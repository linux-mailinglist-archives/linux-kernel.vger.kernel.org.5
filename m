Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF17F2E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjKUNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjKUNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:41:27 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B705D52;
        Tue, 21 Nov 2023 05:41:24 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c08c47c055so59629027b3.1;
        Tue, 21 Nov 2023 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700574083; x=1701178883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcrYwFp88pWTL6yMI9KWImk/qrP0KNOz3TtNbxnSaOM=;
        b=fOZBM1wXb/g3/+EMdX9iCcndKGIWiISBUPuYuQ8EEYPVDamQFfFgeFI+iVL9FkvVeu
         t9rRuRsxD3KldxrPZcy3TDcMMcJrF1mgCtEo6RX+txtmnQgw5ZqwdAaM5VlHCgmWGt1Q
         sl1PPIDAH04hj+LKXgEi5caDL2ggREufFzFMSTJA+zeZFSLHzOQoVBFWIvfLZq3y5LUg
         Wmpf1iIVSCQYF7Fon/hUn9i/olHSacdxc4lec4y/a/hIehKOjYv0qh6xyxlWVefptyJJ
         pxHwH01Dp/XLzjWOQL8fIXu5bQUMIx6qLYbNZFmxwRYdWAeHh3BJSiRaeGjPnWPpwHLI
         LCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574083; x=1701178883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcrYwFp88pWTL6yMI9KWImk/qrP0KNOz3TtNbxnSaOM=;
        b=taPcXC2DDWagd/CHbNPxBD32mohcZFvI6ExJJjteGRWBW0vAmyAGRmZ/EHsa57+6Xh
         aAVyGRVZrUbH8Lv0Qk/5ncEe+dLy1gsg1x1gufRZRHdwLP9leJGESrOAozegLu/54hFn
         RDo8cyUUX0FHTyAVlVL+cMkv8+PKbXH/2GC4UYt4jqLRGnQuejP0hZICIK/Z5Dv4XTBp
         3CQTcTJQfC9ITcmMFRyHlC9lMJWWQX2beB5TlcqJWoh7Ao0ONRKtmKQPn2n9XEz9Ut0L
         kVL9BfxAsZtfxGZGxe+sfZDakHi0gzq13LDjtSsUVbu4k1kGviyH0XIoNqGHbCaWQRZm
         8L7w==
X-Gm-Message-State: AOJu0YwY3S7D348WYgdx3P2hEdR7aBnEM/63mU2bkhOi7YwnCeafRO4g
        yZ+buewtjXK/CbsWgmoHENE=
X-Google-Smtp-Source: AGHT+IGnNXdb+UJ4t57vmW6oRjCwsQPfEVK6tlCbkzAm50ibNiQ/2l5fJcq1gCGM97LIEYHAdXCusg==
X-Received: by 2002:a0d:d087:0:b0:5a7:ba53:6544 with SMTP id s129-20020a0dd087000000b005a7ba536544mr10495811ywd.12.1700574083485;
        Tue, 21 Nov 2023 05:41:23 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id q188-20020a0dcec5000000b00583f8f41cb8sm3010757ywd.63.2023.11.21.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:41:23 -0800 (PST)
Date:   Tue, 21 Nov 2023 05:41:22 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 29/34] net: smc: fix opencoded find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
Message-ID: <ZVyzgmb/+oUJ1xcR@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-30-yury.norov@gmail.com>
 <04ff08d1-5892-44e8-bf74-802a225eeeda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ff08d1-5892-44e8-bf74-802a225eeeda@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:43:54AM +0100, Alexandra Winter wrote:
> 
> 
> On 18.11.23 16:51, Yury Norov wrote:
> > The function opencodes find_and_set_bit() with a for_each() loop. Fix
> > it, and make the whole function a simple almost one-liner.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  net/smc/smc_wr.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> > index 0021065a600a..b6f0cfc52788 100644
> > --- a/net/smc/smc_wr.c
> > +++ b/net/smc/smc_wr.c
> > @@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> >  
> >  static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
> >  {
> > -	*idx = link->wr_tx_cnt;
> >  	if (!smc_link_sendable(link))
> >  		return -ENOLINK;
> > -	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
> > -		if (!test_and_set_bit(*idx, link->wr_tx_mask))
> > -			return 0;
> > -	}
> > -	*idx = link->wr_tx_cnt;
> > -	return -EBUSY;
> > +
> > +	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
> > +	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
> >  }
> >  
> >  /**
> 
> 
> My understanding is that you can omit the lines with
> > -	*idx = link->wr_tx_cnt;
> because they only apply to the error paths and you checked that the calling function
> does not use the idx variable in the error cases. Do I understand this correct?
> 
> If so the removal of these 2 lines is not related to your change of using find_and_set_bit(),
> do I understand that correctly?
> 
> If so, it may be worth mentioning that in the commit message.

I'll add:

        If find_and_set_bit() doesn't acquire a bit, it returns
        ->wr_tx_cnt, and so explicit initialization of *idx with
        the same value is unneeded.

Makes sense?
