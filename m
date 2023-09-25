Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439817AE05E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjIYUko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:40:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF749BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:40:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4056ce55e6fso11064035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695674434; x=1696279234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y1VIE90FwNznt26ixqYqeM8N12dDG5Pgiwlv6opji0=;
        b=cFHTR55D5TTlS53hElWEBw12b1OqQLDMvRtB//Qi6oishl/bV2DCXMZtkkQwtebPCu
         uQjJgbYsNJ3C9+XV0kL/fqY3z4WJSJbkUunJofr0Po0l/W/0YPA5v3cimoBgmu0njyFs
         0U59k1HavSfLa0yWZmc+4sdK2dm7qaDw46bznJXp/0ClSZVomtg/lBrDxL2GR/FpVUv+
         qjrgI759yElVgK4/TZNEPuzEv20nzUiTD4ZEgYfysqIDLbe3rNWAttFXImvVZPM6B3IU
         kad0gUgBmAqmAVcIxTYmIAv4IuJsYdcX1Y+FwvGeqm8/2fgP5SAMtatHMxYP0Uxy1xRm
         9JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695674434; x=1696279234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y1VIE90FwNznt26ixqYqeM8N12dDG5Pgiwlv6opji0=;
        b=ffwDb8cranfoXrpkzOIdy/1c0rpHStI3THcbB9jXAWSaHDo1kRWDL39abysRseet4E
         7LZ5VU+l+UYNAaOyFEVgbsEDU0H9Qfs9F+Ie6fWOyHclIPL6g16slLE9CbwD9Tm4RbYr
         HxvzXWI1tLjgV4mWBJX96JkhhajsySzMJeFCdzjgd8+XdJ7IS8MqG2Ck14ceQtIKg6Kc
         cBY3MtdIviC6LU9juS4I6Jrk3f8PRmSuZsbbJvcP1s1n8UfXEVVG6shIqEi+JKnxfiZ0
         64acPUHzMpyt3G6KXJUSFDtNXSW722t3tRjaHHCnBDVkiiWSeAUN01567Mw9zqHzgnxo
         MjkQ==
X-Gm-Message-State: AOJu0YzvSDiPqT78kEKbZN6OVJ/AWRhOAGDF9bkgFpIZVjoNqPwWuNvV
        pksOi5PT1POcGLxQob8bCeQ=
X-Google-Smtp-Source: AGHT+IHkGoXqIJaJUGQbJmh9+m1Le6KjMm0mAk3cIDo3i5kwO5YcFRX9MZ/f7c6IJaj5l8yt0EH6VA==
X-Received: by 2002:adf:e2c8:0:b0:321:5969:d46d with SMTP id d8-20020adfe2c8000000b003215969d46dmr6082564wrj.1.1695674434182;
        Mon, 25 Sep 2023 13:40:34 -0700 (PDT)
Received: from [192.168.0.106] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm12758354wru.52.2023.09.25.13.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 13:40:33 -0700 (PDT)
Message-ID: <50f0da35-7039-0f4f-5f58-53fd499019eb@gmail.com>
Date:   Mon, 25 Sep 2023 22:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] staging: vt6655: Type encoding info dropped from variable
 "byRFType"
To:     Pavan Bobba <opensource206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZQwyRXFHA9hTLcyv@ubuntu.myguest.virtualbox.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZQwyRXFHA9hTLcyv@ubuntu.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 14:08, Pavan Bobba wrote:
> variable name "byRFType" updated like below:
> 
> a.type encoding info dropped from name
> b.camelcase name replaced by snakecase
> 
> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> ---
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
