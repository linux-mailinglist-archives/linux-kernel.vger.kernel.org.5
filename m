Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684587B863D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbjJDRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjJDRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:17:01 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87219E;
        Wed,  4 Oct 2023 10:16:57 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49352207f33so38734e0c.2;
        Wed, 04 Oct 2023 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696439817; x=1697044617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKXyXyIVrMhHeTBplf68Sne/yJwO2VWXOvGeFVZVVI0=;
        b=UVeM2/6Vz0yjULM8daNkbrbx+zO80ljkxMlZxW1E/gTXQULj4pswFqMcntOazcEZYN
         rPPgMFwtOFqGUFn18ZEcjKxG5ciow2ymoVxr8E5SQu21+xnG9oLfW5xP3HDj4GTlzRIg
         7bNLZ6qQnI3Dith77UOvZI+oOEXeqLyqrOK2UxvCftCiSJnshhe9S/98OXrKIJaXZXFF
         FIe7CAwBaMv1axtPC/JwALTZqq1a798fnxMv8tcqHvDlIstZ2zh8VLYvAIwLUQKaz9Yw
         zC2JYVu3e9t3KmlQ0QNSZc9RaCCrtj3OQu4vNjJNB4ivtEx5rOmhoddoFaZj5lO+OwBi
         GdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439817; x=1697044617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKXyXyIVrMhHeTBplf68Sne/yJwO2VWXOvGeFVZVVI0=;
        b=KQ0qEZGsb067LqLJ9ghhOhYTwNOWZ5hkrN55T3Y/sbiFlxadBhKJZqk4NwpZE9qPz+
         GKQRC278F9pne6r+uDo3mdGyiVaFCo1Fm7a6sWFiYudV7mrRc5AvvoHloQwUXjzO5evr
         Hfw6pYAzakLNebkFLUdbYVuvCMIxdJhQBBO5LMI0mn+nUNnodpNKDLVxtV6nz4vDpqwa
         1VgVxW7RKUYJfN7gjfiI6xuFM28omuDbBO8tDYPCTafklHtV9nNthP5gGPtLaHh9ovvr
         ceLAUXW2xlVO48tYMIwp1upax0o4l2gVhqB4VK71QySTAypREq+lPpflKUnBTRj4js1P
         neOg==
X-Gm-Message-State: AOJu0Ywe3LsW+juApKhk4Jl7+BNtppCoRxAFt8iEFBUykpuwf52aGXm1
        cchsyq4q7Sumldn84wzvvtC5XnCSwvo+uO+m/VM=
X-Google-Smtp-Source: AGHT+IHdD/dOCM5nfzumZAEL0jBE4Ej5n+lk/beg05IUH4Dkjqn+RFPEswXegljO4k7vBq4bJ7qVDHX8OYS1n4TIRH4=
X-Received: by 2002:a1f:4f86:0:b0:495:c10c:ec39 with SMTP id
 d128-20020a1f4f86000000b00495c10cec39mr2674807vkb.2.1696439816668; Wed, 04
 Oct 2023 10:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker> <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
 <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com> <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
 <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com> <CA+V-a8s1S4yTH19PVNSznAgUFoHRNoye9CfwjW6iy6PbQ9thew@mail.gmail.com>
In-Reply-To: <CA+V-a8s1S4yTH19PVNSznAgUFoHRNoye9CfwjW6iy6PbQ9thew@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 4 Oct 2023 18:16:01 +0100
Message-ID: <CA+V-a8vbWW6=HTfR+FCPOB0bAa8M3Bbm_k=7+XbjOc3ybo6VNQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Icenowy Zheng <uwu@icenowy.me>,
        Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Christoph Hellwig <hch@lst.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:03=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Wed, Oct 4, 2023 at 3:18=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
> >
> > On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
> > [...]
> > >>>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
> > >>>> required configs for RZ/Five SoC") can cause regression on all
> > >>>> non-dma-coherent riscv platforms with generic defconfig. This is
> > >>>> a common issue. The logic here is: generic riscv defconfig
> > >>>> selects
> > >>>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> > >>>> non-dma-coherent riscv platforms have a dma global pool, this
> > >>>> assumption
> > >>>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> > >>>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some
> > >>>> specific
> > >>>> conditions can select it globaly, for example NOMMU ARM and so
> > >>>> on.
> > >>>>
> > >>>> Since this is a regression, what's proper fix? any suggestion is
> > >>>> appreciated.
> > >>
> > >> I think the answer is to not select DMA_GLOBAL_POOL, since that is
> > >> only
> > >
> > > Well I think for RISC-V, it's not NOMMU only but applicable for every
> > > core that does not support Svpbmt or vendor-specific alternatives,
> > > because the original RISC-V priv spec does not define memory attribut=
es
> > > in page table entries.
> > >
> > > For the Renesas/Andes case I think a pool is set by OpenSBI with
> > > vendor-specific M-mode facility and then passed in DT, and the S-mode
> > > (which MMU is enabled in) just sees fixed memory attributes, in this
> > > case I think DMA_GLOBAL_POOL is needed.
> >
> > Oh wow, is that really a thing? In that case, either you just can't
> > support this platform in a multi-platform kernel, or someone needs to d=
o
> > some fiddly work in dma-direct to a) introduce the notion of an optiona=
l
> > global pool,
> Looking at the code [0] we do have compile time check for
> CONFIG_DMA_GLOBAL_POOL irrespective of this being present in DT or
> not, instead if we make it compile time and runtime check ie either
> check for DT node or see if pool is available and only then proceed
> for allocation form this pool.
>
> What are your thoughts on this?
>
Something like the below:

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..7bf41a4634a4 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -198,6 +198,7 @@ int dma_release_from_global_coherent(int order,
void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_ad=
dr,
                size_t size, int *ret);
 int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
+bool dma_global_pool_available(void);
 #else
 static inline void *dma_alloc_from_global_coherent(struct device *dev,
                ssize_t size, dma_addr_t *dma_handle)
@@ -213,6 +214,10 @@ static inline int
dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 {
        return 0;
 }
+static inline bool dma_global_pool_available(void)
+{
+       return false;
+}
 #endif /* CONFIG_DMA_GLOBAL_POOL */

 /*
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..605f243b8262 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -277,6 +277,14 @@ int dma_mmap_from_dev_coherent(struct device
*dev, struct vm_area_struct *vma,
 #ifdef CONFIG_DMA_GLOBAL_POOL
 static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_ini=
t;

+bool dma_global_pool_available(void)
+{
+       if (!dma_coherent_default_memory)
+               return false;
+
+       return true;
+}
+
 void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
                                     dma_addr_t *dma_handle)
 {
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0da..a599bb731ceb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -235,7 +235,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
                 * If there is a global pool, always allocate from it for
                 * non-coherent devices.
                 */
-               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
dma_global_pool_available())
                        return dma_alloc_from_global_coherent(dev, size,
                                        dma_handle);


Cheers,
Prabhakar

> [0] https://elixir.bootlin.com/linux/v6.6-rc4/source/kernel/dma/direct.c#=
L238
>
> > and b) make it somehow cope with DMA_DIRECT_REMAP being
> > enabled but non-functional.
> >
> DMA_DIRECT_REMAP config option is selected by NONCOHERENET config option =
anyway.
>
> Cheers,
> Prabhakar
