Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77877815F8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjHSAL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbjHSALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:11:25 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F6FE48
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:11:23 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSK0S4G1rz9Y;
        Sat, 19 Aug 2023 02:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692403880; bh=n6AlMqYYLWa+4W1EOruJR2eseuKtbdxHEbWODPFb5l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVKT5VmNL5l/I5wEs3VuhZaO2RCGYKQs8Li6HfMi4CSVDITTvSns+9vD+8LGOTmg+
         TDq5vIytN4m0PVb4knBjH5pMcc0zqTcPRe+eZPTbbXDaMjzUwTZISTttA/wUqrTi9o
         BiX1HXfXBKT303OBCsZ9DaB+UWfHFGkZV37F0XtDKtLKfaa6VufMHlfwIHH8gr9jXX
         M0FS2GLGbP3KymfyWxBnDC2xmPuxzKlM6LexGW9qCr7aE7fJDrFCyr6MwVmdeXn38u
         j8i9Ga+kzlXBDDxQQ4K6/KAXc3lxkqKRS1vc8f+cLfgByxdLoH53jqak7NsZ4Wk0cz
         LF6YUrQHHWIpw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 19 Aug 2023 02:11:18 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
Message-ID: <ZOAIplO6tcFN2H8L@qmqm.qmqm.pl>
References: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
 <20230818155815.GY986605@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818155815.GY986605@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 04:58:15PM +0100, Lee Jones wrote:
> On Wed, 16 Aug 2023, Micha³ Miros³aw wrote:
> 
> > of_reg is the only constant member of struct mfd_cell. It seems to be
> 
> Sorry, what?
> 
> struct mfd_cell {
>         const char              *name;
> [...]
>         const struct mfd_cell_acpi_match        *acpi_match;
> [...]
>         const struct software_node *swnode;
> [...]
>         const char              *of_compatible;
> [...]
>         const u64 of_reg;
> [...]
>         const struct resource   *resources;
> [...]
>         const char * const      *parent_supplies;
> [...]
> };
[...]

All those are pointers to const, not const fields themselves. Only
`of_reg` is const regardless of the whole structure.

-- 
Micha³ Miros³aw
