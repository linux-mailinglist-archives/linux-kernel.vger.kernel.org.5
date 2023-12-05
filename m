Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B74805BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjLERQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbjLERQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:16:50 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408491B6;
        Tue,  5 Dec 2023 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701796614;
        bh=KWkP8n96GGXrhKo85Rj+ALey16KlZtODcw3/5xOWFUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WC7mZ97GSAfwxIHjGKbWqUNzqRKjIzPKv4na8of1+OwLef5DrPCxhT+cUnDu6POxt
         yJ67y2cWp9Z3RouyCc8hqX9EIgUPCF0RA41Sks/2Psj0iqfB1SACIzzM2rsPQ7EWnW
         jWIiuWwR/Ud/4YsEqJUbAKEC3hNmnL1nhhqz4nac=
Date:   Tue, 5 Dec 2023 18:16:53 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
 <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Joel,

On 2023-12-05 09:04:08+0100, Thomas Weißschuh wrote:
> On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > > Tested by booting and with the sysctl selftests on x86.
> > 
> > Can I trouble you to rebase on sysctl-next?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> 
> Will do.

The rebased series is now available at
https://git.sr.ht/~t-8ch/linux b4/const-sysctl

Nothing much has changed in contrast to v2.
The only functional change so far is the initialization of
ctl_table_header::type in init_header().

I'll wait for Joels and maybe some more reviews before resending it.

> [..]

For the future I think it would make sense to combine the tree-wide constification
of the structs with the removal of the sentinel values.

This would reduce the impacts of the maintainers.


Thomas
