Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD847689E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGaCLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaCLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:11:39 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6148CF;
        Sun, 30 Jul 2023 19:11:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoXHPnX_1690769491;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VoXHPnX_1690769491)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 10:11:32 +0800
Date:   Mon, 31 Jul 2023 10:11:24 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
Message-ID: <ZMcYTNPFigmPF2ml@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20230729121929.17180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:19:29PM +0800, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

LGTM, thanks.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/smc_core.h | 1 -
>  net/smc/smc_ib.h   | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 1645fba0d2d3..3c1b31bfa1cf 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -539,7 +539,6 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini);
>  
>  void smc_conn_free(struct smc_connection *conn);
>  int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini);
> -void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
>  int smc_core_init(void);
>  void smc_core_exit(void);
>  
> diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> index 034295676e88..4df5f8c8a0a1 100644
> --- a/net/smc/smc_ib.h
> +++ b/net/smc/smc_ib.h
> @@ -96,7 +96,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk);
>  int smc_ib_create_queue_pair(struct smc_link *lnk);
>  int smc_ib_ready_link(struct smc_link *lnk);
>  int smc_ib_modify_qp_rts(struct smc_link *lnk);
> -int smc_ib_modify_qp_reset(struct smc_link *lnk);
>  int smc_ib_modify_qp_error(struct smc_link *lnk);
>  long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);
>  int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
> -- 
> 2.34.1
