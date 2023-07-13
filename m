Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D093C751DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjGMJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjGMJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:58:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9D199E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:58:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso323430a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689242299; x=1691834299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+9PSaqxCYsQeRAvlsbE494fcAK4kpQXJdHXBP1WVD4=;
        b=IlHo7q6nOCYV4LUfLH/0eq4Hu1ErdhLKXL2Wb8ALKSJbnGAB0+Vy7NxWUk8QGH/8Wh
         PFf3lHub9R3TcAMyOKlSLcrE1S4zlkE1lW1kzMbj/pBMwbbGE3MCN7GHiakmxWuZ8iua
         XHmQ7vct9f58gD+x+TjbUm0/iC8h2lZJ5HJAUpEQBuXQ3CjvaqVMfZLaZZ8lu8ZlCDHA
         gb6cQo1eGNgLjy865nNTibEFo0OoZIK4KWSLiMU3UScnwdhsrFfCIULn4QB0nG5a1TfU
         Gim1z1VgM6v2NQ98g3VKCKdARjNkR4Hp35DxEA0oWS5OaaEwJOnXPMd3JNl2nCJGr5Gs
         djbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242299; x=1691834299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+9PSaqxCYsQeRAvlsbE494fcAK4kpQXJdHXBP1WVD4=;
        b=iXv8G3ueakPWckBTYV1L3fQoqWEkXpWIRHXjFcQZ3yB0xrWe/V4K7u3aw6kKTPKfN6
         t88UaK9uGeXRT7evMCj5/0nxqoDXC21NbJPTM4RqdFh5YPJJEagrjwLdIrRQYKcVYuBJ
         yaSNIAI+Ve968VNgJZNfPeJHQ5fF7U5JytzN9jmgFyuWfCPgkEheyTHzYnWheZ40MSoK
         +BRIzSE/AGYymtD+fTI3zA8pRFQNSniTXe1oRKsFAQa3A/CsC9u3LPlOzAWlHRLhhQj7
         3qxQw9qC3t/2yIQ9tj2JK/tV1IGPfRoGhbXzKit3nbJ7Cse6ilAhZoxud/BTPlbfz83z
         9vcw==
X-Gm-Message-State: ABy/qLZDd19PKmkyDrCLdHfNMcmPe1YnijCSmPNERR2CXXAaPruGNt5Q
        xE9sxrMtfNMdgE9//exZ7A5KmW1ceR02kuZ60uo=
X-Google-Smtp-Source: APBJJlEJt5PtQs/kKmCo+XAOMf3eCi+sl7CJ5xrLqFzTzaM8Sj886iePKqXd2kqkBpU3aYrZaTiKcA==
X-Received: by 2002:a17:90a:640f:b0:262:fe3e:a7c4 with SMTP id g15-20020a17090a640f00b00262fe3ea7c4mr443360pjj.4.1689242298978;
        Thu, 13 Jul 2023 02:58:18 -0700 (PDT)
Received: from [10.254.22.102] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id nh3-20020a17090b364300b0025c1cfdb93esm5263466pjb.13.2023.07.13.02.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:58:18 -0700 (PDT)
Message-ID: <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
Date:   Thu, 13 Jul 2023 17:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Maple Tree Work
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707163815.ns4kdz7iut5octjv@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230707163815.ns4kdz7iut5octjv@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question I want to discuss here. I noticed that the interface
of maple tree has three different prefixes, namely mtree_*, mt_*, mas_*.
I am curious why the interfaces prefixed with mtree_* and mt_* cannot be
unified? I think they can be changed to mtree_* to avoid two different
prefixes.

