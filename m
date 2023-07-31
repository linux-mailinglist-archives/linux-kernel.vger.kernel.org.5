Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D67769C17
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGaQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGaQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:16:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C26A10CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:16:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso43603505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690820199; x=1691424999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UIisZVv3YHJmXkF0F3DgW2BWqtONI9eq0hPX1eKBDnc=;
        b=zd4jeqmzHM+ZPY7YGX+frgLaL0aACtWoeSmE4fpiKDAFbhX1PXpxEA9EL4MLXAAdoK
         E7dpcLxXhqntQEMmSH2opHcGKttjPx9Y/OyIzapQpRYgGa2ctvpvUD+3vfiS7QPt1yK2
         ocxKfPzFiSXmCNIEjq9LASL/IgvOztssUeBrjL9/2NaMw5ZzSpBQHD3oClkGN2sQfGvH
         dxD7qE0U3YBYzPC8kr3gJf6WGw01KeLYRdoxafw+8Frb3A24WSEzbYKHbwzZp0w0rcD2
         /+Dt8vBqfdUvk1XroFpoqGwG+dPirr7bxKzwMBE0QiCvKdzL9RCF42aOJFTC+B2E9WtO
         z5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820199; x=1691424999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIisZVv3YHJmXkF0F3DgW2BWqtONI9eq0hPX1eKBDnc=;
        b=OdJ98N2bW27Roa5RvLQNPicaQPrAlWpHtkYOSTwJscCewaCKbxTQtvb/+PTpSJ6Cfy
         5J8M1bTvsMSo4tddEnNaGsBhYDoO6BCb0bX3x1CC/q6yuxd93ud0Z2Y1+oQT6YMB5mz/
         AhOVrmHIsVKLwyiqrefKBZzzFi2bFAuYh8/0eJLgh7w2hgym3i3DcoTimwxLdFEiBbLG
         VKw01qJ563uzBZ8hdg4NkPhbN/GEh9wTZKYdZVujGnDSmq2yBHYEycmhxrJrSDmGQHCW
         XfEcfZaq/hpSpmCeIuBiy/tdVXXgFVmuoJjsZaSou7rs722myt5zDN7LM+gDxpIwzO/n
         qEaA==
X-Gm-Message-State: ABy/qLZO/yJWSGssQ2wEOpukKAcnBQpAMPbRNWX+YGXQjZ6PCIrVsUar
        oJqnt+MADIb23XeiVS4yFab41A==
X-Google-Smtp-Source: APBJJlEkayVBrtZlM2bg5wxvBhBOCevcJ6EFmWqbmA9DTDFlfTIrR9VW4Bwgkn+NMeW4ufoP5K53Dw==
X-Received: by 2002:a7b:c019:0:b0:3fb:e356:b60d with SMTP id c25-20020a7bc019000000b003fbe356b60dmr313209wmb.38.1690820199006;
        Mon, 31 Jul 2023 09:16:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c215200b003fe0bb31a6asm8899696wml.43.2023.07.31.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:16:38 -0700 (PDT)
Date:   Mon, 31 Jul 2023 19:16:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in
 ordered_list_elements_from_package
Message-ID: <2978ca9d-fbab-45b1-8d90-321fb9453965@kadam.mountain>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
 <20230725220056.25560-3-jorge.lopez2@hp.com>
 <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain>
 <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:03:42AM -0500, Jorge Lopez wrote:
> On Thu, Jul 27, 2023 at 1:21 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >    134          int value_len = 0;
> >    135          int ret;
> >    136          u32 size;
> >    137          u32 int_value = 0;
> >
> > It confused me that it's called int_value when it's not an int.  Just
> > call it "u32 value = 0;".
> 
> The variable is named int_value when it is not an int because it
> stores the value reported by ACPI_TYPE_INTEGER package.
> The variable will be renamed to  type_int_value;

Eep!  That's even worse!  Just leave it as-is then.

> >    201                  case SEQUENCE:
> >    202                          ordered_list_data->common.sequence = int_value;
> >    203                          break;
> >    204                  case PREREQUISITES_SIZE:
> >    205                          ordered_list_data->common.prerequisites_size = int_value;
> >    206                          if (int_value > MAX_PREREQUISITES_SIZE)
> >    207                                  pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> >
> >         ret = -EINVAL;
> >         break;
> >
> We encountered during our testing that one or more packages could be
> assigned the wrong package type or invalid data..
> For this reason, it was decided to ignore any invalid data and
> incorrect type package and allow the read process to continue.
> 

So you have BIOSes which are still printing this warning and you can't
fix it?  Fine.  Are you sure it's not because you re-used the elem
iterator and started looping again in the middle?

Could you at least do the bounds check here instead of in the next step?


		if (int_value > MAX_PREREQUISITES_SIZE) {
			pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
			int_value = MAX_PREREQUISITES_SIZE;
		}
		ordered_list_data->common.prerequisites_size = int_value;

> >    257                  case ORD_LIST_ELEMENTS:
> >    258                          size = ordered_list_data->elements_size;
> >
> > We don't use size anywhere so this can be deleted.
> >
> >    259
> >    260                          /*
> >    261                           * Ordered list data is stored in hex and comma separated format
> >    262                           * Convert the data and split it to show each element
> >    263                           */
> >    264                          ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
> >
> > The value_len here is wrong.  We don't read value_len for ORD_LIST_ELEMENTS
> > or PREREQUISITES so this value_len comes from the PATH object.
> The size

?

regards,
dan carpenter
