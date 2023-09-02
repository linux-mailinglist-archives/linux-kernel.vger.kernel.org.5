Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15FE7904C4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbjIBCqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:46:48 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE84E56;
        Fri,  1 Sep 2023 19:46:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64a5bc52b0aso14734886d6.3;
        Fri, 01 Sep 2023 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693622804; x=1694227604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYjZGvbGWU9jnlsJHPlffxOKxtAJZfdMBuJVjHbXqTQ=;
        b=dRyqAGItH/Rrirj54P4nqPFWJreIMmNND/0U+R3UfR80jcIUuDoaj+CVTa4trSCkZL
         LTSgfQXL1dv3wpk/D+cwCveTiLNqSNRK72OE2x3XpN7pNHnpC+gmBD5GfXRu4wfiZYyo
         wI5E+15Gx7jXGIRcBi0ByoVZWwWE4GQ3+leCEP3dswAKLrCOv6Yz31ZTJQ15vMmZ9Lew
         0xyMKC9lgB52jck8LDbvNz9XWLP9h3GvZNsjZrpHcAjxhQRFvCKNgD1plUlmMrZqivoo
         ELrvmjfJnKesyMy60sE0OYwcwg9FrZr8dE3EOu3G/J+WgWYl5uc3mwqynkoXWB8m8Crm
         yurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693622804; x=1694227604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYjZGvbGWU9jnlsJHPlffxOKxtAJZfdMBuJVjHbXqTQ=;
        b=DXU6yg/A+oI54BL6Z6rRYsXeYmezHK+H6XjK7MPO6POsei59MsdnOo9WuB1BQlyBJA
         UO5RNB+Q7C4nrgBsWFoWHkMGTisyFzHnbCkzpn2NzUWyQOdYWP65txqA7nVuuk7kBvE9
         NlDTfHVPCJY/xb7nrQSWOEkKgOP6q/kbKIKvCDjtgHWkDy4ihoevOBpXlvCYvGhgxldO
         i0532TBQ6ua88g4AzzbVxzfloGceVJhT/YJhXsiN42IPPCffI6fDGnT3lplSL6Gx7SeT
         50XCORimamKwHn2lcnmRGtPy2VH8p8oGJyoF1jBfewIuRYsGhcW2KO3snNV2FAlTZigf
         hUZQ==
X-Gm-Message-State: AOJu0YxgeUPmQ1IIHo+LDL0wReKc7kIc+5OLP4CBSSWuMoh80GEvO7T9
        /6W0IzUiYskdwRzr1yCu5XA=
X-Google-Smtp-Source: AGHT+IHnSBpEiSIkMJ2ZwmrxVxi41c/+a1iJ18+jBZPhJxiuCQSqQ0s3qsjH8oa5BMPlr1GrEpCvOQ==
X-Received: by 2002:a0c:a719:0:b0:64f:7fe6:bf1d with SMTP id u25-20020a0ca719000000b0064f7fe6bf1dmr3707066qva.12.1693622804228;
        Fri, 01 Sep 2023 19:46:44 -0700 (PDT)
Received: from luigi.stachecki.net (pool-96-232-116-30.nycmny.fios.verizon.net. [96.232.116.30])
        by smtp.gmail.com with ESMTPSA id mx16-20020a0562142e1000b0064f725828f3sm580654qvb.35.2023.09.01.19.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 19:46:43 -0700 (PDT)
Date:   Fri, 1 Sep 2023 22:47:06 -0400
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, charles.d.prestopine@intel.com,
        rafael.j.wysocki@intel.com
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
Message-ID: <ZPKiKrfVswqhrryZ@luigi.stachecki.net>
References: <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
 <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
 <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
 <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
 <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
 <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
 <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
 <eec91766-10a9-4d50-8e82-376f52f54be8@amd.com>
 <9f3b82466e36aef3591d03176c04663c89625d4a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3b82466e36aef3591d03176c04663c89625d4a.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:39:58PM -0700, Todd Brandt wrote:
> > > > > > > > > > > > While testing S3 on 6.5.0-rc6 we've found that 5
> > > > > > > > > > > > systems are seeing
> > > > > > > > > > > > a
> > > > > > > > > > > > crash and reboot situation when S3 suspend is
> > > > > > > > > > > > initiated. To
> > > > > > > > > > > > reproduce
> > > > > > > > > > > > it, this call is all that's required "sudo
> > > > > > > > > > > > sleepgraph -m mem
> > > > > > > > > > > > -rtcwake
> > > > > > > > > > > > 15".
> > > > > > > > > > > 
> 
> I just ran 6.5.0-rc6 plus this patch on all 5 machines where the
> problem was detected and they work now. It looks good.
> 
> Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>

I just wanted to report that at least on an SBC running a J4105, this
prevented the kernel from booting *at all* ever since 6.1.46 was released.

The fix which drops the ret assignment above allows the SBC to successfully
boot a kernel again -- just mentioning for severity given that:
  1) It also impacts the 6.1 LTS kernel that distros are tracking
  2) In some cases, the kernel no longer boots anymore at all

SBC this is seen on is a Seeed Studio ODYSSEY - X86J4105 for the curious.

Tested-by: Tyler J Stachecki <stachecki.tyler@gmail.com>
