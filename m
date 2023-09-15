Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A557A272B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjIOT1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbjIOT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:27:10 -0400
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C318D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:27:05 -0700 (PDT)
Message-ID: <a967ddd5-9b6d-df17-cef4-0baeb0d9252e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694806024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alWL3GHrQxakFacxE4oyxz8hAneeAlgh8UAl0NR/+y0=;
        b=kr8idsAdVaY/Q1Gf1ctsFqEMe0gkbyhtTN26W4rx7pupcNoQSVyRZRZfLLNadgwIa5N511
        x3DP9git8cdWpBxJtDig8cqjlWZFhrZnvi4DXadNBkA1wB8amBsqEindfUgdL+XiIrkl9i
        0RiCWrrLevdtYtFb8FlQNO36Rudk3Ro=
Date:   Fri, 15 Sep 2023 12:26:34 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags
 together
Content-Language: en-US
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org
References: <20230915083914.65538-1-larysa.zaremba@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230915083914.65538-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 1:39 AM, Larysa Zaremba wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags condition
> for dev-bound-only programs, segments are still prohibited for fully
> offloaded programs, hence additional check.

Applied. Please do follow up with a test. Thanks.

