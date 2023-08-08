Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23547773EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHHQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjHHQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:55 -0400
Received: from out-66.mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773673C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:52:05 -0700 (PDT)
Message-ID: <1591f6c8-f346-83da-f4f5-abdd7d0c0bd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691500286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/lIaGaMy4aD0ASgIkzR9MKyiCWlm3ct+3qApo5JH54=;
        b=WR0ktPZvEmEl5N39254FTQWH+skmrzfpOSuswr5kLbplNopwYJKoazBPF3QGUK4b8P+BaO
        bZRp6seoxUGwn4MKBjnwNcwH96DxlfT2dlAhuMikf3kEebqNQ9CuZKDWHPSMnO6iKtNu6w
        Wi71nghvkj7PwcS+TFXkDASf6jsysJA=
Date:   Tue, 8 Aug 2023 14:11:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH linux-next v2] net/ipv4: return the real errno instead of
 -EINVAL
Content-Language: en-US
To:     xu.xin.sc@gmail.com
Cc:     dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>, Si Hao <si.hao@zte.com.cn>,
        davem@davemloft.net
References: <20230807015408.248237-1-xu.xin16@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230807015408.248237-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 02:54, xu.xin.sc@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, No matter what error pointer ip_neigh_for_gw() returns,
> ip_finish_output2() always return -EINVAL, which may mislead the upper
> users.
> 
> For exemple, an application uses sendto to send an UDP packet, but when the
> neighbor table overflows, sendto() will get a value of -EINVAL, and it will
> cause users to waste a lot of time checking parameters for errors.
> 
> Return the real errno instead of -EINVAL.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Si Hao <si.hao@zte.com.cn>
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
