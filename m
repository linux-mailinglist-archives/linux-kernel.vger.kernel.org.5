Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C47B16C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjI1I7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjI1I7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:59:45 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B650AC;
        Thu, 28 Sep 2023 01:59:43 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Rx6n81lP8zB0R6n;
        Thu, 28 Sep 2023 16:57:32 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 28 Sep
 2023 16:59:37 +0800
Date:   Thu, 28 Sep 2023 16:59:37 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nstange@suse.de>, <tangqingmei@xfusion.com>,
        <stone.xulei@xfusion.com>
Subject: Re: Issue: padata: UAF in padata_serial_worker reproduce
Message-ID: <ZRVAeZuUxuWjw1D1@fedora>
References: <ZQft1jGSMSTRlxfi@fedora>
 <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:21:59AM -0400, Daniel Jordan wrote:
> Hi,
> 
> On Mon, Sep 18, 2023 at 02:27:34PM +0800, Wang Jinchao wrote:
> > Hello, I have reproduced the issue mentioned by Nicolai Stange on an arm64 server.
> > After applying Nicolai Stange's patch, the issue did not reoccur even after running for two days.
> > The test tools used were ltp20220121 and stress-ng-0.15.06.tar.gz.
> > 
> > refurl: https://lore.kernel.org/all/20221028160401.cccypv4euxikusiq@parnassus.localdomain/T/#u
> 
> Yeah, this series seems close to being finished, just hasn't made it
> over the finish line quite yet.  I wonder if Nicolai has plans to
> ressurect or whether someone else should take it over.


Hello, after a thorough study of padata, I'd like to attempt a refactoring of 
padata that doesn't rely on CPUs. The initial results on my personal computer
seem promising. Please review and provide some feedback if possible.

Link: https://lore.kernel.org/all/ZRU%2FEjubEH%2F5QLlG@fedora/

Thanks.
