Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6C753191
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjGNF57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjGNF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:57:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFF2D46
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:57:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1645613f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689314272; x=1691906272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPQ9teSwd7Nb0FFHLc2ex+bU+I6qkcibvl/8wSBGpM=;
        b=mpRqdXBs8lf/WLyEeojTNe9gL7TaquUgfb/wvL2K/bifpt0UIXhRSzaLPzzNy33XY/
         yyAMv6o6KSpYRQEG9t9Fm+OH22gcjDUXIydlyvTrpqPQSzLXqY5KxYsPdvIZT38PqJMr
         5CgNVtPMpQ1/hzxc/9cbr0C2tTrVBoJ038wIA5Oc5STTsg1qMN8jTySe+w3wGfwVFA7z
         6oomNO5mP5ddl4X/7t+6e+kO+nELxB0PDUxl1UjjkIUHyT8/TAIjla+o/3vqFqfWPRrR
         v+iP3HI9vQihXu4ujzNHXnnFR7W/JMJZksnAOaKxRrrMqs5cszQi+0ZoyTzXchMfNUhA
         jkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314272; x=1691906272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwPQ9teSwd7Nb0FFHLc2ex+bU+I6qkcibvl/8wSBGpM=;
        b=cqGeZaiR9MWszUNvL/BBbSWokis+vDBGz2pmC87TYnnLoS0h46jGMbYIPDf/GWflZv
         NbJ4HEyZNZFS1nZuIQWvOdVr/3Td36up146GT2ZcQFYvDOL50LFsz2GWbLIsYQHtee3U
         70qDr/h2J1YApR33z+FE4ZUONH4238FCryh8Vl1JTeZewpQXeQbVRfXdfZ2ej/igueuS
         xRWou8IDhm2SxAQLOjlpM8CI1edJ7ash1Z+JOc4t7A7mSNFKmpirHBrHCeMs6sAVh9dw
         0wtrkClO0jJgt6X9E4eAXXk+9A/DofTUVWJlK4p2JxeAHEH7t+TLvYDCv5e7N4ogqfM3
         Q0dA==
X-Gm-Message-State: ABy/qLZPAJsmWHBiyZn/cl17aM5JgtVV0N+2JNiEUzgsZ8CijM90KhmU
        r+pK+bcRM/2GbvQmu4qQDWzOYg==
X-Google-Smtp-Source: APBJJlEiO62Awkmfn/b8CTowVt52CzGQlfo4zygUtugdcmsF4JuaJ1Tq6jXK3SdounlkLp1n8IkMlw==
X-Received: by 2002:a5d:680b:0:b0:316:f099:209f with SMTP id w11-20020a5d680b000000b00316f099209fmr173009wru.70.1689314272135;
        Thu, 13 Jul 2023 22:57:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6712000000b003113ed02080sm9735214wru.95.2023.07.13.22.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 22:57:50 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:57:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
        kernel-janitors@vger.kernel.org, ntb@lists.linux.dev,
        Allen Hubbe <allenbh@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jon Mason <jdmason@kudzu.us>,
        Serge Semin <fancer.lancer@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <791a3c06-47cd-450a-8c4e-24fe52fdaa4e@kadam.mountain>
References: <20230713085621.3380-1-machel@vivo.com>
 <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus is banned from vger so only people who are on the CC list can
see his email.  A number of maintainers have asked him to stop
commenting on patches.

regards,
dan carpenter

