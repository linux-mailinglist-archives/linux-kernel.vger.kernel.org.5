Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629076FC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjHDIaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjHDIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:30:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE11646B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:30:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca38a6618so1571781a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137810; x=1691742610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=GzQT2IqnS0O9DsPcor7DwEmC2sqiMDOSQPI4yqQEhlltfGaGer/VaRPL79vkoGC3nq
         OI2mf4uB95BiiebH88szvpfhhb4hvT2F+ko6eNeOK9/E9F2QgOGqU3hBbUOJg+LFzTmB
         vd+4ynvEAgfFtLVfaLBUybVzDa6hZBiOuW8u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137810; x=1691742610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=TO5U4GzBHe+R0/fyfuw/+G40LaZn/p4JslKTxzf1d6kxIV1LawgLA0akpcnje6DX9D
         UwRhbQm3uXbN+fyADKHmOxuSIOjW1xaileah9E7vzkkGcmwHHV+8MikwB90jKgPG0Jjt
         tsj+MCT8XWxr1Sy0NC+y+5V/pydxxBnPAVogA6zzXTAe4SuSWt8UegT2xVbjQnMTMO1c
         /viPbXk+H0BZDHluU1KZp15CN/X69dl0KS/4a7qB73VWgbLb6gTJk+6jDe4Cw810t0Le
         gsh4y9cpKeOzDd5u1y7WrlKVS0YhN50dYEL0pxBkUhr5cyKPDVYeqIIphVWMbQSmH7cJ
         ud8w==
X-Gm-Message-State: AOJu0YyER8TAf7DeJtRBWX2/VBN8hA4WjT7XzE7rC4rSS9yVFG1hy7k4
        4aRD8Umue2gdcGTa73x17VRD9g==
X-Google-Smtp-Source: AGHT+IHh6wCyuLACZdpvHgsdR8UkOmQsmagdun+zvBpnhfZpwlQcNCElW7X7S0H00eHM1MYxpZV3NA==
X-Received: by 2002:a9d:67d6:0:b0:6b9:68fb:5a28 with SMTP id c22-20020a9d67d6000000b006b968fb5a28mr931396otn.27.1691137810270;
        Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4b4e00b00268b439a0cbsm1057998pjl.23.2023.08.04.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:30:09 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:30:09 -0700
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
Subject: Re: [PATCH net-next 3/3] virtchnl: fix fake 1-elem arrays for
 structures allocated as `nents`
Message-ID: <202308040130.E48094967E@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-4-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-4-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:52:07PM +0200, Alexander Lobakin wrote:
> Finally, fix 3 structures which are allocated technically correctly,
> i.e. the calculated size equals to the one that struct_size() would
> return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
> the same approach when there are no enough space as taken previously
> for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
> automatically instead of trying to guestimate it using maths.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
