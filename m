Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A367D7A00
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJZBPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:15:28 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514A1CC;
        Wed, 25 Oct 2023 18:15:26 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SG77x5Rv5z9yNtM;
        Thu, 26 Oct 2023 09:12:45 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 26 Oct
 2023 09:15:20 +0800
Date:   Thu, 26 Oct 2023 09:15:20 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZTm9qHGIyRgaF/hL@fedora>
References: <ZRU/EjubEH/5QLlG@fedora>
 <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
 <ZSCxxxMKoby6XWsg@fedora>
 <tmo426hobqdoj7ua33kwpjux243476c7rxech4x7lvmky3mdre@oxq2mfqx2n2b>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tmo426hobqdoj7ua33kwpjux243476c7rxech4x7lvmky3mdre@oxq2mfqx2n2b>
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

On Wed, Oct 25, 2023 at 02:13:43PM -0400, Daniel Jordan wrote:
> On Sat, Oct 07, 2023 at 09:17:59AM +0800, Wang Jinchao wrote:
> > This is just a design idea, because I am not familiar with IPsec, I haven't 
> > tested it in a real network environment yet. 
> 
> Out of curiosity, what's your use case for padata?
When I wrote the rfc_v1 on September 28th, I only used the "pcrypt_aead01" 
test case from LTP. Thank you for you and Steffen's responses. I now have
more test cases, but I haven't tested them yet.
