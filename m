Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD875186F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGMGAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjGMGAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:00:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C91FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:00:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso2238765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689228027; x=1691820027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CD3yM43uVnHI58j5asWPMcNTIiJ0VXkGdNi8zJM5rl8=;
        b=jPbN/2PN3o9FYzujK+crWu5CCRRJRoeTLtRw6l3ITIs32FKiFPJPLeOLwZq4h24rF8
         7oAxo5tBIscu4EdByBgJZFm24LSWy/fc9wrZA6Tw3RrLicgmsn5Ucz5H3kwQlARQ06gO
         f/BbDF3wzVAIUwd6nKXu8y6Q/2H8ScEsu83F+B9sWmZqtbatLnmExDgGb3Hh1B/bflth
         EVq1MlVLP4StOFw8L2Ju7KfWi29gNTo7AbSFuTCm2fyLx6oCZvasny0RKOYlHE/rxhxT
         M6YENiNygFmCLbjGrEeFPbny97ZvNqwchXSKwJBEMPeInyoQznQe/63M3gkcQWa/f3wX
         7qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689228027; x=1691820027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CD3yM43uVnHI58j5asWPMcNTIiJ0VXkGdNi8zJM5rl8=;
        b=aTkV8Ildh2hgAPWGbD3/7I6vyvXre0MXtB+xcUhCFfogtVX2SWPvaey2+i6T3BXHii
         KCRopWDWzkMFDh/va1J9Y0GolKBWEJEC3fnKICCZJzgUs5AAXOPJsEs/JnWTrSfnbQdJ
         MbNaK15TeqsaaXLkWu0e0/F9R0/oWSLqvwhWW3ji2KGpcuAyFy6CDRooiCKlj2mRBpxK
         uOQmtmd7X17mhEAvo4Cjx3CJ0r3t0LawDTAul0priSEuJuavuIEpLeaCt64oJD8L51u+
         G7CtIarPgDhUlIfpemau1a6cl8NNP1s0HF2v1E/4bhdBcvX6CFCi94a586DituLO4mLr
         55uw==
X-Gm-Message-State: ABy/qLYCeyyPXY8rtg6bkVL8jXKr9qYH5EfjQ+0h4Dby6qEX4TkWsM8y
        nAQ/o2Hes9f9ACJ9N5yK+HrslA==
X-Google-Smtp-Source: APBJJlHonhciDEd++BHU5EGIRUCt/hp64szoeIPE8MHsVC2B6aCGlD5ZkVr3/Z2zEogB2D9OgGuHPA==
X-Received: by 2002:a7b:c5ce:0:b0:3fb:dff2:9f17 with SMTP id n14-20020a7bc5ce000000b003fbdff29f17mr437447wmk.15.1689228026881;
        Wed, 12 Jul 2023 23:00:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fa98908014sm17443210wml.8.2023.07.12.23.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:00:24 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:00:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG50?=
 =?utf-8?Q?b=3AFix_an_NULL_v?= =?utf-8?Q?s?= IS_ERR() bug for
 debugfs_create_dir() in tool_setup_dbgfs()
Message-ID: <bc1efd80-a490-4037-9e83-e0bb5cc0cb47@kadam.mountain>
References: <20230712124035.7981-1-machel@vivo.com>
 <138ab604-27de-4ac6-88fb-0886ee8f6b6d@kadam.mountain>
 <SG2PR06MB3743C36C711A4801F4CE2304BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3743C36C711A4801F4CE2304BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:13:32AM +0000, 王明-软件底层技术部 wrote:
> Hi dan carpenter
> You mean that this modification is correct, but there is no need to do
> so, is that the understanding?

No, this patch is wrong.  Possibly harmless, possibly harmful but either
way it is wrong.  The correct way is:

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index eeeb4b1c97d2..e0acc11d29ba 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
 
 	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
 					   tool_dbgfs_topdir);
-	if (!tc->dbgfs_dir)
-		return;
 
 	debugfs_create_file("port", 0600, tc->dbgfs_dir,
 			    tc, &tool_port_fops);
