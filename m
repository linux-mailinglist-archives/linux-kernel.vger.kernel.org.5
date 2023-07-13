Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC8751D28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGMJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjGMJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:27:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1F273E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:27:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so264543f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689240426; x=1691832426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFy8Pts0LcMar7vgk965ZkrW+eDzYXfD6qlexHCCf4=;
        b=GjzXsO5pvr5yTnC24wSsLxq4uUHCODJvmTmNBC61pJ+VcxVO+rded2Dqz7N7GQtuHX
         /CMowCrDZYxDdNVjv1939iL0uzJlRGbIcrZQZxHhjAmfi/mt7CTOwY5CnI3e2x9uzrQv
         7FGlkCTEtYe2KdVKGXzb9zBanasR2TKajAKWqal9AFMCID9xNosS5IJ1za3fOOrR9D+0
         vyl/h9hlx9R8nCPGSq9N8BE4DZQOOHe6fNvnLVa8hf+C7IkUIgkATScrdP6uQWL37FTZ
         vf0EDOGUIZ75T0AKn98LYQJRXDu3PxyA38Jh/ELD0REyhYenvGUJqReXWYVT6SrIq54T
         qLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240426; x=1691832426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPFy8Pts0LcMar7vgk965ZkrW+eDzYXfD6qlexHCCf4=;
        b=XpG25LkLYssYkjIkDXIsIEWPmCody28F1W5SxCwnk30zgb2xYOpfcKcaDu/KqO0+wx
         52iH9ssiWVr88Ke/ad6DxgyRnmx+KINNr2QxVU5+AiESyrEdLrB4bHUCNBRO0p2am5Zf
         g1FssvhvwH4sWUwNy4Sd4oJ73RZyjBARDjGR7M/UXXuc/ge0UsfyGVhGuJtHxiAMQIG9
         wdE6NrpzPfvajwfe/a/TJnPe3rziEsVNJNQ+bgeERkJs+EKOa9DQms9s3nGykfbabHam
         8nYWqtpuyN2KVpnJk4eXNtJZ1Ch+T1ge5FTbYac0n0cElRF+qp3KSpVK1FJy4tQRU8sS
         TM7Q==
X-Gm-Message-State: ABy/qLaVE8pVKjhAzI7FWqKQTD1DehigZ63Qn5wpwtCX5aHMp2Tfh4T2
        uH+f800mjcJEfRfh87MmQHHBhQ==
X-Google-Smtp-Source: APBJJlEYX4xUqsyCGASg6QHn74arKnVrzbqutPqoE+n1RDM76O8R2nfw2NapSkpg3xu7aIhhsaWFdw==
X-Received: by 2002:a5d:618f:0:b0:30f:c050:88dd with SMTP id j15-20020a5d618f000000b0030fc05088ddmr3716529wru.8.1689240426604;
        Thu, 13 Jul 2023 02:27:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003fc080acf68sm13920059wmc.34.2023.07.13.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:27:04 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:27:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Message-ID: <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
References: <20230713085621.3380-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713085621.3380-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:56:06PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in tool_setup_dbgfs()
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

