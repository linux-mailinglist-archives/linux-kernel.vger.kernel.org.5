Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6E7C81FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjJMJ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjJMJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4688EC0;
        Fri, 13 Oct 2023 02:26:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C37C433C8;
        Fri, 13 Oct 2023 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697189177;
        bh=E9/0n9LD/3cTgp1J3dMrzLvgcdHdGIWkLFZiOEzQPe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4MivpCeIlf5lPj5gu87Vx6jggV0nhy+otJc08N5cogxnNrWLh2fZz60tA4fE+nzb
         NojezG0O4S76IxeOpzQvWS7XTej8HHXZDlAD48TCogl58KWFBZAh6xSnTMTxNpZ07T
         l3wdwWSTBx/AWenQP6TL4SFqge12GHcXeegxRxYbEvLotsrEpWIv3rnqbXwMGehwpz
         LsrhuEWijiCcLpngvCw/fxMIpbZh+l66av3hrv64HY+Xnyk1zapl2onqQKWGLbKV0r
         ChitxTpt6s9z/LXg2UHt5CtZ68tzY9YrPi2cJYZTadzNaOMp1vCaJWHGJmyXJaoVoq
         Y7eqpxl9ZehHg==
Date:   Fri, 13 Oct 2023 11:26:12 +0200
From:   Simon Horman <horms@kernel.org>
To:     George Guo <guodongtai@kylinos.cn>
Cc:     fw@strlen.de, coreteam@netfilter.org, davem@davemloft.net,
        dongtai.guo@linux.dev, edumazet@google.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pabeni@redhat.com, pablo@netfilter.org
Subject: Re: [PATCH v2] netfilter: cleanup struct nft_table
Message-ID: <20231013092612.GA29570@kernel.org>
References: <20231007105335.GB20662@breakpoint.cc>
 <20231009025548.3522409-1-guodongtai@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009025548.3522409-1-guodongtai@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:55:48AM +0800, George Guo wrote:
> Add comments for nlpid, family, udlen and udata in struct nft_table, and
> afinfo is no longer a member of struct nft_table, so remove the comment
> for it.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Thanks,

I checked that the fields of the structure now match the kernel doc
for struct nft_table.

I might have mentioned kernel doc, or similar in the subject,
but I don't think there is a need to respin because of that.

As a follow-up, you may want to consider addressing
other kernel doc problems in the same file.
The following command may be helpful there.

  ./scripts/kernel-doc -none include/net/netfilter/nf_tables.h

Reviewed-by: Simon Horman <horms@kernel.org>
