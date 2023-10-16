Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65997CA476
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjJPJpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:45:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7482AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:45:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4075c58ac39so44156175e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697449541; x=1698054341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4gFeAGcNfSMTJr1b2bXzs3lCO22px++fHRFICWCI/o=;
        b=H5UHIVKLJ/EQH64aDMR0/2/rqeSj5YpcK6nXbT/LAEFujo+Zh7FTIyBL+kRvA8FXOL
         wXhi+b+KhgFe7gjSoGmWdSsbWjUG0NK9rXsGx5Wy8p1QiRlbMJP8I/AYlvdesruwlBdr
         dYIG2LKZoaABBKd7J7lxyuS7NPHIdCZI1BTx19oufAq6oGQXTyr+9OM1QfNxueodbYGu
         WxJdKMA9aFHqtBwK2URbsOkJmEJk0IJOjvbNi7OoKudjB+bntZQOZ6XApO7bDf8bdWjI
         zABZMi5GsPRtNDBlx4h8qEta9zwjQ7QbBo3MUYv70voOGpCcJuU9F4t5kJOfe4xUoM23
         cFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449541; x=1698054341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4gFeAGcNfSMTJr1b2bXzs3lCO22px++fHRFICWCI/o=;
        b=Xu5AIoYQ6YLE4hOZtCxhxs9fmTJoDAYSp56+HvdG/RRVLfAwWXsAgNnMaooVKV3VAZ
         VNMn8JkFYrFSY+6c4SciPgUpuzsx1uazTBkYNf5n3k4sPGa/yDwYO0zE+CeKiAVoatv6
         50RTgT7duk3bbn8xFpEbaw0N4gQ8hMokzYqbLI1i9Iw8ITjQXFfhym8nTGJzcBO7P1gz
         3Tr+Gi9XFZa2pLBE82igStdFeY1HHGyFM3N/dYC2jgTzn6kUhvZv27ye/wYu8NSKV4Hv
         MDx/ZzNj7qHG1yXs0+3oKctwZpdWzTbOrkPQ2H27Vk82gzVW6VMJ5WNgkiifGlUgUrAn
         XM1Q==
X-Gm-Message-State: AOJu0YwOt+erNimLoPgkWny9HImSAPSTPmR/Tsb5h0A6WXQWt8TYNXYn
        iSrcYgGiJ8NixrxcZERsgsw=
X-Google-Smtp-Source: AGHT+IFliSDRd2vcn0qyp1QnVM42hWucD0jCdtjuD9O3dEjKMLjFIl/6modM2A5tqS8JOlXfQTPEEQ==
X-Received: by 2002:a05:600c:3652:b0:3fe:d1b9:7ea9 with SMTP id y18-20020a05600c365200b003fed1b97ea9mr28176479wmq.36.1697449541025;
        Mon, 16 Oct 2023 02:45:41 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003fee6e170f9sm6669041wmo.45.2023.10.16.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:45:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 11:45:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZS0GQoEsG/20IvnE@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
 <ZShALJDaxJ9VJvek@gmail.com>
 <20231012204347.4aei5jr64fsv2iv5@treble>
 <ZSkhE2GWfGRW+9Hh@gmail.com>
 <20231015141147.qeczgcfnl73zcqao@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015141147.qeczgcfnl73zcqao@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Oct 13, 2023 at 12:50:59PM +0200, Ingo Molnar wrote:
> > 
> > * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > 
> > > On Thu, Oct 12, 2023 at 08:51:24PM +0200, Ingo Molnar wrote:
> > > > > Another way to avoid ifdeffery:
> > > > > 
> > > > > static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > > > > 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
> > > > 
> > > > I think we could make it a simple:
> > > > 
> > > > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);
> > > > 
> > > > Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
> > > > Maybe add a comment to the enum to maintain this property in the future 
> > > > too.
> > > 
> > > Hm, that both obfuscates the default and makes it fragile.  The fact
> > > that it would need a comment to try to prevent breaking it in the future
> > > is a clue that maybe we shouldn't do it ;-)
> > 
> > Can be enforced with BUILD_BUG_ON().
> 
> That replaces fragility with brittleness.  If we change a default then
> we have to go rearrange the corresponding enum, and update the
> BUILD_BUG_ONs.

How realistic is that? A world in which an enum named '*_OFF' isn't zero 
and the most obvious second enum isn't 'auto' would be unconditionally sad 
IMO...

> More importantly, it's still less readable because the reader now has to 
> go read the enum values to cross-reference the hard-coded values of 0 and 
> 1 with the enums which are used everywhere else.

They'd have to do that anyway, to make sense of the enum jungle.

Thanks,

	Ingo
