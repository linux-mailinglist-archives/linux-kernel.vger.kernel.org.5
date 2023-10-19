Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2527CEEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJSEaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:30:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F49122;
        Wed, 18 Oct 2023 21:30:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b390036045so1256908b3a.1;
        Wed, 18 Oct 2023 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697689830; x=1698294630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07TI5lUHbLHzCbfbAfFgFmfomhDjrV2r0S9w2heQhcw=;
        b=DhSKf4s94RZLjGuU2CvlxfMReCZI3sFWBSgFB1y8mYYsKsg9gRhB0u1hUUsc6brxCQ
         JvnWZ7c55B2obn5SebwvdoaJyzOOZbR1MUZorvwJ5qfP5cD02MuIUVg3wylmXu7WeKLf
         gwz0NdWBsVqI7A9Mg2urmMqu/FGMH7mOO44ZHBU6as0Nv2IEkPjNrlX1khyoNHOMo3g8
         lx79MC4998mX6+5AK2IA+gSaJ6C0NKKtE+Xg2hGSvrdQ+MFNVauXnXj1OsF6BN8VIy0f
         RrPvY06GGzuRwo3xZ25Z66bd2jYSJ3cIRBL5tJDRVim3Gw3zyoIEAuvkhP7AoNrImcqD
         knvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689830; x=1698294630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07TI5lUHbLHzCbfbAfFgFmfomhDjrV2r0S9w2heQhcw=;
        b=TDaDBsZr1aeA8laRHX6x3vXdP4N/xKU2OXQZ8UEzT+FHfTcc4ysvn1hNVGVGozBx+y
         lb39MFn2Fyvz0R/KV8KoQrG+lzHEm5HTZMWIxAB+Dkv6PO9CgUXSFMy5IZ4hjx8NvT6z
         Faccxmbzc+kVeYgdph81CUJctPkvT4CDEE0yG2/pJtBothk7fQhu62pJCcD/rP9ZMWEe
         +YtR7CzjhdDze2o/UInFL6tOFXUv+xBzNojEbR2ll00UXXGEUmm5scWxCp4aqbBIUH0o
         hBfPnH8JcrLzwiH69pLtX5f4DWgPfU+socWu1yBIUQbP43hBg1c2ILrxgcJE2hXGCvIP
         MK3Q==
X-Gm-Message-State: AOJu0YwLy1tG2OGKGjx3C3ZmSN/F5CjEmM2zCFoiamviF9g+xiY0xyaP
        itQCiD06SjDu0pmaP/DnolbQ6mjy9qnMOtl/
X-Google-Smtp-Source: AGHT+IEkWJvFP6rwED1ZbZyuQSYjiy/JNyTa5i4es2xKS+eEA8tiLgNC+CD3rO0KS3qkrixbUcz6ZQ==
X-Received: by 2002:a05:6a21:3286:b0:17a:e03f:38b7 with SMTP id yt6-20020a056a21328600b0017ae03f38b7mr1137611pzb.6.1697689830046;
        Wed, 18 Oct 2023 21:30:30 -0700 (PDT)
Received: from sivslab-System-Product-Name ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001c5eb37e92csm745514pll.305.2023.10.18.21.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 21:30:29 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:30:25 +0800
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, lenb@kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NFIT: Optimize nfit_mem_cmp() for efficiency
Message-ID: <20231019043025.GA577714@sivslab-System-Product-Name>
References: <20231012215903.2104652-1-visitorckw@gmail.com>
 <20231013122236.2127269-1-visitorckw@gmail.com>
 <CAJZ5v0gSB_ACBpK1nKu3sbA0HQ1xsk2mn3oc9AjpoFtge9Opdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gSB_ACBpK1nKu3sbA0HQ1xsk2mn3oc9AjpoFtge9Opdw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:17:31PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 13, 2023 at 2:22 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > The original code used conditional branching in the nfit_mem_cmp
> > function to compare two values and return -1, 1, or 0 based on the
> > result. However, the list_sort comparison function only needs results
> > <0, >0, or =0. This patch optimizes the code to make the comparison
> > branchless, improving efficiency and reducing code size. This change
> > reduces the number of comparison operations from 1-2 to a single
> > subtraction operation, thereby saving the number of instructions.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > v1 -> v2:
> > - Add explicit type cast in case the sizes of u32 and int differ.
> >
> >  drivers/acpi/nfit/core.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index f96bf32cd368..563a32eba888 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -1138,11 +1138,7 @@ static int nfit_mem_cmp(void *priv, const struct list_head *_a,
> >
> >         handleA = __to_nfit_memdev(a)->device_handle;
> >         handleB = __to_nfit_memdev(b)->device_handle;
> > -       if (handleA < handleB)
> > -               return -1;
> > -       else if (handleA > handleB)
> > -               return 1;
> > -       return 0;
> > +       return (int)handleA - (int)handleB;
> 
> Are you sure that you are not losing bits in these conversions?

I believe your concerns are valid. Perhaps this was a stupid mistake I
made. Initially, I proposed this patch because I noticed that other
parts of the Linux kernel, such as the sram_reserve_cmp() function in
drivers/misc/sram.c, directly used subtraction for comparisons
involving u32. However, this approach could potentially lead to issues
when the size of int is 2 bytes instead of 4 bytes. I think maybe we
should consider dropping this patch. I apologize for proposing an
incorrect patch.

Thanks,
Kuan-Wei Chiu
> 
> >  }
> >
> >  static int nfit_mem_init(struct acpi_nfit_desc *acpi_desc)
> > --
