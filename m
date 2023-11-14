Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E07EA9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjKNEwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:52:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BC4A4;
        Mon, 13 Nov 2023 20:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=r3sYe9WZdqxnfaXhk9h2yztgf0ciQLfjChsoT0hl1Bc=; b=SdS2+F7GNRyfTcAwoaswtLhNaj
        RSohOUDC7WZWk9Pm++YzplZtEXC14cTUULZzF6MPfSDb8W5Ulq84dbP9pjvQ4/FZWi5fIQ6/o4dhw
        Y84fko9XK/C0kYQ+3lyrYQxLVaG8kmA5ICy6B3LAWrwDrDpDGNYSIrFk/mhEWEUf5W9rKZbOhbfIJ
        p4Pl9HghOZJT8+Nsd6vgiWBMzjvsc5TcM4vpGlpBBPWt7buVAPdXhYtPQ2xxZTOjxORnKGE+yuu6m
        zdPsXDzuCZKDrhk/XBrx+vwCL5qBeSe8ph1f+TesFUN1liZsBW+oTTSMc/AmAaHVLxH4bDibHiyOZ
        FygeyKYA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2lPB-00FAos-1c;
        Tue, 14 Nov 2023 04:52:05 +0000
Message-ID: <1553cd01-37fe-48c6-a6e3-b6ea9974d40b@infradead.org>
Date:   Mon, 13 Nov 2023 20:52:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Non-existing CONFIG_ options are used in source code
Content-Language: en-US
To:     sunying@isrc.iscas.ac.cn, linux-kernel@vger.kernel.org,
        Neal Liu <neal_liu@aspeedtech.com>,
        David Howells <dhowells@redhat.com>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     linux-crypto@vger.kernel.org,
        "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "renyanjie01@gmail.com" <renyanjie01@gmail.com>
References: <4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 02:29, sunying@isrc.iscas.ac.cn wrote:
> The following configuration options are not defined
>  (they may have been deleted or not yet added)
>  but are used in the source files.
> 
> Is there something in these that might need fixing?
> 
> ===============================================
> 1. CONFIG_NETFS_DEBUG
> fs/netfs/internal.h:122:#elif defined(CONFIG_NETFS_DEBUG)
> 
> 2. CONFIG_SSB_DEBUG
> include/linux/ssb/ssb.h:626:#ifdef CONFIG_SSB_DEBUG
> 
> 3. CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO_DEBUG
> drivers/crypto/aspeed/aspeed-hace-crypto.c:19:#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO_DEBUG
> ===============================================

Yes, please send separate patches to remove each of them.

thanks.
-- 
~Randy
