Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C19B769A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGaPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjGaPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD810EB;
        Mon, 31 Jul 2023 08:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AF561199;
        Mon, 31 Jul 2023 15:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990AC433C9;
        Mon, 31 Jul 2023 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690816102;
        bh=8WeL/6slyvWw7HT3fiPSTpSPJCIGxvXPKTIYefW7MUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CzyzrktMolLGDewSqzLYZ7D8ZpXSaP5pBO5Qk+cVHF5QXtTip97ddnTGae59kYdB7
         qHQKa9Rx1ycRwg8x+K5KwYOvzt4Hu+fj/WESxc0Ce9IA37cPlH6Su1lFsgLv5ccxN5
         iEMcc8z0mqdJJEidVjTyaqMVm/1/jkqdrD/A+XjbvWB0g1K9hGohT6NM7dED4tZ9ew
         mUQn4cyhcGmi5bZToM0SFN3uhOlJ1BDWedI5608VBevFoL03lJbP4BU0KDdlvO8HC9
         BGHqclX579UZrja2/3s2+o+9W2rlbQWR9k9wROwbRGPsj127+7vjZLHvpfWsVdXLuR
         uy2KJ/Vjzn+Dw==
Message-ID: <127b01ed-01f2-8b1e-5851-d7ef4ffd9b6c@kernel.org>
Date:   Mon, 31 Jul 2023 17:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] rtla: Fix uninitialized variable found
To:     Colin Ian King <colin.i.king@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Schwab <schwab@suse.de>
References: <20230727150117.627730-1-colin.i.king@gmail.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230727150117.627730-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 17:01, Colin Ian King wrote:
> Variable found is not being initialized, in the case where the desired
> mount is not found the variable contains garbage. Fix this by initializing
> it to zero.
> 
> Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
