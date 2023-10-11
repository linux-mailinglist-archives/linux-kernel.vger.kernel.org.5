Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952E77C5135
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjJKLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjJKLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC1103;
        Wed, 11 Oct 2023 04:11:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A7C433C7;
        Wed, 11 Oct 2023 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697022670;
        bh=X4oN6SGOLiwR3mzIj/29e+IHIPBGU1iGik5QI8MSC44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H4/IZmWPC8OaITn10HnJCCWyDGwnrLly/1aLc5mWa4W9gr0qAKrAk55Y+FdkdLlMR
         yJQKtumZ9AtKrmVbtJVxWzLmhWwuHPG6WJZ7da/RbbjTRnyUNtzCyyuYHJiXK3voox
         CzR0tyswVk2ppjsE8XsLd8bnClHwpScNsPMC/TAWon5WgKuWdLVhtULDnZBCXs0yYQ
         sWBm0LBZORRq2o76FWqtG3kaS3WRtXTsAQkVFG6jjC6w+imm8gF2/6tWNPwAumN1uz
         GYePdfxKE9pljBc4ygbTT4bQLuOlQ0qTb6mg2XhhOaUitFjpkvrHJnFzbzkHQaSgL5
         5Gym+ejVsS6VA==
Message-ID: <9b785303-8de6-464a-9685-103465b51cde@kernel.org>
Date:   Wed, 11 Oct 2023 20:11:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: xgene: Use of_device_get_match_data()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231006214433.339688-1-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231006214433.339688-1-robh@kernel.org>
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
> Use preferred of_device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.7. Thanks !

> ---
> Perhaps device_get_match_data() could be used here and all the ACPI
> specific code dropped, but not sure if all the ACPI code is really
> necessary.

Will have a look at that.

-- 
Damien Le Moal
Western Digital Research

