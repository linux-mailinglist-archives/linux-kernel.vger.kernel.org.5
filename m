Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0F796DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbjIFXkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIFXku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:40:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A97132
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:40:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so2273966d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694043645; x=1694648445; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRFCUp1EgKStwtQrssEYAgdj2N9VkIEfiBYPju9CrRw=;
        b=cgJn1MaptXmK+FnH7d2Tmqn7i5tPreOiZe/Ldu2y5TArL1LyLAcaTO24SuFstqlaNp
         S3xYzz6kQTEX/jhRzzqZhuJx463U5VlzBwxbkyYw7JIwKuwBOk8WsCY/MtbZNeNtimGf
         1MK+UmD6coIS3ZJ9I1wRAyNSSfIAXINc6jplg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043645; x=1694648445;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRFCUp1EgKStwtQrssEYAgdj2N9VkIEfiBYPju9CrRw=;
        b=lZla7fHpI001Rj7SJe/sYKdV56HBSB5nYsPTMov8YEK1iPR9rXh/WVMIGq4ur2HxHI
         +NK18+ZKtHnmDt+mnaScNBK0A9Va6UeeA0h/hVy09hW5JkUUUu3QnAp1Ze011TKOGc3a
         BKNHbyBwyswTMEoF6t2ZLAN0tsGc67ZM8pdpiDY4b5Fp0ApAF/63D4V6g3hCs6w1xdMz
         QfLWSdo+DOwgtzszzGu9XWe8/OHwsWtc6sbeFnfvPvIQIJi6zjGJjbKpVwzb7y3JbUbN
         OLjr4A6JBcMbHOGwxn9agAebalJQK1UK2zYFrCcw7/C7B84ehCkPywTqEUjHfcQC/gHR
         jzhA==
X-Gm-Message-State: AOJu0Yz31N/09HRr33T+Q3PsO3YxuToS188WEKEMyyK+wITtVdEjj/r8
        CysaUUm2N3E8i9Aiq+TcIJyzp83+j7kWM7TfbxU=
X-Google-Smtp-Source: AGHT+IGhsdEfD5ztLaWrvVOZaisxBDSfdAxOEiVkQZGer7K/GGeg15/nfhi/lRo4HWni4JqF5NTDLg==
X-Received: by 2002:a05:6214:1710:b0:64f:92dc:3de3 with SMTP id db16-20020a056214171000b0064f92dc3de3mr18245434qvb.6.1694043645278;
        Wed, 06 Sep 2023 16:40:45 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.67])
        by smtp.gmail.com with ESMTPSA id p17-20020a0ce191000000b0064f4d3bc78csm5762918qvl.61.2023.09.06.16.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 16:40:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [merged mm-hotfixes-stable] mm-vmalloc-add-a-safer-version-of-find_vm_area-for-debug.patch removed from -mm tree
Date:   Wed, 6 Sep 2023 19:40:33 -0400
Message-Id: <2E4C860E-EB96-477E-B980-42DE61FF9AAF@joelfernandes.org>
References: <CAA5enKZDKA9=gHJL1J=UVGFiB_LLBuR_4XHTasHauaFjeORHCQ@mail.gmail.com>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        willy@infradead.org, urezki@gmail.com,
        thunder.leizhen@huaweicloud.com, stable@vger.kernel.org,
        qiang.zhang1211@gmail.com, paulmck@kernel.org,
        akpm@linux-foundation.org
In-Reply-To: <CAA5enKZDKA9=gHJL1J=UVGFiB_LLBuR_4XHTasHauaFjeORHCQ@mail.gmail.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 6, 2023, at 3:14 PM, Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, 6 Sept 2023 at 16:09, Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>>=20
>>=20
>> The quilt patch titled
>>     Subject: mm/vmalloc: add a safer version of find_vm_area() for debug
>> has been removed from the -mm tree.  Its filename was
>>     mm-vmalloc-add-a-safer-version-of-find_vm_area-for-debug.patch
>>=20
>> This patch was dropped because it was merged into the mm-hotfixes-stable b=
ranch
>> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>=20
> Hmm, I had outstanding review on this :/ I guess I will have to send a
> follow up patch to address those concerns...

That works me because we also had some disagreements on some of the suggesti=
ons!

Looking forward to your patch and discussing it!

Cheers,

 - Joel


>=20
>=20
>>=20
>> ------------------------------------------------------
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> Subject: mm/vmalloc: add a safer version of find_vm_area() for debug
>> Date: Mon, 4 Sep 2023 18:08:04 +0000
>>=20
>> It is unsafe to dump vmalloc area information when trying to do so from
>> some contexts.  Add a safer trylock version of the same function to do a
>> best-effort VMA finding and use it from vmalloc_dump_obj().
>>=20
>> [applied test robot feedback on unused function fix.]
>> [applied Uladzislau feedback on locking.]
>> Link: https://lkml.kernel.org/r/20230904180806.1002832-1-joel@joelfernand=
es.org
>> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Zqiang <qiang.zhang1211@gmail.com>
>> Cc: <stable@vger.kernel.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>=20
>> mm/vmalloc.c |   26 ++++++++++++++++++++++----
>> 1 file changed, 22 insertions(+), 4 deletions(-)
>>=20
>> --- a/mm/vmalloc.c~mm-vmalloc-add-a-safer-version-of-find_vm_area-for-deb=
ug
>> +++ a/mm/vmalloc.c
>> @@ -4278,14 +4278,32 @@ void pcpu_free_vm_areas(struct vm_struct
>> #ifdef CONFIG_PRINTK
>> bool vmalloc_dump_obj(void *object)
>> {
>> -       struct vm_struct *vm;
>>        void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
>> +       const void *caller;
>> +       struct vm_struct *vm;
>> +       struct vmap_area *va;
>> +       unsigned long addr;
>> +       unsigned int nr_pages;
>> +
>> +       if (!spin_trylock(&vmap_area_lock))
>> +               return false;
>> +       va =3D __find_vmap_area((unsigned long)objp, &vmap_area_root);
>> +       if (!va) {
>> +               spin_unlock(&vmap_area_lock);
>> +               return false;
>> +       }
>>=20
>> -       vm =3D find_vm_area(objp);
>> -       if (!vm)
>> +       vm =3D va->vm;
>> +       if (!vm) {
>> +               spin_unlock(&vmap_area_lock);
>>                return false;
>> +       }
>> +       addr =3D (unsigned long)vm->addr;
>> +       caller =3D vm->caller;
>> +       nr_pages =3D vm->nr_pages;
>> +       spin_unlock(&vmap_area_lock);
>>        pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS=
\n",
>> -               vm->nr_pages, (unsigned long)vm->addr, vm->caller);
>> +               nr_pages, addr, caller);
>>        return true;
>> }
>> #endif
>> _
>>=20
>> Patches currently in -mm which might be from joel@joelfernandes.org are
>>=20
>>=20
>=20
>=20
> --
> Lorenzo Stoakes
> https://ljs.io
