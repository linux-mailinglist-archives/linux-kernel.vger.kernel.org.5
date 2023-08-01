Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B576A888
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjHAFym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHAFyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:54:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187711BC8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:54:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso34126265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690869278; x=1691474078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N80uoosdDa7yvdA2hpRb8uu5HD+aBTdak3hppZUjvME=;
        b=W81z5LIvTNakNfnLI9h3rRYOTVhxMuXypfc2ZPp23NYR4TBHZZIZ6FC2WY5K8qM0v7
         c9KtpjQEzbz03YmYXSu9sfaMCIXLovw2AYzmSNAagTnDxlKdSCOjUZdQi5mOIom5iTnt
         SYbmdG3PHq5eH2hSykAFJ/EHcpvNEOppuR5pEYZ9CgxjPmyAlrUczgYGxu1oyEEyIpYd
         KH0urdQDlL+Y4r4OFB58hK9UNpFplEmNntMwJimg6KV3FGWu3tFYyMmC5VV51rjYxWHn
         ApEfWU7lB2Q5bcxJ97ooXjZcsz6kHxi/QhZybjhi91GsdM/L09iyus+govgCNBVVdhdD
         DroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690869278; x=1691474078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N80uoosdDa7yvdA2hpRb8uu5HD+aBTdak3hppZUjvME=;
        b=Bn/HWBoAEjKHCeYo6Yj3QVBzfCl+20foXeW5Q047S0cBpwwZYf/QPGTroG0uiRpd0G
         gQ3aKhiQRQVNtdQU9tSIt0/TZdYM89xs5JYZex/TCd/NWrQPlwDcxjyc83vHe2vFofCA
         JrD/5zdGGxvDCaaPztZdJze1RlnmnpxVjZ1pFzboimFNNLRuT3cwLJdbldZlR6cEmB4c
         6vgvzkeWt60ZfsiqNvx7i2vF4znT1rALR+/ksaoljHEY5CeEHIR9pRBmC3VFP2MXWmj3
         yx1cQp27Bw2ClDHggCKGoBj6yBBXFkf4Sz9nG9hZSuVoRLssjj9sQUQi/kWtvhmUR6kQ
         8oQw==
X-Gm-Message-State: ABy/qLYoIw6Xdgd7dVqJx5xRt32y+q/Br5iCYTOvsOEK9p/sJel2jOLj
        w19EVu5YMZP2c7BgrBCAG5tjJw==
X-Google-Smtp-Source: APBJJlF7w8g4PdS0vx0UCedzEPqIB3jut1ot+T356u96ck8Ze0W/oghlj8TAPWJYmtsTeMO2yGB1Qg==
X-Received: by 2002:a7b:cc88:0:b0:3fe:1d13:4663 with SMTP id p8-20020a7bcc88000000b003fe1d134663mr1535750wma.1.1690869278559;
        Mon, 31 Jul 2023 22:54:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b003fe18d03188sm7679010wmc.17.2023.07.31.22.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 22:54:38 -0700 (PDT)
Date:   Tue, 1 Aug 2023 08:54:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in
 ordered_list_elements_from_package
Message-ID: <0f8c1b87-e211-4ca7-bf92-8fde5bb77cd2@kadam.mountain>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
 <20230725220056.25560-3-jorge.lopez2@hp.com>
 <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain>
 <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
 <2978ca9d-fbab-45b1-8d90-321fb9453965@kadam.mountain>
 <CAOOmCE_p_QgV0QJZKtYZD+t7Y9MzNOQ9sEkfSM88VoHDUCwdCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_p_QgV0QJZKtYZD+t7Y9MzNOQ9sEkfSM88VoHDUCwdCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:35:35AM -0500, Jorge Lopez wrote:
> On Mon, Jul 31, 2023 at 11:16 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Mon, Jul 31, 2023 at 11:03:42AM -0500, Jorge Lopez wrote:
> > > On Thu, Jul 27, 2023 at 1:21 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > >    134          int value_len = 0;
> > > >    135          int ret;
> > > >    136          u32 size;
> > > >    137          u32 int_value = 0;
> > > >
> > > > It confused me that it's called int_value when it's not an int.  Just
> > > > call it "u32 value = 0;".
> > >
> > > The variable is named int_value when it is not an int because it
> > > stores the value reported by ACPI_TYPE_INTEGER package.
> > > The variable will be renamed to  type_int_value;
> >
> > Eep!  That's even worse!  Just leave it as-is then.
> 
> Oops!  just send a new patch using type_int_value.  Should I change it back?

In order of preference for me, it's "value", "int_value", and
"type_int_value".  But it doesn't really matter.  I feel there were a
couple bugs like the size vs value_len and re-using the iterator.  You
have addressed the real problems so lets not worry about variable names.
Whatever you pick is fine.

regards,
dan carpenter

