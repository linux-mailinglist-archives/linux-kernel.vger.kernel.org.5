Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502D7FF93E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346180AbjK3SXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:23:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39825D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:23:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E830C433C8;
        Thu, 30 Nov 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701368622;
        bh=qQlf1wlM46DStT6SsBHk1Ov4ohMfBkiHcFw/hbSHDzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzZZ8kZRdJ6pu6uovrGlCvcsYD7x7XChrvYhQtmCH0KuYQqvn11bWG96iotfj+n7p
         dXhzk7H2K0gpbPETqyRcS6ISPZgn6eN27zEvbY9g8OqigiikY0TfTmeveUjN7p3AZj
         ZTIj+dyREsWw7HRSoo/fVNdWUnKXjScHmJe01yqK7BWZIMbnZbohkkmltCJidBGLIG
         kVHBqFoNIAnqmJybMFjnBDFeTWHdLBlspwKVOVZGBsd5gdmGtjCBJBNgEhw1o7PfGG
         Tlxlf3Ib/rtxu0Q3rdlAOswSiIGZ/kBdBDHKSkxjCfnfrZZFwmdUYhjBaYbbnweOSv
         rdwpPyoHj9o1A==
Date:   Thu, 30 Nov 2023 18:23:38 +0000
From:   Simon Horman <horms@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] octeon_ep: Fix error code in probe()
Message-ID: <20231130182338.GM32077@kernel.org>
References: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:13:19PM +0300, Dan Carpenter wrote:
> Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code
> returns success.
> 
> Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks Dan,

I had noticed this one too.

Reviewed-by: Simon Horman <horms@kernel.org>

...
