Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D250779320
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjHKPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjHKPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:30:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B783103
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:30:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50014FF806;
        Fri, 11 Aug 2023 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691767817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4xKF+hjlslSDA42bTjS22AZxekN3RRqU/NumeMIP7I=;
        b=MetvjAq7OxwnCMlgu6pPKRwlGrdB0VLjKsbNDayVkECB3VygxaAlbXT6wpedXmCjgHyQQp
        mT4L6wvG/iM39QjU6UwxAMpTJQ9MkpYksbmz9lFrQp789Q0IRIJCvVHM36VT8cIUO8d+2a
        afoXLx/ShaVrkhkO0YRCMBYHo5f4UFAU7XhlG4ggqhfNoIEI6v26WROq7ZNkzXEGVWkmp1
        LQGMQMboXO6K0t5wSHIUqmGShVvdIqKPQDk9hpz7eMmJB+KA2P6kyqYIbYAeCKmryknow4
        hZO8z6h2+eHuKJOAKwsh/FtcLzXHeHZDp31rKdkPf/npbJ39RYxvbX5Vvo7GGw==
Date:   Fri, 11 Aug 2023 17:30:14 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>,
        <wsa+renesas@sang-engineering.com>, <jdelvare@suse.de>,
        <yuancan@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] misc: eeprom/idt_89hpesx: Use devm_kmemdup to
 replace devm_kmalloc + memcpy
Message-ID: <20230811173014.4cf38c79@booty>
In-Reply-To: <20230810115049.2104099-1-lizetao1@huawei.com>
References: <20230810115049.2104099-1-lizetao1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 19:50:49 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Use the helper function devm_kmemdup() rather than duplicating its
> implementation, which helps to enhance code readability.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
