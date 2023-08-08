Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16A7742E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjHHRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHHRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:17 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCCAB5E94
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:23:00 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso2405319e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511733; x=1692116533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIJajdd4Yc3wo/yJr5hUql5qY0jUL0/PgHadt/NVtZQ=;
        b=YiN8ubnr3RQJdDtrdPUDu4WUxfV6c36iMFSNgwnY/f0sqnio0XsnumiLTuIk3qse6j
         4YdDHLw1qjHv+cRLGccEpSNSddNSoEuqOytlc18xHc/QBjnAyfGTFc84PfRjo4w7XhnY
         1HQ1VbNMkdFil4wgSci2eyjA7+LeeZWyWFCdIEK6X4PJbf6ZwLGT1MRcyoi48y+5qX7W
         i0d+7Na+1AIWR/D9EEbZ6oX/QU7qKR+z2EJ/MglyLR3kbF4tvSlpIs2ggYoNEB6o9vDy
         UoUzq+a/RNSVkegcRfn6GXrAlHT1ejyxNBkjviLxwClSDysk7rV/micxOfKTPm2ousUI
         J3hQ==
X-Gm-Message-State: ABy/qLaGEqa8I/cg8yLEjOOND21b6h3apcVSpI2S5NGg6FRsb2bUrMKs
        ueC8GaYkwrwH6sYLbjkmAw80zgXczGs=
X-Google-Smtp-Source: APBJJlEoiyO37RduZ7UBE8MsP6lQX9+dGJ+PMsujgLSdn/gByNmxC9FfTmJiAV5YnY2h1CjgpXWYlA==
X-Received: by 2002:a05:600c:32af:b0:3fb:aadc:41dc with SMTP id t47-20020a05600c32af00b003fbaadc41dcmr25000550wmp.4.1691491817395;
        Tue, 08 Aug 2023 03:50:17 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b003145559a691sm13581437wri.41.2023.08.08.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 03:50:16 -0700 (PDT)
Message-ID: <14286c1a-b6cd-24bb-0f9c-7943c97b8304@grimberg.me>
Date:   Tue, 8 Aug 2023 13:50:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme v3 2/2] fabrics: Do not pass disable_sqflow if not
 supported
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230808091550.25349-1-dwagner@suse.de>
 <20230808091550.25349-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808091550.25349-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sagi Grimberg <sagi@grimberg.me>

You can make the patch from you, you are sending it after all..

> Only retry a connect attempt with disable_sqflow if the kernel
> actually supports this option.

commit msg needs update.
