Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C22753727
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjGNJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGNJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:53:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127B12C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:53:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso16817885e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689328397; x=1691920397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkZHHcRsX6xT5CwFSt0BPE87o3Wbf8EEmNwVu3AS04s=;
        b=dK3IFU+sdFFeYFy+O2s+OJ9hivKr3h30WV1HuYXwbxE+ae6q9bUwX55R5WRM6On8Ab
         koPOe8Bj5neJBcTC+v53ZbKTQgrkcItOrR7t7AJonM3RFzPSd2/oXmC9OkyDZENVCir1
         wUkb69ymsyIwKYwksfRva0r9kQcVW3yGnSJTe5snk6ZSLODIH9JkO6hUtedGH6xV00YO
         0wTj4IyxDv6T/OHqBJkuc9+nZfbU1KMf94zJwJODs2u2i2AU7nsSW9oqMyAxbhWKDP0w
         5a74osDolzaa48qbTbXtkw7lTxKNmptnTipbVhcQ27Xt5x8WRzm7nglOEW4hd1uv09do
         hZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328397; x=1691920397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkZHHcRsX6xT5CwFSt0BPE87o3Wbf8EEmNwVu3AS04s=;
        b=a93gX4EeJoEPYENrWIS9hQ4R5i1JpCw9bWp8xjTou76kIsPfxkN+i7krkgV1JH5D2H
         gpwAI0kzhNT+CEar4lu4OM1jrocvbLJcBBAraBMW0Formo9KL8ds2TygwQ/+JPXW+WYJ
         HChvW6s4FzONJvPBVaiJgvgP3gKpoEMW35kGY8fyuNRpWx5p7p9uDRmC/gSpuUc+HNkD
         ZolF3LWJltHXILATihis0Jo94mxPcqN2dFwADayemooCXFLW5fIfMQAi4sN3uS6PCn8x
         Nw1BMMO2bWIj4sxlOUIdEojJG1DW10XH2gTZi2VwFtv+jJUpdb4I882RdH/ECVjYDCYz
         AOiw==
X-Gm-Message-State: ABy/qLYwlEZcUah5X4KCzQXwVjTGsxIOhbqxQhHTaQ74lItReMjo6sR+
        MGeFvaDBzulPLOynssQM9rgDJg==
X-Google-Smtp-Source: APBJJlEeo9gAOUZlKead1BmpWj8b5QWJLKPIK39T1k2tRBtPjxfuO88MJ87xg7EaQbkJrOjP2zZ8qA==
X-Received: by 2002:a05:600c:214d:b0:3fa:aeac:e96c with SMTP id v13-20020a05600c214d00b003faaeace96cmr4384362wml.9.1689328397419;
        Fri, 14 Jul 2023 02:53:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b0031434cebcd8sm10304400wrw.33.2023.07.14.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:53:14 -0700 (PDT)
Date:   Fri, 14 Jul 2023 12:53:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] Staging: rtl8192e: Rename variable pBA
Message-ID: <da405689-d41d-4633-acdc-1c03d35cb871@kadam.mountain>
References: <ZK84sYjc9uHIWZcr@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK84sYjc9uHIWZcr@basil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:35:13PM -0700, Tree Davies wrote:
> Rename variable pBA to pba in order to Fix checkpatch
> warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 106 +++++++++++-----------
>  drivers/staging/rtl8192e/rtllib.h         |   2 +-
>  2 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 6b5da38353ee..43ee1bd4a6ed 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -10,17 +10,17 @@
>  #include "rtllib.h"
>  #include "rtl819x_BA.h"
>  
> -static void activate_ba_entry(struct ba_record *pBA, u16 Time)
> +static void activate_ba_entry(struct ba_record *pba, u16 Time)

Here the "p" stands for "pointer".  This style of naming is not allowed
in the Linux kernel.  Just use "ba" as a name.  This happens in a couple
other patches as well so fix those too.

regards,
dan carpenter

