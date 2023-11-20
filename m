Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B97F0A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjKTAbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66525107
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 16:31:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332B4C433C8;
        Mon, 20 Nov 2023 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700440277;
        bh=OmHLXiOrAgMaNG1uUjFv3wgZ/90zPZx0ShH/mn5WtTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nY4DNXZD0Y9rZhdWVKcsw/rCi5fTazaY29Yos4iEFIDruVJ/E0c4LTR/d33l298JD
         y8lNmW7ynG1PRuozONgIPkJUm7DSyCn1cv+VMkxtv3tdpfC9DrUG1OnvH3DmoV1ig+
         AYpRsLiAx+UZ0qcF7g2OP9wYwlwxqgTPFYyGA3jVK/eLSFRQCKi4/cXKVmQ/kmPwOw
         p2XfdTSGreXOuV62VNs7nUu6G9C1mnSNQxT88ZCeZSrB579nrfbuChEXY33nSExbwW
         XO/+xUBDZjo/OfiYWMo5NPClKLtzJoe7LsSxB4YpCAbmGiiR816Ekpu7yJ4VD75U63
         0f1k6d7GOhrfA==
Message-ID: <bdb6a94f-f068-4627-b11b-dae4c152e7c3@kernel.org>
Date:   Mon, 20 Nov 2023 09:31:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <497fe3c81b83ea74c4850bc44ea09acf15886b7e.1700296910.git.christophe.jaillet@wanadoo.fr>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <497fe3c81b83ea74c4850bc44ea09acf15886b7e.1700296910.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
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

On 11/18/23 17:42, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> While at it, also propagate the error code that is now available.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to for-6.8. Thanks !

-- 
Damien Le Moal
Western Digital Research

