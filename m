Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFE784C58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjHVVyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHVVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614CE63;
        Tue, 22 Aug 2023 14:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F54B652AA;
        Tue, 22 Aug 2023 21:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F17C433C7;
        Tue, 22 Aug 2023 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741282;
        bh=yWzv4mlWa/5L1vYouPWV/RhrZqybKAAW3OUddj6lo70=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YjUQyB4oB7yIqIGcFieZTm9ZL534ZoN6NB45tYGX+in4Wnn1ivb5b9YMCZ5CkK52B
         EluqAVWuDWqo/udOvpSuEgzhEHTuv8knB7C24o7Yt7fNEs5tzVvrX1m30R4gOYdwqk
         X/PU8VQEhtX4i33VosKwDFR3AdfHC/ks1eDzKRhnmqpgyrFSNYJKty0X+4tDVUNEbJ
         So7EoGxPfjiaPN3CmwvwzeFs7opf5mODuLJEB89IHZGuHxFEH1nBuwyGkske0TgOxs
         MNbz5XGkunENcd6EqIumpHXxp+9I5dS6JZLYlCp39itEGHzu0spSL4d107YDtwU7ST
         aGZFPowbhQW7A==
Message-ID: <ac91d7991d714e9ac0769f74fe29e4f8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-2-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-2-frank.li@vivo.com>
Subject: Re: [PATCH 02/13] clk: actions: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:54:39 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2023-07-04 23:53:02)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
