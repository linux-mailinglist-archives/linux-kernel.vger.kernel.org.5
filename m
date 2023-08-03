Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5376F0D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjHCRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjHCRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8C3C2F;
        Thu,  3 Aug 2023 10:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954F461E59;
        Thu,  3 Aug 2023 17:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F080C433C8;
        Thu,  3 Aug 2023 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691084737;
        bh=NYvjsiwLCUT+hyfVYpuPUB20GDyJSX72vAXBvPGj2PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQauctMikTrBSs0A223sKVV9gnlWChPOmPXl4We56DDOlaag0jx6V7fYL32u2XCgD
         Ao3c62a3ydN1UYQtyQhpAVqHmC5cIhncBzEOtQwEb10O4fC70+xMUcA3bn8lIFtQeA
         2axsTcuHdFMEfiMBA6PHVLN5xMC0542jQVK/VPus5MBSy1QpKTKttN/szSrc3Omlch
         +q0w4Yl86J5SdCwCGK2oiV1UyiAz6WoHeACGCD9qUlmEsLUY6uaYCoiwN5DRye87UR
         f4Y5zpoQ6EFIzeD4fVUex6wcnSXpuqpHRRKoLPTC3om1DxlbLn8CNxJ2c115AyXXH9
         pK6EMIbUKqEFg==
Date:   Thu, 3 Aug 2023 19:45:32 +0200
From:   Simon Horman <horms@kernel.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/6] net/smc: add vendor unique experimental
 options area in clc handshake
Message-ID: <ZMvnvLOZgtmS2IqN@kernel.org>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-3-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803132422.6280-3-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:24:18PM +0800, Guangguan Wang wrote:

...

Hi Guangguan Wang,

> @@ -987,12 +991,12 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  {
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_clc_msg_accept_confirm *clc;
> -	struct smc_clc_first_contact_ext fce;
> +	struct smc_clc_first_contact_ext_v2x fce;
>  	struct smc_clc_fce_gid_ext gle;
>  	struct smc_clc_msg_trail trl;
>  	struct kvec vec[5];
>  	struct msghdr msg;
> -	int i, len;
> +	int i, len, fce_len;

Please preserve reverse xmas tree - longest line to shortest -
for local variable declarations: this is Networking code.

https://github.com/ecree-solarflare/xmastree is your friend here.

...
