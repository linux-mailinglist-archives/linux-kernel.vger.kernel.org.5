Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03297B71B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjJCT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCT0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:26:07 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FEE93;
        Tue,  3 Oct 2023 12:26:01 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bf6ea270b2so10045475ad.0;
        Tue, 03 Oct 2023 12:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361161; x=1696965961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvmeoMdGq/xr4jJD60T1ZLKABdnT8aFJPxFgwlDXHy0=;
        b=mPTFHmeHfkTU542x09DuxdgaxyqzqBazQT3gcJZOx9pKyNKTB2uvOR0fhR4uPeXrzX
         XI1avUcHlbnbGxKSDvBMm5Bh6LUIXCVzXSeUwgXTyu3xGxcfd4fHjTljBvP90935QLrr
         zJkUXpA/dS/RGh8Pz9/uuBfGnHX+O2eehT9OrCgjgSzuthKM9uPHMIP/r7g4f63ESXkZ
         CXQcB4tNmrvYEZFaTQXagPx7SO4W71VnzbvlLINurG70QAleVgrJkegAYK7yJjvecZY6
         ENGvY6IlRj0J+KMtcpfeipz6VsnlQWknI58BTQtxxCtFYbsUlDjDw/swmagxREJ/ihGS
         juMA==
X-Gm-Message-State: AOJu0YxH2iCpl+EuH6rxKHjm/+cXu+7aaB0XNkKZiANLr7Pn5eVz7CAt
        fckNQlw2anG/hHGJyjYp7Ks=
X-Google-Smtp-Source: AGHT+IFIYRUS5m4yRgtItZ8WzAh4hem8rd3fIRxCTadNXk4dIv+TmPaAMYkBU+jBLYSnZS5+ewmlNg==
X-Received: by 2002:a17:902:e847:b0:1bd:d92d:6b2 with SMTP id t7-20020a170902e84700b001bdd92d06b2mr579129plg.10.1696361161272;
        Tue, 03 Oct 2023 12:26:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001c76891b1c9sm1981549plb.10.2023.10.03.12.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:26:00 -0700 (PDT)
Message-ID: <9ba10b14-931b-42db-b7c2-e6f9aa95e477@acm.org>
Date:   Tue, 3 Oct 2023 12:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929093717.2972367-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 02:37, John Garry wrote:
> +.BR RWF_ATOMIC " (since Linux 6.7)"
> +Allows block-based filesystems to indicate that write operations will be issued
> +with torn-write protection. Torn-write protection means that for a power or any
> +other hardware failure, all or none of the data from the write will be stored,
> +but never a mix of old and new data. This flag is meaningful only for
> +.BR pwritev2 (),
> +and its effect applies only to the data range written by the system call.
> +The total write length must be power-of-2 and must be sized between
> +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both inclusive. The
> +write must be at a natural offset within the file with respect to the total
> +write length. Torn-write protection only works with
> +.B O_DIRECT
> +flag, i.e. buffered writes are not supported. To guarantee consistency from
> +the write between a file's in-core state with the storage device,

It seems wrong to me to start the first sentence with "Allows". Atomic
behavior should be mandatory if RWF_ATOMIC has been set.

Additionally, shouldn't it be documented what value will be stored in
errno if the atomic write has been rejected?

Thanks,

Bart.
