Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0879D88A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjILSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjILSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:19:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECEA115;
        Tue, 12 Sep 2023 11:19:35 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE3316607314;
        Tue, 12 Sep 2023 19:19:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694542774;
        bh=ZdPR4Xrn7HpWKcmeBN6s0Y6xOv+P4P1mAUlJC6Z4XHM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nyTjCpaizKcPfZZ+E0suixOKFmzweY1NAGmbC4xjaGEEksRjh2C2wjCcKn1Q/mFZV
         P0BSC50j8cXnn+UdyY8SAzQJXeAPWkIuk24OzoK0+b8cQZLiYghgg6C/YECjCVVreh
         PstsP8yCsnVV/5z2MRMX8RWxZqjRso2wV999zF1abqrVCpVzNmEY/IGZnuSkaPzJh1
         rq4w6jmf9I3DpJuxWllauiKgOfwblMohz/ibLmvqsslz0gxhbYulN9s107tBUlfzqV
         1SMv3/wsuSFomT5rt4ZIKA5uA19Pz+hdD5pGbGRytuLMLRsgeoso7bHKRDqcpO6cTw
         uxY2SM6s3kkSw==
Received: by mercury (Postfix, from userid 1000)
        id 4740F106098A; Tue, 12 Sep 2023 20:19:31 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20230814-void-drivers-power-reset-vexpress-poweroff-v1-1-c3d9b0107e5d@google.com>
References: <20230814-void-drivers-power-reset-vexpress-poweroff-v1-1-c3d9b0107e5d@google.com>
Subject: Re: [PATCH] power: vexpress: fix -Wvoid-pointer-to-enum-cast
 warning
Message-Id: <169454277126.489158.9426280067711996461.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:19:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 22:21:51 +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/power/reset/vexpress-poweroff.c:124:10: warning: cast to smaller integer type 'enum vexpress_reset_func' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         124 |         switch ((enum vexpress_reset_func)match->data) {
> 
> This is due to the fact that `match->data` is a void* while `enum vexpress_reset_func`
> has the size of an int. This leads to truncation and possible data loss.
> 
> [...]

Applied, thanks!

[1/1] power: vexpress: fix -Wvoid-pointer-to-enum-cast warning
      commit: 4ec7b666fb4247bc6b9cdc84fa753d8dc2994d25

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

