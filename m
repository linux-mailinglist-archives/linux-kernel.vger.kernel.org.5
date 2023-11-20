Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F357F1E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjKTUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:43:19 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67499CF;
        Mon, 20 Nov 2023 12:43:15 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a013d22effcso34415466b.2;
        Mon, 20 Nov 2023 12:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512994; x=1701117794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMxDFRBVGQxAcyd/h/e01Uqtt9vCU82wNeM940Cvh0U=;
        b=XHPmiDmYFm56ataY0Pw+ZGCAkVb//0uheiX4SSy4PzrLsoHHkcXrpWZ2hzVYW8jmwK
         V9a61HTgqfr0iZRQJHS9ztLf6tFxO6DR/58DtucDqKzmNZqgCpIR7RDKfI+ggyi5MIUo
         9oDr91k8MaNlXsI1jrPzm+wJQuFtGemUkjecRe5+gJJ+S8vmQkZbVGmBvjgkqvK5hhNk
         JExjT/qn3S4U1cDUKLsr5RLtYhAquW2o1dN1vptRdxOGFU06S9ri1UYdChzRcaLuAc5u
         jJ7ixHxuy5W9uhoUemftyU/NosMhXWI9gpIT1k8A2e0BRtzYzVTOOFxblFOl70YapNGh
         8Gdw==
X-Gm-Message-State: AOJu0Yzlk5xmlJMg1IpPM/NVKeoKJUYGRf1vPLe1WRN8/4S+PQ7/DgbM
        21qOTNYAtUOlXcp5AL+Cvys=
X-Google-Smtp-Source: AGHT+IHOT2Y65xnLk5UdW08i+jq0X4mpOLcw7WXb1VsktMLDCYT8JFr4sI7yEsgB4KKvQG6G85VH8w==
X-Received: by 2002:a17:906:19c:b0:9e3:fbab:e091 with SMTP id 28-20020a170906019c00b009e3fbabe091mr6427990ejb.15.1700512993651;
        Mon, 20 Nov 2023 12:43:13 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id cm42-20020a170906f5aa00b009fcf829d84csm1992395ejd.169.2023.11.20.12.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:43:13 -0800 (PST)
Date:   Mon, 20 Nov 2023 12:43:11 -0800
From:   Breno Leitao <leitao@debian.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     leit@meta.com, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, donald.hunter@gmail.com,
        linux-doc@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <ZVvE36Sq1LD++Eb9@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
 <87y1ew6n4x.fsf@meer.lwn.net>
 <20231117163939.2de33e83@kernel.org>
 <ZVu5rq1SdloY41nH@gmail.com>
 <20231120120706.40766380@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120120706.40766380@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 12:07:06PM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 11:55:26 -0800 Breno Leitao wrote:
> > I am not planning to do it, since I would like to trust Make. Let me
> > know if you think this is important and I can do it also.
> 
> Makefile is good enough for me.
> 
> > +$(YNL_INDEX): $(YNL_RST_FILES)
> > +       $(YNL_TOOL) -x # Generate the index
> > +
> > +%.rst: $(YNL_YAMLS_FILES)
> > +       $(YNL_TOOL) -i $(patsubst %.rst,%.yaml, $(@F)) # generate individual rst files
> 
> IDK what @F means, can the tool take one file at a time and then
> we can make the rule a more usual:

'$(@F)' is the file-within-directory part of the file name of the
target. If the value of ‘$@’ is dir/foo.o then ‘$(@F)’ is foo.o. ‘$(@F)’
is equivalent to ‘$(notdir $@)’.

> %.rst: $(YNL_YAML_DIR)/%.yaml
> 	$(YNL_TOOL) -i $< -o $@

That is basically what it does now in the current implementation, but,
you don't need to pass the full path and no output file, since it knows
where to get the file and where to save it to.

If you are curious about the current python script, I've pushed it here:
https://github.com/leitao/linux/blob/netdev_discuss/tools/net/ynl/ynl-gen-rst.py

I can easily remove the paths inside the python file and only keep it in
the Makefile, so, we can use -i $< and -o $@.

