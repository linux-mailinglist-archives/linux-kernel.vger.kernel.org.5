Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14C76012F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGXV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGXV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:29:57 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FF10D8;
        Mon, 24 Jul 2023 14:29:56 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bb69c0070dso1160023fac.1;
        Mon, 24 Jul 2023 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234195; x=1690838995;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OM539phS9aOw031TgelZO+437tA64R65GJ/+pU084Fo=;
        b=cIvNzaDL15Y2eJENk2IVN4J0bKT6f6H2oF/ENGE8oooYUcE/gVEuLZxvMvopRMg3FR
         D6ziP5esaI+bTzaqZbLu/FainqT+ue3Lko5myqvd5JkwmVDAEWCdc5sneS0qJWph7imm
         btuD3dG7tJqRSLBw5/KNdtEMiU025haUuf+1PTiUltBnyccZId4+gLlIYVaHtALglyxO
         hEBkVInmYGxeqWvuwPmPF3DjVCvkjNPKbUfCkiOSwYaoZ3WApzYylOQssUJc8D0iqDQs
         SM5q6rgLL2K3XQO5WNuiy0iYhZz2n+ejE5a5QU46PXZco/PKJTsVTCWitiwCrR3Pmn+d
         phRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234195; x=1690838995;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM539phS9aOw031TgelZO+437tA64R65GJ/+pU084Fo=;
        b=SoRk0nmEW3cPOnPVFGIvlSjuf2yqvG+gvzU3jEi2aayWeGzDGZazA3R3hNvyhY9QBB
         /Y8btU4P3Xnb5oh3r481pwcpbVAYnV7/6FIj8XPsuPK6MXvSQFpwZpP/YlvLTMMxB+6l
         Y7DpyMY2f5PgpltDjijMuu8UWGZmQyevJPmVIan4Up9+45bB0c7eu1910W8+NLhDFA+X
         ccciYaR9q6C6qwzaXVYs2mQZc1E2dIh2xfH88Wkz4Fs37Z0HiHwWVpGq5ZPF7ScHkmrE
         L4EnlZ6Ub8lgQXPYJX7I29KeEfiuBk/sfabqNtktjj6b05SKe+knum04bQpHrSyx0c3B
         KkZA==
X-Gm-Message-State: ABy/qLa2dUVap5pkwwMfDeer1rpD2fw83lBD4vl3T2jOoaWIUgwZEmjT
        8sMCpRxUjaxBwepN8FXQrJ4=
X-Google-Smtp-Source: APBJJlF3grPO7B7w46vrT2F2ZY060k90j9nUiLzaAItdGqiTBwkCSbnTHVk/om5uOI4wGUkgUeLLQw==
X-Received: by 2002:a05:6870:4394:b0:1ba:4815:ee64 with SMTP id r20-20020a056870439400b001ba4815ee64mr12563283oah.1.1690234195652;
        Mon, 24 Jul 2023 14:29:55 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:6d75:166e:2197:2c44:331b? ([2804:7f1:e2c1:6d75:166e:2197:2c44:331b])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d6245000000b006b9443ce478sm4358572otk.27.2023.07.24.14.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 14:29:55 -0700 (PDT)
From:   Victor Nogueira <victor.nogueira.rio@gmail.com>
X-Google-Original-From: Victor Nogueira <vnogueira@user.com>
Message-ID: <2d346050-3b6f-e9ec-10bb-99447c88fdf7@user.com>
Date:   Mon, 24 Jul 2023 18:29:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Content-Language: en-US
To:     Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230724014625.4087030-1-linma@zju.edu.cn>
In-Reply-To: <20230724014625.4087030-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 22:46, Lin Ma wrote:
> The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
> not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as 8 byte integer and passed to priv->max_rate/min_rate.
> 
> This patch adds the check based on nla_len() when check the nla_type(),
> which ensures that the length of these two attribute must equals
> sizeof(u64).
> 
> Fixes: 4e8b86c06269 ("mqprio: Introduce new hardware offload mode and shaper in mqprio")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
