Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7577C59E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjHOCIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjHOCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92673172C;
        Mon, 14 Aug 2023 19:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27113644FF;
        Tue, 15 Aug 2023 02:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8410BC433C7;
        Tue, 15 Aug 2023 02:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065263;
        bh=Sf1f6HcmcCqT/xTbQgDjPUCBG8YZBaGPXD/uAr2kD/s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uBaCkgjhSyPsburjeK5c7wIYGPuij3HRcF+k5XA66AD5bj8I9BmtWv7LE8g/Dlti8
         No3EA0M7KutVgr6A3xCgTciLyEaft4qzy1mwd4AtxoAzVZzi6LVDvTWEbgaPSquf8a
         akbcT1Qz0kg7A7R4+f2AwEiYOAzS/X6ZRxEMTwLq2yLaEsWTD4YlcBCy6UEpQ13rSA
         dOYJkh0RICVYHHbYbqXzK5gaBTU5UJtGD6QsqUy0fDrSzjjvk8FU1k8Da/bLfw45tc
         0jryd1gFzVXR0dgYiiE9R8PTF2T/tkZ43eMGYFe3azy9FK3Pqdc2i5ldfQhwBZ3U41
         XJlfqc1M5pomQ==
Message-ID: <c42b475c-8fdc-e1cc-45d1-a693faffd4ca@kernel.org>
Date:   Tue, 15 Aug 2023 11:07:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/10] scsi: libsas: Delete enum sas_class
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-3-john.g.garry@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230814141022.36875-3-john.g.garry@oracle.com>
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
> enum sas_class prob would have been useful if function sas_show_class() was
> ever implemented, which it wasn't.
> 
> enum sas_class is used as asd_sas_port.class and asd_sas_phy.class, which
> are only ever set, so delete these members and the enum.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

