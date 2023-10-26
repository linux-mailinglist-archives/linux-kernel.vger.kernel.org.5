Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C587D849B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjJZOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345233AbjJZOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:24:45 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD71B3;
        Thu, 26 Oct 2023 07:24:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB058240008;
        Thu, 26 Oct 2023 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698330279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PziSD1PgLb0667xILGVhhWhS3pJpGafG9WCNyplDM6M=;
        b=QIn7GuOInRvzLopWLDpEwkNAHOMLbAID0zp3gldafosregQkAiEFK3AidlLnrta4vGYG4y
        wr5A5L4tEgRVFz6aDtcbpalX2QiVE7UgBQla1eH5D+AaaCpOUCM2d7EkqGfs9QCWHHExWY
        KgKsYMAFdux9kQYKH4Dr5F88YDwjoxpvGkDZ4ydIhkmDgh2c+IhcdLWMdgUOa3FhrWvZXb
        fi1g9c84ant7cWC5XmGIy0/bcZQanfqqXLE9L2VH36Zz+NSpS16lVJgwHNZj2j8BP8PaX6
        OHMers7IgTCaRz8Pels/IChplDKbacwVhDlxNpUIxSHIXwEeb3h7Yf2EHrZlvg==
Date:   Thu, 26 Oct 2023 16:24:38 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] of: address: Consolidate bus .map() functions
Message-ID: <20231026162438.5b063044@bootlin.com>
In-Reply-To: <20231026135358.3564307-3-robh@kernel.org>
References: <20231026135358.3564307-2-robh@kernel.org>
        <20231026135358.3564307-3-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 26 Oct 2023 08:53:59 -0500
Rob Herring <robh@kernel.org> wrote:

> The bus .map() functions vary only by checking the flag cells values
> and skipping over any flag cells to read the addresses. Otherwise they
> all do the same reading 'ranges' address and size and returning the
> address's offset if it is within the 'ranges' entry.
> 
> Refactor all the .map() functions to pass in the flag cell size so that
> each bus can check the bus specific flags and then call a common
> function to do everything else.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
