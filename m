Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005D80803C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjLGFdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:33:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E061DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:33:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso8265485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701927214; x=1702532014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDh5Ha6meMpNT5PZvdiFsf/a/63SoEjRN6VfIgk3fbs=;
        b=bpj3YbNLkvzoxEw3xr0u3agkAhCoIuowOElrV/CTMzye8qwEDGvkm7uR0/cuL/ftIt
         jRquYrxsKhkgv5IE3W4Znm0vKoMxtiibCYaq3PHsXZHiRDE69BXKRvyHra6UJrZOb0yx
         5oP0oV9Xp+4qIJPjAS4YsUSOoFJLslTrFGhysjrsJRHyvoSBWDBqECcOzT8ZGY4J7FRs
         FWr8T0YXHfsJoKZ1LEotF/Rto6mU37c+Q6Ovedu0tLngsP9f7fodtv1C90zMwhcIY2Z7
         ejn6BqFG2uqY7p1NT4CzU3pGdrQ9EcLj/fTLkh8OPizFM0+96H/D4NemDC7T3p/JMVTD
         N6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927214; x=1702532014;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDh5Ha6meMpNT5PZvdiFsf/a/63SoEjRN6VfIgk3fbs=;
        b=BBcgWXkt0zEwcimSxp3dHiFfleUN7rML0rhDEyiKv8xX8Vx9WLftg/O4UEF1ofomsf
         i57lstFYd67u1Mr+u/rC8T9aNa8oJMpwPil4lQxpP81S2pQmRCxo8TvHH5CObe1/qD1I
         qLobPksCfAj5sMjLdCvYWi1olbg7wa5J/xwhIRnU78N6AsCHRrIhZkzD8LQ8IEQhHElJ
         bAH27p8fE/4X9pg8CEHVptYKdNbd6ZUaD7JbSepLC7cV0EtnUBYwxPItM/aC1CkOrcB0
         rD5k5MaglRGpChobEeVrKhJZozkKkgFozPOxUtT/Gwst/x00EobIsar8nzktJZMAV0Hk
         oQ0w==
X-Gm-Message-State: AOJu0YwNUJJ17XJwXmftIafPP0O3Ne1MOwuum2qMBMNgJK+b21V56PwG
        iuAkcHeATsUDdWisNEZ+YLA/gQ==
X-Google-Smtp-Source: AGHT+IGRMzw6ole/sY4x+aWmyT5JGTFS7U8esyxKHbhMcm0/ifnMUpQvK3RimMuKBvFeDdeF9e+gqQ==
X-Received: by 2002:a7b:c4c9:0:b0:40b:5e21:dd2b with SMTP id g9-20020a7bc4c9000000b0040b5e21dd2bmr1280861wmk.89.1701927213762;
        Wed, 06 Dec 2023 21:33:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm459345wrs.47.2023.12.06.21.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:33:33 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:33:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Lev Pantiukhin <kndrvt@yandex-team.ru>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        mitradir@yandex-team.ru, Lev Pantiukhin <kndrvt@yandex-team.ru>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: add a stateless type of service and a stateless
 Maglev hashing scheduler
