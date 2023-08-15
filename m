Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC377C5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjHOCKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjHOCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF07E5F;
        Mon, 14 Aug 2023 19:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C818646FE;
        Tue, 15 Aug 2023 02:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC024C433C7;
        Tue, 15 Aug 2023 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065406;
        bh=NcUdYJw9J/Et8H7NUY2lS+O95aVKgMNpDQrE3Ksi+iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C4G9UWDJxekxQjf+gIHVuydJu1C/HzNqPrxT0gCN+oXqxcz0DONUU4UAPJMiaqjLl
         3wVu60Nf0gvG7/Iye0nwacsaARRXwbK0/q/XIuACe6AV2wjQw99AcHCpVUFdbKjOUh
         sKgzyCdHilp0Zyjfvmpa2RvECD0KCd4nuafIsXmH0qCFaUJISyINK81Vm2idkIXLFG
         AwMcAdgx3bVFKzsVQ57+L5AVR7lSxaygoa7+VdtL8lel19q0+pOunEXoJzS2J5yM8P
         1Sy5E2RmPSCVCTkZYT5e3DTjQtVHT97l4LJAYbKFLpVZj/WMnI6leN2NTUTtQ2LLPb
         A25cNq6ZaWp5w==
Message-ID: <3469722a-b905-4de5-5eba-57dae0ea3d3d@kernel.org>
Date:   Tue, 15 Aug 2023 11:10:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] scsi: libsas: Delete struct scsi_core
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-5-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-5-john.g.garry@oracle.com>
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
> Since commit 79855d178557 ("libsas: remove task_collector mode"), struct
> scsi_core only contains a reference to the shost. struct scsi_core is only
> used in sas_ha_struct.core, so delete scsi_core and replace with a
> reference to the shost there.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

