Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75428762415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjGYVEa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:04:28 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69354E3;
        Tue, 25 Jul 2023 14:04:27 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 2074F140EEE;
        Tue, 25 Jul 2023 21:04:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id D02C320025;
        Tue, 25 Jul 2023 21:04:21 +0000 (UTC)
Message-ID: <27446992c6fcc982a26085151988f7be3aa1e3d7.camel@perches.com>
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 14:04:20 -0700
In-Reply-To: <20230725125601.7ec04aa5@kernel.org>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
         <20230724160214.424573ac@kernel.org>
         <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
         <20230724175612.0649ef67@kernel.org>
         <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
         <20230725123842.546045f1@kernel.org>
         <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
         <20230725125601.7ec04aa5@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: npphdcb6o1xt7dirfqjttg8pcz5oi8tx
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: D02C320025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19edhjucITOZNxGaHNgPF8dnt2qV7nJGAY=
X-HE-Tag: 1690319061-31213
X-HE-Meta: U2FsdGVkX18KZrCWQEg3rXO6V8qyzoOYddB2+v5JJF+iebXEdolTvXazmweMGU81DZgniu1ckllN+InUEiomf3MJ+syYj5wyBrq5DxrJRD8ViLYWfN5kkhhwZPaS49ksU8X5NE30uTbL75CXi5/YjsQdeB9LCB0TE0vqfKRn6fe3JEd5TddiqlqZMhBz1c6xAm4Zr35dGjhQWPwfM++3RUrq5UT6AssZQsVHC5QM1cD1Zivo22hB51siXvr/sg+HvwtZ+NPPuhi6fBji3mzdW0F2BJQPsHmlNHTZDz2FKc8uUqIsVvadNaYiU6Wptosm
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 12:56 -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 12:50:00 -0700 Joe Perches wrote:
> > > > What do you think the "case" is here?
> > > > 
> > > > Do you think John Fastabend, who hasn't touched the file in 7+ years
> > > > should be cc'd?  Why?  
> > > 
> > > Nope. The author of the patch under Fixes.  
> > 
> > It adds that already since 2019.
> 
> Which is awesome! But for that to work you have to run get_maintainer
> on the patchfile not the file paths. Lin Ma used:
> 
>   # ./scripts/get_maintainer.pl net/sched/sch_mqprio.c
> 
> That's what I keep complaining about. People run get_maintainer on
> paths and miss out on all the get_maintainer features which need 
> to see the commit message.

Which is useful when editing a file but not when sending
a patch.  get_maintainer does _both_.

Again, there's no issue with get_maintainer, but there is
in its use.  If there's a real issue, it's with people
and their knowledge of process documentation.

It's _not_ the tool itself as you stated.

