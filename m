Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA027B797C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbjJDIEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjJDIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:04:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82FA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:04:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4060b623e64so3545245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696406682; x=1697011482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJdb1qMHJ+Cbk4cGjE6rcjXo+B39SPe1RPD3Rof3+L0=;
        b=uJJ/Vwbc0CbMnwvQUKkm05V3jEdEI7fTq1hMhAHVV6PdLL0OlR43Bd1K2vOuNk/O40
         bAdRSrMpAdKyez9746d7xRR68K1j7HWK1XmCkfqCRJ6+/JUTrPnRAKl6+3eVFkA+Q0m+
         s2sAzLLGcGsoWjohU6ceeBi6wbJ5Foh1AeenJjG91dxaBtbo0H26Hr7TS1xXJDx8ms11
         gH+6HGdRZG8uOhMdiv8Qig+i60VUrp1yhvRMX8YWHkTo2sosivPydebKsIJ4tm8AV9H7
         E+7mO20CVym0Rzd0HuzLppaZbnhQXfGziAdC3wP2u66srAYJenzHfpd4uqhYHdPRLgSF
         JF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406682; x=1697011482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJdb1qMHJ+Cbk4cGjE6rcjXo+B39SPe1RPD3Rof3+L0=;
        b=iUFETxwn4Ew+shDXuEzCu2HhdtncjSUN2T81ygXzYNw1V+GkNZ6cbP9uNQHqquknlz
         vo9AiLM2LPNEK0Wt4fHj0o47kekO8a37PD49Z3oqn25t8MOmAXnf45NdR2RNclnvINF1
         qU3cEOhFvNnx4OW2Y2cUTHLcHq4SvEFlj06B3NpK66jU10J0tBT9UTSh0VPMYpmvo3aG
         oD9dLADNFMubRiEmHEdK5X6DX/94ZD8D1CLg9WFLmowortg5PtRd9b4N+6hXHmOiFHGK
         dxB5dfzzUL+qxesF3i2zRnMl4HzYjWLH/CJv9yBEf0QgyMBGbVsIKkIycOvkpdCNtQRf
         fTUg==
X-Gm-Message-State: AOJu0YwFK6vL7wy5fOLJY9i9EHc/vBmJ0XZCvoK2Bn791yN9yf2WkDMI
        +UqX4Wn7SfP+ZUWxhH0gt/28VQ==
X-Google-Smtp-Source: AGHT+IEC7Kk4F818yPH6966d9Z6ExD5ZI8JjXGRj24+Tu4eq1T+SWsvmQBmsuJ3WYMQq3IezkMnwnQ==
X-Received: by 2002:a05:600c:5014:b0:401:b425:2414 with SMTP id n20-20020a05600c501400b00401b4252414mr3936654wmr.18.1696406681795;
        Wed, 04 Oct 2023 01:04:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c15-20020a7bc84f000000b00405323d47fdsm859765wml.21.2023.10.04.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:04:41 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:04:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] iavf: Avoid a memory allocation in
 iavf_print_link_message()
Message-ID: <8c153188-a5e3-46f9-b126-7ae447236022@kadam.mountain>
References: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
 <a5e933fe-4566-9ae6-9a5d-b3a4c186fe0b@intel.com>
 <abf8d279-b579-4a03-9ae9-053cf5efec3d@wanadoo.fr>
 <ecc05528-ba59-922b-7384-4bedd46cf89b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecc05528-ba59-922b-7384-4bedd46cf89b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:01:18PM -0700, Jesse Brandeburg wrote:
> On 10/3/2023 1:33 PM, Christophe JAILLET wrote:
> > kasprintf() is much better.
> 
> cool! I just sent the patches and cc'd you earlier today.
> 
> > > 
> > > your patch still shows these errors
> > 
> > I built-tested the patch before sending, so this is strange.
> > 
> > However, I got a similar feedback from Greg KH and the "kernel test
> > robot" for another similar patch.
> > 
> > What version of gcc do you use?
> > I use 12.3.0, and I suspect that the value range algorithm or how the
> > diagnostic is done has been improved in recent gcc.
> 
> Fedora gcc 12.3.1, with W=1 flag
> 
> gcc version 12.3.1 20230508 (Red Hat 12.3.1-1) (GCC)
> 
> [linux]$ make W=1 M=drivers/net/ethernet/intel/iavf
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_main.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_ethtool.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_virtchnl.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_fdir.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_adv_rss.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_txrx.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_common.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_adminq.o
>   CC [M]  drivers/net/ethernet/intel/iavf/iavf_client.o
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c: In function
> ‘iavf_virtchnl_completion’:
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1446:60: warning: ‘%s’
> directive output may be truncated writing 4 bytes into a region of size
> between 1 and 11 [-Wformat-truncation=]
>  1446 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>       |                                                            ^~
>  1447 |                          link_speed_mbps, "Mbps");
>       |                                           ~~~~~~

GCC is kind of crap at static analysis, right?  Smatch would know that
this at most 11 characters long.  It's kind of laziness for GCC to print
this warning.  If you complained to me about a false positive like this
in Smatch I would at least think about various ways to silence it.

But I probably wouldn't write a check for this anyway because I don't
view truncating strings as a note worthy bug...

Smatch also gets stuff wrong, but in that case I just always encourage
people to mark the warning as old news and move on.  Only new warnings
are interesting.

I feel like as we incorporate more and more static analysis into our
processes we're going to have to give up on trying to keep every static
checker happy.

regards,
dan carpenter
