Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB99781D83
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHTK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjHTK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:57:18 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774ECE6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 03:56:20 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98273ae42d0so66827466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528979; x=1693133779;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fndnz0BClY74ZvC1KI9ie/PQcM6bSctNngaKRLtptJmhb0Gj75mIUhmRazyve76g8a
         PMnaPwxX/yLeVzmIzj1JBmz3pAlb6D/4DM2lmrDOnR0/Rco+VGg9SqtUTtOFJ+Y8dlxd
         NbPdMKyR40RG0Xf4OUXVHgFBIcpi9sJFLT+paqxB3+yQstFq1LjeffY1Lg5fuQf3hljd
         X4qx+7QTJqyzfQfVAdF32bi57+RT7FM5y4kSvOrcNl/CCv44Sy3GW6+nzZ8v1mRoZBmD
         8cbEudPFC1FftqZ1VfXh09ZW/A9m561XV68YIZ1hqcZkawbTPvrviT3yrs3wI+OeJeoi
         iZcw==
X-Gm-Message-State: AOJu0YwPHw411yXE+SmdByZR1YBwiCOhZkGuVOWo1/tpRC8nk2l9m8L7
        Xc7WUA2md9IQ7/CEGW3ORA8=
X-Google-Smtp-Source: AGHT+IGtRTECD/MNIoTuqfoiFY5OsDcl7m8aKRiDkCJ/u9CJP1gkkzpFhqmboZfnDeOPDjXcZLv85Q==
X-Received: by 2002:a17:906:74ca:b0:99d:ed5e:cc77 with SMTP id z10-20020a17090674ca00b0099ded5ecc77mr3195961ejl.2.1692528978743;
        Sun, 20 Aug 2023 03:56:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0099df2ddfc37sm4398037ejd.165.2023.08.20.03.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:56:18 -0700 (PDT)
Message-ID: <0071bc88-7080-b0a9-63e1-8133841e19ea@grimberg.me>
Date:   Sun, 20 Aug 2023 13:56:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
