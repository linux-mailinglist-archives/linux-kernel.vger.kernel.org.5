Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2980B5FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjLITLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLITLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:11:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42913A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:11:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8FC433C7;
        Sat,  9 Dec 2023 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702149110;
        bh=GoCf7IwFe+k6fUAIEuS1Bv4Gt8vQiC8SZUGXlwqNP14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwYAfxWz/Df9+K8+uODNixBenK018c+cULFPVo3AGdn8/km789jmrQDYpXgRqzkEo
         dXIFMhQa6QVAEnDv8dCpcQJgZZEBfeAfk77SYbQdg/AkCKzowdJBQIL3NuWZRs6X5M
         Cf4xbmuqCaU6twGy+HbUEx73seYsDhuu9VZOV+aiqaAR1EuGQQSGyZYswNvmSHS1Ow
         ZImqyTovXdZri7TCWvpyaucHDdbnycZoovR2gwOvIadbKgxv94ztXZjqO3/m3Zm8LN
         3kawYMtQBOH6DnmKOrXaRxebNg7Lb94raNdALbGEFvClLQ6vJ1p1YuXTDI7DcMraft
         wSHe2nEQI8mTQ==
Date:   Sat, 9 Dec 2023 19:11:45 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
        shannon.nelson@amd.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v5 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
Message-ID: <20231209191145.GD5817@kernel.org>
References: <20231208031950.47410-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208031950.47410-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:19:50AM +0800, Kunwu Chan wrote:
> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256.
> 
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

