Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C7751A88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGMH62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGMH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:01 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC92691;
        Thu, 13 Jul 2023 00:57:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7CDAC0006;
        Thu, 13 Jul 2023 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O91e1w6Iq4C7RGnZeF8oJ3LsJAQZj1iKYFvjsH6RaP4=;
        b=iKYcGWdK82kH1t+evHPcN8+R3g2sn7/dp7bp4oJ0QqZx7fnZZY+DJOOR0CvL5CxD6UGxCM
        Tr5LyKTkeUN6aYAOnDaJu3R9gKLCLucrEYcMkhkjoU1lcSLPX/kxWTJy5xFeH8sYxjBuYv
        3gbPW1rd6eAI9Ncod53LbMKeZkCoUqrpUN/HlGW7cqxNBjU2viNS8NvOt528q+g9Raw3r4
        k/4X8mM5/3vrYbUk7xYNAazebdDk4H6dIK5CUw0bZ4EbFQVJyT0Ji5yoQ8RetcFBLQ0+o1
        3d7u105gujwoCHRN1XAG2Z/OrYdGJW/ZuruxpBv0LRPmuLnRvj8fqPMSMJw0pw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Thu, 13 Jul 2023 09:57:34 +0200
Message-Id: <20230713075734.485960-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703035044.2063303-4-chris.packham@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c7758249db25999ef01b054ed792c5e0be356668'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-03 at 03:50:44 UTC, Chris Packham wrote:
> Add support for the AC5/AC5X SoC from Marvell. The NFC on this SoC only
> supports SDR modes up to 3.
> 
> Marvell's SDK includes some predefined values for the ndtr registers.
> These haven't been incorporated as the existing code seems to get good
> values based on measurements taken with an oscilloscope.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