Message-ID: <db2f0650-6e23-457f-bc5c-f9da0047f37d@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204152020.472247-1-kndrvt@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lev,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lev-Pantiukhin/ipvs-add-a-stateless-type-of-service-and-a-stateless-Maglev-hashing-scheduler/20231204-232344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git master
patch link:    https://lore.kernel.org/r/20231204152020.472247-1-kndrvt%40yandex-team.ru
patch subject: [PATCH] ipvs: add a stateless type of service and a stateless Maglev hashing scheduler
config: i386-randconfig-141-20231207 (https://download.01.org/0day-ci/archive/20231207/202312070849.i9gwwSH0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312070849.i9gwwSH0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312070849.i9gwwSH0-lkp@intel.com/

New smatch warnings:
net/netfilter/ipvs/ip_vs_core.c:545 ip_vs_schedule() error: uninitialized symbol 'need_state'.

vim +/need_state +545 net/netfilter/ipvs/ip_vs_core.c

^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  440  struct ip_vs_conn *
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  441  ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
d4383f04d145cc net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  442  	       struct ip_vs_proto_data *pd, int *ignored,
d4383f04d145cc net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  443  	       struct ip_vs_iphdr *iph)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  444  {
9330419d9aa4f9 net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-01-03  445  	struct ip_vs_protocol *pp = pd->pp;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  446  	struct ip_vs_conn *cp = NULL;
ceec4c38168184 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2013-03-22  447  	struct ip_vs_scheduler *sched;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  448  	struct ip_vs_dest *dest;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  449  	__be16 _ports[2], *pptr, cport, vport;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  450  	const void *caddr, *vaddr;
3575792e005dc9 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-09-17  451  	unsigned int flags;
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  452  	bool need_state;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  453  
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  454  	*ignored = 1;
2f74713d1436b7 net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  455  	/*
2f74713d1436b7 net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  456  	 * IPv6 frags, only the first hit here.
2f74713d1436b7 net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  457  	 */
6b3d933000cbe5 net/netfilter/ipvs/ip_vs_core.c Gao Feng               2017-11-13  458  	pptr = frag_safe_skb_hp(skb, iph->len, sizeof(_ports), _ports);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  459  	if (pptr == NULL)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  460  		return NULL;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  461  
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  462  	if (likely(!ip_vs_iph_inverse(iph))) {
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  463  		cport = pptr[0];
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  464  		caddr = &iph->saddr;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  465  		vport = pptr[1];
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  466  		vaddr = &iph->daddr;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  467  	} else {
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  468  		cport = pptr[1];
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  469  		caddr = &iph->daddr;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  470  		vport = pptr[0];
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  471  		vaddr = &iph->saddr;
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  472  	}
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  473  
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  474  	/*
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  475  	 * FTPDATA needs this check when using local real server.
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  476  	 * Never schedule Active FTPDATA connections from real server.
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  477  	 * For LVS-NAT they must be already created. For other methods
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  478  	 * with persistence the connection is created on SYN+ACK.
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  479  	 */
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  480  	if (cport == FTPDATA) {
b0e010c527de74 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  481  		IP_VS_DBG_PKT(12, svc->af, pp, skb, iph->off,
0d79641a96d612 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  482  			      "Not scheduling FTPDATA");
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  483  		return NULL;
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  484  	}
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  485  
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  486  	/*
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  487  	 *    Do not schedule replies from local real server.
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  488  	 */
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  489  	if ((!skb->dev || skb->dev->flags & IFF_LOOPBACK)) {
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  490  		iph->hdr_flags ^= IP_VS_HDR_INVERSE;
6ecd754883daff net/netfilter/ipvs/ip_vs_core.c Matteo Croce           2019-01-19  491  		cp = INDIRECT_CALL_1(pp->conn_in_get,
6ecd754883daff net/netfilter/ipvs/ip_vs_core.c Matteo Croce           2019-01-19  492  				     ip_vs_conn_in_get_proto, svc->ipvs,
6ecd754883daff net/netfilter/ipvs/ip_vs_core.c Matteo Croce           2019-01-19  493  				     svc->af, skb, iph);
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  494  		iph->hdr_flags ^= IP_VS_HDR_INVERSE;
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  495  
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  496  		if (cp) {
b0e010c527de74 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  497  			IP_VS_DBG_PKT(12, svc->af, pp, skb, iph->off,
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  498  				      "Not scheduling reply for existing"
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  499  				      " connection");
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  500  			__ip_vs_conn_put(cp);
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  501  			return NULL;
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  502  		}
802c41adcf3be6 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  503  	}
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  504  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  505  	/*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  506  	 *    Persistent service
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  507  	 */
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  508  	if (svc->flags & IP_VS_SVC_F_PERSISTENT)
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  509  		return ip_vs_sched_persist(svc, skb, cport, vport, ignored,
d4383f04d145cc net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  510  					   iph);
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  511  
190ecd27cd7294 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  512  	*ignored = 0;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  513  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  514  	/*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  515  	 *    Non-persistent service
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  516  	 */
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  517  	if (!svc->fwmark && vport != svc->port) {
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  518  		if (!svc->port)
1e3e238e9c4bf9 net/netfilter/ipvs/ip_vs_core.c Hannes Eder            2009-08-02  519  			pr_err("Schedule: port zero only supported "
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  520  			       "in persistent services, "
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  521  			       "check your ipvs configuration\n");
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  522  		return NULL;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  523  	}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  524  
ceec4c38168184 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2013-03-22  525  	sched = rcu_dereference(svc->scheduler);
05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  526  	if (sched) {
05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  527  		/* read svc->sched_data after svc->scheduler */
05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  528  		smp_rmb();
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  529  		/* we use distinct handler for stateless service */
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  530  		if (svc->flags & IP_VS_SVC_F_STATELESS)
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  531  			dest = sched->schedule_sl(svc, skb, iph, &need_state);
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  532  		else
bba54de5bdd107 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2013-06-16  533  			dest = sched->schedule(svc, skb, iph);

need_state not initialized on this path

05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  534  	} else {
05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  535  		dest = NULL;
05f00505a89acd net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2015-06-29  536  	}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  537  	if (dest == NULL) {
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  538  		IP_VS_DBG(1, "Schedule: no dest found.\n");
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  539  		return NULL;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  540  	}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  541  
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  542  	/* We use IP_VS_SVC_F_ONEPACKET flag to create no state */
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  543  	flags = ((svc->flags & IP_VS_SVC_F_ONEPACKET &&
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  544  		  iph->protocol == IPPROTO_UDP) ||
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04 @545  		 (svc->flags & IP_VS_SVC_F_STATELESS && !need_state))
                                                                                                                                         ^^^^^^^^^^

b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  546  		? IP_VS_CONN_F_ONE_PACKET : 0;
26ec037f9841e4 net/netfilter/ipvs/ip_vs_core.c Nick Chalk             2010-06-22  547  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  548  	/*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  549  	 *    Create a connection entry.
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  550  	 */
f11017ec2d1859 net/netfilter/ipvs/ip_vs_core.c Simon Horman           2010-08-22  551  	{
f11017ec2d1859 net/netfilter/ipvs/ip_vs_core.c Simon Horman           2010-08-22  552  		struct ip_vs_conn_param p;
6e67e586e7289c net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-01-03  553  
3109d2f2d1fe06 net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  554  		ip_vs_conn_fill_param(svc->ipvs, svc->af, iph->protocol,
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  555  				      caddr, cport, vaddr, vport, &p);
ba38528aae6ee2 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2014-09-09  556  		cp = ip_vs_conn_new(&p, dest->af, &dest->addr,
ee78378f976488 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  557  				    dest->port ? dest->port : vport,
0e051e683ba4ac net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  558  				    flags, dest, skb->mark);
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  559  		if (!cp) {
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  560  			*ignored = -1;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  561  			return NULL;
f11017ec2d1859 net/netfilter/ipvs/ip_vs_core.c Simon Horman           2010-08-22  562  		}
a5959d53d6048a net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2010-11-19  563  	}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  564  
cd17f9ed099ed2 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  565  	IP_VS_DBG_BUF(6, "Schedule fwd:%c c:%s:%u v:%s:%u "
cd17f9ed099ed2 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  566  		      "d:%s:%u conn->flags:%X conn->refcnt:%d\n",
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  567  		      ip_vs_fwd_tag(cp),
f18ae7206eaebf net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2014-09-09  568  		      IP_VS_DBG_ADDR(cp->af, &cp->caddr), ntohs(cp->cport),
f18ae7206eaebf net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2014-09-09  569  		      IP_VS_DBG_ADDR(cp->af, &cp->vaddr), ntohs(cp->vport),
f18ae7206eaebf net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2014-09-09  570  		      IP_VS_DBG_ADDR(cp->daf, &cp->daddr), ntohs(cp->dport),
b54ab92b84b616 net/netfilter/ipvs/ip_vs_core.c Reshetova, Elena       2017-03-16  571  		      cp->flags, refcount_read(&cp->refcnt));
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  572  
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  573  	if (!(svc->flags & IP_VS_SVC_F_STATELESS) ||
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  574  	    (svc->flags & IP_VS_SVC_F_STATELESS && need_state)) {
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  575  		ip_vs_conn_stats(cp, svc);
b276d504bee439 net/netfilter/ipvs/ip_vs_core.c Lev Pantiukhin         2023-12-04  576  	}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  577  	return cp;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  578  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

