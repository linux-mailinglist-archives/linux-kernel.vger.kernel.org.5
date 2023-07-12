Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B6750E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGLQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGLQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F912723
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1944861876
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D1C433B9;
        Wed, 12 Jul 2023 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179062;
        bh=m3++tsSMUkSMghoJc11Toy2mU4toGTegF/oDVOAolHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nOwgb+twFMPD6/6pah30rlN6QR3q+0zOesG0z9XUWWdEHDm4r2kpDazUAfHQm9/YQ
         aZJXAedKKxDIozWw45dqCpEv9Z74GLQGah9cSoknf9G39pTuRl9kL7ZBn8OFuSpGKD
         t8ezSFzRaZEE42OVpwo328xERbN5hcdp8CLerTWoWEB6tV1X6UW9j7wgqfYZjRr/MJ
         64LDmtVP0v9nKC7W9lOXIVHpOid4E3+jypwIeef91wTyJSoSeKMG5Rcyg4EuWzWXB+
         gKDpyrFKySlKCdRk/Z4FUwzSUXKBQW5Sj37fh7ALJpfZ2HBf4+cfB0isp5lAQQsa6+
         JIGFIoLprH/WQ==
Date:   Wed, 12 Jul 2023 09:24:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Message-ID: <20230712092421.7dbc6f50@kernel.org>
In-Reply-To: <DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
        <20230711205953.346e883b@kernel.org>
        <DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 09:47:43 +0000 Kubalewski, Arkadiusz wrote:
> >+            if 'enum' in attr_spec:
> >+                decoded = self._decode_enum(rsp, attr_spec)

To be clear - this is just a quick mock up, you'll need to change 
the arguments here, obviously. Probably to decoded and attr_spec?
