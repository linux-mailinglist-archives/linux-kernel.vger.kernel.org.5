Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39EC7C4A85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjJKGZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbjJKGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:25:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FC98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:25:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3af86819ba9so4311176b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697005550; x=1697610350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4ClZHxvE21Enzoh0NDOpqo3NyWl05PNFYEBBDPVGmQ=;
        b=eHIFx8ZaSgteUCK2t5IDDLiUmpiTPgieXoYUujI1ZcXJqian/auYv4aJ9kakogvXIF
         d6fU9jIgAu0QdZ4sdTtAZpSoDgeIuuHQZaWselYEO2jdJ7ZbZSsCjtGRUoAW2inEgZHc
         hElPXAJxCwya1al8l7EfqC6eHlXnoAGbp8yMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697005550; x=1697610350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4ClZHxvE21Enzoh0NDOpqo3NyWl05PNFYEBBDPVGmQ=;
        b=cZQhD7fsw2lqwflUjMMs/nrZhQu0BJs75dQvp4IuZ6ogvLLNL62AXfwcwAD8URKp+Q
         nic++6iyssInMF5O9Y8LflaucxkjboJwlYTamprGwihsAkoK91qpWFKd10yidOFVu4Jn
         hf/1aLrx/NeFKqttCN9lT5dJ6nxYBkGh2tj39GLqVrcKIl2W8p8PDybnO0/X9Ohr1B8O
         eoOYErZ/rHLh8IDwPsHAFa6L16qd7YACOW77+s6cZRg537XdkjFbt+Z7SfgQCGXTucIu
         GXIz3OL1V6GWsP1LwPju4lp8pOJbQ5xdPEHC7s/ilN6ntM/9RAi6a2FST7480uUJpy66
         G/1A==
X-Gm-Message-State: AOJu0YzXI17iogPXAZ3ykKkj77lw8PEyxd5KLvWkFC1Doe1WC5N9IzAM
        wM5xW+JWlBrWQ1fLcNtLQJRAOC+/DwsuXewUcmU=
X-Google-Smtp-Source: AGHT+IFvKf/U5CmXy8Q1+bKrazh4Rpabtdcd9frQEkONxvJ5Wk+J8E6ZqLlvXtpa02YyayHqvr/u6g==
X-Received: by 2002:a05:6358:4188:b0:139:d5f0:c027 with SMTP id w8-20020a056358418800b00139d5f0c027mr19171517rwc.30.1697005550426;
        Tue, 10 Oct 2023 23:25:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6f7e:c4cf:6e5d:fcff])
        by smtp.gmail.com with ESMTPSA id v1-20020a63ac01000000b0056428865aadsm11130128pge.82.2023.10.10.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:25:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:25:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm/list_lru: Remove unused function
Message-ID: <20231011062545.GA2866435@google.com>
References: <20230922100747.17045-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922100747.17045-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/09/22 18:07), Jiapeng Chong wrote:
> The function are defined in the list_lru.c file, but not called
> elsewhere, so delete the unused function.
> 
> mm/list_lru.c:64:1: warning: unused function 'list_lru_from_kmem'.

It seems that this breaks linux-next bisectability:

---

mm/list_lru.c:98:7: error: implicit declaration of function 'list_lru_from_kmem' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                l = list_lru_from_kmem(lru, nid, item, &memcg);
                    ^
mm/list_lru.c:98:5: warning: incompatible integer to pointer conversion assigning to 'struct list_lru_one *' from 'int' [-Wint-conversion]
                l = list_lru_from_kmem(lru, nid, item, &memcg);
                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/list_lru.c:121:7: error: implicit declaration of function 'list_lru_from_kmem' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                l = list_lru_from_kmem(lru, nid, item, NULL);
                    ^
mm/list_lru.c:121:5: warning: incompatible integer to pointer conversion assigning to 'struct list_lru_one *' from 'int' [-Wint-conversion]
                l = list_lru_from_kmem(lru, nid, item, NULL);
                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings and 2 errors generated.
