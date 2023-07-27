Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078C7653A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjG0MXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjG0MXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575E2D5E;
        Thu, 27 Jul 2023 05:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9508361E41;
        Thu, 27 Jul 2023 12:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564DDC433C9;
        Thu, 27 Jul 2023 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460573;
        bh=iZW5vItg2K55eBJZzdUrTYbp+57Bd5l/7ZXnhJZsEwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9TloEwQgEzO7a9OCDEcQxrDBtpB/4UbeeODgHaIg9m9Ea1g4cznu9BLi3KBT08/Z
         Xb6+NtPIsrv/Ns2Y4fZHPPdH0gzpEjiwZIGEYbN4nz4Lhodt9yQAaIdIPhze0X+xxM
         YsdmCrqyaKxW4lJbzET1HtD4Iw9VG61mE6MKezPNNIGvjotmzZa7k+tc7QW7FtYvNl
         /MkA1Wcaz0rUQYc6R2KFupZ4b+tordLN+g+ozmKwKTeXvcaiaTVTbBHrdb90Fl5wU6
         rUcFlkeja/ccX9Nmw2nSClbteNleWPjUjNoHph3YlcpnoGjK83xemEOyq7oQYYZJuW
         7qJbRa+UGEE3A==
From:   Will Deacon <will@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Fix an error handling path in sve_set_common()
Date:   Thu, 27 Jul 2023 13:22:30 +0100
Message-Id: <169045285218.2140890.13798702323290046484.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <aa61301ed2dfd079b74b37f7fede5f179ac3087a.1689616473.git.christophe.jaillet@wanadoo.fr>
References: <aa61301ed2dfd079b74b37f7fede5f179ac3087a.1689616473.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 19:55:05 +0200, Christophe JAILLET wrote:
> All error handling paths go to 'out', except this one. Be consistent and
> also branch to 'out' here.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/ptrace: Fix an error handling path in sve_set_common()
      https://git.kernel.org/arm64/c/5f69ca4229c7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
