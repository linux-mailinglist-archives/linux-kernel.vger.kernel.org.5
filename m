Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAC7F6C80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKXG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:58:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5EBD56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:58:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C6C433C8;
        Fri, 24 Nov 2023 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700809123;
        bh=8oGVysG7zZuKUiOOlj+W5XkGwaErRlyqbLxjW9gwDgI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TZiNHjP5ssXp5XzjwwL2tDf5kFi4FClHfHk6CtpdnfRN1hIYh7DaWwTlg/cO9EYhO
         COlaM4KAdrsHUvCvzzlX6mKgVRr4n4xUwJn6njjhpB/0xwCTOh2gUCmGZWcBYoDaF0
         LilvMfJHTiTQyS8pJjC3OQ47jWsj8JZ/aQyPtobwK00c3E189yDHmDR278fIOBpHth
         LRHSkEEjvdZGQtZhJLGGJFi4BQ+s/jcmj7Rf13UAqm+0kxSDxni2lxExAEjEAudmwP
         x2RyDg+dS7XE9is0AWdXOun4F0lHK0GxchlhIZ/5+2IFRbhAg7X7b3wOpCAJfMcR31
         VAnWfaM4QuhZw==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] soundwire: introduce controller ID
Message-Id: <170080911959.720753.6925948247080380570.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 12:28:39 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 11:09:31 -0500, Pierre-Louis Bossart wrote:
> This patchset is an alternate proposal to the solution suggested in
> [1], which breaks Intel machine drivers.
> 
> The only difference is to use a known controller ID instead of an IDA,
> which wouldn't work with the hard-coded device name.
> 
> This patchset was tested on Intel and AMD platforms, testing on
> Qualcomm platforms is required - hence the RFC status.
> 
> [...]

Applied, thanks!

[1/2] soundwire: bus: introduce controller_id
      commit: 6543ac13c623f906200dfd3f1c407d8d333b6995
[2/2] soundwire: fix initializing sysfs for same devices on different buses
      commit: 8a8a9ac8a4972ee69d3dd3d1ae43963ae39cee18

Best regards,
-- 
~Vinod


