Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296C37E68FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKIK5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjKIK5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:57:52 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 02:57:50 PST
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2522590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:57:50 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AE36E4FB;
        Thu,  9 Nov 2023 11:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699527468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0Pp3wxLQxwvqinEldW2iB8JkRt+g+vtQ+Ggstn4sQ8=;
        b=DhiHDNjfo+83A4Ge6f7D1E28o+nCjbDt1ahL8+q0oxAO7tXocl2jBhkhutCtMla3A8oWFj
        XezJEdEE5Es65SeYXsZ6jak9edvWPvYFUIvfDwUbhkqR/CPcxzzngmbY9NSqfnva6QyC0V
        zq6/BCP/1GEqS0G6xhioLDq0ZwRVtvUfp8lyFMBtsG4CYW5sA4wjZ2ZygYJym6QF/5jpvz
        Rry+DmmU9oTWo3wnWNugwXAG3QEYeNtt6j0a/KMAyjLFs0wF8BRRZMuYfMm6VfGUtEJ3IT
        zB1yShHcA/8yyQ6FNf7pc9E6Kx47FKFIljwpo9oBLERuyRxNCpJLy6oPSfX6UQ==
MIME-Version: 1.0
Date:   Thu, 09 Nov 2023 11:57:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
In-Reply-To: <20231108094303.46303-2-acelan.kao@canonical.com>
References: <20231108094303.46303-1-acelan.kao@canonical.com>
 <20231108094303.46303-2-acelan.kao@canonical.com>
Message-ID: <7fbd05e9683e7c79d7d9ef1bf2cec5e8@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the software reset command isn't supported, we now stop reporting
> the warning message to avoid unnecessary warnings and potential 
> confusion.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Reviewed-by: Michael Walle <michael@walle.cc>
