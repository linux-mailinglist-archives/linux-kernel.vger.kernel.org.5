Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6575D55E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGUUMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGUUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:12:16 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD71358B;
        Fri, 21 Jul 2023 13:12:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2FB1E7DB;
        Fri, 21 Jul 2023 20:12:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FB1E7DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689970335; bh=cquo7MnY+jhuuXqKoMNAjoz1VAPkR7tIN7/uWpc73JI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j5p2g+haqQ/tL/lspIe7wVbWuWqe8la1+A2yWLotkS20HjVk4E+5o7My6UZ5f6gix
         5fa2UeAz+XkQcYX/nTN2AcqHZXUKwyaLOQltX12Zej1SJHtSJY64pNMIPVNxjiQeLs
         0EaYBpquM4WQYcDYbfkiw0nRnm9d36L3PqpMo93ifjrBUqb1K4uixQUFKxeyG4h6uh
         3r1FWrioPGZOhd452Ma39WYzi7Uc3zSfdgOHwWa/nH9VOv20sRIRgyVWsLlAhBUGzE
         3vSGe8qoHZVnFlKmG3Mhze2yqZ88HvF0YrY+TBfAvscIlIcFRBu4krovHRPkJXds2Z
         VH9e2Q8laAbhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
        linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH] docs/sp_SP: Add translation of
 process/contribution-maturity-model
In-Reply-To: <20230717181602.3468421-1-avadhut.naik@amd.com>
References: <20230717181602.3468421-1-avadhut.naik@amd.com>
Date:   Fri, 21 Jul 2023 14:12:14 -0600
Message-ID: <87pm4lc9cx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avadhut Naik <avadhut.naik@amd.com> writes:

> Translate Documentation/process/contribution-maturity-model.rst into
> Spanish
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../process/contribution-maturity-model.rst   | 120 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   1 +
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/contribution-maturity-model.rst
>
> diff --git a/Documentation/translations/sp_SP/process/contribution-maturity-model.rst b/Documentation/translations/sp_SP/process/contribution-maturity-model.rst
> new file mode 100644
> index 000000000000..36a6f9727933
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/process/contribution-maturity-model.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-sp.rst
> +
> +:Original: :ref:`Documentation/process/contribution-maturity-model.rst`

So that line creates this build warning:

> Documentation/translations/sp_SP/process/contribution-maturity-model.rst:4:
> WARNING: undefined label: documentation/process/contribution-maturity-model.rst

Please be sure to do a docs build and ensure that you're not adding
warnings before sending patches.

The fix in this case is to make the line read simply:

> :Original: Documentation/process/contribution-maturity-model.rst

...and all the right things happen.  I've made that fix and applied the
patch this time.

Thanks,

jon
