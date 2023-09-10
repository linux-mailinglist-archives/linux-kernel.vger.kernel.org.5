Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D2799F92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjIJTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIJTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:48:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E212D;
        Sun, 10 Sep 2023 12:48:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B41C433C8;
        Sun, 10 Sep 2023 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694375309;
        bh=9UuN74tLddb723fnyqCQwHi5BUisS2bk+DV2UkYk/Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chTgpvbwfN7Y8RbuFnCymv7LXpfvmp9yYvRSVNjHGP+FszURQ20gd05OcjwMGhvbC
         l1RS5/6vHKU+e4l14VnYEy1R6voyOQCAIIg2MHWt+FPC9AT0JkUrYY1F9pMi7LhSEf
         SItw+Jnv60jb1Q3O+BFlCc94C6BtIwF68hDBvPGxSAJYuAQ7Z8vhctO2FEUeRdhS7l
         OAfFosPs99HFyC62R76IufsO5o7gAZLc2PJ+f6uvbBuaRU53rAWIpjZ4a245YXmG8Z
         19rpR0+kvcex/mzTPBLBI7tyTn2UnTmBysdEvsXh2xz6tzVKKqshVYTcDKlXd1RhCL
         1xd5xMFSou6Dw==
Date:   Sun, 10 Sep 2023 21:48:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 02/10] rcu: Rename jiffies_till_flush to
 jiffies_lazy_flush
Message-ID: <ZP4diUqkZqgSJl8m@localhost.localdomain>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-3-frederic@kernel.org>
 <CAEXW_YQ1tz4G3EwPZBx=ADVzjDiQCVPA-4GtqMpFxfRsx3oc9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ1tz4G3EwPZBx=ADVzjDiQCVPA-4GtqMpFxfRsx3oc9A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Sep 08, 2023 at 09:07:42PM -0400, Joel Fernandes a écrit :
> While at it, could we replace jiffies_lazy_flush with
> rcu_get_jiffies_lazy_flush() in the below? That way all users are
> going through the API.
> 
> With that,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,

Makes sense, will do, thanks!
