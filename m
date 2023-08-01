Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64DC76B6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjHAOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjHAOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:07:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47826AA;
        Tue,  1 Aug 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Y4/TFwx2v1KmTAjwi0Nux8sw+w03GEnDtkgQrS1mP7I=; b=JGUe7ZHns4LwnJudRSRDBbDtHU
        UcYWtElj1AqS/G6jqLJ5v+oQtJvkPW2KItrw18VTFDA1L1PSUbnuQ2OgqQPxPO1uGU4Est66tvbYw
        9lXaHvGiUJZtnx8l2ypLIV93FqXav27fLreMBSUCz7k3q3f30fWDB4mOVj0UP0v3KeDg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qQq1r-002oC8-RP; Tue, 01 Aug 2023 16:07:15 +0200
Date:   Tue, 1 Aug 2023 16:07:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Ren <andy.ren@getcruise.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: Re: [PATCH] net: export dev_change_name function
Message-ID: <d88e4980-66e5-4ff2-a868-7f7450181925@lunn.ch>
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
 <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch>
 <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_RENAME_DEVICES is the module which needs "dev_change_name" API. Our
> requirement is to change the network device name from kernel space.

Can you give a link to this module. It is very unusual for the kernel
to change the device name. Before accepting this patch, we probably
want a better understanding of the big picture. Which is why we
normally to use the user of an API.

   Andrew
