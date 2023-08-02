Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24576C738
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjHBHmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjHBHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB181BF9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D301D61849
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3159C433C8;
        Wed,  2 Aug 2023 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690962005;
        bh=jLElfZCc0HXALipmgfIbgWrzc2uaPkdLw7TlZL5w5oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfHlAhS0slkzx9gHMG8sHeET7oXyzk2OnJ8Iisg+rezv1a2cBrTDuIMgpfCpdvj/l
         E9FM4p3Ydk9uUXqLivnV1e7PFe35HAEIaAjQRexdKOycTyXaAXd7Ci9uXazZ2in1XM
         mUFKajz6co5xqN0nB99afK4rzadPj4n8gAyuPmIWIgZsZY8FXBTE+7czSKpdW3Z11x
         njo7tTaYKT3Qa1tWkKDBGG8bvzZPf61Pa4iHlVtVLWQYXo3/zxthU/ANFa3wcEqly+
         dUm7zroL1l373nRmKZqbI8RmDrxk+MY4V9HSoQfKAe/goou/+R6Y/+5BkwdNMw/hNB
         eHH23/LB3PJiw==
Date:   Wed, 2 Aug 2023 09:40:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH RESEND^2] nios2: support clone3() syscall
Message-ID: <20230802-abgaben-behutsam-92946d2ecbf5@brauner>
References: <20230802051924.7837-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802051924.7837-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:19:24PM -0700, Randy Dunlap wrote:
> Add support for the clone3() syscall to prevent a warning from
> checksyscalls.sh:
> 
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Christian Brauner <christian@brauner.io>
> ---
> Is there some reason that NIOS2 should not (does not) support clone3()?

Cc Arnd, in case he knows.
