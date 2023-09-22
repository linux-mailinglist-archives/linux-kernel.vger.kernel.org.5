Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEB7AB097
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjIVL3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:29:00 -0400
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [IPv6:2001:41d0:203:375::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581FAC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:28:53 -0700 (PDT)
Message-ID: <5b5704d6-3eca-70a8-4dc4-3a37653e3956@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695382131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ahl86MwZXr+YqMQ9RZ+afjaNkizX+5JO/dtLHweXa+0=;
        b=gbo+nDcY+K7sqWqfH1y+mtpLzXZVT+gU+uCU4HjweuzKp+hMT/maJL2DepzaWVkDhft0qn
        3/17euRx65ZP5m8+32f6CksOSBABeWeo2tuCyATsoYzSAL+JkuJLAHOwjwHBN+S38DowYS
        Nl/4C0oOQKnS+VFKfWElQ9KPPYcfuaU=
Date:   Fri, 22 Sep 2023 12:28:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix error handling in ptp_ocp_device_init
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Vadim Fedorenko <vadfed@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 10:40, Dinghao Liu wrote:
> When device_add() fails, ptp_ocp_dev_release() will be called
> after put_device(). Therefore, it seems that the
> ptp_ocp_dev_release() before put_device() is redundant.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thanks!

Reviewed-by: Vadim Feodrenko <vadim.fedorenko@linux.dev>

