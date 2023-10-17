Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104B7CC000
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjJQJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjJQJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5571CED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697536594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YskDJvOwtltUEF1vV1LUQRzaj8p5jAo4b5a3cEViogM=;
        b=P2rR2M7CgVFFLEjkCCDWhmJwjocZB/wKtpNhWENHgmk39wlZg0kwMKsnjCTSsgwwv1MsYT
        fofRYh2xZfK70dwZpoOsBIflqgDbzD6rpAnI18u+2WkhAmj3hiszlvWdH8ODFzBIeVyh2s
        BR/wLYyiMGwzoUW+R3Ajf4Idq6ICgv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-B0Jm9qSrO7CpqPjDEewBfw-1; Tue, 17 Oct 2023 05:56:23 -0400
X-MC-Unique: B0Jm9qSrO7CpqPjDEewBfw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DDA88F15C5;
        Tue, 17 Oct 2023 09:56:22 +0000 (UTC)
Received: from [10.43.2.183] (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F85492BEE;
        Tue, 17 Oct 2023 09:56:21 +0000 (UTC)
Message-ID: <b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
Date:   Tue, 17 Oct 2023 11:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
References: <20231013170755.2367410-1-ivecera@redhat.com>
 <20231013170755.2367410-4-ivecera@redhat.com>
 <20231016075619.02d1dd27@kernel.org>
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20231016075619.02d1dd27@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16. 10. 23 16:56, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 19:07:53 +0200 Ivan Vecera wrote:
>>   "serial_number" -> The PCI DSN of the adapter
>>   "fw.mgmt" -> The version of the firmware
>>   "fw.mgmt.api" -> The API version of interface exposed over the AdminQ
>>   "fw.psid" -> The version of the NVM image
> 
> Your board reports "fw.psid 9.30", this may not be right,
> PSID is more of a board+customer ID, IIUC. 9.30 looks like
> a version, not an ID.

Maybe plain 'fw' should be used for this '9.30' as this is a version
of the whole software package provided by Intel for these adapters
(e.g. 
https://www.intel.com/content/www/us/en/download/18190/non-volatile-memory-nvm-update-utility-for-intel-ethernet-network-adapter-700-series.html).

Thoughts?

>>   "fw.bundle_id" -> Unique identifier for the combined flash image
>>   "fw.undi" -> The combo image version
> 
> UNDI means PXE. Is that whave "combo image" means for Intel?

Combo image version (aka CIVD) is reported by nvmupdate tool and this
should be version of OROM that contains PXE, EFI images that each of
them can have specific version but this CIVD should be overall OROM 
version for this combination of PXE and EFI. I hope I'm right.

Thanks,
Ivan

