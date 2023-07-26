Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F81762CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGZHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjGZHMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:12:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFCB4C3D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:08:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8AxEvBLxsBkzRoKAA--.24122S3;
        Wed, 26 Jul 2023 15:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyNFxsBkpW87AA--.53138S4;
        Wed, 26 Jul 2023 15:07:52 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        YingKun Meng <mengyingkun@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: loongson: mark OF related data as maybe unused
Date:   Wed, 26 Jul 2023 15:06:48 +0800
Message-Id: <20230726070648.700754-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNFxsBkpW87AA--.53138S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAEDGS-S68JLwABsR
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1rCr45WryDGF48CF4rJFc_yoW8Jw4kpw
        nxA3yqgrWYgr45Aws5JrWrAa4xC3s8Z3ZxGa17Gw1rKr9rA3WDu3s3JF42vF42vryUGFyU
        Xr97GrWFk3WDWFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASoC Sound Card driver can be compile tested with !CONFIG_OF
making 'loongson_asoc_dt_ids' unused:

sound/soc/loongson/loongson_card.c:200:34: warning: unused variable 'loongson_asoc_dt_ids' [-Wunused-const-variable]

Here we solve it in the same way as [1].

[1] https://lore.kernel.org/all/20201125164452.89239-1-krzk@kernel.org/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242008.xqdjgk04-lkp@intel.com
Fixes: d24028606e76 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
Signed-off-by: YingKun Meng <mengyingkun@loongson.cn>
---
 sound/soc/loongson/loongson_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
index 9ded16329747..7dd7adc13484 100644
--- a/sound/soc/loongson/loongson_card.c
+++ b/sound/soc/loongson/loongson_card.c
@@ -197,7 +197,7 @@ static int loongson_asoc_card_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct of_device_id loongson_asoc_dt_ids[] = {
+static const struct of_device_id loongson_asoc_dt_ids[] __maybe_unused = {
 	{ .compatible = "loongson,ls-audio-card" },
 	{ /* sentinel */ },
 };
-- 
2.33.0

