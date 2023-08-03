Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809B76EA1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjHCN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjHCN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:26:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EDE2D72
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:25:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so1713086e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691069133; x=1691673933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX1yN9Ixci8IcrltYrGugFYIQgxWeNIjdcjZ6DOu8VQ=;
        b=h/MIjuBQXoq05U76MfpTugGQ2wCdqSY2kmw1KLU/UJEdzS10EiaxXnFcx2Pa7UrOSD
         AIdCBmmrf7qeZ6zxosxhoZDak+n9PRiRcPhbj3ppia9szhEYOj+bPU8Q3ynsT9auiKVK
         bilo4hSsuRixPhCcUfMKS7ScmLB2xhU0OewQ7YaFDgOGscEG9PF6S02hIUyj0YCl4d/0
         8E50basgRjz16AUTCMOcy0un1MvywpRWGbmieM4MoOdbzczAP7HttoF1rcd5SJFlwayl
         QKz9PBAvpCCXGNNFCwO7My9CTJWBD4sXyC/1hqzH0Zr7jUfd8CTxYNMMFoKSDakuW0Pv
         sC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069133; x=1691673933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX1yN9Ixci8IcrltYrGugFYIQgxWeNIjdcjZ6DOu8VQ=;
        b=boyQT2b5TaG0w4vxx4xH+1pSQGTyPKj2llkgbcDcHugwxfNpLfgvs6hAxhz5rDOmZy
         IJrR8zIRjCOE4bpX8O9v3YkxI/pfGKF5b+DMi8gqv4Qk3VAcRKespK+TmPbORrmXOLiP
         OaWolB1AkAZNeuBo48d0X/nnil+Wic13pRjIEdg/GREH/hbQrEn9CNlvO1tCrR2j1mH2
         nsPTzHvd8xdIqW8GXLGkvozqsSe+FVMwOi3E2yuT78No8th6qzrdCQF9xPIEnPuzpym3
         T03++Y7QXxFl2TkMmbWN622TsTdOlhJjfVFriEbPx7uzeRio9h0tpXvZOGnv4Xd5FVEC
         rxXQ==
X-Gm-Message-State: ABy/qLZlIiF6Rggy8KT7tYPbIe0nrQOmOJTZ3JkjJYr5+LND3Ys/nI8b
        55uSUzjy6azJ+8+Gbp9qKXaImA==
X-Google-Smtp-Source: APBJJlHYeqEwy6KD1OxnrtjOYODMuMnIXYbY4rZvxsbyH+nY0Epj5By3KPyjIh40xnsMlFIvZF5QuA==
X-Received: by 2002:a19:4f1a:0:b0:4fd:c0dd:d54b with SMTP id d26-20020a194f1a000000b004fdc0ddd54bmr7273358lfb.65.1691069132854;
        Thu, 03 Aug 2023 06:25:32 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090616ca00b0098d486d2bdfsm10574938ejd.177.2023.08.03.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:25:32 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:25:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
        hkelam@marvell.com, sbhatta@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH v1 net-next 2/4] tc: flower: support for SPI
Message-ID: <15ea5ace-db96-4839-8376-b885cf32c6d5@kadam.mountain>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
 <20230801014101.2955887-3-rkannoth@marvell.com>
 <ZMqpd2DyHz4O/v17@kernel.org>
 <664b202a-d126-4708-a2af-94f768fe3abd@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664b202a-d126-4708-a2af-94f768fe3abd@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done.  :)  That false positive has been bothering me for a while so it's
nice to have it fixed.  I'll test this out for a bit before pushing.

regards,
dan carpenter

diff --git a/check_index_overflow.c b/check_index_overflow.c
index 19ea4354029b..644310ae837c 100644
--- a/check_index_overflow.c
+++ b/check_index_overflow.c
@@ -160,6 +160,43 @@ free:
 	return ret;
 }
 
+static unsigned long __TCA_FLOWER_MAX(void)
+{
+	struct symbol *sym;
+	struct ident *id;
+	sval_t sval;
+
+	id = built_in_ident("__TCA_FLOWER_MAX");
+	sym = lookup_symbol(id, NS_SYMBOL);
+	if (!sym)
+		return 0;
+	if (!get_value(sym->initializer, &sval))
+		return 0;
+	return sval.value;
+}
+
+static bool is_out_of_sync_nla_tb(struct expression *array_expr, struct expression *offset)
+{
+	sval_t sval;
+	char *type;
+
+	if (option_project != PROJ_KERNEL)
+		return false;
+
+	if (!get_value(offset, &sval))
+		return false;
+	type = type_to_str(get_type(array_expr));
+	if (!type)
+		return false;
+	if (strcmp(type, "struct nlattr**") != 0)
+		return false;
+
+	if (sval.uvalue >= __TCA_FLOWER_MAX())
+		return false;
+
+	return true;
+}
+
 static int is_subtract(struct expression *expr)
 {
 	struct expression *tmp;
@@ -286,6 +323,9 @@ static int should_warn(struct expression *expr)
 	if (common_false_positives(array_expr, max))
 		return 0;
 
+	if (is_out_of_sync_nla_tb(array_expr, offset))
+		return 0;
+
 	if (impossibly_high_comparison(offset))
 		return 0;
 
