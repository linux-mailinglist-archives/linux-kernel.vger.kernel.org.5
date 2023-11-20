Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306D7F1737
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjKTPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjKTPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:25:02 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4AB4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:24:58 -0800 (PST)
Message-ID: <ce8c3296-d751-4f67-b109-a61b3d3dac89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700493896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0H8FTlr9fcdwDD07hcBimFiAc3RJ94n6TR7AdGN6fa0=;
        b=adzt1BorjpRRATbF52loZ0if16onR6BG85RhCxyqcFjCvGw3pwVvW8IYSoRaeQlcRjjLdO
        wd78VcA9Hnk0Y2EvtsvezPy+o5X0SXVHJAyB0/4SlHwhcWt9JGibwaXX4nrGt1U+Mxg69x
        inGH5khwaE5jQd8ac9S8C0Ud96fgwMA=
Date:   Mon, 20 Nov 2023 07:24:50 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bind_perm
Content-Language: en-GB
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, andrii.nakryiko@gmail.com, mykolal@fb.com,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DA27C0B42E88881B6534E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563DA27C0B42E88881B6534E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
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


On 11/18/23 1:44 PM, Yuran Pereira wrote:
> bind_perm uses the `CHECK` calls even though the use of
> ASSERT_ series of macros is preferred in the bpf selftests.
>
> This patch replaces all `CHECK` calls for equivalent `ASSERT_`
> macro calls.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

