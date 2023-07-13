Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A380E751A89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjGMH6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjGMH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:05 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16526BC;
        Thu, 13 Jul 2023 00:57:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F38841C000C;
        Thu, 13 Jul 2023 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zm70Pn5WowQZi56CEQT8CB/u/lv3WH1eimTpmgCWNHU=;
        b=p02VM6E4wTbdL/iNBK7F+S+qYX5WX4yiY+5Qkjchrchqe9I8CYJ6xpK2rKceFrKVcHs4E+
        fPW7J7fPgZdvN2NB+kHsF+SFAhKZ6WpH1PHs2RbM/V/+LfSFwd8oMqgpz665lR9bx0UrPr
        jeKdkXF1th/TCs11IRZfmx+XG3SlsaCSevUDlsw0mwPez39Q4ZJk6HMbb1AAPOn5muorcA
        Qxc5xyru28pqQV8JeP9F5b6f3tGSRGNbR7S6OsvnO7lRic1VugIxw7+xQFg7W1MDSp8Fyj
        uFRvx0xZWZZ1vSKuUueWSegd0mPWT9JdG+Y1kG0Jeh9S8x3OyITRrWo+Equo3g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com
Subject: Re: [PATCH v5 1/2] mtd: rawnand: qcom: Implement exec_op()
Date:   Thu, 13 Jul 2023 09:57:47 +0200
Message-Id: <20230713075747.486046-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710054440.23297-1-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5c6a9518447ebc72606b390ab5cb3eab9dc1d867'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-10 at 05:44:39 UTC, Md Sadre Alam wrote:
> Implement exec_op() so we can later get rid of the legacy
> interface implementation.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
