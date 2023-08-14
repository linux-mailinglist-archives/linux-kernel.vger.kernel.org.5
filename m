Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66ED77BD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjHNPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjHNPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:35:42 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F06130
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:35:42 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-0QcCinrKNLmPciCBeNQiZw-1; Mon, 14 Aug 2023 11:35:37 -0400
X-MC-Unique: 0QcCinrKNLmPciCBeNQiZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE7A81C07583;
        Mon, 14 Aug 2023 15:35:36 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA80C4021B9;
        Mon, 14 Aug 2023 15:35:34 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:35:33 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 2/5] net: phy: remove MACSEC guard
Message-ID: <ZNpJxca6SE4Mii2L@hog>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
 <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-11, 18:59:57 +0200, Andrew Lunn wrote:
> On Fri, Aug 11, 2023 at 06:32:46PM +0300, Radu Pirea (NXP OSS) wrote:
> > Allow the phy driver to build the MACSEC support even if
> > CONFIG_MACSEC=N.
> 
> What is missing from this commit message is an answer to the question
> 'Why?'

The same question applies to patch #1. Why would we need a dummy
implementation of macsec_pn_wrapped when !CONFIG_MACSEC?

I guess it's to avoid conditional compilation of
drivers/net/phy/nxp-c45-tja11xx-macsec.c and a few ifdefs in the main
driver.

-- 
Sabrina

