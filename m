Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417957D43C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjJXAMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjJXAL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:11:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14610C7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:11:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD0CC433C8;
        Tue, 24 Oct 2023 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698106305;
        bh=nunD+4gbQ43OWpDMzt1aMIddlChl+mgwV/NK5UI/DNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JivXI1cLvpqztbdV9v6ENZOYrWK50wD/keeSE7slXsG0LBOG30oRoKeg0yEWml+0x
         4dz4dID55O72HEKnF7KuwuI6/PqG0JweiNf7LJTpAvF/6u3+TBI6050umD/mosWvQ4
         uVVNTz3xk1RdB/fgX3bY22RNduPlzKIAnJXcp1XOQbzOK1tnr0ulWMbOfhUi0qiuIB
         YYPdcQVnRDhIYprIMLgK3fPVsbY2ziYnF8qzm+9HDXZyH41Eg2Dc6gv43FFObzSHRv
         CMg0Q+UoGX1pbcsEoLXGZeX8ELI34XOul8AVRKymvtinLljzyv165Eh0Fhnyuw2XC6
         jZw5AuYOhoZLg==
Date:   Mon, 23 Oct 2023 17:11:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Dell Jin <dell.jin.code@outlook.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        "Andrew Lunn" <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net] net: ethernet: adi: adin1110: Fix uninitialized variable
Message-ID: <20231023171143.47c83b0e@kernel.org>
In-Reply-To: <20231020062055.449185-1-ciprian.regus@analog.com>
References: <20231020062055.449185-1-ciprian.regus@analog.com>
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

On Fri, 20 Oct 2023 09:20:53 +0300 Ciprian Regus wrote:
> The spi_transfer struct has to have all it's fields initialized to 0 in
> this case, since not all of them are set before starting the transfer.
> Otherwise, spi_sync_transfer() will sometimes return an error.
> 
> Fixes: a526a3cc9c8d ("net: ethernet: adi: adin1110: Fix SPI transfers")

Applied, thank you!
