Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBB78FFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbjIAPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbjIAPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:21:28 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C151704
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693581666;
        bh=j81HFEWNvfGv2L1WPdr+sCdKYxrG6nL7umPela9V0Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CGICvdDcaFR8IE1SiTPR8qhtfE/L0kdiR+J8aAqEnvJ6y70pnn1ULWOG58MCJXYMq
         lTzZcEYvoPXtFOtO3D4RulHPuKQDlhRd51NCfeFRiRWMUFatieQYLoUzJewXvNqMux
         wDa1/bm8aS9DbPzDrvvpWsziAuuE5wYwW7EAaQdGnZQBv/LIlvq6lB+7yZD6kUutzi
         4OdivLtvI/0a+kNhTcqfgPiTA5VozYilW0kKJYf2EsqSSzmTIuBq98bN6LFb9iFObX
         Fy47rpreXdWZROsT+cR/Y0rJID1q3q8TA8OSbgewgv/ADeNpEkXO3LsqWf3hGDk3Y7
         ykByfFNdatelQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id D307824B39E;
        Fri,  1 Sep 2023 22:21:02 +0700 (WIB)
Date:   Fri, 1 Sep 2023 22:20:58 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Message-ID: <ZPIBWlhQWCkqI65k@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
 <ZPHPJDXIkFfP5Eux@1wt.eu>
 <ZPHh0duonHnyAX6C@biznet-home.integral.gnuweeb.org>
 <b6a33f1c9c0544c29904e29b06a7cff8@AcuMS.aculab.com>
 <ZPH4I2W+zvhK93U/@biznet-home.integral.gnuweeb.org>
 <0d4effd9255143d6a7d90b5b37f01cdb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4effd9255143d6a7d90b5b37f01cdb@AcuMS.aculab.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:54:56PM +0000, David Laight wrote:
> I'd forgotten about the (stupid) return value.
> 
> I'm pretty sure it is an accident from the original pdp-11
> implementation from the days before C had an explicit 'return'
> statement.
> (The pdp-11 I used ran RSX/11M - so had a Fortran compiler
> not a C one.)

You're old. I did not exist in that era. And my parents were still young :-)

-- 
Ammar Faizi

