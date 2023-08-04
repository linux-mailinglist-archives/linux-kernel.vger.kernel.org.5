Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4C76FBFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjHDI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjHDI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:27:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911394EC9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:27:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so1330395b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137623; x=1691742423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUS4uE91dvG7NiA03WNNZdSwC3Poo9mFt4/nET0m0dg=;
        b=S89d4M3DnOXOCpVn6+SsXsaln+b1CDkwN+Wc8iZfQIJp/5Mg31YkipDnIpZFJ8WT22
         6KDDkE6N/Q9+Z1OSckAI2AGnB0jNWeeiAnARi+3bxQCjA0MVKMlkSTzRdpiegjDdjzs9
         alwHeWzqeeo6oSaTxIIaxPIaZMlivjqD7xdio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137623; x=1691742423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUS4uE91dvG7NiA03WNNZdSwC3Poo9mFt4/nET0m0dg=;
        b=ern6O10/1sGun6iD245AS9whQMo9pvCv+vn3/pI1LbbJIBfk4C9SSRmyeJcNrAdBAs
         oyF2AS6P/xyFKIzwv1FRtC0ymS5HWapmWkp72hyrwav2mvK8d9QHOC7WwbSaT/Ab8Qdf
         c0OVmDaPEpG6OsBt+Z8LH/cFd2EifMlLdzgCDSSyI6Z41uxK3YgKjsn140FzqqbLHIxj
         Trs+P6TyNZkCUnZWXFbej4jcSjB2puS5egTPXEgCs+d5SdzILUvOeq7hCmlQF2bttObt
         MLmXsuqHSaUsTkk+XQ0PkZwmELlaUpFQdLdTO4euCI9Wad3JV2A8IH9cas3YGqVKDfvM
         L6bQ==
X-Gm-Message-State: AOJu0YzJFeLO7pzPCf3U/MQPhnE7lT0vAFK34AcXzfash9uVSlyikAsP
        u28bqSZF7s/h49ift72iG7qvpw==
X-Google-Smtp-Source: AGHT+IEMVAqP/UVb3WrkT6mDnbU4Pw1rjYqa7tcZY9aFwv2xDvN5rJf3YMidsLXa7DBayiqLPkiTZQ==
X-Received: by 2002:a05:6a20:8f02:b0:13f:8855:d5a0 with SMTP id b2-20020a056a208f0200b0013f8855d5a0mr1071535pzk.50.1691137623268;
        Fri, 04 Aug 2023 01:27:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b0019ee045a2b3sm1138162plo.308.2023.08.04.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:27:02 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:27:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs
 allocated as `nents + 1` - 1
Message-ID: <202308040126.ADDA993@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-2-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> The two most problematic virtchnl structures are virtchnl_rss_key and
> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
> allocating / checking, the actual size is calculated as `sizeof +
> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
> of such structure with proper flex array, it's two bytes larger due to
> the padding. That said, their size is always 1 byte larger unless
> there are no tail elements -- then it's +2 bytes.
> Add virtchnl_struct_size() macro which will handle this case (and later
> other cases as well). Make its calling conv the same as we call
> struct_size() to allow it to be drop-in, even though it's unlikely to
> become possible to switch to generic API. The macro will calculate a
> proper size of a structure with a flex array at the end, so that it
> becomes transparent for the compilers, but add the difference from the
> old values, so that the real size of sorta-ABI-messages doesn't change.
> Use it on the allocation side in IAVF and the receiving side (defined
> as static inline in virtchnl.h) for the mentioned two structures.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

This is a novel approach to solving the ABI issues for a 1-elem
conversion, but I have been convinced it's a workable approach here. :)
Thanks for doing this conversion!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
