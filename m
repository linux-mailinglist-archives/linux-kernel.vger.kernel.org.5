Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B178F300
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbjHaTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHaTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:01:51 -0400
X-Greylist: delayed 76618 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Aug 2023 12:01:46 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6234E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:01:46 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Rc9W85fh1z1sCHT;
        Thu, 31 Aug 2023 21:01:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4Rc9W73sV1z1qqlY;
        Thu, 31 Aug 2023 21:01:39 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 3t2LcBBBC5P6; Thu, 31 Aug 2023 21:01:38 +0200 (CEST)
X-Auth-Info: lXkH32dCcJBd+12DFQPqBK2TsYUkx9qeK/d1QE75ehLNaJXCOJQ9jpTXTWJ0N5Py
Received: from igel.home (aftr-62-216-205-244.dynamic.mnet-online.de [62.216.205.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 31 Aug 2023 21:01:38 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3B0CF2C1069; Thu, 31 Aug 2023 21:01:38 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <87y1hr22o1.fsf@mail.lhotse> (Michael Ellerman's message of "Thu,
        31 Aug 2023 15:37:02 +1000")
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
        <20230819004356.1454718-2-Liam.Howlett@oracle.com>
        <87bkeotin8.fsf@igel.home> <87y1hr22o1.fsf@mail.lhotse>
X-Yow:  Everything will be ALL RIGHT if we can just remember things about
 ALGEBRA.. or SOCCER..  or SOCIALISM..
Date:   Thu, 31 Aug 2023 21:01:38 +0200
Message-ID: <87cyz3594d.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31 2023, Michael Ellerman wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>> This breaks booting on ppc32:
>
> Does enabling CONFIG_DEBUG_ATOMIC_SLEEP fix the crash?

Yes, it does.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
