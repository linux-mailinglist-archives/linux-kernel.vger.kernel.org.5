Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890278E537
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbjHaD7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHaD7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:59:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C2CC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:59:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso374740a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693454374; x=1694059174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Wr8NYu6HSmc0mkG+FLn0sx5HN2+FhcGiqyKWtv7y8=;
        b=htestwlF5DdghKeMk3UrzsnxUWcimyGZy/IP4Q7RFYb6UbMedUrtqJVYqc5ISvSih7
         Vb4oBmZ/wFofHnzn4DdcW5c926kq1S/ajvZF3A3/kdZ+6CQ4tQHnpmz/FMsb3NkCRFgv
         Y+mte31bn0vurt2OIS6BnoCVBG+8c+H+IoChA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693454374; x=1694059174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Wr8NYu6HSmc0mkG+FLn0sx5HN2+FhcGiqyKWtv7y8=;
        b=hVP+QrVrUf+ECLLzIuebsisvIpB1viqhFunXu7kn+5ukMXal5cb5KvH9m0sWPHIbYl
         unGpJlbVSAnJQH39LPlRWhhtG6L7SyyRRq3bkQI5zXbShKMDiebSMhSCJ/CvMXfh78Gd
         DIbLvBalvKq5ADboQdu8GT2MkzFYa6qmuulYIgJM90MlMDQgKsloHngZEphvq7yeduO1
         XeOed1KSEJAYaLDigL5fXW7uLuGiU41FgLdGromE0+TeEdB4q30IjsQEzFiWQmcgaJrd
         EHy21k0MPSaF8gsZIVGrVxmUC66LPxTdNpSrQQGW7thpeltcGOqJaVW+93liThF7T6sW
         PGWg==
X-Gm-Message-State: AOJu0YzIwoN1AdLYJPTOOlJw78HMfgTjmIqF8mD9aekypMzZM1JeKMkE
        QFgRIEwtCH1bVTya1ZbhkrqtX4YV4HVxRmlP45tE7Q==
X-Google-Smtp-Source: AGHT+IFMcBnrdnctyby/Y7nXXS7QhE+vs2TBoiDjsvnehzDJvzPdYcPkxdYj/rt8Ms3ZNtDcFCFQew==
X-Received: by 2002:a17:906:c110:b0:9a4:dd49:da41 with SMTP id do16-20020a170906c11000b009a4dd49da41mr4103797ejc.76.1693454373891;
        Wed, 30 Aug 2023 20:59:33 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906951700b0099d0a8ccb5fsm266977ejx.152.2023.08.30.20.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 20:59:33 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9936b3d0286so36901366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:59:33 -0700 (PDT)
X-Received: by 2002:a17:907:7844:b0:9a5:c4ae:9fec with SMTP id
 lb4-20020a170907784400b009a5c4ae9fecmr3151324ejc.52.1693454372889; Wed, 30
 Aug 2023 20:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZO/Te6LU1ENf58ZW@nvidia.com>
In-Reply-To: <ZO/Te6LU1ENf58ZW@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 20:59:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_L-97_06_ruO7xL7vxX4QpaqGQKw-6LtKAR_CB1cyYw@mail.gmail.com>
Message-ID: <CAHk-=wg_L-97_06_ruO7xL7vxX4QpaqGQKw-6LtKAR_CB1cyYw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 16:40, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This includes a shared branch with VFIO:
>
>  - Enhance VFIO_DEVICE_GET_PCI_HOT_RESET_INFO so it can work with iommufd
>    FDs, not just group FDs. [...]

So because I had pulled the vfio changes independently with their own
merge message, I ended up editing out all the commentary you had about
the vfio side of the changes.

Which is kind of sad, since you arguably put some more information and
effort into it than Alex had done in his vfio pull request. But the
vfio parts just weren't part of the merge any more.

I did put a link to your pull request in the commit, so people can
find this info, but I thought I'd mention how I ruthlessly edited down
the merge commit message to just the parts that were new to the merge.

I appreciate the extra background, even if I then decided that by the
time I merged your part, some of it was "old news" and not actually
about what I merged when I pulled your branch.

.. and if I had realized when I merged the vfio parts, I probably
could have added your commentary to that merge. Oh well.

                  Linus
