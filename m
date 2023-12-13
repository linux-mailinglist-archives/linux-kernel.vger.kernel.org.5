Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D8112D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379031AbjLMN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379024AbjLMN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:28:03 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9110A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:28:07 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c9f575d4b2so16471901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474085; x=1703078885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eErnRtkqSjdfJvRjbcJ+OmIoi33KHHgxwyuDSUKhEhg=;
        b=FiekDwnUtisJRBHpW/uKW+ysZQHipBmc8ma2X6HRYOuqACZjMJe61zaW39EInd2IEp
         vQXReo9wPn7AC4PKz0U3+tWThlIIzcLHZmyB+4kijIudEwP0B0CPYTI0i/DU5meemjCK
         +g7l3wyBLDEdANWFuQ6Y1t6s+jtC5sIZjzXDUjze3o8Las0pTVyTwsWPdbbuzME+L/8u
         Y9wErimI4lLzAHmxV8P+q363duFKoPzSA1aBkvRsRWXUKOwLH1cwzf2OcNc0BKnOXFTY
         fHdvcq+Ndr2yFP/BQoCgDLETLQk37iP/66uMRhAUUQ5osZbX8C90DmZcMjqv9zWE+nYU
         QoyA==
X-Gm-Message-State: AOJu0Yxl+yomjiH4G7WCbW0tHm1zgJRpqRMQoaFnd4u8LhTkd122EaNP
        EPAyBi0aRouqBvYxyyPAmA4=
X-Google-Smtp-Source: AGHT+IHIdfqgPrBDe9HzL/ucELKCUDsg0E+3xJX36t59OjStb+i5K8u+Zg+GaNLar/wj3HORNMO92g==
X-Received: by 2002:a2e:bc23:0:b0:2c9:edfa:f7a0 with SMTP id b35-20020a2ebc23000000b002c9edfaf7a0mr8853783ljf.1.1702474085305;
        Wed, 13 Dec 2023 05:28:05 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm20289168wmb.38.2023.12.13.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:28:05 -0800 (PST)
Message-ID: <8467c511-c251-4e8a-a7f7-3c8c5dd062ab@grimberg.me>
Date:   Wed, 13 Dec 2023 15:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] nvme: refactor ns info helpers
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same comment on PI.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
