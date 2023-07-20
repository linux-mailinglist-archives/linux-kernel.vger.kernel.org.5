Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015E975AB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGTKBD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGTKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:00:59 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC110FC;
        Thu, 20 Jul 2023 03:00:43 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7445524E26B;
        Thu, 20 Jul 2023 18:00:30 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 18:00:30 +0800
Received: from [192.168.60.133] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 18:00:29 +0800
Message-ID: <5135e2cc-8a50-700c-25cf-6fd8a564a2b9@starfivetech.com>
Date:   Thu, 20 Jul 2023 18:00:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/9] drm/verisilicon: Add gem driver for JH7110 SoC
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602074043.33872-5-keith.zhao@starfivetech.com>
 <09c4c066-6467-57d1-364b-be8964f6b0bb@suse.de>
Content-Language: en-US
From:   Keith Zhao <keith.zhao@starfivetech.com>
In-Reply-To: <09c4c066-6467-57d1-364b-be8964f6b0bb@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 21:18, Thomas Zimmermann wrote:
> 
> 
> Am 02.06.23 um 09:40 schrieb Keith Zhao:
>> This patch implements gem related APIs for JH7100 SoC.
>>
>> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Makefile |   3 +-
>>   drivers/gpu/drm/verisilicon/vs_drv.c |   6 +
>>   drivers/gpu/drm/verisilicon/vs_gem.c | 372 +++++++++++++++++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_gem.h |  72 ++++++
>>   4 files changed, 452 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.h
>>
>> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
>> index 64ce1b26546c..30360e370e47 100644
>> --- a/drivers/gpu/drm/verisilicon/Makefile
>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   -vs_drm-objs := vs_drv.o
>> +vs_drm-objs := vs_drv.o \
>> +        vs_gem.o
>>     obj-$(CONFIG_DRM_VERISILICON) += vs_drm.o
>>   diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
>> index 24d333598477..e0a2fc43b55f 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_drv.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_drv.c
>> @@ -30,6 +30,7 @@
>>   #include <drm/drm_vblank.h>
>>     #include "vs_drv.h"
>> +#include "vs_gem.h"
>>     #define DRV_NAME    "starfive"
>>   #define DRV_DESC    "Starfive DRM driver"
>> @@ -47,6 +48,7 @@ static const struct file_operations fops = {
>>       .compat_ioctl    = drm_compat_ioctl,
>>       .poll            = drm_poll,
>>       .read            = drm_read,
>> +    .mmap            = vs_gem_mmap,
>>   };
>>     static struct drm_driver vs_drm_driver = {
>> @@ -54,6 +56,10 @@ static struct drm_driver vs_drm_driver = {
>>       .lastclose        = drm_fb_helper_lastclose,
>>       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>> +    .gem_prime_import    = vs_gem_prime_import,
>> +    .gem_prime_import_sg_table = vs_gem_prime_import_sg_table,
>> +    .gem_prime_mmap        = vs_gem_prime_mmap,
>> +    .dumb_create        = vs_gem_dumb_create,
>>       .fops            = &fops,
>>       .name            = DRV_NAME,
>>       .desc            = DRV_DESC,
>> diff --git a/drivers/gpu/drm/verisilicon/vs_gem.c b/drivers/gpu/drm/verisilicon/vs_gem.c
>> new file mode 100644
>> index 000000000000..3f963471c1ab
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_gem.c
>> @@ -0,0 +1,372 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>> + */
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <drm/drm_gem_dma_helper.h>
>> +
>> +#include "vs_drv.h"
>> +#include "vs_gem.h"
>> +
>> +static const struct drm_gem_object_funcs vs_gem_default_funcs;
>> +
>> +static int vs_gem_alloc_buf(struct vs_gem_object *vs_obj)
>> +{
>> +    struct drm_device *dev = vs_obj->base.dev;
>> +    unsigned int nr_pages;
>> +    struct sg_table sgt;
>> +    int ret = -ENOMEM;
>> +
>> +    if (vs_obj->dma_addr) {
>> +        DRM_DEV_DEBUG_KMS(dev->dev, "already allocated.\n");
>> +        return 0;
>> +    }
>> +
>> +    vs_obj->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_FORCE_CONTIGUOUS
>> +               | DMA_ATTR_NO_KERNEL_MAPPING;
>> +
>> +    nr_pages = vs_obj->size >> PAGE_SHIFT;
>> +
>> +    vs_obj->pages = kvmalloc_array(nr_pages, sizeof(struct page *),
>> +                       GFP_KERNEL | __GFP_ZERO);
>> +    if (!vs_obj->pages) {
>> +        DRM_DEV_ERROR(dev->dev, "failed to allocate pages.\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    vs_obj->cookie = dma_alloc_attrs(to_dma_dev(dev), vs_obj->size,
>> +                     &vs_obj->dma_addr, GFP_KERNEL,
>> +                     vs_obj->dma_attrs);
>> +
>> +    if (!vs_obj->cookie) {
>> +        DRM_DEV_ERROR(dev->dev, "failed to allocate buffer.\n");
>> +        goto err_free;
>> +    }
>> +
>> +    vs_obj->iova = vs_obj->dma_addr;
>> +
>> +    ret = dma_get_sgtable_attrs(to_dma_dev(dev), &sgt,
>> +                    vs_obj->cookie, vs_obj->dma_addr,
>> +                    vs_obj->size, vs_obj->dma_attrs);
>> +    if (ret < 0) {
>> +        DRM_DEV_ERROR(dev->dev, "failed to get sgtable.\n");
>> +        goto err_mem_free;
>> +    }
>> +
>> +    if (drm_prime_sg_to_page_array(&sgt, vs_obj->pages, nr_pages)) {
>> +        DRM_DEV_ERROR(dev->dev, "invalid sgtable.\n");
>> +        ret = -EINVAL;
>> +        goto err_sgt_free;
>> +    }
>> +
>> +    sg_free_table(&sgt);
>> +
>> +    return 0;
>> +
>> +err_sgt_free:
>> +    sg_free_table(&sgt);
>> +err_mem_free:
>> +        dma_free_attrs(to_dma_dev(dev), vs_obj->size, vs_obj->cookie,
>> +                   vs_obj->dma_addr, vs_obj->dma_attrs);
>> +err_free:
>> +    kvfree(vs_obj->pages);
>> +
>> +    return ret;
>> +}
>> +
>> +static void vs_gem_free_buf(struct vs_gem_object *vs_obj)
>> +{
>> +    struct drm_device *dev = vs_obj->base.dev;
>> +
>> +    if (!vs_obj->dma_addr) {
>> +        DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr is invalid.\n");
>> +        return;
>> +    }
>> +
>> +    dma_free_attrs(to_dma_dev(dev), vs_obj->size, vs_obj->cookie,
>> +               (dma_addr_t)vs_obj->dma_addr,
>> +               vs_obj->dma_attrs);
>> +
>> +    kvfree(vs_obj->pages);
>> +}
>> +
>> +static void vs_gem_free_object(struct drm_gem_object *obj)
>> +{
>> +    struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
>> +
>> +    if (obj->import_attach)
>> +        drm_prime_gem_destroy(obj, vs_obj->sgt);
>> +    else
>> +        vs_gem_free_buf(vs_obj);
>> +
>> +    drm_gem_object_release(obj);
>> +
>> +    kfree(vs_obj);
>> +}
>> +
>> +static struct vs_gem_object *vs_gem_alloc_object(struct drm_device *dev,
>> +                         size_t size)
>> +{
>> +    struct vs_gem_object *vs_obj;
>> +    struct drm_gem_object *obj;
>> +    int ret;
>> +
>> +    vs_obj = kzalloc(sizeof(*vs_obj), GFP_KERNEL);
>> +    if (!vs_obj)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    vs_obj->size = size;
>> +    obj = &vs_obj->base;
>> +
>> +    ret = drm_gem_object_init(dev, obj, size);
>> +    if (ret)
>> +        goto err_free;
>> +
>> +    vs_obj->base.funcs = &vs_gem_default_funcs;
>> +
>> +    ret = drm_gem_create_mmap_offset(obj);
>> +    if (ret) {
>> +        drm_gem_object_release(obj);
>> +        goto err_free;
>> +    }
>> +
>> +    return vs_obj;
>> +
>> +err_free:
>> +    kfree(vs_obj);
>> +    return ERR_PTR(ret);
>> +}
>> +
>> +struct vs_gem_object *vs_gem_create_object(struct drm_device *dev,
>> +                       size_t size)
>> +{
>> +    struct vs_gem_object *vs_obj;
>> +    int ret;
>> +
>> +    size = PAGE_ALIGN(size);
>> +
>> +    vs_obj = vs_gem_alloc_object(dev, size);
>> +    if (IS_ERR(vs_obj))
>> +        return vs_obj;
>> +
>> +    ret = vs_gem_alloc_buf(vs_obj);
>> +    if (ret) {
>> +        drm_gem_object_release(&vs_obj->base);
>> +        kfree(vs_obj);
>> +        return ERR_PTR(ret);
>> +    }
>> +
>> +    return vs_obj;
>> +}
>> +
>> +static struct vs_gem_object *vs_gem_create_with_handle(struct drm_device *dev,
>> +                               struct drm_file *file,
>> +                               size_t size,
>> +                               unsigned int *handle)
>> +{
>> +    struct vs_gem_object *vs_obj;
>> +    struct drm_gem_object *obj;
>> +    int ret;
>> +
>> +    vs_obj = vs_gem_create_object(dev, size);
>> +    if (IS_ERR(vs_obj))
>> +        return vs_obj;
>> +
>> +    obj = &vs_obj->base;
>> +
>> +    ret = drm_gem_handle_create(file, obj, handle);
>> +
>> +    drm_gem_object_put(obj);
>> +
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +
>> +    return vs_obj;
>> +}
>> +
>> +static int vs_gem_mmap_obj(struct drm_gem_object *obj,
>> +               struct vm_area_struct *vma)
>> +{
>> +    struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
>> +    struct drm_device *drm_dev = vs_obj->base.dev;
>> +    unsigned long vm_size;
>> +    int ret = 0;
>> +
>> +    vm_size = vma->vm_end - vma->vm_start;
>> +    if (vm_size > vs_obj->size)
>> +        return -EINVAL;
>> +
>> +    vma->vm_pgoff = 0;
>> +
>> +    /*
>> +     * We allocated a struct page table for starfive_obj, so clear
>> +     * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
>> +     */
>> +    vm_flags_mod(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP, VM_PFNMAP);
>> +
>> +    vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
>> +    vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>> +
>> +    ret = dma_mmap_attrs(to_dma_dev(drm_dev), vma, vs_obj->cookie,
>> +                 vs_obj->dma_addr, vs_obj->size,
>> +                 vs_obj->dma_attrs);
>> +
>> +    if (ret)
>> +        drm_gem_vm_close(vma);
>> +
>> +    return ret;
>> +}
>> +
>> +struct sg_table *vs_gem_prime_get_sg_table(struct drm_gem_object *obj)
>> +{
>> +    struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
>> +
>> +    return drm_prime_pages_to_sg(obj->dev, vs_obj->pages,
>> +                     vs_obj->size >> PAGE_SHIFT);
>> +}
>> +
>> +int vs_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>> +{
>> +    struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
>> +
>> +    void *vaddr = vs_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING ?
>> +               page_address(vs_obj->cookie) : vs_obj->cookie;
>> +
>> +    iosys_map_set_vaddr(map, vaddr);
>> +
>> +    return 0;
>> +}
>> +
>> +void vs_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
>> +{
>> +    /* Nothing to do */
>> +}
>> +
>> +static const struct vm_operations_struct vs_vm_ops = {
>> +    .open  = drm_gem_vm_open,
>> +    .close = drm_gem_vm_close,
>> +};
>> +
>> +static const struct drm_gem_object_funcs vs_gem_default_funcs = {
>> +    .free = vs_gem_free_object,
>> +    .get_sg_table = vs_gem_prime_get_sg_table,
>> +    .vmap = vs_gem_prime_vmap,
>> +    .vunmap = vs_gem_prime_vunmap,
>> +    .vm_ops = &vs_vm_ops,
>> +};
>> +
>> +int vs_gem_dumb_create(struct drm_file *file,
>> +               struct drm_device *dev,
>> +               struct drm_mode_create_dumb *args)
>> +{
>> +    struct vs_drm_private *priv = dev->dev_private;
>> +    struct vs_gem_object *vs_obj;
>> +    unsigned int pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>> +
>> +    if (args->bpp % 10)
>> +        args->pitch = ALIGN(pitch, priv->pitch_alignment);
>> +    else
>> +        /* for costum 10bit format with no bit gaps */
>> +        args->pitch = pitch;
>> +    args->size = PAGE_ALIGN(args->pitch * args->height);
>> +    vs_obj = vs_gem_create_with_handle(dev, file, args->size,
>> +                       &args->handle);
>> +    return PTR_ERR_OR_ZERO(vs_obj);
>> +}
>> +
>> +struct drm_gem_object *vs_gem_prime_import(struct drm_device *dev,
>> +                       struct dma_buf *dma_buf)
>> +{
>> +    return drm_gem_prime_import_dev(dev, dma_buf, to_dma_dev(dev));
>> +}
>> +
>> +struct drm_gem_object *
>> +vs_gem_prime_import_sg_table(struct drm_device *dev,
>> +                 struct dma_buf_attachment *attach,
>> +                 struct sg_table *sgt)
>> +{
>> +    struct vs_gem_object *vs_obj;
>> +    int npages;
>> +    int ret;
>> +    struct scatterlist *s;
>> +    u32 i;
>> +    dma_addr_t expected;
>> +    size_t size = attach->dmabuf->size;
>> +
>> +    size = PAGE_ALIGN(size);
>> +
>> +    vs_obj = vs_gem_alloc_object(dev, size);
>> +    if (IS_ERR(vs_obj))
>> +        return ERR_CAST(vs_obj);
>> +
>> +    expected = sg_dma_address(sgt->sgl);
>> +    for_each_sg(sgt->sgl, s, sgt->nents, i) {
>> +        if (sg_dma_address(s) != expected) {
>> +            DRM_ERROR("sg_table is not contiguous");
>> +            ret = -EINVAL;
>> +            goto err;
>> +        }
>> +        if (sg_dma_len(s) & (PAGE_SIZE - 1)) {
>> +            ret = -EINVAL;
>> +            goto err;
>> +        }
>> +        if (i == 0)
>> +            vs_obj->iova = sg_dma_address(s);
>> +        expected = sg_dma_address(s) + sg_dma_len(s);
>> +    }
>> +
>> +    vs_obj->dma_addr = sg_dma_address(sgt->sgl);
>> +
>> +    npages = vs_obj->size >> PAGE_SHIFT;
>> +    vs_obj->pages = kvmalloc_array(npages, sizeof(struct page *),
>> +                       GFP_KERNEL);
>> +    if (!vs_obj->pages) {
>> +        ret = -ENOMEM;
>> +        goto err;
>> +    }
>> +
>> +    ret = drm_prime_sg_to_page_array(sgt, vs_obj->pages, npages);
>> +    if (ret)
>> +        goto err_free_page;
>> +
>> +    vs_obj->sgt = sgt;
>> +
>> +    return &vs_obj->base;
>> +
>> +err_free_page:
>> +    kvfree(vs_obj->pages);
>> +err:
>> +    vs_gem_free_object(&vs_obj->base);
>> +
>> +    return ERR_PTR(ret);
>> +}
>> +
>> +int vs_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>> +{
>> +    int ret = 0;
>> +
>> +    ret = drm_gem_mmap_obj(obj, obj->size, vma);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    return vs_gem_mmap_obj(obj, vma);
>> +}
>> +
>> +int vs_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> 
> This function needs to go away.
> 
>> +{
>> +    struct drm_gem_object *obj;
>> +    int ret;
>> +
>> +    ret = drm_gem_mmap(filp, vma);
> 
> Set drm_gem_mmap() as your fops.mmap callback.
> 
>> +    if (ret)
>> +        return ret;
>> +
>> +    obj = vma->vm_private_data;
>> +
>> +    if (obj->import_attach)
>> +        return dma_buf_mmap(obj->dma_buf, vma, 0);
>> +
>> +    return vs_gem_mmap_obj(obj, vma);
> 
> Both, dma_buf and regular objects, should be handled in struct drm_gem_object_funcs.mmap. drm_gem_mmap() will call it for you. vs_gem_mmap_obj() can then be removed.
> 
> you can find example code in drm_gem_shmem_helper.c and drm_gem_dma_helper.c on how to write GEM object's mmap function.
> 

hi Thomas : 
yes , it is a good idea , 
It can largely reuse drm helper interfaces rather than defining its own set of interfaces.

I added 
.mmap = drm_gem_dma_object_mmap,
in my own defineed drm_gem_object_funcs

also use "struct drm_gem_dma_object base;" to replace  "struct drm_gem_object base;"
this makes my code more consice!
> 
>> +}
>> diff --git a/drivers/gpu/drm/verisilicon/vs_gem.h b/drivers/gpu/drm/verisilicon/vs_gem.h
>> new file mode 100644
>> index 000000000000..3a6d7452cb06
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_gem.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>> + */
>> +
>> +#ifndef __VS_GEM_H__
>> +#define __VS_GEM_H__
>> +
>> +#include <linux/dma-buf.h>
>> +
>> +#include <drm/drm_gem.h>
>> +#include <drm/drm_prime.h>
>> +
>> +#include "vs_drv.h"
>> +/*
>> + *
>> + * @base: drm gem object.
>> + * @size: size requested from user
>> + * @cookie: cookie returned by dma_alloc_attrs
>> + *    - not kernel virtual address with DMA_ATTR_NO_KERNEL_MAPPING
>> + * @dma_addr: bus address(accessed by dma) to allocated memory region.
>> + *    - this address could be physical address without IOMMU and
>> + *    device address with IOMMU.
>> + * @dma_attrs: attribute for DMA API
>> + * @get_pages: flag for manually applying for non-contiguous memory.
>> + * @pages: Array of backing pages.
>> + * @sgt: Imported sg_table.
>> + *
>> + */
>> +struct vs_gem_object {
>> +    struct drm_gem_object    base;
>> +    size_t            size;
>> +    void            *cookie;
>> +    dma_addr_t        dma_addr;
>> +    u32                iova;
>> +    unsigned long    dma_attrs;
>> +    bool            get_pages;
>> +    struct page        **pages;
>> +    struct sg_table *sgt;
>> +};
>> +
>> +static inline
>> +struct vs_gem_object *to_vs_gem_object(struct drm_gem_object *obj)
>> +{
>> +    return container_of(obj, struct vs_gem_object, base);
>> +}
>> +
>> +struct vs_gem_object *vs_gem_create_object(struct drm_device *dev,
>> +                       size_t size);
>> +
>> +int vs_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
>> +void vs_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
> 
> 
> 
>> +
>> +int vs_gem_prime_mmap(struct drm_gem_object *obj,
>> +              struct vm_area_struct *vma);
>> +
>> +int vs_gem_dumb_create(struct drm_file *file_priv,
>> +               struct drm_device *drm,
>> +               struct drm_mode_create_dumb *args);
>> +
>> +int vs_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>> +
>> +struct sg_table *vs_gem_prime_get_sg_table(struct drm_gem_object *obj);
>> +
>> +struct drm_gem_object *vs_gem_prime_import(struct drm_device *dev,
>> +                       struct dma_buf *dma_buf);
>> +struct drm_gem_object *
>> +vs_gem_prime_import_sg_table(struct drm_device *dev,
>> +                 struct dma_buf_attachment *attach,
>> +                 struct sg_table *sgt);
>> +
>> +#endif /* __VS_GEM_H__ */
> 
