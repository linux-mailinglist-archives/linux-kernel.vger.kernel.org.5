Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890780FA67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbjLLW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377775AbjLLW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:26:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674EA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702420006; x=1733956006;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A56YutUtr2X321jkHeqVGmvOtC6lpTVVUDQRaN1h/ZE=;
  b=A3gKIT2aTbrmSnVFG6svUSp4M/tqlpoP4kt83/Rbx6MpWeIN1kxN2Prf
   b3e1AvzIkrqXFX302DOIevwEFx+q0BC3n/U+3rAHDLmukr5ulPh+zs1Cj
   6TBqgRhJ8iYOkD8Obnsxgell71rZcEpPH3mz2vJncdQc/26RSFnEQfc2L
   sgSIqjMZsE4mINUwXryVwiH5pB8XOWHvWxBrJskmo5wS6UAKtSkMVwK2z
   a7WMnGfRePBh3Ke3AoEZs0eCwDEau0NhrcrLt3i9ctbO/2OcSUdhx6ixd
   YRrxM4VReWBEfbBpOT/+AuTyjqCJ9hesL2c5kj5x/AG5MgRncZocj/EBg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049712"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049712"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723393274"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723393274"
Received: from rfield-mobl1.amr.corp.intel.com (HELO [10.209.75.26]) ([10.209.75.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:26:45 -0800
Message-ID: <0d1183a7dd64d74c91ad15e2a4b2102f056a858d.camel@linux.intel.com>
Subject: Re: [PATCH] sched/headers: Remove duplicated struct rq declare
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     WangJinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     stone.xulei@xfusion.com
Date:   Tue, 12 Dec 2023 14:26:44 -0800
In-Reply-To: <202312072018+0800-wangjinchao@xfusion.com>
References: <202312072018+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-07 at 20:19 +0800, WangJinchao wrote:
> `struct rq` has been declared at the top of the file,
> so remove the second declaration.
>=20
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>  kernel/sched/sched.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..349c90554bd8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -931,7 +931,6 @@ struct uclamp_rq {
>  DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>  #endif /* CONFIG_UCLAMP_TASK */
> =20
> -struct rq;
>  struct balance_callback {
>  	struct balance_callback *next;
>  	void (*func)(struct rq *rq);

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim
