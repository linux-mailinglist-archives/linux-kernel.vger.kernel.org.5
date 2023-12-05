Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F88804BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjLEIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:04:06 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DDD83;
        Tue,  5 Dec 2023 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701763449;
        bh=uVveZGVaZUbRnOAutlrO+8dx/i4swMQhmAWYmf7MjJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toBtk2dg3zME3NTivyV0eIcnfHFayW+Sj63QXxP2KybGsXPcb/EP9BYJDDBdYy+C2
         qJqStQ03416apxhNdj0VmgT1esI/H0K4OO4HGu0Ks+pTM9G5ih/ZzDAgRvZD9VtB4j
         7r1MiRQPUt/QOE1kSP3fmQgtpoV4QvN9atqH1MpU=
Date:   Tue, 5 Dec 2023 09:04:08 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > Tested by booting and with the sysctl selftests on x86.
> 
> Can I trouble you to rebase on sysctl-next?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

Will do.

Note:

I noticed that patch "sysctl: move sysctl type to ctl_table_header" from
this series seems to be the better alternative to
commit fd696ee2395755a ("sysctl: Fix out of bounds access for empty sysctl registers")
which is currently on sysctl-next.

The patch from the series should only depend on
"sysctl: drop sysctl_is_perm_empty_ctl_table" from my series.

Thomas
