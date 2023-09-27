Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F77B05B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjI0NqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjI0NqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:46:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A89126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:46:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50325ce89e9so18543628e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695822378; x=1696427178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjMt+usahKyEXhyMN9rIKh7XECu5zDX2FLeHZvS3f6M=;
        b=oeM46MhCnw2BXtdx77cSFQE5ZisF0H7LLh5VDsP0l0BfTAQx7M1DE+GG5r2VK2P1Pa
         4NbI3TfaTC+TMJbX9DcrrMhCjnSmsxET7LyhbyhpvnpHORow0QYAcJ4BnIXzVbxKdt6/
         of2+ewnbHC22U+xkr9oeytf9WupUCtHS9KvBaZbsKqMByo5VZbCiWouR30lcFSFSxuhR
         iHwFxFdD7/VFPXwDsIAAkwq/m3BQNs5nqxPKnBT+/aX3N1EVEm1fGEbyjrI6ey/fLPe3
         zYNVNjQnIVIC2QgzOjVFTkWSEZhYeTvrtFxoAlFtD89XRE4/Yg842AztHn8Ii9gcYxnN
         HN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822378; x=1696427178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjMt+usahKyEXhyMN9rIKh7XECu5zDX2FLeHZvS3f6M=;
        b=iyEgfmbs8C5p0QV5T39ZXtweaglFNn64nT6h1LcTJM4yZZH21xvRcNn1pVkjqPgxlZ
         X0dPu1KHmlJfbC3XI4rijCJMYAVzdcGYQ4YrnhqMdPrggE92q91wDaMgu4MLDmeUNM/T
         WcKJIrY871PN+PhL59e8uvVq/VYuJ2D41i24PGOPENz28Z5PeHPlIbuLWLMAS98Jr0Wp
         TsCg5DULBZspLnsXuRjTu4RrFis0wMvyyUDGOUtaJA+HUwrh6yr8zAR3b0W/Wc0bEbSI
         BpGLpKEnJHgmogkkbFNGdubM8vZW3u46PnuiE+93gSRgEQV6PgOHyom2M6KdjDAysEb/
         AF3g==
X-Gm-Message-State: AOJu0Yy2mpSiPuUkKoU2J6z1k+kzS9kyO9NVUm4m5DuFgZllfmmNUidi
        kO030HuFntPLeTfbCLTMs8VqDA==
X-Google-Smtp-Source: AGHT+IGpPGTE4fiqS7H6X5cE5gxZAu7fbfw/lkC2Rf9hkEdABrFyFW6E9N1aUp/8UrNrtYA3KSkgEg==
X-Received: by 2002:ac2:58e4:0:b0:504:3424:215c with SMTP id v4-20020ac258e4000000b005043424215cmr1658146lfo.51.1695822377525;
        Wed, 27 Sep 2023 06:46:17 -0700 (PDT)
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id f21-20020a19ae15000000b00500d1f67be9sm2664810lfc.43.2023.09.27.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:46:16 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:46:14 +0200
From:   Joakim Bech <joakim.bech@linaro.org>
To:     Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jianjiao Zeng =?utf-8?B?KOabvuWBpeWnoyk=?= 
        <Jianjiao.Zeng@mediatek.com>,
        Kuohong Wang =?utf-8?B?KOeOi+Wci+m0uyk=?= 
        <kuohong.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/9] dma-buf: heaps: mtk_sec_heap: Initialise tee session
Message-ID: <20230927134614.kp27moxdw72jiu4y@pop-os.localdomain>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-6-yong.wu@mediatek.com>
 <d0373c02-9b22-661f-9930-ca720053c2a0@collabora.com>
 <a115a2a5d3ac218e6db65ccdb0a1876f9cfca02b.camel@mediatek.com>
 <d798b15b-6f35-96db-e3f7-5c0bcc5d46a2@collabora.com>
 <a4ecc2792f3a4d3159e34415be984ff7d5f5e263.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ecc2792f3a4d3159e34415be984ff7d5f5e263.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:49:50PM +0000, Yong Wu (吴勇) wrote:
> On Tue, 2023-09-12 at 11:32 +0200, AngeloGioacchino Del Regno wrote:
> > Il 12/09/23 08:17, Yong Wu (吴勇) ha scritto:
> > > On Mon, 2023-09-11 at 11:29 +0200, AngeloGioacchino Del Regno
> > > wrote:
> > > > Il 11/09/23 04:30, Yong Wu ha scritto:
> > > > > The TEE probe later than dma-buf heap, and PROBE_DEDER doesn't
> > > > > work
> > > > > here since this is not a platform driver, therefore initialise
> > > > > the
> > > > > TEE
> > > > > context/session while we allocate the first secure buffer.
> > > > > 
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >    drivers/dma-buf/heaps/mtk_secure_heap.c | 61
> > > > > +++++++++++++++++++++++++
> > > > >    1 file changed, 61 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > b/drivers/dma-
> > > > > buf/heaps/mtk_secure_heap.c
> > > > > index bbf1c8dce23e..e3da33a3d083 100644
> > > > > --- a/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > +++ b/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > @@ -10,6 +10,12 @@
> > > > >    #include <linux/err.h>
> > > > >    #include <linux/module.h>
> > > > >    #include <linux/slab.h>
> > > > > +#include <linux/tee_drv.h>
> > > > > +#include <linux/uuid.h>
> > > > > +
> > > > > +#define TZ_TA_MEM_UUID		"4477588a-8476-11e2-ad15-
> > > > > e41f1390d676"
> > > > > +
> > > > 
> > > > Is this UUID the same for all SoCs and all TZ versions?
> > > 
> > > Yes. It is the same for all SoCs and all TZ versions currently.
> > > 
> > 
> > That's good news!
> > 
> > Is this UUID used in any userspace component? (example: Android
> > HALs?)
> 
> No. Userspace never use it. If userspace would like to allocate this
> secure buffer, it can achieve through the existing dmabuf IOCTL via
> /dev/dma_heap/mtk_svp node.
> 
In general I think as mentioned elsewhere in comments, that there isn't
that much here that seems to be unique for MediaTek in this patch
series, so I think it worth to see whether this whole patch set can be
made more generic. Having said that, the UUID is always unique for a
certain Trusted Application. So, it's not entirely true saying that the
UUID is the same for all SoCs and all TrustZone versions. It might be
true for a family of MediaTek devices and the TEE in use, but not
generically.

