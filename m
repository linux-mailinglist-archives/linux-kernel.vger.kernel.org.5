Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75D7C04A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjJJTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B41A94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:32:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F4C433C7;
        Tue, 10 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696966356;
        bh=GPjua0IjCuMmByKlFL6lkNxV/332at3VwhBzisfdC1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgQRxMcvNVVtr9a++yWmtIV8aRE4qIlhES2ie00klEHXAI4mm1LXGCzByBIEv3th6
         DbBMK1z1cDlS5GonXRB1Zevzm3uChV8KKdPxdjM2oDpYCILXlIMKy31hatUQWL8R57
         RyzhYyLY54XXXY+dYJOW907p91R/NA0H82XkaZm6Wf92w+B9y9BjsL4P9tjK5CkGUO
         Mn9EPEgFt0v75/3f6OW2bSN3kus9cLE50edhw8BcDkJO+ALPTGxrxPd15djB7ViAS7
         SplqRtSI3pCgyJvf26XuBMHyR6sW+lFwmX6C1P5YzGz/smaclVJKUtvQ9lFiZRL1Mr
         q86GKoXJPXBfw==
Date:   Tue, 10 Oct 2023 12:32:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Takeru Hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231010123235.4a6498da@kernel.org>
In-Reply-To: <20231008075221.61863-1-hayatake396@gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Oct 2023 07:52:22 +0000 Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sd`
> In addition to gtpu(4|6), we now support gtpc(4|6), gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.

This is for tunneling, right? IDK much about GTP but we don't have flow
types for other tunneling protos. What makes this one special?
