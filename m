Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8F7C513B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjJKLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJKLLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:11:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523AD7;
        Wed, 11 Oct 2023 04:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22937C433C9;
        Wed, 11 Oct 2023 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697022695;
        bh=0uI2S60WTdV7FfQq9cdwuq29Q5F3hgzaJEmqz7lwfKE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NgKdolV/9BtLEaRjfZRJ5E08xBChLa0URk58vSGNkF9kFGifBKMcrW6ix8u7zLhUb
         0DW5vMZe8kKhfgtg3+w8ecTJ0pEOTmVFUKkIgfzOAzG4zyWh5udhs4xVPn2GLq0QRR
         Lvd95XzCqrHOhKKzc2MxnVxNiIN9Skj+K3K2bpFD4bx5s//CB4GtocIWgggzVghcnU
         canDeiacIIy/yEpTI+Ih3c+6HXIGuOfSliWspA8QEvS4fcEJ9SipWHX7XdLNan7Gpa
         wpDlPJe0K2aBY6EchiZspQJrBJXCH49uZ4/9HVVP7K6v3slCyL6eKbcju7Xp588bZ5
         7wIgO+4fwGLfA==
Message-ID: <64562998-e992-4e46-8b9c-cc70655e648c@kernel.org>
Date:   Wed, 11 Oct 2023 20:11:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: imx: Use device_get_match_data()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231006214442.339890-1-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231006214442.339890-1-robh@kernel.org>
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

On 10/7/23 06:44, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

