Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E580779311
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjHKP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjHKP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:28:32 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2F103
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:28:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAC5020005;
        Fri, 11 Aug 2023 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691767708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bz0P3SxJy8zR8yKS2yBLUzB8Q7bU7/HvALUPM7DR1c=;
        b=h/MA780Kh3/AtKfr4gkmdN5JtETcnGRfq124gioitEZyTJRBbCKXOqepsinac4u5FVApnI
        pUVJKofm4QhDBHkmmzCk80yfwdndStgrecykRlrQF8jYusJAfwfKXLpUnmSdUQsCyeV7KV
        SSEIxNT+9Y3R96BaPjxhhPzFCvcowTzLNZDJvkriGz4elNs4ShkKiLtWUujQx10lkzEtaV
        XXfktPDyMkYoWW9y4Zmd3bJaXYAwePyayHO/0GetOO4a8Zfh8sEBuuXKMjY84JgxbK0FGP
        zFh2EjduIzKZLKMV8TmR3r8uCdxFhmkdJRBlLTI5zh7Kr6ErgeThBIXMMmmzDg==
Date:   Fri, 11 Aug 2023 17:28:26 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>, <jdelvare@suse.de>,
        <wsa+renesas@sang-engineering.com>, <yuancan@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] misc: eeprom/idt_89hpesx: Switch to
 memdup_user_nul() helper
Message-ID: <20230811172826.203aa618@booty>
In-Reply-To: <20230810121608.2110328-1-ruanjinjie@huawei.com>
References: <20230810121608.2110328-1-ruanjinjie@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 20:16:08 +0800
Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
