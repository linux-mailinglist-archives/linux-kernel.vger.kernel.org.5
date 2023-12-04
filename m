Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D35803413
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjLDNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjLDNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:10:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667D10E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:10:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C485BC433C8;
        Mon,  4 Dec 2023 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701695441;
        bh=mH6UFinR2jS1kpwOBQ++DpQNO6L7gqAEnFvCgBuoLGY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b5w/c0SRgBX7jvWNhtbcglu86+s3q51ywjLP3jI4BbPueqnGvCE4mRLSYh6CwMJep
         BQ5wOt7tbnK0reMAMwxSJ5mYyrqf+bKyB1BO1Vo73kYNZw5DRm8gGYaQmihn/r7sjV
         QUQUN1nl+cK0kz6oI4jh9CaKFBla9wc/xnlBYah61rwfHR40DEbTS7VhCYYgQtRXHA
         X9+y24Pxug1KsnjC54SQ76+l/aScZcROHdhQxFJWg53/u3ppa0I0k3k8Rp067G9lz4
         iqmdJ0zJyHBgZ0pAzXMoAVq/e4qAsqhes2p+voBMI5trJm7ePTYCFpyAUWZDcAfrJz
         Abc3YWhRCACxg==
From:   Leon Romanovsky <leon@kernel.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Dragos Tatulea <dtatulea@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gal Pressman <galp@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231201104857.665737-1-dtatulea@nvidia.com>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
Subject: Re: (subset) [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-Id: <170169543706.44375.3181832396401755311.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 15:10:37 +0200
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


On Fri, 01 Dec 2023 12:48:50 +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the driver. This is a firmware feature
> that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> [...]

Applied, thanks!

[1/7] vdpa/mlx5: Expose resumable vq capability
      https://git.kernel.org/rdma/rdma/c/b24910e1be0e76

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
