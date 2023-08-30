Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54FE78DF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjH3TYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243681AbjH3L2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E55132
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693394845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gCpyYaDoykWvvFtRkJq4n5NwTWes+cVEb3SWcI7ddY=;
        b=D2d/AB47KWIhF3+nviN3LTBKODoNHgzU6OxksD8SrCXR+Sj0RF0ZAVLJ05BI0+dbnx4Pap
        RiFO7gMwBQ98CbzEkUe3aJgbuigEkVxAgd/RpLUVqB8EjPZpxffcvueWu1smuVEvSJK+7F
        Tc3PuUojqwsQLZBs/d/+MxX/4l4r+50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-wNNx9Tt2PreOTKdwNUnwrw-1; Wed, 30 Aug 2023 07:27:22 -0400
X-MC-Unique: wNNx9Tt2PreOTKdwNUnwrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A065802C1E;
        Wed, 30 Aug 2023 11:27:22 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F6A1121315;
        Wed, 30 Aug 2023 11:27:19 +0000 (UTC)
Message-ID: <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
Date:   Wed, 30 Aug 2023 13:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, xieyongji@bytedance.com,
        jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
 <20230829130430-mutt-send-email-mst@kernel.org>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
In-Reply-To: <20230829130430-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 19:05, Michael S. Tsirkin wrote:
> On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
>>
>>
>> On 8/11/23 00:00, Jakub Kicinski wrote:
>>> On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
>>>>> Directly into the stack? I thought VDUSE is vDPA in user space,
>>>>> meaning to get to the kernel the packet has to first go thru
>>>>> a virtio-net instance.
>>>>
>>>> yes. is that a sufficient filter in your opinion?
>>>
>>> Yes, the ability to create the device feels stronger than CAP_NET_RAW,
>>> and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
>>> experience with virt so no strong opinion, perhaps it does make sense
>>> for someone's deployment? Dunno..
>>>
>>
>> I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
>> devices, as the device could be attached to vhost-vDPA and so not
>> visible to the Kernel networking stack.
>>
>> However, CAP_NET_ADMIN should be required to attach the VDUSE device to
>> virtio-vdpa/virtio-net.
>>
>> Does that make sense?
>>
>> Maxime
> 
> OK. How are we going to enforce it?

Actually, it seems already enforced for all VDPA devices types.
Indeed, the VDPA_CMD_DEV_NEW Netlink command used to add the device to
the VDPA bus has the GENL_ADMIN_PERM flag set, and so require
CAT_NET_ADMIN.

> Also, we need a way for selinux to enable/disable some of these things
> but not others.

Ok, I can do it in a patch on top.
Do you have a pointer where it is done for Virtio Block devices?

Maxime

