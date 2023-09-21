Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D77A903B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIUAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:50:41 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DDC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:50:26 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RrcFw1fPGz9xkGb;
        Thu, 21 Sep 2023 08:48:20 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 21 Sep
 2023 08:50:18 +0800
Date:   Thu, 21 Sep 2023 08:50:17 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nstange@suse.de>, <tangqingmei@xfusion.com>,
        <stone.xulei@xfusion.com>
Subject: Re: Issue: padata: UAF in padata_serial_worker reproduce
Message-ID: <ZQuTSeIskyDjkiMg@fedora>
References: <ZQft1jGSMSTRlxfi@fedora>
 <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
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

Hello, I'd like to inquire about something:

Since users of padata_free_shell need to ensure that all tasks in padata_shell have completed, 
how can they confirm this when they are uncertain? Would it be better if Padata provided a mechanism, 
such as padata_shell_status(), to maintain statistics like the number of tasks?

Thanks
