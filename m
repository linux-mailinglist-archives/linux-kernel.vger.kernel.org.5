Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A8753B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjGNMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:43:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33487CE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:42:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9cdef8619so11664445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689338568; x=1691930568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF1G5UAt4ngbjaLsrBFjCg7Dq+2zgqRM/LN9T1v8nyg=;
        b=NgFvlWvTGo9DYMha3A94fzJBndVcnWYji22YaijvG+0d+GApKV/cYu+6u+Fjf5kS9K
         z1OVexdj/rlvANRRTiGZWDH2gGo3uKGsPBtL5vyGAxR6lxVt08PmwjeF4ByVn8Z4MiY7
         o+290JxXvejhqM5y6Dq3YGTZGztijMGhxzn4FwOZjFIxYDuBy93diopz57H0+QPTCkVX
         MnPU3IWLT1pkwqTTteG2exsP8HA/QPKdHlUiXhBdtDG76+Uz6jJbnzdlQePmQAwxhjsP
         rVzJpUgS4tIMFcMnXzkPIRyRri3Gc/yrxeV6KnFxVpa4Tk9X9O8yzRXw0YOEh1YaLTzl
         LwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338568; x=1691930568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pF1G5UAt4ngbjaLsrBFjCg7Dq+2zgqRM/LN9T1v8nyg=;
        b=DKcgmqj54YGvlrJEulsFa7568ZUZ6vUQzel8tQQ7DaF3iTy4ug5jac5wAXCq0bs+xv
         9Bz5hPF8t4dTKazI5VJrcXT5iUOcRBSUX0VjD9Amf2w/xhgqsGLve/neshhzIJbzRiKu
         ffEW11242INFOBnb0WFppkFw1qVS2tdN/NuwipCG6S3Lkh6EHuGvWiE/jbsFAGRR/naj
         tOgIX9nL8J335LYafORRTd0r/Ap5Da3RcCsEXtrrDsOyRfGPzT3STh/5sP64SCh37jxW
         rAeVdvyXCf/yubjxHkEJwk28WAZG066CX5sNsijuR04eD6xsB0mz2QXW6pOk74sKjSOH
         b4bQ==
X-Gm-Message-State: ABy/qLZdLJdhQBRPQ0Ht6+rnDJEHzjlaq1jd6kB58gcLPPUiUiXzsnn9
        rr/44lbyd72rPwGaReaCyaFM3A==
X-Google-Smtp-Source: APBJJlEwKO1cf0BnnNyxJZUVxF++J3zFgCa9Ts4HV53LHXpyuTDUBEfPR336c2pNThJdrVSUO0ukbg==
X-Received: by 2002:a17:902:8689:b0:1bb:1a64:5a74 with SMTP id g9-20020a170902868900b001bb1a645a74mr598470plo.33.1689338568711;
        Fri, 14 Jul 2023 05:42:48 -0700 (PDT)
Received: from [10.254.16.139] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001b890b3bbb1sm7667622plh.211.2023.07.14.05.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 05:42:48 -0700 (PDT)
Message-ID: <710342c1-eccd-d2ad-9206-f8770ad30ace@bytedance.com>
Date:   Fri, 14 Jul 2023 20:42:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm: kfence: allocate kfence_metadata at runtime
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Are there any other comments here?
Welcome any comments.

Thanks,
Peng
