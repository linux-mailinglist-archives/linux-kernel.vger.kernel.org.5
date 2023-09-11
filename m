Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6879B50D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjIKVFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjIKOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:01:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE9CF0;
        Mon, 11 Sep 2023 07:00:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68e3083aa1dso4326713b3a.1;
        Mon, 11 Sep 2023 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694440855; x=1695045655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2Q+4HmWdmD9If9N6/Rge7uDA1fBSwpfjskqILwBtyY=;
        b=UHOMyqRf+UzcrytabLO8Z5EcNtgnv9O2fw1M0DtQ62AZBBVvEMjEHdH1+0PX+OsG29
         Zh5CllaS4yMzKCA7+TTQ7wk3m1Hsq4oIBuRJgHY0IsCsaQbXWU9P5NRXZ4zkDhIpvPET
         OMng7K8gh8hNX0WNeymVpP/6t4Kpt5QUU2tNrkjmc5vzdhDo4MOR38ryXjBtTlLKubjx
         t8JpPgaORhLeEBpz2c91UBQTRdXc7IEYE+AM/pWmvfnacH6zI9xszm/KzRwtyjys/pOi
         jhCXsqa1zTUMj3XJrcOgnuepndw3XubMGkO6w9swc6s0DeVl73p6/fE044rov4LfRIT5
         enQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440855; x=1695045655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2Q+4HmWdmD9If9N6/Rge7uDA1fBSwpfjskqILwBtyY=;
        b=Zyagk91Ru+n7A55xWE7TwHbBddw9Xdj1WeXh2pCUFnTUv/LZG6AMjP15bUZtyK/D8r
         u/0eMWxRUm8IZBjscD4HR4jWLKMcgQEZbS3fJcrdov/91QINZ4OHEEjxjDX9W2l8SD0U
         r/IJz+czYR+q8dNQmrOaDQ3WBPSFZJyuDxjsJ3ncEJ05vbc9r+fPegMxpDFu0HOYXc6i
         Fnpwz7dDgfLhd0beEw9XlGCYXJp8dHH9nqHHVOQJyKoZ+EjOS3D0Wb2aFSFYAdEGDWCq
         Q18UxyMcexJ13RBYC3ZBPcG57NdzUsaoGyaVbjyjMBppfYEvH5yzna90ji2aKmrtlB21
         vqVw==
X-Gm-Message-State: AOJu0YzBuWt4DJPzjX+dvUugbatyQppyQ6POmVnMIL9+4xWoprhYRO8N
        zaOn3NwVX1myrulCP6HNneo=
X-Google-Smtp-Source: AGHT+IF+5c9+fQ4xKQsvS/HkkOz8hj7VmzC06mn57xXfwBGYWcR9O0Oc90MXkr1cUCqA0/oKcvITYA==
X-Received: by 2002:a05:6a20:e11b:b0:140:6d68:ce07 with SMTP id kr27-20020a056a20e11b00b001406d68ce07mr13423508pzb.52.1694440855159;
        Mon, 11 Sep 2023 07:00:55 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b00682d79199e7sm5586494pfi.200.2023.09.11.07.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:00:54 -0700 (PDT)
Message-ID: <9a8d2090-a58e-49a0-3b1d-00bb5b8f04f2@gmail.com>
Date:   Mon, 11 Sep 2023 21:00:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Slow boot and shutdown/reboot problems with 6.5.0+
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
References: <5011708f-b0ae-2853-0f87-a3b59845a2cc@gmail.com>
 <CA+FbhJO8b5V_So2mMPu1ApKXTxk0ieWvNMa=HBTYTWDXLEA-ew@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CA+FbhJO8b5V_So2mMPu1ApKXTxk0ieWvNMa=HBTYTWDXLEA-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 20:56, Marcus Seyfarth wrote:
> As to bisecting: Unfortunately I cannot afford the time right now to bisect this further as the system is used in production and already did invest a lot of time without success into it. Hopefully someone else can find the root cause of the problem. My systemd version is: 254.1, and I also use dbus 1.14.10 and dbus-broker 33.r35.g2220a84 which was configured with -D linux-4-17=true.
> 

[also Cc: Thorsten]

To Thorsten: It looks like the reporter can neither bisect nor
test the mainline since he only has production machine instead.
What can I (and the reporter do) in this case?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

