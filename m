Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDEE781409
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379869AbjHRUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379850AbjHRUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:02:38 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BA1706;
        Fri, 18 Aug 2023 13:02:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 279FE1BF204;
        Fri, 18 Aug 2023 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692388955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBuafLkRO12L2VXNLAEirbbppACezhDPBaIxB+yiYEU=;
        b=Iz4YoMrKD4JwW+Zqar+V3hnOvC02vxCUQjGjrLCiHD/2Jw+HZZE2Bu9Th+sZ/TuAX5LtdS
        irBAAiXipFLFPwREVmTvdVaEGCQZe6FO4ikDYw7Llz69hJI/1n01XTzpvasgGAnhknfF12
        ex38pT+uelRgNSdG+MmN9wkDTmW9rLN7zKeptMTtGkZvstFml7SNx6fNC1p0GeR4ShA33K
        2WCd+Cm2DULg/vpP8zNa+HojEdZYUZrEjx4OCLVUZifrkPyHMTNdaQiG1R8TkzgZqvZckC
        S26JTJmXEMn3lm2qxJsrgfSjP5SRBSqqQCrPSiryllQ2b7t/0jZEXdfd8QV9sA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com
Subject: Re: [PATCH 3/3] mtd: rawnand: qcom: Add read/read_start ops in exec_op path
Date:   Fri, 18 Aug 2023 22:02:32 +0200
Message-Id: <20230818200232.149295-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818145101.23825-4-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5a7688a3e2e6293b6b405322b8fbdbb2a0508511'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 14:51:01 UTC, Md Sadre Alam wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> READ/READ_START opcodes are not set in exec_op path.
> Fixing that here.
> 
> While there, Steps to program the controller is common for
> erase/reset/read/program page. So use a common pattern and
> pull them under one function.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
