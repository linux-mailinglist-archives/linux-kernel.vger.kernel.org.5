Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1F77C5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjHOCIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjHOCIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D181703;
        Mon, 14 Aug 2023 19:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF3964219;
        Tue, 15 Aug 2023 02:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1A4C433C8;
        Tue, 15 Aug 2023 02:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065297;
        bh=ivwIAO+D+4LGxSdwMDxyc/gUBiaomFwprOa9XLUkYpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WAJdUqaNxqxMcEsGqC/qYDmOMXM8oshBgoRr5Pen0cK1KJiyF8fNlLd0Ho1iTSc02
         WICKvLsluLVRKnfABXmLGnxau25uTP1YOYJaXnWj2ZkT5oKtpDEHLulLHWLz5uvCI6
         rrIXNuhrwGjWQcafXYAKIZ+CvogzoZjr0foudytDibIHhQQwZotY+68xt77ELwwTqe
         WBNFehYUffoNgqn0/uP/iYm039i0zj86qaI4eQNqxzBaA4i9iF6VKXGjzGWmD32DDU
         TGKR8IsmKF3Jz3+7WzZPW7hHKujGBcAnJ1Jxv29TjoXRSyj6U4BpWboz95BoMA7U/z
         Bqb/GxaR4JVmQ==
Message-ID: <49f271fd-f49d-f587-9c58-1f5255d0945f@kernel.org>
Date:   Tue, 15 Aug 2023 11:08:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/10] scsi: libsas: Delete enum sas_phy_type
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-4-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 23:10, John Garry wrote:
> enum sas_phy_type is used for asd_sas_phy.type, which is only ever set,
> so delete this member and the enum.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

