Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573676B5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjHANgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjHANf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:35:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554401982
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:35:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3176a439606so5048908f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690896956; x=1691501756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz0yGjO1qKDbxeRy4LT7c4IrjUWSnOv7CvFqKBtFAzE=;
        b=hMxgShGQre3lpI6O+SJtPA26y8w5YIQ1mXPh6UOJIoI/FFeXb5TlRQeS2BSTIts4hm
         sfHPXOfLjaH3SyZFXFCBAft+65/Cf+578Se8rdPmC9DBUcJ544akfd3bqeAUqDWIaFD/
         FUpsufFD+NR6J7wSvBvM4p+bh8QD67ts2Quf7S08w75bssRY+IhY26QFWtDP63xwAZX4
         jTwfpz1UOg4/bRruqkuiVr2P40aAuzCPJJA9zV9wo4DWWbmgotPMqm1jgIJMxDtdyYb5
         fwea+YAgSRvl/d+5Ey0gdrF3Mu/h6rfAZBXOp9e66se1tCp5WLMB5nKk5qKK/KhFQhUZ
         PuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896956; x=1691501756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz0yGjO1qKDbxeRy4LT7c4IrjUWSnOv7CvFqKBtFAzE=;
        b=Qg3NQ7l1EGS6WKwxSxsVIfYaHOZPCteaL+jwarK8nEZ/KaiZDh5QP9ImQmgbWS9Xkv
         9Bxi31n9I4JwIvjhycFfNwCgyhxZsNE9SxwgbP34ZqXFKTXRj0Fuz6VrsEvRNpPg+DQY
         QY2zjzvIoIYA1TGgtji+LWbKU6DUwYL80Ffg5udmGcH1hLKz+sNeWLzJuix0A06+RS3R
         JnnmSIvmdAVn4QcE6Ie8ySYzNaWABBv59Oc3Dl3a2lIWHafln29/oS+qB+1vjaF4wizz
         nBjI52jZmz+BgvX6Gv8hI+/n9Rn5c2z7ldVUIdUTUndsKyV191rwoAmEvlyK2dP2Kp5k
         cG6A==
X-Gm-Message-State: ABy/qLYbAdlhiuQRLM39MBsF10f75LurSyTaFdU/x6rMzrU6Q7Qws6OA
        iKmbtIa7A+60q9Mp6Ly3y3jxnQ==
X-Google-Smtp-Source: APBJJlEE3fGQm+I3m2rMCJV5cmNyB6ScxNrrERzEfVrSxrtWqngpVzbkVQEyAv0mF5yNf+ysKeMajw==
X-Received: by 2002:a5d:50c4:0:b0:317:3f0e:8cb1 with SMTP id f4-20020a5d50c4000000b003173f0e8cb1mr2548419wrt.45.1690896955832;
        Tue, 01 Aug 2023 06:35:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k8-20020a056000004800b003141a3c4353sm16246410wrx.30.2023.08.01.06.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:35:55 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:35:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH 0/8] hp-bioscfg: Overall fixes and code cleanup
Message-ID: <c891e1cb-3fb6-448a-850c-e94c48d32c66@kadam.mountain>
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are fine.  We still need to do something like this.  Also we could
just get rid of value_len completely.  Nothing uses it.

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index cffc1c9ba3e77..6ba0e49e787ec 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -264,7 +264,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			 * Ordered list data is stored in hex and comma separated format
 			 * Convert the data and split it to show each element
 			 */
-			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
+			ret = hp_convert_hexstr_to_str(str_value, size, &tmpstr, &tmp_len);
 			if (ret)
 				goto exit_list;
 
