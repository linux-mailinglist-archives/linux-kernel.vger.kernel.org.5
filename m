Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA477C5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHOCK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjHOCKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD0E5F;
        Mon, 14 Aug 2023 19:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 312D660AC4;
        Tue, 15 Aug 2023 02:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60194C433C8;
        Tue, 15 Aug 2023 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065451;
        bh=FLYOlStsvGeLjc5wAEsJAq7Q7sfqnj++AnIu5mNa9ko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sme/n9Y8BKt97Jr2NrhOUSgrEc3Wq9REXncbYf0cbRf9pJm575Ce5GcAa4/IVoVYU
         3LFCJbeQyG6XO7xxBC04W2Ys73RfG5+PSWgRjneY3SeUlJ4uAS0nNPzcQoqEFOFe+9
         PW/rRHG9bNIUKNsqk4uxs2b1ICh0FnJJOj7Jj/4G5Ufk2G4w6QEcpVcvKw7QdrOV6V
         5fM4c3xeguvHw27oJJ1EiHJ7UFXAmxkGxcBWPo/ZgC3LVenUb2WbFJI1BH2Mmfnd6z
         xVtXnLExZ6u9j8gpWQ4lfYD5fYuN9u5X+i7dwF1l22fFS/sF2kPst4nUpO51OrHSE/
         zPyMFY56Ye0ZQ==
Message-ID: <71d416bd-d8ac-74ca-e596-60c44839177c@kernel.org>
Date:   Tue, 15 Aug 2023 11:10:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/10] scsi: libsas: Delete sas_ssp_task.retry_count
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-6-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 23:10, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ssp_task.retry_count is only ever set, so delete it.
> 
> The aic94xx driver also had its own retry_count definition in struct scb
> sub-structs, which may have caused a mix-up.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

