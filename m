Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C014E77C5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjHOCMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjHOCL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4779E5F;
        Mon, 14 Aug 2023 19:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432BE63C19;
        Tue, 15 Aug 2023 02:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7403C433C7;
        Tue, 15 Aug 2023 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065517;
        bh=NIwN6+aYG5ci/fhKfenF3KLIpm9qmCjQw2z87oooXWE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mPa2VPH7Edzmo5iM23b6eDdPL7bmRuFXoM58nG5RgSO5ne6ZwG8fwOLur7pVipTeb
         RYecoL1EZv+7MEZCTmqM6O6PH9un/TTEDNKwtmoTD0OfxHOA4UIKYCCiLd1l3vjoPl
         n+Ylr1gHYQWd1P7+uZu+0AoinOqhM2bgdsKH40lij9oVrYrFfv7/yVNzYXuZP1igsw
         /gxcARcizFzRgUaPYBDiBl4aTlaBZ5kT30EvV7oTTk2TDIIwmF62tRJucsKX89UUNO
         cuvKIo58baXHnOSkTKS5dYILu7Cx5uSiOzy7mLhsl8S5F2lB/hQD5AT4QZAS0lSROv
         hEkOxBpU49Ghg==
Message-ID: <22c2197e-fac3-8d98-2441-10a9f52cd779@kernel.org>
Date:   Tue, 15 Aug 2023 11:11:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] scsi: libsas: Delete
 sas_ssp_task.enable_first_burst
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-7-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-7-john.g.garry@oracle.com>
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
> driver"), sas_ssp_task.enable_first_burst is never set, so delete it and
> any references.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

