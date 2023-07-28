Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0477675E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjG1S4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjG1S4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:56:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3585D19A7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:56:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1822458b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690570569; x=1691175369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94oOxm0WoyXasJp0lxEK6G1xzuxiRUtkw48hzY+2KKA=;
        b=nfFcmOBJUm2G6WKuAfyEZ1v/efunAenmLDRiCwhUFkyB4/fhkaMB/a3ar/ZX1JHkJJ
         X52mM981hfdSShkGjg2Vvwpzny4IOVGJxvpmPnU9XZCRpZCXBTAxRkJJpuboGQBoFhra
         +GZ3CecY6skX6YlCNydRWv9yDDlEcDjHIMMLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690570569; x=1691175369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94oOxm0WoyXasJp0lxEK6G1xzuxiRUtkw48hzY+2KKA=;
        b=PKq6PuBFd7WHzIVQNgFVyiqq2cTuvDrPrMRvkfImQp9LoRlPl1yBOlD0aYxfW+asuc
         EIzDkf2fkiELx0EKrfPmPC/Aar3RgKgWXOTlLcwsrUI2tUKZlG9hbawQ/qRfT1IIC5/g
         NjAM/uk6K+xOLHabopHCdQ3FX/pnTY2WhB2p/Tw6jFu+kj7Xgh75VWCchrWSV3mnTsKy
         3jmGUt6LubyYE2FoGod7ocUmcawPk1YDxiUockEsX6iFDT5Bxo4YW2IaxtRcq6+vvppO
         HRUAzcNT0XzdGUM891S7RUkWPjpBbnrq78mho9/NPNx9tkpIhk+CJcPZNlKO4o9MwMzA
         AriA==
X-Gm-Message-State: ABy/qLYmIzPsRYyWsJi1bMdA0ePpb4tPmhiZvBlTv5MDcsYE3SV1tXoO
        AoAhubmvLxr3O+4nxsJd9GhZ5g==
X-Google-Smtp-Source: APBJJlGUxisSIvpw4EAEzjvpNjNfQyoa9MtaWQzi1HEOuQ+jPTd7IumEeb5BGAJdxPLLG2bRGYWaKw==
X-Received: by 2002:a05:6a00:170f:b0:686:254c:9d4e with SMTP id h15-20020a056a00170f00b00686254c9d4emr3001823pfc.14.1690570569293;
        Fri, 28 Jul 2023 11:56:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a26-20020aa780da000000b00682802ca418sm3528085pfn.79.2023.07.28.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:56:08 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:56:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <202307281153.B9D0831710@keescook>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
 <f0f0ebe4-55fb-4861-a94c-77c82ec600c5@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f0ebe4-55fb-4861-a94c-77c82ec600c5@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:27:24AM +0100, Mark Brown wrote:
> On Thu, Jul 27, 2023 at 08:30:18PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> 
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Hm, I see "X-Mailer: b4 0.12.3". Is this a default behavior of b4? (If
so, that needs fixing.)

-- 
Kees Cook
