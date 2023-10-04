Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA597B8E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjJDU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:58:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931C90;
        Wed,  4 Oct 2023 13:58:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E46AC433C8;
        Wed,  4 Oct 2023 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696453115;
        bh=Kgxn5AIRhIWtyFuMGakZL10Svqz1LmHd7tgwEA8m0mQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPOSpeR3Kg+uel4BpVB4iitLFWAWZNuCZ6+LM3nNieGz7u6iwhvavHV8mv4YQga0z
         u37whBN/5hAI7VMB3JT/0OJW6pE7/g78JOFvDN7jgNLiDuwC/9SiXf5OieVX1AVGqS
         t79tRLJ9JdW0JuR2+0sQ8bKLVr572azXKoPkIE0e3qk5PnTzHdNecOpoO8oty6aLFD
         czWWgfPFRpDEGVymkAcJQb2cN3L2MbTpO5wkGTRm+3U4bw1Fa8X3kVV9Hbcp3EnWay
         ct2XO5c/wRgQxa3UurRvBhtSqDQdbTALZ978+wzX88JcH5fAqKPOjc5mu68uSEq8e9
         lXYitUvjiMQBA==
Date:   Wed, 4 Oct 2023 13:58:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v3] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20231004135833.6efdbced@kernel.org>
In-Reply-To: <20230928103000.186304-1-danishanwar@ti.com>
References: <20230928103000.186304-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 16:00:00 +0530 MD Danish Anwar wrote:
> +/**
> + * Config state machine variables. See IEEE Std 802.1Q-2018 8.6.8.4
> + */

Please use correct kdoc format with all members documented or not use
the /** marker.

> +struct tas_config_list {
> +	/* New list is copied at this time */
> +	u64 config_change_time;
> +	/* config change error counter, incremented if
> +	 * admin->BaseTime < current time and TAS_enabled is true
> +	 */
> +	u32 config_change_error_counter;
> +	/* True if list update is pending */
> +	u8 config_pending;
> +	/* Set to true when application trigger updating of admin list
> +	 * to active list, cleared when configChangeTime is updated
> +	 */
> +	u8 config_change;
> +};
-- 
pw-bot: cr
