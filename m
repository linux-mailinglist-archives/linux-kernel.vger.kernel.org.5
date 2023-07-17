Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E07563AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGQNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGQNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:00:59 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAAE47;
        Mon, 17 Jul 2023 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689598833; x=1721134833;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=V2IvuJXOfmhoPksJdsTV2u6WeOptT8UYUa+NgoJE45M=;
  b=t2cwfzSrRvelu9EQ+le8JKPKDKumIXfw24lsrkNo+zQO3Qy+qXdVMvr4
   eEmfHfqhw6ffDZL/hBhHoKGw2jxxJN+42XOfGve30Dtndw+NIQ9MIkyFZ
   FeXhi3umyjOtDaqnBhL5jbUIpjkHWkzVtx/IgHngzOUKU+d826WODrZIL
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="593338174"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 13:00:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 4FDFFE0E21;
        Mon, 17 Jul 2023 13:00:30 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.174) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 13:00:29 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 17 Jul 2023 13:00:29 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 341BE200A; Mon, 17 Jul 2023 13:00:29 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the crypto tree
References: <20230717075545.28f93630@canb.auug.org.au>
Date:   Mon, 17 Jul 2023 13:00:29 +0000
In-Reply-To: <20230717075545.28f93630@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 17 Jul 2023 07:55:45 +1000")
Message-ID: <lrkyqmszuitg2.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Commit
>
>   a0459d277b1b ("KEYS: use kfree_sensitive with key")
>
> is missing a Signed-off-by from its author.

Sorry for that, sent Patch v4 with the correction
