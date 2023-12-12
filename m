Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143B80E4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjLLHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:09:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F536BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:09:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3949BC433C8;
        Tue, 12 Dec 2023 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702364965;
        bh=pB8+fIZhzR492UWfipR7CODlOesDHwNffafvM9Vgtrk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VyUljDowqbRlOWaI5ynH5FOKn6SM4FmBvpZ9i7jyQn4k3gBEzyiGyeliZWsFa54Ks
         EFIoMKgRD8fGUYhwFfXPvHEy53EnGHSyOYvSgR9j1Qbk3EkvX2quUN4XeLfqNnsHlh
         4UvGBO6s2SpW8izhAnhQTjq83O+tT0bZ8WF0P5lU4PvrBsIqgsTYfX08kexF0YcA/B
         QDdpECiOrczg0nK/612ofONN1Oa+RdgL33bAjqDGRSrMakjycpUGsf3wnee+ZGWRye
         O5hyNTNLsFqX/ZrXMyW2Um75V90M470jv5PzdQQEZKXnFvEgUeU0DKRw1wevwNxKR9
         Wv5ZQv6FStZEw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Shun Hao <shunh@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next v1 0/5] Expose c0 and SW encap ICM for RDMA
Message-Id: <170236496138.251016.9253831188442382874.b4-ty@kernel.org>
Date:   Tue, 12 Dec 2023 09:09:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 16:01:33 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Reordered patches
> v0: https://lore.kernel.org/all/cover.1701172481.git.leon@kernel.org
> 
> [...]

Applied, thanks!

[1/5] net/mlx5: Introduce indirect-sw-encap ICM properties
      https://git.kernel.org/rdma/rdma/c/1ca51628e73037
[2/5] RDMA/mlx5: Support handling of SW encap ICM area
      https://git.kernel.org/rdma/rdma/c/a429ec96c07f30
[3/5] net/mlx5: Manage ICM type of SW encap
      https://git.kernel.org/rdma/rdma/c/abf8e8f29a3cb6
[4/5] net/mlx5: E-Switch, expose eswitch manager vport
      https://git.kernel.org/rdma/rdma/c/eb524d0fd46249
[5/5] RDMA/mlx5: Expose register c0 for RDMA device
      https://git.kernel.org/rdma/rdma/c/d727d27db536fa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
