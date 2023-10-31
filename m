Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1B7DCB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJaLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjJaJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:54:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5312F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:53:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso78834111fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698746037; x=1699350837; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWALiZD+LmJgzXNjW8ZH05nKNc7IXtVIX8FUs6lSTpo=;
        b=RzHNCCpRDGl9QEd7IqwaCc9hYr9IA7qwXQeozLN4KlQk7MaeyHJXg995kATOGkdBrd
         zJ/49TuYnzsJMESiva6E6DEUVNv9I8N9OpRXdJJyoyyA97FAnJKg3iMuRZd7SFqOc0P/
         RWigy2pkHEqCjyyI5KZr51eEzFSmq7dIegk6gpNE/fFUsnc0mkRCL8jwA7ssgpZPdA4D
         XGOV4k8uuBrhnnqOoIjTY1LiAMdivh8CloZwywJiHHG0zBSCALdrTI36Y9Nebm4gHLet
         GTeJr5xjPXAJPTqAONQNI5biTnvgJ/dFXyuwHkFhaGu6X2ZU9dDig/LUDpXgrvNo5vF7
         oARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746037; x=1699350837;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWALiZD+LmJgzXNjW8ZH05nKNc7IXtVIX8FUs6lSTpo=;
        b=roTNwICzoCBKI1igUCpJVkI5k7cuDyzSzyysEa8uPpYDqzLlLgYJW27NRgdeJtruqR
         viOm/dVezncFUEKkmL2skhEF6xwgavY7MkK1zj5Tkn0VunatPWtK9MXVJ4FWPNWgkP3t
         y59nMbm+O6vXBucD5u6XIq/B5XDFKlYPJTTzlQL1mpifS/csNeHvl1yv1gv4XRetstN+
         OH7qePbBMOuV+yuSIIOzWxcPZvGbgO4dhHhg3FSP0T9K8xHjwzUBieM/0EkVLXBVAHT9
         ecy8QcD+VRvabjl2ZU9wsj4ZdX3vfOQLEqPpOQbg8ZSqcgj9Po2BSuyTP80+cChQcKbi
         hK4A==
X-Gm-Message-State: AOJu0Ywfek9kRqE+PnKqDep1kH52GfFlDhpUOSRe5asj56OPUtk6Duj8
        V6v+BCxXGldjo2kZ6wTTN6rM6A==
X-Google-Smtp-Source: AGHT+IEHXsb4rb/FV413wamIK0APOt1PRUhvDkv2ZnekSu6wmtFA8saDU7XHHx5zCQF4/tqmP/At7g==
X-Received: by 2002:a05:651c:327:b0:2c5:15a5:826a with SMTP id b7-20020a05651c032700b002c515a5826amr8672532ljp.19.1698746036880;
        Tue, 31 Oct 2023 02:53:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ha15-20020a05600c860f00b004053a6b8c41sm1225323wmb.12.2023.10.31.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:53:56 -0700 (PDT)
Date:   Tue, 31 Oct 2023 12:53:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] cxl/hdm: Fix && vs || bug
Message-ID: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "info" is NULL then this code will crash.  || was intended instead of
&&.

Fixes: 8ce520fdea24 ("cxl/hdm: Use stored Component Register mappings to map HDM decoder capability")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cxl/core/hdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index bc8ad4a8afca..af17da8230d5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -146,7 +146,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 
 	/* Memory devices can configure device HDM using DVSEC range regs. */
 	if (reg_map->resource == CXL_RESOURCE_NONE) {
-		if (!info && !info->mem_enabled) {
+		if (!info || !info->mem_enabled) {
 			dev_err(dev, "No component registers mapped\n");
 			return ERR_PTR(-ENXIO);
 		}
-- 
2.42.0

