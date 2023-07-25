Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F30761055
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGYKMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGYKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:12:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C510E3;
        Tue, 25 Jul 2023 03:12:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EA5DF32008FB;
        Tue, 25 Jul 2023 06:12:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Jul 2023 06:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690279970; x=1690366370; bh=xgUVqqNdgbniF
        Ku43r5PV8GdNxqPVdClT1x0fcn2Eiw=; b=zS/A2pyjZnF4kvWcirBt5OlRqnuVY
        t+BE+RRUQvF2Ruvx7K72DOWdQddydkr8HOV45r0zSsPsLhzK5IZopyDsmw5H3vHK
        2Oz+DX/OF/5SQGBHQisMgv1FJGGq1V9TPInEKhDdBYV0Jz3Zbu+vCcBKoEFCKN/c
        L1K1ARsDWqW89K4CqdUTDnY/b8da4BHIp/2p0C0Ahm5t1YszMZQtYlNOLkbhNWBZ
        E1+qXZxGJG94Ln1wpIcicgc8czpDyFHZOacNlxWEKZ0QFlE9RJ0+PGt7UfG6HGT9
        hoVca3T9YpHkXP5vdoXxHOLMvnH/puK//qRB10Ahqf8TSq7sL+sfS1CpQ==
X-ME-Sender: <xms:IqC_ZCnrpiqzcEgfAXkTWrJ53ye3iZxcMnhntjEMDCj0uZPh2E1KZw>
    <xme:IqC_ZJ0SG8CpHH_7j1SVSFn-JGPk8TSZ_B1hllguyHIDMzCz3AL0V18o_QuVsCd5j
    wPsFQpzFDLTnJ0>
X-ME-Received: <xmr:IqC_ZApTXGSmLNQlN3G6sUcBFkhTmm_gNUiFhhK6EwaLBfPrzjXn89o-hgoH9G81Pe1xUMr0Ou2OYdGiu8cUWuSvVBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:IqC_ZGnDBSw3seLQQa3Q6H39fiVJ6iq9ngSccYu99kYt32q1yMvigw>
    <xmx:IqC_ZA1OFFt9nGhGqXd9jC_0u4AMMLFcuRI2fb0yNiLyMlUaAyZs0Q>
    <xmx:IqC_ZNuFp8BZVQQvn03PII2UeMFELez5pPRVB0zdTagflbaEOs7m1g>
    <xmx:IqC_ZBl-kj4Fg1ZdXut26qyxgUCboRi5ImL-2Srusu007D49aVtmnw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 06:12:49 -0400 (EDT)
Date:   Tue, 25 Jul 2023 13:12:46 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Message-ID: <ZL+gHkLnLE91YBkS@shredder>
References: <20230725032451.505189-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725032451.505189-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:54:51AM +0530, Ratheesh Kannoth wrote:
>  Support for dissecting IPSEC field SPI (which is
>  32bits in size) for ESP and AH packets.
> 
>  This implementation does not support NAT-T
>  (encapsulation of ESP packets over UDP).
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  include/net/flow_dissector.h |  9 ++++++
>  include/net/flow_offload.h   |  6 ++++
>  include/uapi/linux/pkt_cls.h |  3 ++
>  net/core/flow_dissector.c    | 53 +++++++++++++++++++++++++++++++++++-
>  net/core/flow_offload.c      |  7 +++++
>  net/sched/cls_flower.c       | 18 ++++++++++++

Please split flow dissector and flower changes into separate patches.
Also, you can't add the flow offload bits without a corresponding driver
change. Nobody calls the exported flow_rule_match_ipsec() function.

[...]

> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7865f5a9885b..a90b0e3d351f 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -594,6 +594,9 @@ enum {
>  
>  	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
>  
> +	TCA_FLOWER_KEY_SPI,		/* be32 */
> +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
> +

This will break existing user space on new kernels. New attributes must
be added at the end.

>  	TCA_FLOWER_L2_MISS,		/* u8 */
>  
>  	TCA_FLOWER_KEY_CFM,		/* nested */
