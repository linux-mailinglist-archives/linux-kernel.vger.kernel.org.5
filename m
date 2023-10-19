Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0672C7CEE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjJSDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJSDOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEC9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697685224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8WlcZic7kSH9rRX+goplPvwCNzCwt/7uWU5wmIT7u0=;
        b=UjVSRcBNAoWDLbUs3rzZutgUC8L14L0KEBNiJU+ScFu3UvmVE/VuMGsWiQ/FdZzZWddcR+
        nkcjPREkdHRqeD2Xk3IR6zYOpU+EZr0Ggr4DRqbpBAerUdYXlujziqhxUgi73qIbvUMXtS
        4YP8opbyB/0t4HfvBBH/ripXeBybHLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-soX1RRh7MnCSv2WevTVVmA-1; Wed, 18 Oct 2023 23:13:38 -0400
X-MC-Unique: soX1RRh7MnCSv2WevTVVmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 831A410201E3;
        Thu, 19 Oct 2023 03:13:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D23F2166B26;
        Thu, 19 Oct 2023 03:13:34 +0000 (UTC)
Date:   Thu, 19 Oct 2023 11:13:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] block: ublk_drv: Remove unused function
Message-ID: <ZTCe2MonmQezTLAv@fedora>
References: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:04:44AM +0800, Jiapeng Chong wrote:
> The function are defined in the ublk_drv.c file, but not called
> elsewhere, so delete the unused function.
> 
> drivers/block/ublk_drv.c:1211:20: warning: unused function 'ublk_abort_io_cmds'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6938
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Fixes: b4e1353f4651 ("ublk: simplify aborting request")

Reviewed-by: Ming Lei <ming.lei@rehdat.com>


Thanks,
Ming

