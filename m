Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921779D9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbjILUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjILUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:01:30 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1182E4B;
        Tue, 12 Sep 2023 13:01:25 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4RlZGT6RWJz1sCHB;
        Tue, 12 Sep 2023 22:01:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4RlZGS6ZMTz1qqlW;
        Tue, 12 Sep 2023 22:01:20 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 5XmMrTpGkowr; Tue, 12 Sep 2023 22:01:18 +0200 (CEST)
X-Auth-Info: /CYuj1d8CSY9w7emKuNdoE8IT8M85oBonNI0rYcXkSZzjRPMJKll2vkUZB6/Y2QA
Received: from igel.home (unknown [62.216.205.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 12 Sep 2023 22:01:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id DB4D52C12A1; Tue, 12 Sep 2023 22:01:02 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <20230912190929.54kxm7wyws7pgcsv@revolver> (Liam R. Howlett's
        message of "Tue, 12 Sep 2023 15:09:29 -0400")
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
        <20230819004356.1454718-2-Liam.Howlett@oracle.com>
        <87bkeotin8.fsf@igel.home> <87edj3b6me.fsf@igel.home>
        <20230912190929.54kxm7wyws7pgcsv@revolver>
X-Yow:  I always have fun because I'm out of my mind!!!
Date:   Tue, 12 Sep 2023 22:01:02 +0200
Message-ID: <8734zjb1q9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 12 2023, Liam R. Howlett wrote:

> * Andreas Schwab <schwab@linux-m68k.org> [230912 14:15]:
>> Any news?  This is still broken.
>
> I have a proposed fix.  I seem to have caused a pre-existing problem to
> show up.  Please see if the attached works for you, and I'll send it
> to a lot of people.

Thanks, it fixes the issue for me (tested both 6.5 and 6.6-rc1).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
