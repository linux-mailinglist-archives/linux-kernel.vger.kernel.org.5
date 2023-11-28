Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6B7FB07D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjK1CnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1CnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:43:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E318F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:43:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7B8C433C7;
        Tue, 28 Nov 2023 02:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701139388;
        bh=FP5iJJdaRp/C3nYdpRdsVX299+R2BDsbJDi1D7WwSW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qyhYjOKf9DXu8bH+bDiJXmJUfqSLmCdUcv9xz5080dk3JfRoUfnMtEgHfAhNWe+Ru
         6ENqX9mYL7GV88wm+J6VPnNLsZ1hAejksTrttO6WeLCjpR8hL96nBJOPz9KalEjXbu
         MOfVYudEUkpaFVVEwB6B+gw3dG5Yxz9T4ZmepFNcC/r8e0J7/Kpte39LrQj/7CLc/v
         5svFCaCQPbKI3auHVmmySgb3dm25Ul+qWPfN8ypOB2O+8FSIC9Ilc6yHXYfn9094Xf
         3rAgCaEnPVZFlwRpzVpnQqC5wOnSpvBfPCIqLKkXrb5SizJuLDRM36sLxTHbN5mEuJ
         GPt1vUCUBqi6Q==
Date:   Mon, 27 Nov 2023 18:43:06 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1 1/2] octeon_ep: implement device unload
 control net API
Message-ID: <20231127184306.68c2d517@kernel.org>
In-Reply-To: <20231127162135.2529363-2-srasheed@marvell.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
        <20231127162135.2529363-2-srasheed@marvell.com>
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

On Mon, 27 Nov 2023 08:21:34 -0800 Shinas Rasheed wrote:
> Device unload control net function should inform firmware

What is "control net" again?
