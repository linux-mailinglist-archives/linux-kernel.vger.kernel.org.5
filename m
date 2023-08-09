Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E17776436
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjHIPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjHIPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:41:23 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C9211C;
        Wed,  9 Aug 2023 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691595682; x=1723131682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXQIZ+fPIH3bc8gxDN+g8b0rmUv7zu4isFxQBbk0R64=;
  b=hkVOwlaKEEbp4TzWr9POvR/BIfcNwXKxEIiCTwzFe9xDBhJz917GaiG1
   4D7EAnf8M2iXkrHewCgzfyD1JZ0ROtyLUygbB3INUH3HonfP8s0M9r/Kl
   cLe/PM/lnCKodvwZ+ILTuZ/b12p9/BNOpbY4QHLCDm+r32ohJpWglh0tN
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="147543119"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:41:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id B516146BA6;
        Wed,  9 Aug 2023 15:41:17 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 15:41:16 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 15:41:13 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <horms@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <llvm@lists.linux.dev>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <trix@redhat.com>
Subject: Re: [PATCH] net/llc/llc_conn.c: fix 4 instances of -Wmissing-variable-declarations
Date:   Wed, 9 Aug 2023 08:41:04 -0700
Message-ID: <20230809154104.64963-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZNONx8N1/NFqmP6b@vergenet.net>
References: <ZNONx8N1/NFqmP6b@vergenet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms@kernel.org>
Date: Wed, 9 Aug 2023 14:59:51 +0200
> + Kuniyuki Iwashima

Thanks Simon.

> 
> On Tue, Aug 08, 2023 at 09:43:09AM -0700, Nick Desaulniers wrote:
> > I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> > bot spotted the following instances:
> > 
> >   net/llc/llc_conn.c:44:5: warning: no previous extern declaration for
> >   non-static variable 'sysctl_llc2_ack_timeout'
> >   [-Wmissing-variable-declarations]
> >   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
> >      |     ^
> >   net/llc/llc_conn.c:44:1: note: declare 'static' if the variable is not
> >   intended to be used outside of this translation unit
> >   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
> >      | ^
> >   net/llc/llc_conn.c:45:5: warning: no previous extern declaration for
> >   non-static variable 'sysctl_llc2_p_timeout'
> >   [-Wmissing-variable-declarations]
> >   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
> >      |     ^
> >   net/llc/llc_conn.c:45:1: note: declare 'static' if the variable is not
> >   intended to be used outside of this translation unit
> >   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
> >      | ^
> >   net/llc/llc_conn.c:46:5: warning: no previous extern declaration for
> >   non-static variable 'sysctl_llc2_rej_timeout'
> >   [-Wmissing-variable-declarations]
> >   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
> >      |     ^
> >   net/llc/llc_conn.c:46:1: note: declare 'static' if the variable is not
> >   intended to be used outside of this translation unit
> >   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
> >      | ^
> >   net/llc/llc_conn.c:47:5: warning: no previous extern declaration for
> >   non-static variable 'sysctl_llc2_busy_timeout'
> >   [-Wmissing-variable-declarations]
> >   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
> >      |     ^
> >   net/llc/llc_conn.c:47:1: note: declare 'static' if the variable is not
> >   intended to be used outside of this translation unit
> >   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
> >      | ^
> > 
> > These symbols are referenced by more than one translation unit, so make
> > include the correct header for their declarations. Finally, sort the
> > list of includes to help keep them tidy.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

> 
> > ---
> >  net/llc/llc_conn.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index d037009ee10f..0a3f5e0bec00 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
> > @@ -14,14 +14,15 @@
> >  
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > -#include <net/llc_sap.h>
> > -#include <net/llc_conn.h>
> > -#include <net/sock.h>
> > -#include <net/tcp_states.h>
> > -#include <net/llc_c_ev.h>
> > +#include <net/llc.h>
> >  #include <net/llc_c_ac.h>
> > +#include <net/llc_c_ev.h>
> >  #include <net/llc_c_st.h>
> > +#include <net/llc_conn.h>
> >  #include <net/llc_pdu.h>
> > +#include <net/llc_sap.h>
> > +#include <net/sock.h>
> > +#include <net/tcp_states.h>
> >  
> >  #if 0
> >  #define dprintk(args...) printk(KERN_DEBUG args)
> > 
> > ---
> > base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
> > change-id: 20230808-llc_static-de4dddcc64b4
> > 
> > Best regards,
> > -- 
> > Nick Desaulniers <ndesaulniers@google.com>
