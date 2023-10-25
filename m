Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC087D6FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbjJYOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJYOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D21BE5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698245357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQg2aiugEAr81dlu2QQgtvQkHg29djoP9+oseI0sItA=;
        b=b2Rn/Wbc8D8Ucs1PKcKd79sFFIdvz/mypoaYVVXTgln4yFiq0eLzW1teFpXZvkgTgEz0oH
        KN/CaBCNezt723u6+FCRoOTdzywAKDPsAMookvfC+oB38gbCHNyvrvU9hY95n3sB4FBwmX
        lYQch0ldK2C8L1sO9mp17+N1fK2/gVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-D9xpdfXVNhCgtpipLzBmYw-1; Wed, 25 Oct 2023 10:49:14 -0400
X-MC-Unique: D9xpdfXVNhCgtpipLzBmYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 637C9811E91;
        Wed, 25 Oct 2023 14:49:13 +0000 (UTC)
Received: from [10.45.225.62] (unknown [10.45.225.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F175525C0;
        Wed, 25 Oct 2023 14:49:11 +0000 (UTC)
Message-ID: <fa91d099-74d7-48f8-9316-dba9a4e0b826@redhat.com>
Date:   Wed, 25 Oct 2023 16:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused
 i40e_mac_info fields
Content-Language: en-US
To:     Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231025105911.1204326-1-ivecera@redhat.com>
 <389ecfc4-dfd7-4c56-b18f-82565e059914@intel.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <389ecfc4-dfd7-4c56-b18f-82565e059914@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25. 10. 23 13:03, Wojciech Drewek wrote:
> On 25.10.2023 12:59, Ivan Vecera wrote:
>>  From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
>> the field i40e_mac_info.san_addr is unused (never filled).
>> The field i40e_mac_info.max_fcoeq is unused from the beginning.
>> Remove both.
>>
>> Co-developed-by: Michal Schmidt<mschmidt@redhat.com>
> Signed-off-by from Michal is needed, other than that:
> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
Will fix by v2

Ivan

