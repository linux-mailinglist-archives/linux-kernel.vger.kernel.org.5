Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929276FD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHDJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjHDJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:25:53 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B430EB;
        Fri,  4 Aug 2023 02:25:52 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRr41-003bJ8-Cq; Fri, 04 Aug 2023 17:25:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 17:25:41 +0800
Date:   Fri, 4 Aug 2023 17:25:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add power management support in CAAM driver
Message-ID: <ZMzEFTwzSt3SZzDS@gondor.apana.org.au>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
 <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:52:28AM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> This patch set add support of Power Management in CAAM driver
> 
> We are saving the state of the CAAM:
>  - JRs MID
>  - Address of input and output rings
> in suspend function and getting same state in resume function
> on platforms where power of CAAM is turned off.
> 
> Changes in v2:
> 	- not protecting PM code under macro CONFIG_PM_SLEEP
> 	as CONFIG_PM_SLEEP is on by default
> 
> Franck LENORMAND (1):
>   crypto: caam - Change structure type representing DECO MID
> 
> Horia Geanta (1):
>   crypto: caam - add power management support
> 
>  drivers/crypto/caam/ctrl.c   | 106 +++++++++++++++++++
>  drivers/crypto/caam/intern.h |  25 ++++-
>  drivers/crypto/caam/jr.c     | 193 +++++++++++++++++++++++++++++++----
>  drivers/crypto/caam/regs.h   |   9 +-
>  4 files changed, 306 insertions(+), 27 deletions(-)
> 
> -- 
> 2.25.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
