Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6467D5EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbjJYAPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbjJYAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F00FDA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:15:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C843C433C7;
        Wed, 25 Oct 2023 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698192905;
        bh=7DzSBs3yhzCXmpQ2fczjY4U1Gc12sPHBBSETAV0qOqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1Xl/JJl+iGbGiniqzmoF7fhtzP/KhaICJIxDWa6eIqnABzD9cwujPvHlZDGly3GF
         /bjD+1APhEhePeokVZpfHhaWCbX3sEq7zQXClu/IBDm4p+YD65Hmio1J902QTsPf0S
         yrP2w9fM7nqj7WiZTgJJwZxQrI6AWRX/tKTXhQBoej171CBdvASCJPQkBeBjMujlH/
         sBhCZ4zhjOtF7tTrLVM0ovTDPwWKUQYV7KaOTmdYUobI9NyLUGMlcHmth5rvQ1H81U
         wEl928LIMe+Ide/FEuTsYCed16QOqz0nu4E33CrXbErL3h3+rOD8ofZusG8/1gdtal
         0SwMlxjQNR9fg==
Date:   Tue, 24 Oct 2023 17:15:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 1/4] octeon_ep: add padding for small
 packets
Message-ID: <20231024171504.568e28f0@kernel.org>
In-Reply-To: <20231024145119.2366588-2-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
        <20231024145119.2366588-2-srasheed@marvell.com>
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

On Tue, 24 Oct 2023 07:51:16 -0700 Shinas Rasheed wrote:
> Pad small packets to ETH_ZLEN before transmit.

The commit message needs to focus on the "why", rather than "what".
-- 
pw-bot: cr
