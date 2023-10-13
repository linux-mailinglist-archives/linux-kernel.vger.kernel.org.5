Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694F7C842D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJMLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJMLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:15:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C55BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:15:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE638C433C7;
        Fri, 13 Oct 2023 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697195710;
        bh=jA46OFfZWE5nXbqzK1rBDGiSAqJladumXI0uqrd0S44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDPvni/AZVdMKTlO8s/IBEmavFAjqLDOaRcwMvA8tdAkQ8+fB/O3DzkNkzOtYMXpW
         dkx6vgxkMbpHPwbEL9x/F1yBPw8WqjJMOzQ9PH9OEmKrM+V42syJ83yeVeL+CAOdGe
         I6f+AihD+y26HPYtWFPdwnLhU8rR5OwxHmmE/R8cXqR3G0eEXY4paqAn+acP/PvlEp
         xsRzRqJNJ/Zb1y34jhlLM63lWMbVfhX9oOzVvlE3p/9ZFz2ZNsS0jf6oKVlVdxZEeA
         5uwk6rorBxYU9JcTtdhchUVCixTShpqgJ68w+OQAU2jZeF0EiTBA6Vt3dcHJqgSxBL
         uWMXpoUjdmb5g==
Date:   Fri, 13 Oct 2023 13:15:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     pabeni@redhat.com, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, egallen@redhat.com,
        hgani@marvell.com, kuba@kernel.org, mschmidt@redhat.com,
        netdev@vger.kernel.org, sedara@marvell.com, vburru@marvell.com,
        vimleshk@marvell.com
Subject: Re: [net-next PATCH v2] octeon_ep: pack hardware structures
Message-ID: <20231013111505.GE29570@kernel.org>
References: <PH0PR18MB47341BB93B1CCC7E6E91AC53C7CDA@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231010194026.2284786-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010194026.2284786-1-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:40:26PM -0700, Shinas Rasheed wrote:
> Add packed attribute to structures correlating to hardware
> data, as padding is not allowed by hardware.

Hi Shinas,

in the v1 you stated that this is bot a bugfix.
So I am assuming, that by some happy coincidence,
the layout of the structures is the same before and after
this patch. And this patch is thus a cleanup.

If so I think it would be worth noting in the patch description.
