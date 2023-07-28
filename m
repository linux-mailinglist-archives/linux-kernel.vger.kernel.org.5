Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A257675DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjG1SxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjG1SxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:53:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE42D4D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:53:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bba54f7eefso23443925ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690570383; x=1691175183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sz3fdz5ASL81uIRwaUvVdUPGG/7NGI0jRB0c78sZ30=;
        b=d0IX++FZw48K0U6wYhl7mnSyskHucEutaQxvWgvxM4NYMAUX2D82J+WUfC9O7+teVP
         cAAIUvU3rJH3Z2qhdIiaQ5DZTOLcWTsG4XxOcXc3iSA62354iMMXUusRI5Oo5OBigONt
         pxRqB4RCr125sKliFdzBVUrlZTp0G6YVOqpMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690570383; x=1691175183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sz3fdz5ASL81uIRwaUvVdUPGG/7NGI0jRB0c78sZ30=;
        b=KJHcg7ZEC2QhR3sT7y3DI/7vaJtFV9vSLbkabfVdJqJMatB5nvn1HPjx92gOCOOCgb
         HvvcF7qEbeaTJ/3V3bsbSpoQx8xls/ULZurvNOWTZsqo//qDnBquOom/C1jaG19XUsLT
         wF3VcxZW3jR4SdDgwBLZe7KOzfn+PJoBEFfCEb1dSpffPxTJ3D3/WW841k0KwepodCw9
         gKqSQ/MBjpcVXMv30m7Hau2p1RcSq4B7Zu48FynTAGzoGBvrRupmXbLZUCWk1A6Pp0gp
         FJjqcmOOqzYQxnRfsX+xjEnxm4Ux1CaU7APHyzfGR6U84inV2tUnstTxz7+DStYkVqhn
         x3Tw==
X-Gm-Message-State: ABy/qLZ2gMfPqF0DIrD+bXSG2LbiGtbsua/hHG1dCnE7EE/5OcDPBKY3
        eREW1GhHX5MSCTkc/q+qzFmB7g==
X-Google-Smtp-Source: APBJJlFZtVPnVSe+QaD0w5VK3Xw+yr0QbYVt3cbtUKxfEN73/VRkLvzX/WeR43f5vhKJLl8KX2OnCA==
X-Received: by 2002:a17:902:f691:b0:1b4:5699:aac1 with SMTP id l17-20020a170902f69100b001b45699aac1mr3264358plg.12.1690570382884;
        Fri, 28 Jul 2023 11:53:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh3-20020a170903328300b001b8b6a19bd6sm3940878plb.63.2023.07.28.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:53:02 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:53:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     justinstitt@google.com,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <202307281143.AE254E3A@keescook>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <202307261532.3EFCF04F1@keescook>
 <402a7a63-5584-ef79-e42f-e2102f42b9aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <402a7a63-5584-ef79-e42f-e2102f42b9aa@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:25:24AM +0200, Amadeusz Sławiński wrote:
> On 7/27/2023 12:34 AM, Kees Cook wrote:
> > On Wed, Jul 26, 2023 at 09:12:18PM +0000, justinstitt@google.com wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > > 
> > > A suitable replacement is `strscpy` [2] due to the fact that it
> > > guarantees NUL-termination on its destination buffer argument which is
> > > _not_ the case for `strncpy`!
> > > 
> > > It was pretty difficult, in this case, to try and figure out whether or
> > > not the destination buffer was zero-initialized. If it is and this
> > > behavior is relied on then perhaps `strscpy_pad` is the preferred
> > > option here.
> > > 
> > > Kees was able to help me out and identify the following code snippet
> > > which seems to show that the destination buffer is zero-initialized.
> > > 
> > > |       skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
> > > 
> > > With this information, I opted for `strscpy` since padding is seemingly
> > > not required.
> > 
> > We did notice that str_elem->string is 44 bytes, but
> > skl->lib_info[ref_count].name is 128 bytes. If str_elem->string isn't
> > NUL-terminated, this can still hit an over-read condition (though
> > CONFIG_FORTIFY_SOURCE would have caught it both before with strncpy()
> > and now with strscpy()). So I assume it is expected to be
> > NUL-terminated?
> > 
> 
> Yes it is a filename of additional library which can be loaded, topology
> UAPI only allows for passing 44 bytes long strings per string token (see
> snd_soc_tplg_vendor_array -> union -> string flex array ->
> snd_soc_tplg_vendor_string_elem -> SNDRV_CTL_ELEM_ID_NAME_MAXLEN), so we

Thanks for the details! And just to confirm, these are (expected to be)
NUL-terminated?

> could also change length of
> skl->lib_info[ref_count].name and potentially save few bytes. And looking at
> it again I also think that we should not copy destination size number of
> bytes, by which I mean ARRAY_SIZE(skl->lib_info[ref_count].name), which is
> 128 in this case... so either need to change destination buffer size to be
> same as topology field or calculate it differently.

If the source is NUL-terminated, it's fine as-is. (And
CONFIG_FORTIFY_SOURCE will catch problems if not.)

-- 
Kees Cook
