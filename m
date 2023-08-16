Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7377D701
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbjHPAVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbjHPAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:20:47 -0400
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [IPv6:2001:41d0:203:375::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067EE1FFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:20:43 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:20:06 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1692145242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/3Bsolx/C/bCd6nOgkXy1stoSxXxl8avJcHTQmWk3I=;
        b=Tpva4ZtkibnK2GpTytK/vDG7PYBOm9kMJYnKeuwzxMdOWTeVMCFi1+0qtNAw1R0lvN8wl+
        86GYlyaAkvxbIamrTP9qBx8pRsqVG6NtyDynpUFbjjfnBQ57lwQLk4o+mCD2+yPowEkhzE
        0+SaVhqII3x4UAQJV7T4lKpOz31dD9E7FiYApEQXU+Ut99HXlGW8o2ANSuyWxf9kkk2cXo
        wmbb2D2gDU7spwwImbbOzcakL/YBE5q9Ic7hYup6eqHdTWxObMCEKPEvh/lSTuW+ut2Jo8
        7bS6zyC8fM0DpbZE5PyZMLMcwYiyJB+yvd9cWpxlpolwUdMN1UBbSkdG2Emw0Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        boris.brezillon@collabora.com
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
Message-ID: <ZNwWNopPItNwKCTV@titan>
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
 <ZNm2ihdTojuPJM2f@debian.me>
 <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
 <CAGgoGu5iTE1xeupwTUUAcJv59294dNQJEf9oUWQKF72hrpFxRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu5iTE1xeupwTUUAcJv59294dNQJEf9oUWQKF72hrpFxRw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:01:02PM +0100, Fawad Lateef wrote:
> Hi everyone,
> 
> Can someone guide me? I am not sure what I am missing here.
> 
> I am trying to debug the code but I assume that the SUNXI NAND driver
> is supposed to be working and that something is missing from my
> changes and additions to the dts/dtsi for A20 SOM.
> 
> Thanks in advance

Hi there Fawad,

I've hit this problem before and it's usually been because the pins are being
used by another peripheral already

Could you post the kernel log? It might have some notes on this.

John.
