Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D97D7A22
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJZB0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjJZB0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:26:13 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84113A;
        Wed, 25 Oct 2023 18:26:09 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SG7NJ3bZDz9yNtW;
        Thu, 26 Oct 2023 09:23:28 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 26 Oct
 2023 09:26:03 +0800
Date:   Thu, 26 Oct 2023 09:26:03 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC v2] padata: Simplify sysfs cpumask and sequencing logic
Message-ID: <ZTnAK8MZzsFirDEg@fedora>
References: <202310121006-wangjinchao@xfusion.com>
 <mtuckinkekec6b5jolatrshnaodj7q2572itq6glfmvdf4yy2v@q2xmkhwegbnn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mtuckinkekec6b5jolatrshnaodj7q2572itq6glfmvdf4yy2v@q2xmkhwegbnn>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:17:32PM -0400, Daniel Jordan wrote:
> Hello,
> 
> On Thu, Oct 12, 2023 at 10:06:40AM +0800, Wang Jinchao wrote:
> > Utilizing the WQ_SYSFS from workqueue to support sysfs
> > ======================================================
> >
> > Padata relies on workqueue, and since workqueue has already implemented
> > support for cpumask through WQ_SYSFS, we can reuse this functionality
> > and avoid redundant implementation.
> > Link: https://docs.kernel.org/core-api/workqueue.html#affinity-scopes
> 
> Keeping the existing padata sysfs paths seems best, as mentioned in the
> other thread.  
Symlinks can serve both purposes, keeping the original path and simplifying the code.
I will incorporate this in the subsequent patches.
> 
> > Using completion to ensure the sequencing of the 'serial()'
> > ===========================================================
> 
> I responded in the other RFC thread.
> 
> 
> Thanks.
The extensive changes in RFC v1 indeed made it challenging to read.
Thank you very much for your patience. In RFC v2, I only wrote the
core logic instead of lengthy patches,making it a true RFC.
I've carefully considered your and Steffen's feedback,
which will be addressed in RFC v3.

Thanks.
