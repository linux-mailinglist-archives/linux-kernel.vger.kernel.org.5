Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4954809B1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573155AbjLHEhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:37:50 -0500
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72F10DE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:37:52 -0800 (PST)
Message-ID: <39853044-6139-41ab-87b4-0d9972722226@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702010270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVVGC+pDfqN5MkCHTiCHQ6KtlU1POIkUDJH86yPwMsc=;
        b=E42pjds6jfU/duIckTqDd50zy5v/m8aousSLjjx+BL+ef+wYtfXQP5PoSY7D/hwQ7ysAJo
        TlRJTpJ6HHlQCAaCJlrnQ39gLfQrVMoK4OfN9fnoJeKnCZshZcHjYWS/1Zhc9fuItpSX10
        nmBJryGomnVzTI896UMqHSMaj8jc6yw=
Date:   Thu, 7 Dec 2023 20:37:40 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_cpumask_weight() kfunc
Content-Language: en-GB
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20231207210843.168466-1-void@manifault.com>
 <20231207210843.168466-2-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207210843.168466-2-void@manifault.com>
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
> It can be useful to query how many bits are set in a cpumask. For
> example, if you want to perform special logic for the last remaining
> core that's set in a mask. Let's therefore add a new
> bpf_cpumask_weight() kfunc which checks how many bits are set in a mask.
>
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

