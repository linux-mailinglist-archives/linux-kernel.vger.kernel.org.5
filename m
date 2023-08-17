Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2877FCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353909AbjHQRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353942AbjHQRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:10:27 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3802136
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:10:22 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4D083F0;
        Thu, 17 Aug 2023 19:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692292221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KISS4diuBJN4zlTQxR2ELa6FNfvHMKCOwBLTJya1pFo=;
        b=UwodL+VoMTcvPG1OjUbP0vnbM61jpmT80T5K9/U/5wn25KAkfg/ZSRI5tO6Mz1tXCNoy7O
        4dg6eGvLPzp3YS1kiTtybUyBmLaRjX3KO1f30YekE6NR4Jt9MvUDIgBeAIG+aqLlDDmXkw
        Wr//lTUUSxg9ITRRrA3w7CPBPS8igOizRXqTAT92ryAe4vqlY2YZHKmsz9yX7HV6+3+zde
        sSPTGCbhiSpnojkOV3Bx1bcWX7g54CvvEZckyy6pdXhFU9snch2N25yyHuh8ebXPMKmdh+
        BURcB2+FHh8OZ3GE8Ymg/zeqRfXuOeH/+jHHpenLmK8dQBpKjJaKdpDveTknmQ==
MIME-Version: 1.0
Date:   Thu, 17 Aug 2023 19:10:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     SSunk <ssunkkan@gmail.com>
Cc:     miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, pratyush@kernel.org, richard@nod.at,
        ssunkkan@gmail.com, tudor.ambarus@linaro.org, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
In-Reply-To: <20230817170335.3711-1-ssunkkan@gmail.com>
References: <20230817152050.6679eae3@xps-13>
 <20230817170335.3711-1-ssunkkan@gmail.com>
Message-ID: <abd705350b650717dbbc187815d384e7@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> XMC parts seem to have SFDP tables and they should work out of the box
>> without any patches with the generic spi nor driver [1]. Therefore,
>> you don't need any entry at all.
> 
> I think it is related to the PARSE_SFDP flag.
> The XMC flash part supports SFDP, so i don’t needto add
> NO_SFDP_FLAGS() macro.

Correct. If the flash is working with PARSE_SFDP, it has SFDP and
all the information of the flash_info table is pulled from the SFDP
tables, except for the part name. Therefore, you don't need any entry
at all. The flash should just work out of the box. Are you using the
latest kernel?

-michael
