Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81057809B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573158AbjLHEju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:39:48 -0500
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA02D59
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:39:52 -0800 (PST)
Message-ID: <c456bb34-d3ca-43e2-8728-718eda6b442c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702010390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjrWzXk/m3XscEpRSIbLLG+smAp+5Bs848NK5I6vCWE=;
        b=Mw3YMccgxOa6MBQlVQhpJFLZymYjmiX6rOTtvX1Akg8P80TKP7VWdrfKxu6zvxjHrCL86L
        iZd2q1o3iWn20X8jzkwVdoOEgTORHCyS8oU2sDwR98HXGuYaMKfaJhPQpVv0atg9i+lFxa
        VV+SLF/GLv0qWVuzSlwoqI+vR7jZZMw=
Date:   Thu, 7 Dec 2023 20:39:37 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for
 bpf_cpumask_weight() kfunc
Content-Language: en-GB
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20231207210843.168466-1-void@manifault.com>
 <20231207210843.168466-3-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207210843.168466-3-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/23 1:08 PM, David Vernet wrote:
> The new bpf_cpumask_weight() kfunc can be used to count the number of
> bits that are set in a struct cpumask* kptr. Let's add a selftest to
> verify its behavior.
>
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

