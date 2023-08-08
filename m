Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4877472F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjHHTKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjHHTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:10:27 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F4DD1AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:32:13 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9312B143;
        Tue,  8 Aug 2023 11:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691486713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnWaMg3pDXLcdgXWo2n1OSIIXOLVVnJHBw9DYZAQRK8=;
        b=MnY9VJuGz9KvfjWX5YQ/RtcCgRAL29rIouLpbf1EAhvtUwPg8l7woT1gozLX8/Uek3Aj25
        Fb67HVnLhN+ex6M+a4bBO/yCnW6my4fXhXm35oaxvvIA66u68VupqNJMAimwfv4CGC65Fj
        y1IE4fERwN7TqerqLThNewjWPHAVhhGD6dmzOjAAbUTNDmU2naImtO2y0+L87f35w1cDA0
        sLglxX1QVeaMwuJp070VJBNCPXZLnRuZTiwb7s8GwuQ6qkY47lhL/OfVM3OmK67VDERzgD
        H29uQMo8hXyKZ9ZRK6IMpkwxgFe6xt51wkAaZ8m8argYNxD9UBsCTizxb+iUaQ==
MIME-Version: 1.0
Date:   Tue, 08 Aug 2023 11:25:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 00/41] mtd: spi-nor: clean the flash_info database up
In-Reply-To: <2d86bba8-6cad-d67f-59bf-157e245edc97@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
 <2d86bba8-6cad-d67f-59bf-157e245edc97@linaro.org>
Message-ID: <ecd7b592e6aaa4ca7e98d231c74693ed@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2023-08-08 11:21, schrieb Tudor Ambarus:
> I skimmed over the patches, the idea is good as I already said.
> When do you aim to have these integrated, now or after -rc1 is out?
> After -rc1 is more conservative, as if there are problems, we'll have
> more time to fix them. Either way is good for me as long as you're 
> around
> to fix possible problems, but I'd like some timeframe to know when to
> invest time in reviewing all. We're at -rc5.

After -rc1 is out is fine. I just need to track the flash_info additions
until then.

-michael
