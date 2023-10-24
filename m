Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219067D4B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjJXJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjJXJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:07:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89212E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:07:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 888771FD71;
        Tue, 24 Oct 2023 09:07:15 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0129F2CAF7;
        Tue, 24 Oct 2023 09:07:14 +0000 (UTC)
Date:   Tue, 24 Oct 2023 11:07:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: printk: =?utf-8?Q?Remo?=
 =?utf-8?B?dmUgdW5uZWNlc3Nhcnkgc3RhdGVtZW50c++8h2xlbiA9IDA777yH?=
Message-ID: <ZTeJQheCpVUE5o6n@alley>
References: <20231023062359.130633-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023062359.130633-1-kunyu@nfschina.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.01)[50.20%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 888771FD71
X-Spam: Yes
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-10-23 14:23:59, Li kunyu wrote:
> In the following two functions, len has already been assigned a value of
> 0 when defining the variable, so remove 'len=0;'.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

The patch has been committed into printk/linux.git, branch for-6.7.

Best Regards,
Petr
