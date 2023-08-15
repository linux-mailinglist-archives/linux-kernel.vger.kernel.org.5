Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98577C59C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHOCHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHOCHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAE10F9;
        Mon, 14 Aug 2023 19:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D1C6401F;
        Tue, 15 Aug 2023 02:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DFDC433C8;
        Tue, 15 Aug 2023 02:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065222;
        bh=LEwFbGN66DpGHdgH52WI5KYqDRheJ9RE0tXXKR4QYSY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=faTDecExM8FodG+/9UvieIrr3DLMfChcld8Py5Dl/95QGg88Abu4KHtd0G7FIg3Al
         Gv4afe+7FUOIWl4u5gBv8Obhx/fK/Wk1gakiIkhOWh5EsVZmOl8sGAF9eL0p2wwgX1
         Obu58OxsGfbcv9G4E9hl/8rHsn2Ay3X6uNofeXp8OYe/uBswOVRS1qK2/xXLXDj3bV
         Oxi8SiSgkQU60NXDlSTXU937hBj6xgPdIXW9G5VF9W8Vz+jyDSpOmonrBIrtn5Z98Z
         jxguV+De5Kqskhr3ukF6cCFZdBHFVXD4tQzDO9+JNDNXWgfMNRKMPR6aRYNG8C/Cx/
         iCgd27WfPAxjg==
Message-ID: <dd7044e2-2a2b-635e-a92f-f75a4c47bd19@kernel.org>
Date:   Tue, 15 Aug 2023 11:07:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-2-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-2-john.g.garry@oracle.com>
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
> driver"), sas_ha_struct.lldd_module has only ever been set, so remove it.
> 
> Struct scsi_host_template already has a reference to the LLD driver
> module as to stop the driver being removed unexpectedly.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

