Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69AE810FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377366AbjLMLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjLMLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD31B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702466624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=7Y+yhg2kzKRracDkULVJwjSDml4IjcPt6n8GLCXMB3I=;
        b=RBgeEDhnPC06C1OvwEhHoDNBZmAw+IhwbemxyS1X2wS+krq7JGlSqkCN8fkuXwf1AE1Wq/
        SsaMRwLdjWiD35tAbo77Obk3qi5lCC4P4QhImHfWeAPnknURP5tDWkrSEpjSywHyDqATGV
        LoZI6COY7sypFTSRvVh71yrHw8QFpXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-k2g5QuaDMYKUw_v-lTjg7Q-1; Wed, 13 Dec 2023 06:23:41 -0500
X-MC-Unique: k2g5QuaDMYKUw_v-lTjg7Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 657DE837187;
        Wed, 13 Dec 2023 11:23:40 +0000 (UTC)
Received: from [10.39.208.4] (unknown [10.39.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D316492BC6;
        Wed, 13 Dec 2023 11:23:37 +0000 (UTC)
Message-ID: <8afc44f7-cef5-4b4a-afac-85a4eb967d3e@redhat.com>
Date:   Wed, 13 Dec 2023 12:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] vduse: Temporarily disable control queue features
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-3-maxime.coquelin@redhat.com>
 <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 xsFNBFOEQQIBEADjNLYZZqghYuWv1nlLisptPJp+TSxE/KuP7x47e1Gr5/oMDJ1OKNG8rlNg
 kLgBQUki3voWhUbMb69ybqdMUHOl21DGCj0BTU3lXwapYXOAnsh8q6RRM+deUpasyT+Jvf3a
 gU35dgZcomRh5HPmKMU4KfeA38cVUebsFec1HuJAWzOb/UdtQkYyZR4rbzw8SbsOemtMtwOx
 YdXodneQD7KuRU9IhJKiEfipwqk2pufm2VSGl570l5ANyWMA/XADNhcEXhpkZ1Iwj3TWO7XR
 uH4xfvPl8nBsLo/EbEI7fbuUULcAnHfowQslPUm6/yaGv6cT5160SPXT1t8U9QDO6aTSo59N
 jH519JS8oeKZB1n1eLDslCfBpIpWkW8ZElGkOGWAN0vmpLfdyiqBNNyS3eGAfMkJ6b1A24un
 /TKc6j2QxM0QK4yZGfAxDxtvDv9LFXec8ENJYsbiR6WHRHq7wXl/n8guyh5AuBNQ3LIK44x0
 KjGXP1FJkUhUuruGyZsMrDLBRHYi+hhDAgRjqHgoXi5XGETA1PAiNBNnQwMf5aubt+mE2Q5r
 qLNTgwSo2dpTU3+mJ3y3KlsIfoaxYI7XNsPRXGnZi4hbxmeb2NSXgdCXhX3nELUNYm4ArKBP
 LugOIT/zRwk0H0+RVwL2zHdMO1Tht1UOFGfOZpvuBF60jhMzbQARAQABzSxNYXhpbWUgQ29x
 dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPsLBeAQTAQIAIgUCV3u/5QIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQyjiNKEaHD4ma2g/+P+Hg9WkONPaY1J4AR7Uf
 kBneosS4NO3CRy0x4WYmUSLYMLx1I3VH6SVjqZ6uBoYy6Fs6TbF6SHNc7QbB6Qjo3neqnQR1
 71Ua1MFvIob8vUEl3jAR/+oaE1UJKrxjWztpppQTukIk4oJOmXbL0nj3d8dA2QgHdTyttZ1H
 xzZJWWz6vqxCrUqHU7RSH9iWg9R2iuTzii4/vk1oi4Qz7y/q8ONOq6ffOy/t5xSZOMtZCspu
 Mll2Szzpc/trFO0pLH4LZZfz/nXh2uuUbk8qRIJBIjZH3ZQfACffgfNefLe2PxMqJZ8mFJXc
 RQO0ONZvwoOoHL6CcnFZp2i0P5ddduzwPdGsPq1bnIXnZqJSl3dUfh3xG5ArkliZ/++zGF1O
 wvpGvpIuOgLqjyCNNRoR7cP7y8F24gWE/HqJBXs1qzdj/5Hr68NVPV1Tu/l2D1KMOcL5sOrz
 2jLXauqDWn1Okk9hkXAP7+0Cmi6QwAPuBT3i6t2e8UdtMtCE4sLesWS/XohnSFFscZR6Vaf3
 gKdWiJ/fW64L6b9gjkWtHd4jAJBAIAx1JM6xcA1xMbAFsD8gA2oDBWogHGYcScY/4riDNKXi
 lw92d6IEHnSf6y7KJCKq8F+Jrj2BwRJiFKTJ6ChbOpyyR6nGTckzsLgday2KxBIyuh4w+hMq
 TGDSp2rmWGJjASrOwU0EVPSbkwEQAMkaNc084Qvql+XW+wcUIY+Dn9A2D1gMr2BVwdSfVDN7
 0ZYxo9PvSkzh6eQmnZNQtl8WSHl3VG3IEDQzsMQ2ftZn2sxjcCadexrQQv3Lu60Tgj7YVYRM
 H+fLYt9W5YuWduJ+FPLbjIKynBf6JCRMWr75QAOhhhaI0tsie3eDsKQBA0w7WCuPiZiheJaL
 4MDe9hcH4rM3ybnRW7K2dLszWNhHVoYSFlZGYh+MGpuODeQKDS035+4H2rEWgg+iaOwqD7bg
 CQXwTZ1kSrm8NxIRVD3MBtzp9SZdUHLfmBl/tLVwDSZvHZhhvJHC6Lj6VL4jPXF5K2+Nn/Su
 CQmEBisOmwnXZhhu8ulAZ7S2tcl94DCo60ReheDoPBU8PR2TLg8rS5f9w6mLYarvQWL7cDtT
 d2eX3Z6TggfNINr/RTFrrAd7NHl5h3OnlXj7PQ1f0kfufduOeCQddJN4gsQfxo/qvWVB7PaE
 1WTIggPmWS+Xxijk7xG6x9McTdmGhYaPZBpAxewK8ypl5+yubVsE9yOOhKMVo9DoVCjh5To5
 aph7CQWfQsV7cd9PfSJjI2lXI0dhEXhQ7lRCFpf3V3mD6CyrhpcJpV6XVGjxJvGUale7+IOp
 sQIbPKUHpB2F+ZUPWds9yyVxGwDxD8WLqKKy0WLIjkkSsOb9UBNzgRyzrEC9lgQ/ABEBAAHC
 wV8EGAECAAkFAlT0m5MCGwwACgkQyjiNKEaHD4nU8hAAtt0xFJAy0sOWqSmyxTc7FUcX+pbD
 KVyPlpl6urKKMk1XtVMUPuae/+UwvIt0urk1mXi6DnrAN50TmQqvdjcPTQ6uoZ8zjgGeASZg
 jj0/bJGhgUr9U7oG7Hh2F8vzpOqZrdd65MRkxmc7bWj1k81tOU2woR/Gy8xLzi0k0KUa8ueB
 iYOcZcIGTcs9CssVwQjYaXRoeT65LJnTxYZif2pfNxfINFzCGw42s3EtZFteczClKcVSJ1+L
 +QUY/J24x0/ocQX/M1PwtZbB4c/2Pg/t5FS+s6UB1Ce08xsJDcwyOPIH6O3tccZuriHgvqKP
 yKz/Ble76+NFlTK1mpUlfM7PVhD5XzrDUEHWRTeTJSvJ8TIPL4uyfzhjHhlkCU0mw7Pscyxn
 DE8G0UYMEaNgaZap8dcGMYH/96EfE5s/nTX0M6MXV0yots7U2BDb4soLCxLOJz4tAFDtNFtA
 wLBhXRSvWhdBJZiig/9CG3dXmKfi2H+wdUCSvEFHRpgo7GK8/Kh3vGhgKmnnxhl8ACBaGy9n
 fxjSxjSO6rj4/MeenmlJw1yebzkX8ZmaSi8BHe+n6jTGEFNrbiOdWpJgc5yHIZZnwXaW54QT
 UhhSjDL1rV2B4F28w30jYmlRmm2RdN7iCZfbyP3dvFQTzQ4ySquuPkIGcOOHrvZzxbRjzMx1
 Mwqu3GQ=
In-Reply-To: <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 12/13/23 05:52, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 9:17 PM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
>>
>> Virtio-net driver control queue implementation is not safe
>> when used with VDUSE. If the VDUSE application does not
>> reply to control queue messages, it currently ends up
>> hanging the kernel thread sending this command.
>>
>> Some work is on-going to make the control queue
>> implementation robust with VDUSE. Until it is completed,
>> let's disable control virtqueue and features that depend on
>> it.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> I wonder if it's better to fail instead of a mask as a start.

I think it is better to use a mask and not fail, so that we can in the
future use a recent VDUSE application with an older kernel.

Why would it be better to fail than negotiating?

Thanks,
Maxime

> Thanks
> 
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 0486ff672408..fe4b5c8203fd 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -28,6 +28,7 @@
>>   #include <uapi/linux/virtio_config.h>
>>   #include <uapi/linux/virtio_ids.h>
>>   #include <uapi/linux/virtio_blk.h>
>> +#include <uapi/linux/virtio_ring.h>
>>   #include <linux/mod_devicetable.h>
>>
>>   #include "iova_domain.h"
>> @@ -46,6 +47,30 @@
>>
>>   #define IRQ_UNBOUND -1
>>
>> +#define VDUSE_NET_VALID_FEATURES_MASK           \
>> +       (BIT_ULL(VIRTIO_NET_F_CSUM) |           \
>> +        BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
>> +        BIT_ULL(VIRTIO_NET_F_MTU) |            \
>> +        BIT_ULL(VIRTIO_NET_F_MAC) |            \
>> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
>> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
>> +        BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
>> +        BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
>> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
>> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
>> +        BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
>> +        BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
>> +        BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
>> +        BIT_ULL(VIRTIO_NET_F_STATUS) |         \
>> +        BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
>> +        BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
>> +        BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
>> +        BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
>> +        BIT_ULL(VIRTIO_F_VERSION_1) |          \
>> +        BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
>> +        BIT_ULL(VIRTIO_F_RING_PACKED) |        \
>> +        BIT_ULL(VIRTIO_F_IN_ORDER))
>> +
>>   struct vduse_virtqueue {
>>          u16 index;
>>          u16 num_max;
>> @@ -1782,6 +1807,16 @@ static struct attribute *vduse_dev_attrs[] = {
>>
>>   ATTRIBUTE_GROUPS(vduse_dev);
>>
>> +static void vduse_dev_features_filter(struct vduse_dev_config *config)
>> +{
>> +       /*
>> +        * Temporarily filter out virtio-net's control virtqueue and features
>> +        * that depend on it while CVQ is being made more robust for VDUSE.
>> +        */
>> +       if (config->device_id == VIRTIO_ID_NET)
>> +               config->features &= VDUSE_NET_VALID_FEATURES_MASK;
>> +}
>> +
>>   static int vduse_create_dev(struct vduse_dev_config *config,
>>                              void *config_buf, u64 api_version)
>>   {
>> @@ -1797,6 +1832,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>          if (!dev)
>>                  goto err;
>>
>> +       vduse_dev_features_filter(config);
>> +
>>          dev->api_version = api_version;
>>          dev->device_features = config->features;
>>          dev->device_id = config->device_id;
>> --
>> 2.43.0
>>
> 

