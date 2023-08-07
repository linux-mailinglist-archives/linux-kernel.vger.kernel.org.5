Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF2773549
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjHGX70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGX7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:59:25 -0400
Received: from out-100.mta0.migadu.com (out-100.mta0.migadu.com [IPv6:2001:41d0:1004:224b::64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB78DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:59:24 -0700 (PDT)
Date:   Tue, 8 Aug 2023 08:59:12 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691452759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4JJU/L+7XhSRIV+47Wbag20pFFf+rBHfWamIK40tDM=;
        b=s1fRNWn5Qa294sWyzLXrDWWU53ZKamerOUvMDXiBEhPzE2YvTHzcriyw83T5Sfs9cS5gHH
        etsLJeGwRxW+yGUiw1MoMUWKFjjVtx+7hrZcJqb9nwh2S46aJyE5aHU6dqmKu6ns5nyzOd
        mjw+hFi9Hn2kM+DKGGGekX8PUBGeJNE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: use helper macro
 llist_for_each_entry_safe()
Message-ID: <20230807235912.GA1743869@ik1-406-35019.vs.sakura.ne.jp>
References: <20230807114125.3440802-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807114125.3440802-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:41:25PM +0800, Miaohe Lin wrote:
> It's more convenient to use helper macro llist_for_each_entry_safe().
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks, looks good to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com> 
