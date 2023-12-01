Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9666D80047C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjLAHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:15:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36710FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:15:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B5DC433C8;
        Fri,  1 Dec 2023 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701414925;
        bh=CNZZ/9juIG0OKqeCsO8gwDQtYKzOzJvLw6s4b85gygc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7lbX6E9Atn0nM6nUkJOXvJ+YXnvvVQOBP2sYOjYBPcclVzf6WHHGgKnA1gq2ttWT
         dHrzt+cU+6aeAbyDzCORYpaRuSmUenP9+ObSY/DjxT1w0bc28kVu26xPBdONHICl1g
         1WercqzES8h+hy0PjTeBQug8GviZrNeMPIblM0VTIxD84kZEEP7OPPAi5pd+ISxAaY
         tvivvH7BVAU9LrbwMiV5j6d/+5EPWcP4NaAJ8mtt2pDbGCOawySReq84/pKuGLGj5u
         oAFFfXByC4nusyblyyqQADkO8p2Pp9GRPYrXDURtCj+Zasvu7lkwfnd8M/BPxzgnvb
         iLvePxfTOoQpw==
Date:   Thu, 30 Nov 2023 23:15:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] octeon_ep: Fix error code in probe()
Message-ID: <20231130231523.267c08a5@kernel.org>
In-Reply-To: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
References: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
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

On Tue, 28 Nov 2023 16:13:19 +0300 Dan Carpenter wrote:
> Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code
> returns success.
> 
> Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Sathesh, Veerasenareddy, please review. See:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html#reviews
-- 
pw-bot: needs-ack
