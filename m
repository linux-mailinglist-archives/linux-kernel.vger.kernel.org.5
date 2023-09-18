Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6E7A550B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjIRV35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIRV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:29:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F10C10F;
        Mon, 18 Sep 2023 14:29:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9492EC433C8;
        Mon, 18 Sep 2023 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695072590;
        bh=XjMzRlGBtNL1Q/EZymEQBbUOu0SfxSTsrHkQ27pJ5xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heRd0VVZxy2EvvKRsiW1igOyVxuUp5WJ4Z1SXq12KJ8XZAZqRQGnhcXzpS3HwF+Ia
         igSQm+CHT1uohmHslvVQIDxkKTjNNujcM226VOyt92pfw7fta1OLsYa0QMsBsRKxlp
         KCFjoAoPvLuLwsnpKP/HTWOR6Mnnss9pcwfK6sS3FAag8nCcS5NskW6/kt3KXntxjW
         tT4rr+IYEdgSyhei0NOznehA3/+QbkPm4LMNkpX4n+qQ2mdGXDeosFtawqvOsaVqyp
         FqyTtsrRZDzHSfwpKlvwkBzQ+dMi0zxqJkgfq/TDaBKQdorSvdGZ8zVkVn+ab943Gf
         OLO8MPN2cu2lA==
Date:   Mon, 18 Sep 2023 17:29:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        lucas.tanure@collabora.com, pierre-louis.bossart@linux.intel.com,
        rander.wang@intel.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.4 04/31] ASoC: amd: vangogh: Use
 dmi_first_match() for DMI quirk handling
Message-ID: <ZQjBTUUJtY+1Q49X@sashalap>
References: <20230908193201.3462957-1-sashal@kernel.org>
 <20230908193201.3462957-4-sashal@kernel.org>
 <8d75077a-799a-4bf1-b259-a931c00fbc54@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8d75077a-799a-4bf1-b259-a931c00fbc54@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 12:20:16AM +0100, Mark Brown wrote:
>On Fri, Sep 08, 2023 at 03:31:33PM -0400, Sasha Levin wrote:
>> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>
>> [ Upstream commit 3dd26e27ccb4f18b4d25c0a49e1888eca9c6a724 ]
>>
>> In preparation for supporting ACPI probing, move DMI quirk handling
>> logic at the probe's top, to be able to return as quickly as possible in
>> case there is no DMI matching.
>
>As the changelog clearly says this is preparatory work for a new feature
>and therefore not stable material.

Dropped, thanks!

-- 
Thanks,
Sasha
