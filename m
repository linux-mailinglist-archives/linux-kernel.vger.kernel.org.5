Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8867EA6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKMXNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKMXNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:13:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A9D48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:13:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A4CC433C8;
        Mon, 13 Nov 2023 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699917209;
        bh=7+/zcxGO6lPV0Gz9Szr7juclgjxrwXfeqmICyjwZJf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFPppTHb/5Va9ufC5gyqMsSZGmhFa/faLikrS11jLNJyZj73DgNitNgs7DYg/2tUc
         uvP13w84f3GJNjiMypAoZOzBfN+Q/UBcRg6QrsZVNYtue0CWn8bCaf2s5rhraQLSJt
         JkNsMWMFxvlZRiqpjInGEoDk+lieeN5M6nx1CkxVeoZbjq0iBUP40bcq9E+APIuKIl
         zLeBva33e8EIZkDs5I0Ot+0ObtSOIpeLZmyUqWu2dZAoCWbEYrLIGrqnT6yfW9hEyB
         sLtPIHjv5Q/ASMjeQckKbDtIGNyCO93XuEICBbbA+448uU8eezAGTcRHSoW2lAoBTU
         xKaABAb0mg6mw==
Received: by mercury (Postfix, from userid 1000)
        id 5578C1060A25; Tue, 14 Nov 2023 00:13:26 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HSI: omap_ssi: Remove usage of the deprecated ida_simple_xx() API
Date:   Tue, 14 Nov 2023 00:13:03 +0100
Message-ID: <169991694447.227822.10264740296784385491.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <d72106fc9de28ef8db2ed653febe366d141362a4.1698831563.git.christophe.jaillet@wanadoo.fr>
References: <d72106fc9de28ef8db2ed653febe366d141362a4.1698831563.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Nov 2023 10:39:39 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Applied, thanks!

[1/1] HSI: omap_ssi: Remove usage of the deprecated ida_simple_xx() API
      commit: fa72d143471d04ce3055d8dad9743b08c19e4060

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>
