Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5E7D85C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjJZPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjJZPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:14:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5611AE;
        Thu, 26 Oct 2023 08:14:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c1936fd5so2482062e87.1;
        Thu, 26 Oct 2023 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698333259; x=1698938059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsnTLczFUHE++C7PelWfuJ8ZbjXsk0ne1xpTGFO0AQQ=;
        b=NRaJ0S2RIHfYa5NRPXUGkFCnIt8W/V6gprxbUoW5FIWu3nPe5Ib+M3JvgKJjT8KOxs
         t2YK6TEHfjczFwoIKbckqZiIlpcAErZJgQjBPpYUWq8YmG20J1vE1fMWFKhohhjVP9hl
         8p4Kb24N5FXq2q1yWzdNifiK+oxhhoFOmQzVODQvwDYd1U7nl0dtPhM/fQPFqShzr9jq
         SnysjOqNHAiZ24lPsknWQUrztxoiIHfkpf2frFwOaCIrkRC7YFyIBeV6UbHqQatpfA4X
         KOXXg+QwBXG9tMfPTDnzoKULzDQcmS89MvZ7ihGx+8xlz5RJA2cwfwez7Df0XDPCi8vI
         vXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333259; x=1698938059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsnTLczFUHE++C7PelWfuJ8ZbjXsk0ne1xpTGFO0AQQ=;
        b=FsPf6F5PYhmgiXcgclTTfEQEvfor9aIOriuvpC2jg92u/qg5qVjPGihQ+UeVoXqLzY
         FTVHLYI2y4JOHf+cDyT2X1LsEAPiu4cr87/87STazraqWXKCitgAVVqNo4hYVBsCCFKp
         SDMbgoHaF0yBJnZ4cx6dXfDfj0syGRGgb7rIaFnQrDjL7R0WCyL2rWW8WtsL9pVGaVoc
         RzcDZj2B5GO7J6z0GrMJ3xMnIR+GNJEKeD+nelyl6NqgLhJxOtFv8OrTPSkJodsx8pRj
         3bnLUxGRm3KxCQOLW3Sth7+zBz7+3alES9619trMuhxZ4D6zzyUklrgyzXRGt0z097uJ
         F5RQ==
X-Gm-Message-State: AOJu0YxyCnkGK+BrdLWQjsg3xbKLhN1277R1pOKlg0nTAYPi7N5W9OyR
        89ulBH0g2Ul6DFHzsGGnN9w=
X-Google-Smtp-Source: AGHT+IGj5FLFaR8N0Yl2QkzNrQwymcxdYetc0DTI2/Cjc8YDxC2mTp58qHvsXIciK7YRh+Yw989wrA==
X-Received: by 2002:a05:6512:2526:b0:503:2879:567 with SMTP id be38-20020a056512252600b0050328790567mr14166lfb.28.1698333258444;
        Thu, 26 Oct 2023 08:14:18 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id y1-20020a056512044100b00507d478c211sm3029020lfk.76.2023.10.26.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:14:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 26 Oct 2023 17:14:16 +0200
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTqCSOD5BlfZYh4T@pc636>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTkwl0bzTTCy8g5N@localhost.localdomain>
 <ZTpi6diP4h84PtWE@pc636>
 <ZTp2Ge2ILOJ4VbYZ@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTp2Ge2ILOJ4VbYZ@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 04:22:17PM +0200, Frederic Weisbecker wrote:
> On Thu, Oct 26, 2023 at 03:00:25PM +0200, Uladzislau Rezki wrote:
> > On Wed, Oct 25, 2023 at 05:13:27PM +0200, Frederic Weisbecker wrote:
> > > > +	llist_for_each_safe(pos, head, head) {
> > > 
> > > Two times head intended here? There should be some
> > > temporary storage in the middle.
> > > 
> > Yes. It is intentially done. The head is updated, i.e. shifted to a next,
> > because we directly process users from a GP. The number is limited to 5
> > all the rest is deferred.
> 
> Ah ok.
> 
> > > So you can have:
> > > 
> > > * Queue to sr.curr is atomic fully ordered
> > > * Check and move from sr.curr to sr.wait is atomic fully ordered
> > > * Check from sr.wait can have a quick unatomic unordered
> > >   llist_empty() check. Then extract unatomic unordered as well.
> > > * If too many, move atomic/ordered to sr.done.
> > > 
> > > Am I missing something?
> > >
> > If too many move to done and kick the helper. The sr.wait can not
> > be touched until the rcu_sr_normal_gp_cleanup() is completed, i.e.:
> > 
> > <snip>
> > GP-kthread(same and one task context):
> >     rcu_sr_normal_gp_cleanup();
> >     wait for a grace period;
> >     rcu_sr_normal_gp_cleanup();
> > <snip>
> > 
> > Am i missing your point?
> 
> Yeah got it. My point was just that any manipulation of sr.wait can be
> done without atomic/ordered operations. Such as using __list_empty() and
> __llist_del_all().
> 
> Ah there is also the line:
> 
>    llist_add_batch(head, tail, &sr.wait);
> 
> in rcu_sr_normal_gp_init() that can be turned into __llist_add_batch()
> 
Thank you for the good input. Indeed we can manipulate sr.wait using
__llist* functions. I will update it accordingly. So, see your point.

Appreciate for your review!

--
Uladzislau Rezki
