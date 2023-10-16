Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151527CA419
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjJPJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjJPJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:27:14 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F09E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:27:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8D0D1BF206;
        Mon, 16 Oct 2023 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFW0Jrjsf+b07Pgsc3hiAmE88v7StBvbhAiMGdt8Tzs=;
        b=gB7khUAQBFkZgZ1RlUWVrmOulhGBAe20mxKklKnmM6h/qG9riz+PmseFhH2hLBk33bBc6B
        qGXlAG+Rr1/NuoXE7Www8qp57AWx4c82VXY/lilpFS9UPtMPyOI+/sg9SM4x/XIWAjaupu
        zMBiCRnFvkqAaquw7htf6Fj3G7HpRsgNKERT10TYbkgBIjysg4InUqJkPAgCN1DewyRfnW
        0T6HMX3SK5V/DFplJD31TigYuhAIjjr78JfnJjt4r3kBEYQfnb7BFKHyRcfDk9I+B2QEdp
        IQ3VFNuPkeiGvPKKVGZrX9PxAz+S5/EIUtdhaktKJMoaQcvMot8AEz3aLULi9A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Use device_get_match_data()
Date:   Mon, 16 Oct 2023 11:27:08 +0200
Message-Id: <20231016092708.288288-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009172923.2457844-1-robh@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6135e730f81d7fdb8864f9f8e102bcb8c8351552'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-09 at 17:28:56 UTC, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
