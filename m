Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAE77CCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjHOMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbjHOMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5851989;
        Tue, 15 Aug 2023 05:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1DC62A34;
        Tue, 15 Aug 2023 12:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5BC433C8;
        Tue, 15 Aug 2023 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692103357;
        bh=QPB38JtI7jyIJtB48l2LRuhMb9sGebA2+TQ7NuZ/QpU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ewJAXJhEzRLJo6ZDpIXsWG4MPkMMA7Cpw0VTR9ih8AcODO3OMdMUfsgaz7vYtzR9S
         u9cvCqjEvQpu2TLse0owYMJA94q/xWDCSmsuFhBqujW8QTIhdgNuOUBdom84HH+PAp
         YwQK3U3w7PENynSxRZcUCJ/CiZWRLRpb/pX1OAKgcC/qbv2rhxT+eoIPXZyL3dK2Eu
         wIhVmTy5s+LE24wwA3GUupImvOfphtmJr3ls50hQfXM5wPvS/xYXF2cSF36w0m6Ltm
         ugcYCpLn0BbEYoaXp6CT4/PPzkfHmr35orzyr2RMudwTyOII2xv4u9FvPIR+P9hlpf
         H+kuRxB/Ae7xA==
Message-ID: <affa770a-e981-e75a-ee9a-3d2b47f1a392@kernel.org>
Date:   Tue, 15 Aug 2023 21:42:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230815115156.343535-1-john.g.garry@oracle.com>
 <20230815115156.343535-8-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230815115156.343535-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 20:51, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ssp_task.task_prio is never set, so delete it
> and any references which depend on it being set (all of them).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

