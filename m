Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247D79D4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjILPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjILPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:24:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D910E2;
        Tue, 12 Sep 2023 08:24:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C8C433B6;
        Tue, 12 Sep 2023 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532273;
        bh=bnpZMEb8ISRduLgq8852O5UPYlyL34vHsYHSSG0B1Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kY6a9kDv7XOhCebA5SqE9LUpt84RjGB+3DMB8ILXVxc90Ts/z/h3EqOB4M1CvMVmI
         AKo0N4nbvfxG5yYSEFEFyPtJzO7pcplr+nC86lAqm+xxqy5cGDId9iRdaJvbjAHKP9
         2dzGKThpMelG5p5yrDSIb34vn4e2zNtngGc4Tlqlb+kd+nMZESrDzlQSoXE8kpMDMS
         dos4Vqzg81YWg2hMAhxN+DBtNiYvFX5y3bWMvmOMni6CBo0LY7tMV0inxwfboMkrw6
         s0QiWHHEEQb1vx980o4mRJG8rlkOzuKMM7pb2zEQYgMxXtT0jq4HZqXHH+LmZyU5k+
         dGjtO3tUpr0FQ==
Date:   Tue, 12 Sep 2023 17:24:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: hinic: Use devm_kasprintf()
Message-ID: <20230912152428.GK401982@kernel.org>
References: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:50:52PM +0200, Christophe JAILLET wrote:
> Use devm_kasprintf() instead of hand writing it.
> This is less verbose and less error prone.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

