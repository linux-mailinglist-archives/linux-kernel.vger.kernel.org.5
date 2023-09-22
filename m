Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE17AB412
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjIVOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:51:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1487C6;
        Fri, 22 Sep 2023 07:51:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3957E0003;
        Fri, 22 Sep 2023 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695394271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4bMcSqfVOcLKjBh3MpHcTy2ewquY/v0eZ6t5YcYSsU=;
        b=aeUW8/R7sdrtUu5bKQ8tM0mSms8cN/RJt/US1tLdgOeJ8VqkZmv1ABIrObo1nhXqnyb8w2
        luF8XvJcx8yhvaZl6pJv4GqW1WA/B+R49WG4e1g7djUry4lVoAyqICvIiiWZ3hfjB91HZp
        i8gTSsFL0QECUrxUORXzVtr+tcQGjSgiCcLwXn7xfisfOFsqB0UbuN344Fa8E7KnX8HeXo
        aHQ/x9DcLz1Wwpp8GcKK+9u7kvnMVkKaKTdtYvt+Tn/ug500Bfuzo1QH1eFP8zVkT6Bzdo
        zpImVtFxJquP2fTyN8z7VSiZf8i0b/QuWGMENXdFIFcQ8WwhB8oQ8cXXxYDTzw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_charante@quicinc.com, quic_kaushalk@quicinc.com,
        quic_pkondeti@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: rawnand: qcom: Unmap the right resource upon probe failure
Date:   Fri, 22 Sep 2023 16:51:09 +0200
Message-Id: <20230922145109.578247-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913070702.12707-1-quic_bibekkum@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5279f4a9eed3ee7d222b76511ea7a22c89e7eefd'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 07:07:02 UTC, Bibek Kumar Patro wrote:
> We currently provide the physical address of the DMA region
> rather than the output of dma_map_resource() which is obviously wrong.
> 
> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
