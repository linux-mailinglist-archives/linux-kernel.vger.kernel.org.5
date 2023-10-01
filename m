Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E47B44DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 03:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjJABIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 21:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjJABIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 21:08:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B859D3;
        Sat, 30 Sep 2023 18:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=C60Ncv2vQB/DJw8skCHwr3eVbL772Jn31RAnGa36VLA=; b=GMfctbW1Rzk/Rs2dC0cOIpycOt
        xNUjrBSOyNCycybZ6jBXYPcTz7F7lLzLWwKx/qN+KfK734FjcsJMwH12JouUUQBOtLEgJbzyuXz1r
        QP4CqU3nJTvcqNQ59DOdNeDeBs/s5Dac25zNNaLSZf6lyPhDBWiz0yL6q+5cjNXoWv/aKp6++l4Rd
        Y6xrAQD/aJVWoBuGq0vhlGALsd7sb6Q/p3RekDPR6k42qEhp1/3JfPojk/ejvufd0FTVdA8aUAUdy
        L6nzBkG49ptbemg+wnlStwhKuRyjCKBRlxB0ykc1E9+4G0avYqDdK0BRBc3SV9Sfy+rc2wKvLseJC
        QqgdBsdQ==;
Received: from [2603:3004:644:9100::a64a]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qmkwE-000QhJ-3w; Sun, 01 Oct 2023 01:08:02 +0000
Message-ID: <7f62045b-aac1-498f-8f5a-6b94b4b5a096@infradead.org>
Date:   Sat, 30 Sep 2023 18:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/mellanox: tmfifo: fix kernel-doc warnings
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Liming Sun <lsun@mellanox.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230926054013.11450-1-rdunlap@infradead.org>
 <7b57bf9d-b024-b435-54ca-6ab5916197a1@linux.intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7b57bf9d-b024-b435-54ca-6ab5916197a1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/26/23 09:18, Ilpo Järvinen wrote:
> On Mon, 25 Sep 2023, Randy Dunlap wrote:
> 
>> Fix kernel-doc notation for structs and struct members to prevent
>> these warnings:
>>
>> mlxbf-tmfifo.c:73: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vring '
>> mlxbf-tmfifo.c:128: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vdev '
>> mlxbf-tmfifo.c:146: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_irq_info '
>> mlxbf-tmfifo.c:158: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_io '
>> mlxbf-tmfifo.c:182: warning: cannot understand function prototype: 'struct mlxbf_tmfifo '
>> mlxbf-tmfifo.c:208: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_msg_hdr '
>> mlxbf-tmfifo.c:138: warning: Function parameter or member 'config' not described in 'mlxbf_tmfifo_vdev'
>> mlxbf-tmfifo.c:212: warning: Function parameter or member 'unused' not described in 'mlxbf_tmfifo_msg_hdr'
>>
>> Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
>> Fixes: bc05ea63b394 ("platform/mellanox: Add BlueField-3 support in the tmfifo driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: lore.kernel.org/r/202309252330.saRU491h-lkp@intel.com
>> Cc: Liming Sun <lsun@mellanox.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Cc: Mark Gross <markgross@kernel.org>
>> Cc: Vadim Pasternak <vadimp@nvidia.com>
>> Cc: platform-driver-x86@vger.kernel.org
>> ---
>>  drivers/platform/mellanox/mlxbf-tmfifo.c |   14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff -- a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
>> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
>> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
>> @@ -53,7 +53,7 @@
>>  struct mlxbf_tmfifo;
>>  
>>  /**
>> - * mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
>> + * struct mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
>>   * @va: virtual address of the ring
>>   * @dma: dma address of the ring
>>   * @vq: pointer to the virtio virtqueue
>> @@ -113,12 +113,13 @@ enum {
>>  };
>>  
>>  /**
>> - * mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
>> + * struct mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
>>   * @vdev: virtio device, in which the vdev.id.device field has the
>>   *        VIRTIO_ID_xxx id to distinguish the virtual device.
>>   * @status: status of the device
>>   * @features: supported features of the device
>>   * @vrings: array of tmfifo vrings of this device
>> + * @config: non-anonymous union for cons and net
> 
> I wonder what information this adds? It's not documenting anything else 
> than C syntax, IMO.
> 
> Would it be possible to make kerneldoc not give warning from a named union 
> which is already fully documented?

I don't know. Maybe.
I have no idea if anyone has ever looked into doing that.

I'm adding Mauro since he did the nested struct/union kernel-doc code.

~Randy


