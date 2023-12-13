Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E5811534
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441822AbjLMOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjLMOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:48:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A391
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:48:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so6119017f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702478934; x=1703083734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BHTj3zjVDU2vao7sN8K8tyFhdcU9khY6wPC0ZJAzdU=;
        b=d6nrUzNFSnWytvpsE6YkcB1b7OkvuxPH5w9hIRq9FjKOtBMkyb48D4Mf4PwnhpuOBD
         T5y835Fd9vQfKdrjQp2IXkV312AP5nldOS9GSylRKAFzwL7PaEhr3Qhi+qp9CQkuUIVe
         TTJscOWwrD46/GikijptCutlSNPqlDm7AzPRPH/gAV60FJXPQ4pJTFJdLT14eQr1T27U
         WfAAZm5fvZkhfeCvXAOV1GGoMXLwh0yXmI5Y4NqdeMTsRAensUUzTFqTsff1HcnyQSB5
         OcFzzhXRqqaPsxeyECsuA2e5hrODsbBU2SgQBCxMo1S8ePpysWv508X4YKgkM177kB4E
         Et0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478934; x=1703083734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BHTj3zjVDU2vao7sN8K8tyFhdcU9khY6wPC0ZJAzdU=;
        b=JcddS1lW1SpedSek4/9iHPwg2SC0aT70s7Zc/uEtXujojOCBzMz93pz3iWuimBIiuC
         V+GTaZLvJuhU21gqH9WxWJ8L2uAqnjTcATwTkfjtyc4ivZRI/b/tpSKKIK+EiVPwcZPD
         NePKXd1nmoJMJzCeLzYAVm+zSHhIyTav2lSvPQ5t+iLrRb84uEC1MuHxAHiY5tGESQm8
         kn+8Gu9pqTfqaEQK/PkoueuWafyC6Qxj5o4uunUXBvMpFPhdsMCFvGgt7p/Re4kldvLe
         mQ76Pw2uu7E1JKHm3+ndh0xSw9BbsjBD37sNO5FRQnDSVzX4O74/1RbQjwYoLkpj/Gdg
         6pug==
X-Gm-Message-State: AOJu0YxGoRggjZ/lAmA7NU86xFruVM4o4OwZH5TYxtjw5AKZiJrVjjJH
        bKR1O/XYvm+noNQdlNB5C3W7Gg==
X-Google-Smtp-Source: AGHT+IEWyg1ONlrYW63c9yfbqDYnALY+KU6gFCYYWgu6wCzEuBDLyEg8on9oRc9RDyY/1IiuNWcBSQ==
X-Received: by 2002:adf:f34f:0:b0:336:360e:b32a with SMTP id e15-20020adff34f000000b00336360eb32amr718600wrp.239.1702478934355;
        Wed, 13 Dec 2023 06:48:54 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6a03000000b003363fd83503sm1347100wru.42.2023.12.13.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:48:53 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:48:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        frank.binns@imgtec.com, matt.coster@imgtec.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH 2/2] drm/imagination: Fix error path in
 pvr_vm_create_context
Message-ID: <e29bd273-543a-459b-9aca-9eb612ffa2fb@suswa.mountain>
References: <20231213144431.94956-1-donald.robson@imgtec.com>
 <20231213144431.94956-2-donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213144431.94956-2-donald.robson@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks so much.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