So, if we need to differentiate between different TA implementations,
then we need different UUIDs. If it would be possible to make this patch
set generic, then it sounds like a single UUID would be sufficient, but
that would imply that all TA's supporting such a generic UUID would be
implemented the same from an API point of view. Which also means that
for example Trusted Application function ID's needs to be the same etc.
Not impossible to achieve, but still not easy (different TEE follows
different specifications) and it's not typically something we've done in
the past.

Unfortunately there is no standardized database of TA's describing what
they implement and support.

As an alternative, we could implement a query call in the TEE answering,
"What UUID does your TA have that implements secure unmapped heap?".
I.e., something that reminds of a lookup table. Then we wouldn't have to
carry this in UAPI, DT or anywhere else.

-- 
// Regards
Joakim

> 
> > If it is (and I somehow expect that it is), then this definition
> > should go
> > to a UAPI header, as suggested by Christian.
> > 
> > Cheers!
> > 
> > > > 
> > > > Thanks,
> > > > Angelo
> > > > 
> > > > 
> > > > > +#define MTK_TEE_PARAM_NUM		4
> > > > >    
> > > > >    /*
> > > > >     * MediaTek secure (chunk) memory type
> > > > > @@ -28,17 +34,72 @@ struct mtk_secure_heap_buffer {
> > > > >    struct mtk_secure_heap {
> > > > >    	const char		*name;
> > > > >    	const enum kree_mem_type mem_type;
> > > > > +	u32			 mem_session;
> > > > > +	struct tee_context	*tee_ctx;
> > > > >    };
> > > > >    
> > > > > +static int mtk_optee_ctx_match(struct tee_ioctl_version_data
> > > > > *ver,
> > > > > const void *data)
> > > > > +{
> > > > > +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> > > > > +}
> > > > > +
> > > > > +static int mtk_kree_secure_session_init(struct mtk_secure_heap
> > > > > *sec_heap)
> > > > > +{
> > > > > +	struct tee_param t_param[MTK_TEE_PARAM_NUM] = {0};
> > > > > +	struct tee_ioctl_open_session_arg arg = {0};
> > > > > +	uuid_t ta_mem_uuid;
> > > > > +	int ret;
> > > > > +
> > > > > +	sec_heap->tee_ctx = tee_client_open_context(NULL,
> > > > > mtk_optee_ctx_match,
> > > > > +						    NULL,
> > > > > NULL);
> > > > > +	if (IS_ERR(sec_heap->tee_ctx)) {
> > > > > +		pr_err("%s: open context failed, ret=%ld\n",
> > > > > sec_heap-
> > > > > > name,
> > > > > 
> > > > > +		       PTR_ERR(sec_heap->tee_ctx));
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	arg.num_params = MTK_TEE_PARAM_NUM;
> > > > > +	arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > > > > +	ret = uuid_parse(TZ_TA_MEM_UUID, &ta_mem_uuid);
> > > > > +	if (ret)
> > > > > +		goto close_context;
> > > > > +	memcpy(&arg.uuid, &ta_mem_uuid.b, sizeof(ta_mem_uuid));
> > > > > +
> > > > > +	ret = tee_client_open_session(sec_heap->tee_ctx, &arg,
> > > > > t_param);
> > > > > +	if (ret < 0 || arg.ret) {
> > > > > +		pr_err("%s: open session failed, ret=%d:%d\n",
> > > > > +		       sec_heap->name, ret, arg.ret);
> > > > > +		ret = -EINVAL;
> > > > > +		goto close_context;
> > > > > +	}
> > > > > +	sec_heap->mem_session = arg.session;
> > > > > +	return 0;
> > > > > +
> > > > > +close_context:
> > > > > +	tee_client_close_context(sec_heap->tee_ctx);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > >    static struct dma_buf *
> > > > >    mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
> > > > >    		      unsigned long fd_flags, unsigned long
> > > > > heap_flags)
> > > > >    {
> > > > > +	struct mtk_secure_heap *sec_heap =
> > > > > dma_heap_get_drvdata(heap);
> > > > >    	struct mtk_secure_heap_buffer *sec_buf;
> > > > >    	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > > > >    	struct dma_buf *dmabuf;
> > > > >    	int ret;
> > > > >    
> > > > > +	/*
> > > > > +	 * TEE probe may be late. Initialise the secure session
> > > > > in the
> > > > > first
> > > > > +	 * allocating secure buffer.
> > > > > +	 */
> > > > > +	if (!sec_heap->mem_session) {
> > > > > +		ret = mtk_kree_secure_session_init(sec_heap);
> > > > > +		if (ret)
> > > > > +			return ERR_PTR(ret);
> > > > > +	}
> > > > > +
> > > > >    	sec_buf = kzalloc(sizeof(*sec_buf), GFP_KERNEL);
> > > > >    	if (!sec_buf)
> > > > >    		return ERR_PTR(-ENOMEM);
> > > > 
> > > > 
> > 
> > 
