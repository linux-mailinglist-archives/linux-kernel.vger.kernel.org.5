Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBA7CF21E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjJSIMZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:12:22 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7FC0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:12:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9939063DCAB8;
        Thu, 19 Oct 2023 10:12:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I3-K0hwykdNu; Thu, 19 Oct 2023 10:12:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0466E63DCAAB;
        Thu, 19 Oct 2023 10:12:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gzzgvJ53A6kM; Thu, 19 Oct 2023 10:12:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF8A863DCAA7;
        Thu, 19 Oct 2023 10:12:14 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:12:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, kernel@sberdevices.ru
Message-ID: <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at>
In-Reply-To: <20231019073838.17586-3-mmkurbanov@salutedevices.com>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com> <20231019073838.17586-3-mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v1 2/2] jffs2: make cleanmarker support option
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: make cleanmarker support option
Thread-Index: aAf02iCoSu5LqB4Vzhuut+cQ9jdF6w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

----- Ursprüngliche Mail -----
> Von: "Martin Kurbanov" <mmkurbanov@salutedevices.com>
> This patch support for disable cleanmarker option. This is useful on
> some NAND devices which entire OOB area is protected by ECC. Problem
> fires when JFFS2 driver writes cleanmarker to some page and later it
> tries to write to this page - write will be done successfully, but after
> that such page becomes unreadable due to invalid ECC codes. This occurs
> because the second write necessitates an update to ECC, but it is
> impossible to do it correctly without block erase.

Hmm, I miss an explanation why this change is correct and safe.
You explain why the OOB area can't be used, okay. But you need to
add more details on why you change is safe in terms of filesystem
consistency.

Beside of that, I don't think this should be kernel config option.
Why not a mount option?

Thanks,
//richard
