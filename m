Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5D7C512A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjJKLK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJKLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:10:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2498115;
        Wed, 11 Oct 2023 04:09:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4DC433C9;
        Wed, 11 Oct 2023 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697022576;
        bh=3kH+pQQjIkIDI8ifN14G+a5TCPOKhClhNMLfZIwqfOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kIljUxRiUIiiOVuTlucAyG9/v2Ua8NWK58vO/XKKWqu/tg5hvowuiyqFHMrxxmCNc
         aYaatK3Zvn3HpNKOM5fN7TTeJ0AL4TtoZKtZBWKpHbqVdDYTpPS6Iruov0w0005L64
         7WHkBnQPRK8XLpGo/xydt7Ev9lDSY/Mtpq7kY/rzD5QYqpiSYj8hiJKYE9erzccIN2
         JnmGMwt4aL6ONjBzXPf2lcN6XIBisQ4HIips3os17nib2tv/BOR7mjIgItDDW6ER+b
         WjXyPNt09GpypWTmr3vitG5r6gulvr963IfmRf5r9or4uxzAntJZAs3xYW8MQqAZPM
         ZFt+ZW1PmR7Zw==
Message-ID: <79b0f043-2dcf-49cc-b52a-e1ab21554610@kernel.org>
Date:   Wed, 11 Oct 2023 20:09:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231010122916.4080132-1-make_ruc2021@163.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231010122916.4080132-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 21:29, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

